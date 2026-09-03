#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
本机 ↔ 资料库 同步层（阶段 1）——纯标准库，无第三方依赖。

职责（双写分离 + 队列合并架构的「管道」）：
  push : 把本地账本/榜单/已学习索引打包（内部 zip 格式、.bin 扩展名，因资料库 drive 拒绝 .zip），
         上传到资料库 drive；首次新建，之后原地替换
  pull : 从资料库队列目录取「云→地」产出包，下载解包到 _work/云同步/inbox/<batch>，合并账本
         （字段级 union，见 merge_ledger）并把云端提取的 Lua 复制进 _提取暂存，再归档到 done。
         幂等：已消费批次不重复处理、已存在的 Lua 文件不覆盖。
  self-test : 本地验证「打包→解包→sha256 一致」，完全不碰网络/资料库
  init-anchor : 在资料库建队列目录，把 space_id/queue_folder_id/pkg_node_id 落盘到锚点文件

鉴权：先判 runtime_context.py 的 mode。sandbox（云端）免 token；client（桌面端）必须先把 token 经
stdin 传入（--token-stdin），token 不落地、不进日志与产物。本脚本绝不打印 token。

依赖路径：资料库 skill 目录由环境变量 CODEBUDDY_SKILL_DIR 提供；缺失时按常见安装位置兜底搜索。

用法
  python ws_sync.py --self-test
  python ws_sync.py --push [--dry] [--token-stdin]
  python ws_sync.py --pull [--dry] [--token-stdin]
  python ws_sync.py --init-anchor [--token-stdin]
  python ws_sync.py --cloud-pack --cloud-ledger <账本json> --extracted <提取目录> [--dry] [--token-stdin]
  python ws_sync.py --cloud-check-heartbeat        # 云端启动用：读本机心跳决定 SKIP/PROCEED
  python ws_sync.py --round-trip-test
  python ws_sync.py --heartbeat-test
  python ws_sync.py --status
