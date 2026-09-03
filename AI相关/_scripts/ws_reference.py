#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
创意工坊物品「查重」工具 —— 用户给你工坊链接时，**先跑这个再决定要不要下载**。

回答四个问题：
  ① 已订阅？      -> E:\\ 订阅目录里有，直接读（只读，绝不改）
  ② 已免订阅暂存？ -> _tools\\steamcmd\\... 里有，直接读
  ③ 已学习？      -> 已经写进《游戏内 Lua 指导书与例题集》的哪些分册/章节
  ④ 已提取 Lua？  -> _提取暂存\\ 里有哪些脚本文件

用法
  python ws_reference.py <url 或 id> [<url 或 id> ...]   # 查询
  python ws_reference.py --rebuild                        # 重建「已学习」索引
  python ws_reference.py --list-learned                   # 列出所有已学习物品
  python ws_reference.py --list-staged                    # 列出所有免订阅暂存物品
  python ws_reference.py --index <路径> --no-build ...     # 云端专用：显式索引路径 + 禁用 fallback 重建

约定（与规程一致）
  - E:\\SteamLibrary\\...\\workshop\\content\\573090  **只读红线**，本脚本只列举不改动
  - 免订阅下载只是**临时暂存**；一旦 Lua 被提取且手法写进指导书，即可清理（见 --purge-check）
