#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
云端执行能力探针（阶段 0）——一次性、可重复跑、零依赖、纯标准库。

目的：在本机或云端沙箱各跑一次，实测 WorkBuddy 自动化改到云端执行前必须确认的几件事：
  1) 外网可达性：api.steampowered.com / steamcommunity.com(浏览页) / steam CDN(zip) 分开测
  2) 运行环境：Python 版本、临时目录可写与剩余配额
  3) SteamCMD：能否下载、能否匿名登录、能否下到样本物品
  4) 资料库 CLI：sandbox 免 token 上传是否成立、预签名链接是否返回
  5) 时间预算：每步耗时，对照云端任务时长上限

输出：cloud_probe.json（默认写到 cwd；用 --out 指定）。本脚本只读外部资源、只写临时目录与
本机 --out 指向的文件，绝不触碰游戏目录或工作区其他文件。

用法
  python cloud_probe.py                         # 本机快跑（跳过 SteamCMD/资料库上传，除非显式开启）
  python cloud_probe.py --skip-steamcmd        # 同上，默认就跳过，重复声明无害
  python cloud_probe.py --sample-id 3788946785 # 额外实测下载 1 个物品
  python cloud_probe.py --lib-upload           # 尝试资料库上传（sandbox 免 token；client 模式需 --token-stdin）
  python cloud_probe.py --token-stdin          # client 模式下从 stdin 首行读 token，不落地
  python cloud_probe.py --skill-dir <path>     # 覆盖 CODEBUDDY_SKILL_DIR（指向资料库 skill 目录）
  python cloud_probe.py --budget 600 --out probe.json