"""
import os
import re
import sys
import json
import time
import shutil
import tempfile
import subprocess
import urllib.request
import zipfile
import hashlib

HERE = os.path.dirname(os.path.abspath(__file__))
META_DIR = os.path.abspath(os.path.join(HERE, "..", "_meta"))   # AI相关\_meta
AI_RELATED = os.path.dirname(META_DIR)                            # AI相关\
EXTRACTED_DIR = os.path.join(AI_RELATED, "_提取暂存")              # 提取暂存根（云→地 Lua 合并目标）
ANCHOR = os.path.join(META_DIR, "lib_anchor.json")
STATE = os.path.join(META_DIR, "ws_sync_state.json")
PKG_NAME = "sw_pkg"            # 本地→云端 元数据包裹
OUT_PREFIX = "sw_out"          # 云端→本地 产出包前缀
SCRIPTS_NAME = "sw_scripts"    # 本地→云端 脚本自举包（供云端任务拉取后运行）
# 明确绝对路径：账本/榜单在 _meta，已学习索引在 AI相关\ 根
BUNDLE_FILES = [
    os.path.join(META_DIR, "ws_scan_progress.json"),
    os.path.join(META_DIR, "ws_ranked.json"),
    os.path.join(AI_RELATED, "_workshop_learned.json"),
]

HEARTBEAT_WINDOW_SEC = 2.5 * 3600   # 云端读不到本机心跳超过该时长，才判定本机「挂了」


# ---------------------------------------------------------------- 资料库 skill 定位
def locate_skill():
    s = os.environ.get("CODEBUDDY_SKILL_DIR")
    if s and os.path.isfile(os.path.join(s, "space_api.py")):
        return s
    roots = [
        r"D:\workbuddy\resources\app.asar.unpacked\resources\plugins\workbuddy-builtin\skills\library",
        r"C:\Users\EC90\.workbuddy\skills\library",
        os.path.join(os.path.dirname(HERE), "..", "..", "resources", "app.asar.unpacked",
                     "resources", "plugins", "workbuddy-builtin", "skills", "library"),
    ]
    for r in roots:
        if os.path.isfile(os.path.join(r, "space_api.py")):
            return os.path.abspath(r)
    return None


def detect_mode(skill):
    rc = os.path.join(skill, "runtime_context.py") if skill else None
    if not rc or not os.path.isfile(rc):
        return "unknown"
    try:
        out = subprocess.run([sys.executable, rc], capture_output=True,
                             text=True, encoding="utf-8", errors="ignore", timeout=30).stdout or ""
        m = re.search(r"mode\s*=\s*(\w+)", out)
        return m.group(1) if m else "unknown"
    except Exception:
        return "unknown"


def _jsons(text):
    """从混合文本中提取所有嵌入 JSON 对象（容忍前后杂散输出行）。"""
    dec = json.JSONDecoder()
    out, i, n = [], 0, len(text)
    while i < n:
        j = text.find("{", i)
        if j < 0:
            break
        try:
            obj, end = dec.raw_decode(text, j)
            out.append(obj)
            i = max(end, j + 1)
        except Exception:
            i = j + 1
    return out


def parse_nodes(raw):
    """从 space_api 输出提取 (node_id, title) 列表：先递归 JSON，再正则兜底。
    资料库 node id 为 ~20 位 base62（如 halJltu7GxlnmVsqM8WW7J），无 blk_ 前缀。"""
    pairs, seen = [], set()
    for obj in _jsons(raw):
        stack = [obj]
        while stack:
            cur = stack.pop()
            if isinstance(cur, dict):
                nid = cur.get("id") or cur.get("nodeId")
                title = cur.get("title")
                if (isinstance(nid, str) and 8 <= len(nid) <= 40
                        and isinstance(title, str) and nid not in seen):
                    seen.add(nid)
                    pairs.append((nid, title))
                stack.extend(cur.values())
            elif isinstance(cur, list):
                stack.extend(cur)
    if pairs:
        return pairs
    return [(m.group(1), m.group(2)) for m in re.finditer(
        r'"(?:id|nodeId)"\s*:\s*"([A-Za-z0-9_-]{8,40})"[^}]*?"title"\s*:\s*"([^"]*)"',
        raw, re.S)]


def find_node_id(raw):
    """从 CLI 输出提取节点 id：KS_ 行格式（manage 脚本）优先，其次递归 JSON。"""
    m = re.search(r"KS_\w+\s+([A-Za-z0-9_-]{10,40})", raw)
    if m:
        return m.group(1)
    for obj in _jsons(raw):
        stack = [obj]
        while stack:
            cur = stack.pop()
            if isinstance(cur, dict):
                for k in ("nodeId", "node_id", "node_block_id", "id"):
                    v = cur.get(k)
                    if isinstance(v, str) and 8 <= len(v) <= 40:
                        return v
                stack.extend(cur.values())
            elif isinstance(cur, list):
                stack.extend(cur)
    return None


def run_lib(skill, rel_script, args, token, want_node=False):
    """通用资料库 CLI 调用。token 仅经 --token-stdin（client 模式）。"""
    script = os.path.join(skill, rel_script)
    cmd = [sys.executable, script] + args
    if token:
        cmd += ["--token-stdin"]
    try:
        if token:
            p = subprocess.run(cmd, input=token + "\n", capture_output=True,
                               text=True, encoding="utf-8", errors="ignore", timeout=180)
        else:
            p = subprocess.run(cmd, capture_output=True, text=True,
                               encoding="utf-8", errors="ignore", timeout=180)
    except Exception as e:
        raise RuntimeError("lib_call %s: %s" % (rel_script, e))
    out = (p.stdout or "") + (p.stderr or "")
    if p.returncode != 0 and "KS_" not in out and "{" not in out:
        raise RuntimeError("lib_call %s failed rc=%d: %s" % (rel_script, p.returncode, out[-300:]))
    if want_node:
        return find_node_id(out), out
    return out


# ---------------------------------------------------------------- 打包
def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for c in iter(lambda: f.read(65536), b""):
            h.update(c)
    return h.hexdigest()


def safe_write_json(path, obj):
    """原子写 JSON，避免中途崩溃损坏账本/索引。"""
    tmp = path + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=1)
    os.replace(tmp, path)


def _parse_ts(s):
    """容错解析多种时间戳格式，返回 epoch 秒；失败返回 None。"""
    fmts = ["%Y-%m-%dT%H:%M:%S%z", "%Y-%m-%dT%H:%M:%S",
            "%Y-%m-%d %H:%M:%S%z", "%Y-%m-%d %H:%M:%S"]
    for f in fmts:
        try:
            return time.mktime(time.strptime(s, f))
        except Exception:
            pass
    return None


def heartbeat_decision(last_seen, now=None):
    """纯函数：依据本机最后心跳决定云端是否接手。SKIP=本机仍在窗口内；PROCEED=超时/缺失。"""
    if not last_seen:
        return "PROCEED"
    dt = _parse_ts(last_seen)
    if dt is None:
        return "PROCEED"
    age = (now if now is not None else time.time()) - dt
    return "SKIP" if age < HEARTBEAT_WINDOW_SEC else "PROCEED"


def build_bundle(tmp):
    """把 BUNDLE_FILES 打进 zip，返回 (zip_path, manifest)。缺失文件跳过并标注。"""
    src = META_DIR
    present, missing = [], []
    for fn in BUNDLE_FILES:
        p = os.path.join(src, fn)
        (present if os.path.isfile(p) else missing).append(p)
    zpath = os.path.join(tmp, "%s_%s.bin" % (PKG_NAME, time.strftime("%Y%m%dT%H%M%SZ", time.gmtime())))
    manifest = {
        "schema": 1,
        "kind": "local_meta_bundle",
        "generated_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "host": "local",
        "contents": [],
        "missing": [os.path.basename(m) for m in missing],
    }
    with zipfile.ZipFile(zpath, "w", zipfile.ZIP_DEFLATED) as z:
        for p in present:
            name = os.path.basename(p)
            z.writestr(name, open(p, "rb").read())
            manifest["contents"].append({"name": name, "sha256": sha256_file(p),
                                         "size": os.path.getsize(p)})
        z.writestr("manifest.json", json.dumps(manifest, ensure_ascii=False, indent=1))
    return zpath, manifest


def extract_bundle(zpath, out_dir):
    """解包到 out_dir，校验每个文件 sha256 与 manifest 一致。返回 manifest。"""
    os.makedirs(out_dir, exist_ok=True)
    with zipfile.ZipFile(zpath) as z:
        names = z.namelist()
        bad = z.testzip()
        if bad:
            raise RuntimeError("zip 损坏：%s" % bad)
        z.extractall(out_dir)
    manifest = json.loads(open(os.path.join(out_dir, "manifest.json"), encoding="utf-8").read())
    for c in manifest.get("contents", []):
        p = os.path.join(out_dir, c["name"])
        if sha256_file(p) != c["sha256"]:
            raise RuntimeError("sha 不一致：%s" % c["name"])
    return manifest


# ---------------------------------------------------------------- 锚点
def load_anchor():
    if os.path.isfile(ANCHOR):
        return json.load(open(ANCHOR, encoding="utf-8"))
    return {}


def save_anchor(a):
    os.makedirs(META_DIR, exist_ok=True)
    json.dump(a, open(ANCHOR, "w", encoding="utf-8"), ensure_ascii=False, indent=1)


def load_state():
    if os.path.isfile(STATE):
        return json.load(open(STATE, encoding="utf-8"))
    return {"consumed_batches": [], "last_pull": None}


def save_state(s):
    os.makedirs(META_DIR, exist_ok=True)
    json.dump(s, open(STATE, "w", encoding="utf-8"), ensure_ascii=False, indent=1)


# ---------------------------------------------------------------- push / pull
def do_push(skill, token, dry):
    tmp = tempfile.mkdtemp(prefix="ws_sync_")
    zpath, manifest = build_bundle(tmp)
    print("[push] 包裹 %s (%d 文件)" % (os.path.basename(zpath), len(manifest["contents"])))
    for c in manifest["contents"]:
        print("       %-26s %s" % (c["name"], c["sha256"][:12]))
    anchor = load_anchor()
    if dry:
        print("[push] DRY：未调用资料库（%s 字节已打包待传）" % os.path.getsize(zpath))
        return
    if not skill:
        raise RuntimeError("找不到资料库 skill 目录（设置 CODEBUDDY_SKILL_DIR）")
    args = [zpath, "--file-name", os.path.basename(zpath)]
    if anchor.get("pkg_node_id"):          # 后续推送原地替换，避免资料库堆积多个 pkg 节点
        args += ["--node-id", anchor["pkg_node_id"]]
    elif anchor.get("queue_folder_id"):    # 首次推送也放进队列目录，云端按 sw_pkg_ 前缀找
        # 注意：drive CLI 参数是 --parent-id（不是 --parent-node-id），且须同时传 --space-id
        args += ["--parent-id", anchor["queue_folder_id"], "--space-id", anchor.get("space_id", "")]
    node_id, out = run_lib(skill, "drive/upload_drive_file.py", args, token, want_node=True)
    if not node_id:
        # 首次未拿到 node_id，尝试列目录回查
        raise RuntimeError("[push] 上传未返回 node_id：%s" % out[-300:])
    # 上传/替换后确保节点位于队列目录（--node-id 替换不改父目录，必要时 move-node 纠正）
    if anchor.get("queue_folder_id"):
        info = run_lib(skill, "space_api.py", ["space.workspace.node-info", "--node-id", node_id], token)
        mp = re.search(r'"parentId"\s*:\s*"([A-Za-z0-9_-]+)"', info)
        if mp and mp.group(1) != anchor["queue_folder_id"]:
            run_lib(skill, "space_api.py",
                    ["space.workspace.move-node", "--node-id", node_id,
                     "--target-parent-id", anchor["queue_folder_id"]], token)
            print("[push] 节点不在队列目录，已自动移动")
    # 记录 pkg 节点用于后续原地替换；云端按 sw_pkg_ 前缀在队列目录里即可找到它
    anchor["pkg_node_id"] = node_id
    save_anchor(anchor)
    print("[push] 已上传/替换 node=%s" % node_id)


def consume_batch(out_dir, ledger_path, extracted_target=EXTRACTED_DIR):
    """消费一个已解包的云→地产出包：合并账本 + 复制提取的 Lua 到 _提取暂存。
    返回 (merged:0/1, copied_files)。幂等：重复消费不重复复制（跳过已存在）。"""
    cloud_ledger = os.path.join(out_dir, "ws_scan_progress.cloud.json")
    merged = 0
    if os.path.isfile(cloud_ledger) and os.path.isfile(ledger_path):
        local = json.load(open(ledger_path, encoding="utf-8"))
        remote = json.load(open(cloud_ledger, encoding="utf-8"))
        safe_write_json(ledger_path, merge_ledger(local, remote))
        merged = 1
    copied = 0
    src_ext = os.path.join(out_dir, "extracted")
    if os.path.isdir(src_ext):
        os.makedirs(extracted_target, exist_ok=True)
        for root, _, files in os.walk(src_ext):
            for f in files:
                sp = os.path.join(root, f)
                rel = os.path.relpath(sp, src_ext)
                dp = os.path.join(extracted_target, rel)
                if os.path.exists(dp):
                    continue
                os.makedirs(os.path.dirname(dp), exist_ok=True)
                shutil.copy2(sp, dp)
                copied += 1
    return merged, copied


def do_pull(skill, token, dry):
    anchor = load_anchor()
    folder = anchor.get("queue_folder_id")
    if not folder:
        print("[pull] 无队列目录锚点（先 --init-anchor）。")
        return
    state = load_state()
    if dry:
        print("[pull] DRY：列出目录但不下载（去掉 --dry 才真正取回并合并）")
    if not skill:
        raise RuntimeError("找不到资料库 skill 目录")
    raw = run_lib(skill, "space_api.py",
                  ["space.workspace.list-node", "--parent-node-id", folder], token)
    nodes = parse_nodes(raw)
    inbox_root = os.path.abspath(os.path.join(HERE, "..", "_work", "云同步", "inbox"))
    done_root = os.path.abspath(os.path.join(HERE, "..", "_work", "云同步", "done"))
    os.makedirs(inbox_root, exist_ok=True)
    ledger_path = os.path.join(META_DIR, "ws_scan_progress.json")
    got = 0
    for nid, title in nodes:
        if not title.startswith(OUT_PREFIX):
            continue
        batch = title[len(OUT_PREFIX) + 1:]
        if batch in state["consumed_batches"]:
            continue
        print("[pull] 批次 %s node=%s" % (batch, nid))
        if dry:
            continue
        url = run_lib(skill, "drive/get_download_link.py", ["--node-id", nid], token)
        m = re.search(r'"download_url"\s*:\s*"([^"]+)"', url)
        if not m:
            print("       ⚠ 未取得下载链接：%s" % url[-200:])
            continue
        zpath = os.path.join(inbox_root, "%s.zip" % batch)
        urllib.request.urlretrieve(m.group(1), zpath)
        out_dir = os.path.join(inbox_root, batch)
        manifest = extract_bundle(zpath, out_dir)
        merged, copied = consume_batch(out_dir, ledger_path)
        state["consumed_batches"].append(batch)
        got += 1
        print("       ✔ 解包 %d 文件 → 合并账本 %s / 复制 Lua %d 段 → %s"
              % (len(manifest["contents"]), "是" if merged else "否", copied, out_dir))
        # 消费后归档到 done（云端保留最新一份，本机侧留痕）
        try:
            shutil.move(out_dir, os.path.join(done_root, batch))
        except Exception:
            pass
    state["last_pull"] = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    save_state(state)
    print("[pull] 本次取回 %d 个新批次，累计已消费 %d" %
          (got, len(state["consumed_batches"])))


def build_cloud_output(tmp, cloud_ledger_path, extracted_root):
    """构建 云→地 产出包：账本快照 + 提取的 Lua 树。返回 (zip_path, manifest)。
    包内含 manifest.json（sha256 清单），与 extract_bundle 的校验格式一致。"""
    batch_id = "cloud-%s" % time.strftime("%Y%m%dT%H%M%SZ", time.gmtime())
    zpath = os.path.join(tmp, "%s_%s.bin" % (OUT_PREFIX, batch_id))
    manifest = {
        "schema": 1, "kind": "cloud_output", "batch_id": batch_id,
        "generated_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "host": "cloud", "contents": [],
    }

    def add_file(arcname, data):
        z.writestr(arcname, data)
        manifest["contents"].append({"name": arcname,
                                     "sha256": hashlib.sha256(data).hexdigest(),
                                     "size": len(data)})

    with zipfile.ZipFile(zpath, "w", zipfile.ZIP_DEFLATED) as z:
        if cloud_ledger_path and os.path.isfile(cloud_ledger_path):
            data = open(cloud_ledger_path, "rb").read()
            add_file("ws_scan_progress.cloud.json", data)
        if extracted_root and os.path.isdir(extracted_root):
            for root, _, files in os.walk(extracted_root):
                for f in files:
                    if not f.endswith(".lua"):
                        continue
                    fp = os.path.join(root, f)
                    rel = os.path.relpath(fp, extracted_root)
                    add_file(os.path.join("extracted", rel), open(fp, "rb").read())
        z.writestr("manifest.json", json.dumps(manifest, ensure_ascii=False, indent=1))
    return zpath, manifest


def do_cloud_pack(skill, token, dry, cloud_ledger_path, extracted_root):
    tmp = tempfile.mkdtemp(prefix="ws_cloudpack_")
    zpath, manifest = build_cloud_output(tmp, cloud_ledger_path, extracted_root)
    print("[cloud-pack] %s：%s" % (os.path.basename(zpath), json.dumps(manifest, ensure_ascii=False)))
    if dry:
        print("[cloud-pack] DRY：未上传（%d 字节，已落到 %s）" % (os.path.getsize(zpath), zpath))
        return zpath
    anchor = load_anchor()
    folder = anchor.get("queue_folder_id")
    if not skill or not folder:
        print("[cloud-pack] 无资料库 skill 或队列目录锚点 → 仅落盘到 %s（请人工上传到资料库队列目录）" % zpath)
        return zpath
    node_id, out = run_lib(skill, "drive/upload_drive_file.py",
                           [zpath, "--file-name", os.path.basename(zpath),
                            "--parent-id", folder, "--space-id", anchor.get("space_id", "")],
                           token, want_node=True)
    if not node_id:
        print("[cloud-pack] 上传未返回 node_id：%s" % out[-300:])
        return zpath
    print("[cloud-pack] 已上传到队列目录 node=%s" % node_id)
    return zpath


def do_cloud_check_heartbeat(skill, token):
    """云端启动第一步：读本机最后一次 push 的账本里的 last_seen，决定是否跳过。打印 SKIP/PROCEED。"""
    anchor = load_anchor()
    folder = anchor.get("queue_folder_id")
    if not folder:
        raw = run_lib(skill, "space_api.py", ["space.searcher.search-nodes", "--query", "SW工坊云同步"], token)
        for nid, title in parse_nodes(raw):
            if title == "SW工坊云同步":
                folder = nid
                break
    if not folder:
        print("HEARTBEAT: PROCEED (无队列目录，假定本机未初始化，云端照常运行)")
        return "PROCEED"
    raw = run_lib(skill, "space_api.py", ["space.workspace.list-node", "--parent-node-id", folder], token)
    pkg = None
    for nid, title in parse_nodes(raw):
        if title.startswith("sw_pkg_"):
            pkg = nid
            break
    if not pkg:
        print("HEARTBEAT: PROCEED (队列目录无 sw_pkg_ 元数据包，本机尚未 push 过)")
        return "PROCEED"
    url = run_lib(skill, "drive/get_download_link.py", ["--node-id", pkg], token)
    mm = re.search(r'"download_url"\s*:\s*"([^"]+)"', url)
    if not mm:
        print("HEARTBEAT: PROCEED (取不到元数据包链接)")
        return "PROCEED"
    tmp = tempfile.mkdtemp(prefix="hb_")
    zpath = os.path.join(tmp, "pkg.zip")
    urllib.request.urlretrieve(mm.group(1), zpath)
    out = os.path.join(tmp, "pkg")
    extract_bundle(zpath, out)
    lp = os.path.join(out, "ws_scan_progress.json")
    if not os.path.isfile(lp):
        print("HEARTBEAT: PROCEED (元数据包内无账本)")
        return "PROCEED"
    ledger = json.load(open(lp, encoding="utf-8"))
    dec = heartbeat_decision(ledger.get("last_seen"))
    print("HEARTBEAT: %s" % dec)
    return dec


def do_init_anchor(skill, token):
    if not skill:
        raise RuntimeError("找不到资料库 skill 目录")
    anchor = load_anchor()
    # ① 已有锚点且节点仍存在 → 直接复用（幂等；searcher 对标题检索不可靠，勿依赖）
    if anchor.get("queue_folder_id"):
        info = run_lib(skill, "space_api.py",
                       ["space.workspace.node-info", "--node-id", anchor["queue_folder_id"]], token)
        if '"kind":"folder"' in info.replace(" ", "") or '"kind": "folder"' in info:
            print("[init] 队列目录已存在，复用 node=%s" % anchor["queue_folder_id"])
            return
    # ② 无锚点 → 新建队列目录
    fid, _ = run_lib(skill, "manage/create_folder.py",
                     ["--title", "SW工坊云同步"], token, want_node=True)
    if not fid:
        raise RuntimeError("[init] 未拿到队列目录节点")
    anchor = {"queue_folder_id": fid}
    # 取 space_id
    info = run_lib(skill, "space_api.py", ["space.workspace.node-info", "--node-id", fid], token)
    m = re.search(r'"spaceId"\s*:\s*"([A-Za-z0-9_-]+)"', info)
    if m:
        anchor["space_id"] = m.group(1)
    save_anchor(anchor)
    print("[init] 队列目录 node=%s space=%s 已写锚点" % (fid, anchor.get("space_id")))


def do_self_test():
    tmp = tempfile.mkdtemp(prefix="ws_sync_test_")
    zpath, manifest = build_bundle(tmp)
    out = os.path.join(tmp, "extract")
    m2 = extract_bundle(zpath, out)
    ok = (m2["generated_utc"] == manifest["generated_utc"]
          and len(m2["contents"]) == len(manifest["contents"]))
    print("[self-test] 打包 %d 文件，解包后 manifest 一致：%s" % (len(manifest["contents"]), ok))
    for c in manifest["contents"]:
        print("   %-26s %s" % (c["name"], "OK" if ok else "FAIL"))
    shutil.rmtree(tmp, ignore_errors=True)
    return ok


# ---------------------------------------------------------------- 账本字段级合并（阶段 3）
def merge_ledger(local, remote):
    """local = 本机基底（权威），remote = 云端来源。返回新 dict，不原地修改。

    规则（由计划阶段 3 规定）：
      - ids_downloaded/extracted/learned/pending_ids：并集
      - value.last_top_ids：云端最新覆盖（单值）
      - value.ranked_pool_size：取 max（近似；精确值由 --rebuild 重算）
      - completeness.cursor_page：取 min（不越级；云端慢一拍的 pending 不丢）
      - completeness.consecutive_empty_pages：不跨机合并，保留 local
      - completeness.done：AND（两轨都到末页才算完）
      - completed：done_local AND done_cloud AND 无 pending
    """
    out = dict(local)
    lv = local.get("value", {})
    rv = remote.get("value", {})
    out["value"] = {
        "enabled": lv.get("enabled", True),
        "pages_per_sort": rv.get("pages_per_sort", lv.get("pages_per_sort")),
        "sorts": lv.get("sorts", ["trend", "totaluniquesubscribers", "lastupdated"]),
        "last_top_ids": rv.get("last_top_ids", lv.get("last_top_ids")),
        "ranked_pool_size": max(int(lv.get("ranked_pool_size", 0) or 0),
                                int(rv.get("ranked_pool_size", 0) or 0)),
    }
    lc = local.get("completeness", {})
    rc = remote.get("completeness", {})
    out["completeness"] = {
        "cursor_page": min(int(lc.get("cursor_page", 1) or 1), int(rc.get("cursor_page", 1) or 1)),
        "pages_scanned": sorted(set(lc.get("pages_scanned", [])) | set(rc.get("pages_scanned", []))),
        "consecutive_empty_pages": lc.get("consecutive_empty_pages", 0),  # 不跨机合并
        "done": bool(lc.get("done")) and bool(rc.get("done")),
    }
    # pending_ids 可能在顶层，也可能在 completeness 下；两侧都兜底取并集
    lp = set(local.get("pending_ids", [])) | set(local.get("completeness", {}).get("pending_ids", []))
    rp = set(remote.get("pending_ids", [])) | set(remote.get("completeness", {}).get("pending_ids", []))
    out["pending_ids"] = sorted(lp | rp)
    for key in ("ids_downloaded", "ids_extracted", "ids_learned"):
        out[key] = sorted(set(local.get(key, [])) | set(remote.get(key, [])))
    done_local = bool(lc.get("done")) and not out.get("pending_ids")
    done_remote = bool(rc.get("done")) and not out.get("pending_ids")
    out["completed"] = bool(done_local and done_remote)
    out["last_note"] = "merge(local,remote) @ " + time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    return out


def _merge_test():
    base = {
        "value": {"last_top_ids": ["a", "b"], "ranked_pool_size": 10, "pages_per_sort": 4},
        "completeness": {"cursor_page": 10, "pages_scanned": [1, 2, 3],
                         "consecutive_empty_pages": 0, "done": True},
        "ids_downloaded": ["1", "2"], "ids_extracted": ["1"], "ids_learned": ["1"],
        "pending_ids": [], "completed": False,
    }
    cloud = {
        "value": {"last_top_ids": ["c"], "ranked_pool_size": 12, "pages_per_sort": 4},
        "completeness": {"cursor_page": 12, "pages_scanned": [4, 5],
                         "consecutive_empty_pages": 2, "done": False},
        "ids_downloaded": ["3", "4"], "ids_extracted": ["3"], "ids_learned": ["3"],
        "pending_ids": ["4"], "completed": False,
    }
    m = merge_ledger(base, cloud)
    checks = {
        "cursor_min_not_max": m["completeness"]["cursor_page"] == 10,
        "done_AND_false": m["completeness"]["done"] is False,
        "empty_pages_local_kept": m["completeness"]["consecutive_empty_pages"] == 0,
        "ids_union": set(m["ids_downloaded"]) == {"1", "2", "3", "4"} and "4" in m["pending_ids"],
        "top_overwrite": m["value"]["last_top_ids"] == ["c"],
        "pool_max": m["value"]["ranked_pool_size"] == 12,
        "completed_false": m["completed"] is False,
    }
    for k, v in checks.items():
        print("  %-22s %s" % (k, "PASS" if v else "FAIL"))
    return all(checks.values())


def _roundtrip_test():
    """离线验证 云→地 全链路：打包(云端) → 解包 → 合并账本 + 复制 Lua。完全不碰网络/资料库。"""
    tmp = tempfile.mkdtemp(prefix="ws_rt_")
    # 1) 造云端账本 delta + 提取目录
    cloud_ledger = {
        "value": {"last_top_ids": ["c1", "c2"], "ranked_pool_size": 12, "pages_per_sort": 4},
        "completeness": {"cursor_page": 12, "pages_scanned": [4, 5], "consecutive_empty_pages": 0, "done": False},
        "ids_downloaded": ["300", "301"], "ids_extracted": ["300"], "ids_learned": ["300"],
        "pending_ids": ["301"], "completed": False,
    }
    cl_path = os.path.join(tmp, "ws_scan_progress.cloud.json")
    json.dump(cloud_ledger, open(cl_path, "w", encoding="utf-8"))
    ext_root = os.path.join(tmp, "extracted")
    os.makedirs(os.path.join(ext_root, "300"))
    open(os.path.join(ext_root, "300", "a.lua"), "w", encoding="utf-8").write("-- x")
    # 2) 本地基底账本
    local_ledger = {
        "value": {"last_top_ids": ["a"], "ranked_pool_size": 10, "pages_per_sort": 4},
        "completeness": {"cursor_page": 10, "pages_scanned": [1, 2], "consecutive_empty_pages": 0, "done": True},
        "ids_downloaded": ["1", "2"], "ids_extracted": ["1"], "ids_learned": ["1"],
        "pending_ids": [], "completed": False, "last_seen": "t0",
    }
    ll_path = os.path.join(tmp, "ws_scan_progress.json")
    json.dump(local_ledger, open(ll_path, "w", encoding="utf-8"))
    # 3) 打包（模拟云端）
    zpath, _ = build_cloud_output(tmp, cl_path, ext_root)
    # 4) 解包 + 消费（模拟本地 pull），Lua 落到临时目标避免污染真实 _提取暂存
    tgt = os.path.join(tmp, "local_extracted")
    os.makedirs(tgt)
    out_dir = os.path.join(tmp, "inbox", "cloud-x")
    os.makedirs(out_dir)
    extract_bundle(zpath, out_dir)
    merged, copied = consume_batch(out_dir, ll_path, extracted_target=tgt)
    new_local = json.load(open(ll_path, encoding="utf-8"))
    checks = {
        "ledger_ids_merged": set(new_local["ids_learned"]) == {"1", "300"} and "301" in new_local["pending_ids"],
        "cursor_min_not_max": new_local["completeness"]["cursor_page"] == 10,
        "done_AND_false": new_local["completeness"]["done"] is False,
        "lua_copied": copied == 1 and os.path.isfile(os.path.join(tgt, "300", "a.lua")),
        "last_seen_kept": new_local.get("last_seen") == "t0",
        "merged_flag": merged == 1,
    }
    for k, v in checks.items():
        print("  %-20s %s" % (k, "PASS" if v else "FAIL"))
    shutil.rmtree(tmp, ignore_errors=True)
    return all(checks.values())


def _heartbeat_test():
    now = time.mktime(time.strptime("2026-09-03T12:00:00", "%Y-%m-%dT%H:%M:%S"))
    cases = [
        ("2026-09-03T11:30:00+08:00", "SKIP"),    # 30 分钟前
        ("2026-09-03T08:00:00+08:00", "PROCEED"),  # 4 小时前（超 2.5h 窗口）
        (None, "PROCEED"),
        ("garbage", "PROCEED"),
    ]
    ok = True
    for ts, exp in cases:
        got = heartbeat_decision(ts, now=now)
        ok = ok and got == exp
        print("  %-28s expect=%s got=%s %s" % (str(ts), exp, got, "PASS" if got == exp else "FAIL"))
    return ok


def do_pack_scripts():
    """把整套 _scripts 打成 zip，供云端任务自举（首次建云端任务时由用户上传一次）。"""
    out = os.path.join(tempfile.gettempdir(),
                       "%s_%s.bin" % (SCRIPTS_NAME, time.strftime("%Y%m%dT%H%M%SZ", time.gmtime())))
    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        for root, _, files in os.walk(HERE):
            for f in files:
                if f.endswith(".pyc") or f.startswith("."):
                    continue
                fp = os.path.join(root, f)
                z.write(fp, os.path.relpath(fp, HERE))
    print("[pack-scripts] %s (%d KB) —— 请上传到资料库一次，并把得到的 node id 记入 lib_anchor.json 的 scripts_node_id"
          % (out, os.path.getsize(out) // 1024))
    return out


def main():
    args = sys.argv[1:]
    skill = locate_skill()
    mode = detect_mode(skill)
    token = None
    if "--token-stdin" in args:
        token = sys.stdin.readline().strip()
    dry = "--dry" in args

    if "--self-test" in args:
        sys.exit(0 if do_self_test() else 1)

    if "--merge-test" in args:
        sys.exit(0 if _merge_test() else 1)

    if "--round-trip-test" in args:
        sys.exit(0 if _roundtrip_test() else 1)

    if "--heartbeat-test" in args:
        sys.exit(0 if _heartbeat_test() else 1)

    if "--cloud-check-heartbeat" in args:
        dec = do_cloud_check_heartbeat(skill, token)
        sys.exit(0 if dec == "PROCEED" else 10)

    if "--status" in args:
        print("skill:", skill, "| mode:", mode)
        print("anchor:", json.dumps(load_anchor(), ensure_ascii=False))
        print("state:", json.dumps(load_state(), ensure_ascii=False))
        return

    if "--init-anchor" in args:
        do_init_anchor(skill, token)
        return

    if "--pack-scripts" in args:
        do_pack_scripts()
        return

    if "--push" in args:
        do_push(skill, token, dry)
        return

    if "--pull" in args:
        do_pull(skill, token, dry)
        return

    if "--cloud-pack" in args:
        ci = args[args.index("--cloud-ledger") + 1] if "--cloud-ledger" in args else None
        ex = args[args.index("--extracted") + 1] if "--extracted" in args else None
        do_cloud_pack(skill, token, dry, ci, ex)
        return

    print(__doc__)


if __name__ == "__main__":
    main()