"""
import os
import re
import sys
import json
import urllib.request
import urllib.parse

APPID = 573090
SUBSCRIBED = r"E:\SteamLibrary\steamapps\workshop\content\573090"
STAGED     = r"D:\STORMWORKS\_tools\steamcmd\steamapps\workshop\content\573090"
STAGING    = r"D:\STORMWORKS\AI相关\_提取暂存"
DOCS       = r"D:\STORMWORKS\数据库\Lua\Lua示例"
INDEX      = r"D:\STORMWORKS\AI相关\_workshop_learned.json"
META       = r"D:\STORMWORKS\AI相关\_meta\items.json"
API = "https://api.steampowered.com/ISteamRemoteStorage/GetPublishedFileDetails/v1/"


def extract_ids(args):
    ids = []
    for a in args:
        for m in re.findall(r"(?:id=|\b)(\d{6,})", a):
            if m not in ids:
                ids.append(m)
    return ids


def api_meta(ids):
    out = {}
    for i in range(0, len(ids), 20):
        batch = ids[i:i + 20]
        data = {"itemcount": str(len(batch))}
        for k, t in enumerate(batch):
            data[f"publishedfileids[{k}]"] = t
        body = urllib.parse.urlencode(data).encode()
        try:
            with urllib.request.urlopen(
                    urllib.request.Request(API, data=body), timeout=25) as r:
                resp = json.loads(r.read().decode("utf-8", "ignore"))
        except Exception:
            continue
        for fd in resp.get("response", {}).get("publishedfiledetails", []):
            if fd.get("result") == 1:
                out[str(fd["publishedfileid"])] = {
                    "title": fd.get("title", ""),
                    "updated": fd.get("time_updated", 0),
                    "subs": fd.get("subscriptions", 0),
                }
    return out


def build_index(index_path=INDEX):
    """扫描指导书，建立 id -> 出现在哪些分册/章节 的索引。

    区分两种「出现」：
      - learned : 有 `- 来源：steam id <id>` 行，即真正写成例题的作品
      - listed  : 仅在「同类作品索引」等候选表里提及，**尚未学习**

    index_path 可指定输出位置（默认写入 INDEX）。云端调用时传入各自路径，避免回写本地 INDEX。
    """
    idx = {}
    for fn in sorted(os.listdir(DOCS)):
        if not fn.endswith(".md"):
            continue
        txt = open(os.path.join(DOCS, fn), encoding="utf-8").read()
        lines = txt.split("\n")
        cur_sec, in_index_tbl = "", False
        for ln in lines:
            if ln.startswith("#"):
                cur_sec = ln.lstrip("# ").strip()
                # 进入「同类作品索引」这类候选表 -> 其中的 id 只是候选
                in_index_tbl = ("索引" in cur_sec) or ("附录" in cur_sec)
            # ① 来源行（真正的例题）——出现即「已学习」，强制置 True，
            #    不被同文件里「同类作品索引」候选表的 False 条目覆盖（阴影 bug 修复）
            for m in re.finditer(r"来源：steam id\s*\*{0,2}(\d{9,11})\*{0,2}", ln):
                e = idx.setdefault(m.group(1), {"file": fn, "sections": [],
                                                "learned": True})
                e["learned"] = True
                if cur_sec and cur_sec not in e["sections"]:
                    e["sections"].append(cur_sec)
            # ② 其他位置出现的 9~11 位数字
            for m in re.finditer(r"\b(\d{9,11})\b", ln):
                tid = m.group(1)
                e = idx.setdefault(tid, {"file": fn, "sections": [], "learned": False})
                if cur_sec and cur_sec not in e["sections"]:
                    e["sections"].append(cur_sec)
                if not in_index_tbl:
                    e["learned"] = True
    json.dump(idx, open(index_path, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    return idx


def load_index(index_path=None, allow_build=True):
    """读取已学习索引。

    index_path : 显式指定索引文件（云端必须传，否则会去扫本地指导书目录）。
    allow_build : False 时若文件不存在**直接返回空 dict**，不回退到 build_index()——
                  防止云端在空目录里 build_index 得到空索引、把所有已学作品重下一遍。
    """
    path = index_path or INDEX
    if os.path.isfile(path):
        try:
            return json.load(open(path, encoding="utf-8"))
        except (ValueError, OSError):
            pass   # 空文件或解析失败 -> 走下方分支
    if allow_build:
        return build_index(path)
    return {}


def lua_files(tid):
    """列出暂存区里属于该 id 的已提取 Lua。"""
    hits = []
    for base, dirs, files in os.walk(STAGING):
        for f in files:
            if f.endswith(".lua") and f.startswith(tid + "_"):
                hits.append(os.path.relpath(os.path.join(base, f), STAGING))
    return sorted(hits)


def query(tid, idx, meta):
    print("=" * 76)
    sub  = os.path.isdir(os.path.join(SUBSCRIBED, tid))
    stag = os.path.isdir(os.path.join(STAGED, tid))
    m    = meta.get(tid) or {}
    title = m.get("title", "")
    if m.get("updated"):
        import datetime
        upd = datetime.datetime.fromtimestamp(m["updated"]).strftime("%Y-%m-%d")
    else:
        upd = "?"
    lf   = lua_files(tid)
    learned = idx.get(tid)

    print(f"id      : {tid}")
    print(f"标题    : {title or '(未取到)'}")
    print(f"更新    : {upd}" + (f"   订阅数 {m['subs']:,}" if m.get("subs") else ""))
    print(f"链接    : https://steamcommunity.com/sharedfiles/filedetails/?id={tid}")
    print("-" * 76)
    print(f"① 已订阅     : {'是  -> ' + os.path.join(SUBSCRIBED, tid) if sub else '否'}")
    print(f"② 已暂存     : {'是  -> ' + os.path.join(STAGED, tid) if stag else '否'}")
    if learned and learned.get("learned"):
        secs = "；".join(learned["sections"][:4]) or "(正文提及)"
        print(f"③ 已学习     : ✅ 是  -> {learned['file']}  【{secs}】")
    elif learned:
        print(f"③ 已学习     : ⬜ 否（仅在候选索引表中提及，未展开）-> {learned['file']}")
    else:
        print("③ 已学习     : 否")
    print(f"④ 已提取 Lua : {len(lf)} 个文件" + (f"  {', '.join(lf[:6])}" if lf else ""))
    print("-" * 76)

    # 决策
    is_learned = bool(learned and learned.get("learned"))
    if is_learned:
        act = "✅ 已学习——直接读指导书对应章节即可，无需重新下载/精读"
    elif sub:
        act = "📖 已订阅——直接读 E:\\ 下的 xml（只读），提取 Lua 后按规程步骤 3~4 处理"
    elif stag:
        act = "📦 已暂存——直接读暂存 xml，无需重新下载"
    elif lf:
        act = "🧪 Lua 已提取——直接看 _提取暂存 里的脚本，无需下载原 xml"
    else:
        act = "⬇️  三者都没有——执行免订阅下载：python ws_download.py " + tid
    print("建议    : " + act)
    return is_learned


def main():
    args = sys.argv[1:]
    if not args:
        print(__doc__)
        return

    # 云端专用：显式指定索引路径 + 禁用 fallback 扫描
    # （避免云端在空目录里 build_index 得到空索引，从而把已学作品全部重下一遍）
    idx_path = args[args.index("--index") + 1] if "--index" in args else INDEX
    allow_build = "--no-build" not in args

    if "--rebuild" in args:
        idx = build_index(idx_path)
        print(f"已重建索引：{len(idx)} 个物品 -> {idx_path}")
        return

    idx = load_index(idx_path, allow_build)
    if "--list-learned" in args:
        real = {k: v for k, v in idx.items() if v.get("learned")}
        cand = {k: v for k, v in idx.items() if not v.get("learned")}
        print(f"✅ 已写成例题（{len(real)} 个）：")
        for k, v in sorted(real.items()):
            print(f"  {k}  {v['file']}  {'；'.join(v['sections'][:2])}")
        print(f"\n⬜ 仅在候选索引表（{len(cand)} 个，未展开）：")
        print("  " + "  ".join(sorted(cand)))
        return
    if "--list-staged" in args:
        if not os.path.isdir(STAGED):
            print("暂存目录不存在")
            return
        ds = sorted(d for d in os.listdir(STAGED) if d.isdigit())
        print(f"免订阅暂存 {len(ds)} 个物品：")
        for d in ds:
            print(f"  {d}  {'（已学习）' if d in idx else ''}")
        return
    if "--purge-check" in args:
        purge_check()
        return

    ids = extract_ids(args)
    if not ids:
        print("未识别到 id")
        return
    meta = api_meta(ids)
    # 合并本地已有元数据
    if os.path.isfile(META):
        for k, v in json.load(open(META, encoding="utf-8")).items():
            meta.setdefault(k, {"title": v.get("title", ""),
                                "updated": v.get("updated_ts", 0),
                                "subs": v.get("subscriptions", 0)})
    for t in ids:
        query(t, idx, meta)


def purge_check():
    """检查哪些免订阅暂存可以安全清理（Lua 已全部留存，删了不丢知识）。"""
    import hashlib
    if not os.path.isdir(STAGED):
        print("暂存目录不存在")
        return
    corpus = set()
    for f in os.listdir(STAGING):
        if f.endswith(".lua") and not f.startswith("_"):
            b = "\n".join(open(os.path.join(STAGING, f), encoding="utf-8",
                               errors="ignore").read().split("\n")[2:])
            corpus.add(hashlib.md5(b.encode()).hexdigest())
    saved = set()
    # ⚠ 必须剥离提取头部两行（-- source: / -- url:），否则每个文件 MD5 都不同，
    #   会得出「全部未留存」的错误结论（与规程附录 A-2 的去重坑同源）。
    for sub in ("_new", "_big"):
        d = os.path.join(STAGING, sub)
        if os.path.isdir(d):
            for f in os.listdir(d):
                if f.endswith(".lua"):
                    body = open(os.path.join(d, f), encoding="utf-8",
                                errors="ignore").read()
                    if body.startswith("-- source"):
                        body = "\n".join(body.split("\n")[2:])
                    saved.add(hashlib.md5(body.encode()).hexdigest())

    pat = re.compile(r"<object\b[^>]*\bscript=(['\"])(.*?)\1", re.S)
    import html
    safe, keep, empty = [], [], []
    for d in sorted(os.listdir(STAGED)):
        dp = os.path.join(STAGED, d)
        if not os.path.isdir(dp) or not d.isdigit():
            continue
        blocks, total = [], 0
        for fn in os.listdir(dp):
            if not fn.endswith(".xml"):
                continue
            p = os.path.join(dp, fn)
            total += os.path.getsize(p)
            if os.path.getsize(p) > 8_000_000:
                blocks.append(None)
                continue
            t = open(p, encoding="utf-8", errors="ignore").read()
            for m in pat.findall(t):
                l = html.unescape(m[1])
                if "onTick" in l or "onDraw" in l:
                    blocks.append(l)
        if not blocks:
            empty.append((d, total))
            continue
        orphan = [b for b in blocks if b is not None
                  and hashlib.md5(b.encode()).hexdigest() not in corpus
                  and hashlib.md5(b.encode()).hexdigest() not in saved]
        (keep if orphan else safe).append((d, total, len(blocks), len(orphan)))

    print("=== 免订阅暂存清理检查 ===")
    print(f"无 Lua（可直接删）      : {len(empty)} 个")
    print(f"Lua 已留存（可安全删）  : {len(safe)} 个")
    print(f"⚠ 有未留存 Lua（保留）  : {len(keep)} 个")
    for d, t, nb, no in keep:
        print(f"    {d}: {nb} 块中 {no} 块未留存   <- 先提取再删")
    sz = lambda xs: sum(x[1] for x in xs)
    print(f"\n可释放空间: {(sz(empty) + sz(safe)) / 1024 / 1024:.1f} MB")
    print("清理命令（确认无误后执行）：")
    print("  # 见 ws_reference.py --purge-check 的输出，逐个 rm -rf 对应目录")


if __name__ == "__main__":
    main()
