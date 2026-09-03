#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Stormworks 创意工坊物品下载器（**无需订阅 / 无需登录 / 无需拥有游戏**）

原理：SteamCMD `+login anonymous` + `+workshop_download_item <appid> <id>`。
SteamCMD 用自己的匿名账号把 UGC 内容拉到**自己的目录**，
**完全不触碰用户的 Steam 订阅目录**（`E:\\SteamLibrary\\...\\workshop\\content\\573090`），
也不改变用户的任何订阅状态（实测：下载 7 个未订阅物品后，用户订阅数仍为 256，E:\\ 零改动）。

⚠ 硬性约束（踩过的坑，勿改）
  1. **SteamCMD 安装路径必须是纯 ASCII**。含中文会直接报
     "Fatal Error: Steamcmd 在该 Windows 版本上无法从含有非 ASCII 字符的文件夹路径运行"。
     所以固定在 `D:\\STORMWORKS\\_tools\\steamcmd`（D:\\STORMWORKS 与 _tools 均为 ASCII）。
  2. **下载目录不受 --out 控制**：SteamCMD 固定下载到
     `<自身目录>\\steamapps\\workshop\\content\\<appid>\\<id>\\`。
     `--out` 只是**下载后再复制**一份到指定位置。

用法
  python ws_download.py 3750251471                      # 单个
  python ws_download.py 3750251471 3793436512           # 多个
  python ws_download.py --file ids.txt                  # 从文件读 id
  python ws_download.py --browse 2                      # 抓创意工坊「最新」2 页的 id 再下载
  python ws_download.py 3750251471 --copy-to D:\\目标    # 下载后另存一份