"""
import os
import sys
import re
import json
import time
import shutil
import zipfile
import urllib.request
import urllib.error
import urllib.parse
import tempfile
import subprocess

APPID = 573090
STEAMCMD_URL = "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip"
API = "https://api.steampowered.com/ISteamRemoteStorage/GetPublishedFileDetails/v1/"
BROWSE = ("https://steamcommunity.com/workshop/browse/?appid=%d"
          "&browsesort=mostrecent&section=readytouseitems&p=1&numperpage=30" % APPID)
UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
SAMPLE = "3788946785"        # 已知存在的作品，作为登录成功后的下载样本（默认不下载，避免耗时）


def now():
    return time.time()


def hms(sec):
    return round(sec * 1000, 1)


def timed(name, budget_left, fn):
    """在剩余预算内执行 fn，返回 (ok, data, ms)；超时/异常都安全返回。"""
    t0 = now()
    try:
        if budget_left is not None and (now() - START) > budget_left:
            return False, {"skipped": "budget_exhausted"}, 0.0
        data = fn()
        return True, data, hms(now() - t0)
    except Exception as e:
        return False, {"error": "%s: %s" % (type(e).__name__, e)}, hms(now() - t0)


def net_probe(url, method="GET", data=None, headers=None, timeout=25, range_bytes=0):
    h = {"User-Agent": UA}
    if headers:
        h.update(headers)
    if range_bytes:
        h["Range"] = "bytes=0-%d" % (range_bytes - 1)
    req = urllib.request.Request(url, data=data, headers=h, method=method)
    t0 = now()
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            chunk = r.read(range_bytes) if range_bytes else r.read(1)
            code = getattr(r, "code", r.getcode())
            return {"ok": True, "http_code": code, "bytes": len(chunk), "ms": hms(now() - t0),
                    "host": urllib.parse.urlparse(url).netloc}
    except urllib.error.HTTPError as e:
        return {"ok": False, "http_code": e.code, "ms": hms(now() - t0),
                "host": urllib.parse.urlparse(url).netloc, "note": "HTTPError"}
    except Exception as e:
        return {"ok": False, "ms": hms(now() - t0),
                "host": urllib.parse.urlparse(url).netloc, "note": type(e).__name__}


def probe_env():
    tmp = tempfile.gettempdir()
    writable = False
    quota_mb = None
    try:
        os.makedirs(tmp, exist_ok=True)
        p = os.path.join(tmp, "cloud_probe_writetest_%d.tmp" % os.getpid())
        with open(p, "wb") as f:
            f.write(b"x" * (1024 * 1024))
        writable = True
        try:
            du = shutil.disk_usage(tmp)
            quota_mb = round(du.free / (1024 * 1024), 1)
        except Exception:
            pass
        os.remove(p)
    except Exception:
        writable = False
    return {
        "python_version": sys.version.split()[0],
        "platform": sys.platform,
        "tmp_dir": tmp,
        "tmp_writable": writable,
        "tmp_free_mb": quota_mb,
    }


def probe_net():
    out = {}
    # 1) Steam Web API
    body = urllib.parse.urlencode(
        {"itemcount": "1", "publishedfileids[0]": SAMPLE}).encode()
    out["api_steampowered"] = net_probe(
        API, method="POST", data=body,
        headers={"Content-Type": "application/x-www-form-urlencoded"})
    # 2) steamcommunity 浏览页（独立主机，403 限流高发）
    out["steamcommunity_browse"] = net_probe(BROWSE)
    # 3) steam CDN（取 steamcmd.zip 前 1024 字节）
    out["steam_cdn"] = net_probe(STEAMCMD_URL, range_bytes=1024)
    return out


def probe_steamcmd(tmp, do_sample, sample_id, budget_left):
    if do_sample and sample_id:
        target = sample_id
    else:
        target = None
    res = {"downloadable": False, "runnable": False,
           "anonymous_login_ok": False, "sample_item_downloaded": None}
    work = os.path.join(tmp, "sc_probe")
    os.makedirs(work, exist_ok=True)
    # 下载 steamcmd.zip
    ok, info, _ = timed("scz", budget_left,
                        lambda: _download_to(STEAMCMD_URL, os.path.join(work, "sc.zip")))
    if not ok or not info.get("ok"):
        res["download_error"] = info
        return res
    res["downloadable"] = True
    # 解压
    try:
        with zipfile.ZipFile(os.path.join(work, "sc.zip")) as z:
            z.extractall(work)
    except Exception as e:
        res["unzip_error"] = "%s: %s" % (type(e).__name__, e)
        return res
    # 定位可执行文件
    exe = None
    if os.path.isfile(os.path.join(work, "steamcmd.sh")):
        exe = os.path.join(work, "steamcmd.sh")
        try:
            os.chmod(exe, 0o755)
        except Exception:
            pass
    elif os.path.isfile(os.path.join(work, "steamcmd.exe")):
        exe = os.path.join(work, "steamcmd.exe")
    if not exe:
        res["exec_not_found"] = True
        return res
    res["exec"] = os.path.basename(exe)
    # 匿名登录
    ok, info, _ = timed("login", budget_left,
                        lambda: subprocess.run(
                            [exe, "+login", "anonymous", "+quit"],
                            cwd=work, capture_output=True, text=True,
                            encoding="utf-8", errors="ignore", timeout=120))
    if ok:
        txt = (info.stdout or "") + (info.stderr or "")
        res["runnable"] = True
        res["anonymous_login_ok"] = ("Logged in" in txt) or ("OK" in txt)
        res["login_tail"] = txt[-400:].replace("\r", "")
    # 样本下载（可选）
    if target:
        ok, info, _ = timed("sample", budget_left,
                            lambda: subprocess.run(
                                [exe, "+login", "anonymous",
                                 "+workshop_download_item", str(APPID), target, "+quit"],
                                cwd=work, capture_output=True, text=True,
                                encoding="utf-8", errors="ignore", timeout=240))
        if ok:
            log = (info.stdout or "") + (info.stderr or "")
            m = re.search(r'Downloaded item %s to "([^"]+)"' % target, log)
            res["sample_item_downloaded"] = bool(m)
            if m:
                res["sample_path"] = m.group(1)
    return res


def _download_to(url, path):
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    with urllib.request.urlopen(req, timeout=120) as r:
        data = r.read()
    with open(path, "wb") as f:
        f.write(data)
    return {"ok": True, "bytes": len(data)}


def probe_library(skill_dir, do_upload, token):
    """sandbox 免 token，client 模式需 token。只上传一个探针 json，记录 node_id。"""
    if not do_upload:
        return {"attempted": False, "note": "跳过（未指定 --lib-upload）"}
    if not skill_dir or not os.path.isdir(skill_dir):
        return {"attempted": False, "note": "无 skill_dir，无法调用资料库 CLI"}
    upload = os.path.join(skill_dir, "drive", "upload_drive_file.py")
    if not os.path.isfile(upload):
        return {"attempted": False, "note": "找不到 upload_drive_file.py"}
    payload = os.path.join(tempfile.gettempdir(), "cloud_probe_lib_payload.json")
    with open(payload, "w", encoding="utf-8") as f:
        json.dump({"probe": True, "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())}, f)
    cmd = [sys.executable, upload, payload, "--file-name", "cloud_probe_payload.json"]
    if token:
        cmd.append("--token-stdin")
    try:
        if token:
            proc = subprocess.run(cmd, input=token + "\n", capture_output=True,
                                  text=True, encoding="utf-8", errors="ignore", timeout=120)
        else:
            proc = subprocess.run(cmd, capture_output=True, text=True,
                                  encoding="utf-8", errors="ignore", timeout=120)
        out = (proc.stdout or "") + (proc.stderr or "")
        node = re.search(r'"node[_a-zA-Z]*"?\s*[:=]\s*"?blk_([0-9a-zA-Z_]+)"?', out)
        return {"attempted": True, "exit_ok": proc.returncode == 0,
                "node_id": ("blk_" + node.group(2)) if node else None,
                "tail": out[-300:].replace("\r", "")}
    except Exception as e:
        return {"attempted": True, "error": "%s: %s" % (type(e).__name__, e)}


def detect_mode(skill_dir):
    if not skill_dir or not os.path.isdir(skill_dir):
        return "unknown"
    rc = os.path.join(skill_dir, "runtime_context.py")
    if not os.path.isfile(rc):
        return "unknown"
    try:
        out = subprocess.run([sys.executable, rc], capture_output=True,
                             text=True, encoding="utf-8", errors="ignore", timeout=30).stdout or ""
        m = re.search(r"mode\s*=\s*(\w+)", out)
        return m.group(1) if m else "unknown"
    except Exception:
        return "unknown"


def main():
    global START
    args = sys.argv[1:]
    START = now()
    out_path = "cloud_probe.json"
    budget = 600.0
    skip_sc = "--skip-steamcmd" in args or "--no-steamcmd" in args
    sample = "--sample-id"
    sample_id = None
    if sample in args:
        i = args.index(sample)
        if len(args) > i + 1:
            sample_id = args[i + 1]
    do_upload = "--lib-upload" in args
    token = None
    if "--token-stdin" in args:
        token = sys.stdin.readline().strip()
    skill_dir = os.environ.get("CODEBUDDY_SKILL_DIR")
    if "--skill-dir" in args:
        i = args.index("--skill-dir")
        if len(args) > i + 1:
            skill_dir = args[i + 1]
    if "--budget" in args:
        i = args.index("--budget")
        if len(args) > i + 1 and args[i + 1].isdigit():
            budget = float(args[i + 1])
    if "--out" in args:
        i = args.index("--out")
        if len(args) > i + 1:
            out_path = args[i + 1]

    mode = detect_mode(skill_dir)

    report = {"schema": 1, "generated_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
              "host_mode": mode}

    ok, env, ms = timed("env", budget, probe_env)
    report["environment"] = env
    report["environment_ms"] = ms

    ok, net, ms = timed("net", budget, probe_net)
    report["network"] = net
    report["network_ms"] = ms

    if not skip_sc:
        ok, sc, ms = timed("sc", budget, lambda: probe_steamcmd(
            tempfile.mkdtemp(prefix="sc_probe_"), bool(sample_id), sample_id, budget))
        report["steamcmd"] = sc
        report["steamcmd_ms"] = ms
    else:
        report["steamcmd"] = {"skipped": True, "note": "显式跳过"}

    report["library"] = probe_library(skill_dir, do_upload, token)
    report["wallclock_ms"] = hms(now() - START)

    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(report, f, ensure_ascii=False, indent=1)

    # 摘要
    print("== cloud_probe 摘要 ==")
    n = report["network"]
    for k in ("api_steampowered", "steamcommunity_browse", "steam_cdn"):
        v = n.get(k, {})
        print(f"  {k:<24} ok={v.get('ok')} code={v.get('http_code')} {v.get('ms')}ms")
    sc = report.get("steamcmd", {})
    if sc.get("skipped"):
        print("  steamcmd             跳过")
    else:
        print(f"  steamcmd             downloadable={sc.get('downloadable')} "
              f"login_ok={sc.get('anonymous_login_ok')} sample={sc.get('sample_item_downloaded')}")
    print(f"  library.upload        attempted={report['library'].get('attempted')} "
          f"node={report['library'].get('node_id')}")
    print(f"  wallclock={report['wallclock_ms']}ms  -> {out_path}")


if __name__ == "__main__":
    main()