"""
import os
import re
import sys
import html
import shutil
import zipfile
import time
import subprocess
import urllib.request

APPID = 573090                                        # Stormworks: Build and Rescue
# ⚠ 纯 ASCII 路径，勿改成中文目录
STEAMCMD_DIR = r"D:\STORMWORKS\_tools\steamcmd"
STEAMCMD = os.path.join(STEAMCMD_DIR, "steamcmd.exe")
# SteamCMD 固定输出位置（不可改）
DOWNLOAD_ROOT = os.path.join(STEAMCMD_DIR, "steamapps", "workshop", "content", str(APPID))
STEAMCMD_URL = "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip"
UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"


def ensure_steamcmd():
    """SteamCMD 缺失时自动下载解压。只写 D:\\，且校验路径为纯 ASCII。"""
    if any(ord(c) > 127 for c in STEAMCMD_DIR):
        print(f"[fatal] SteamCMD 路径含非 ASCII 字符，SteamCMD 拒绝运行：{STEAMCMD_DIR}")
        return False
    if os.path.isfile(STEAMCMD):
        return True
    print(f"[setup] 未找到 SteamCMD，下载到 {STEAMCMD_DIR} ...")
    os.makedirs(STEAMCMD_DIR, exist_ok=True)
    zp = os.path.join(STEAMCMD_DIR, "..", "steamcmd.zip")
    os.makedirs(os.path.dirname(zp), exist_ok=True)
    urllib.request.urlretrieve(STEAMCMD_URL, zp)
    with zipfile.ZipFile(zp) as z:
        z.extractall(STEAMCMD_DIR)
    os.remove(zp)
    print("[setup] 完成。注意：首次运行会自更新，约需 1-2 分钟。")
    return os.path.isfile(STEAMCMD)


def browse_ids(pages=1, sort="mostrecent"):
    """从创意工坊浏览页抓 id（不需要登录）。
    sort: mostrecent / trend / totaluniquesubscribers / lastupdated

    ⚠ steamcommunity.com 有 IP 级限流：短时间内请求过多会返回 403，
      此时连物品页也一并被封。遇到 403 请**隔 15~60 分钟再试**，不要连续重试。
      注意 api.steampowered.com 与 SteamCMD 走的是不同基础设施，限流时它们通常仍可用。
    """
    ids, seen = [], set()
    for p in range(1, pages + 1):
        url = (f"https://steamcommunity.com/workshop/browse/?appid={APPID}"
               f"&browsesort={sort}&section=readytouseitems&p={p}&numperpage=30")
        req = urllib.request.Request(url, headers={"User-Agent": UA})
        try:
            h = urllib.request.urlopen(req, timeout=30).read().decode("utf-8", "ignore")
        except Exception as e:
            code = getattr(e, "code", None)
            if code == 403:
                print(f"[browse] 403 限流（steamcommunity.com 已拒绝）。"
                      f"请隔 15~60 分钟再试；或直接给已知 id 跳过 --browse。")
            else:
                print(f"[browse] 抓取失败: {e}")
            return ids
        for i in re.findall(r"filedetails/\?id=(\d+)", h):
            if i not in seen:
                seen.add(i)
                ids.append(i)
        if p < pages:
            time.sleep(3)          # 礼貌间隔，降低被限流概率
    return ids


def download(ids):
    """批量下载。返回 (结果 dict, 原始日志)"""
    cmds = ["+login", "anonymous"]
    for i in ids:
        cmds += ["+workshop_download_item", str(APPID), str(i)]
    cmds.append("+quit")

    proc = subprocess.run([STEAMCMD] + cmds, cwd=STEAMCMD_DIR,
                          capture_output=True, text=True, encoding="utf-8", errors="ignore")
    log = (proc.stdout or "") + (proc.stderr or "")

    result = {}
    for i in ids:
        m = re.search(rf'Downloaded item {i} to "([^"]+)"', log)
        if m:
            result[i] = (True, m.group(1))
        elif f"Downloading item {i}" in log:
            result[i] = (False, "已开始但未报告成功（可能限流，稍后重试）")
        elif "Fatal Error" in log:
            result[i] = (False, "SteamCMD 致命错误（多为非 ASCII 路径）")
        else:
            result[i] = (False, "未出现在日志中（id 无效 / 物品已下架 / 需登录）")
    return result, log


def summarize(root):
    """统计下载结果里的 xml 与内嵌 Lua 脚本块。"""
    if not os.path.isdir(root):
        return []
    pat = re.compile(r"<object\b[^>]*\bscript=(['\"])(.*?)\1", re.S)
    rows = []
    for d in sorted(os.listdir(root)):
        dp = os.path.join(root, d)
        if not os.path.isdir(dp) or not d.isdigit():
            continue
        xmls = [f for f in os.listdir(dp) if f.lower().endswith(".xml")]
        if not xmls:
            continue
        nlua = 0
        for f in xmls:
            t = open(os.path.join(dp, f), encoding="utf-8", errors="ignore").read()
            nlua += len([b for b in (html.unescape(m[1]) for m in pat.findall(t))
                         if "onTick" in b or "onDraw" in b])
        rows.append((d, ",".join(xmls)[:30],
                     sum(os.path.getsize(os.path.join(dp, f)) for f in xmls), nlua))
    return rows


def main():
    args = sys.argv[1:]
    if not args:
        print(__doc__)
        return

    copy_to = None
    if "--copy-to" in args:
        copy_to = args[args.index("--copy-to") + 1]
        args = args[:args.index("--copy-to")] + args[args.index("--copy-to") + 2:]

    if "--browse" in args:
        k = args.index("--browse")
        pages = int(args[k + 1]) if len(args) > k + 1 and args[k + 1].isdigit() else 1
        args = args[:k] + args[k + (2 if pages != 1 else 1):]
        ids = browse_ids(pages)
        print(f"[browse] 抓到 {len(ids)} 个 id")
    elif "--file" in args:
        k = args.index("--file")
        txt = open(args[k + 1], encoding="utf-8").read()
        ids = re.findall(r"\d{6,}", txt)
    else:
        ids = [a for a in args if a.isdigit()]

    if not ids:
        print("没有可下载的 id")
        return
    if not ensure_steamcmd():
        print("[error] SteamCMD 不可用")
        return

    print(f"[download] {len(ids)} 个物品（匿名登录，不改动任何订阅）")
    result, log = download(ids)
    ok = sum(1 for v in result.values() if v[0])
    for i, (good, info) in result.items():
        print(f"  {'OK  ' if good else 'FAIL'} {i:<14} {info}")
    print(f"\n成功 {ok}/{len(ids)}")

    rows = summarize(DOWNLOAD_ROOT)
    got = {r[0] for r in rows}
    if rows:
        print(f"\n{'id':<14} {'xml 文件':<32} {'大小':>10} {'Lua块':>6}")
        for d, f, sz, n in rows:
            print(f"{d:<14} {f:<32} {sz:>10,} {n:>6}")

    if copy_to and ok:
        os.makedirs(copy_to, exist_ok=True)
        n = 0
        for i, (good, _) in result.items():
            src = os.path.join(DOWNLOAD_ROOT, i)
            if good and os.path.isdir(src):
                dst = os.path.join(copy_to, i)
                if os.path.isdir(dst):
                    shutil.rmtree(dst)
                shutil.copytree(src, dst)
                n += 1
        print(f"\n[copy] 已复制 {n} 个物品到 {copy_to}")

    print(f"\n真实下载位置: {DOWNLOAD_ROOT}")
    if ok < len(ids):
        print("提示：个别失败多为限流，隔几分钟重试即可。")


if __name__ == "__main__":
    main()
