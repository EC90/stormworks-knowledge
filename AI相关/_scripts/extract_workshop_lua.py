#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
创意工坊 Lua 只读提取器（规程附录 A 实现 + 清单统计）

约束（硬性）：
  - 对 E:\\ 路径 ONLY READ：全程只用 open(..., 'r')，绝不 write/delete/rename/mkdir。
  - 唯一写入目标是 D:\\STORMWORKS\\AI相关\\_提取暂存\\。
输出：
  - <id>_<vehicle|microcontroller>_<序号>.lua
  - _manifest.json：id -> 文件/块数/字符数/是否疑似压缩，供步骤 2 抓取描述页使用
"""
import os
import re
import sys
import html
import json

# 默认只读源：用户的创意工坊订阅目录（<SW_WORKSHOP>）
DEFAULT_SRC = r"E:\SteamLibrary\steamapps\workshop\content\573090"
DEFAULT_OUT = r"D:\STORMWORKS\AI相关\_提取暂存"

def parse_args(argv):
    r"""--src DIR（可重复，多个源依次扫描） / --out DIR。
    免订阅批次下载在 <WS>\_tools\steamcmd\...\573090 下，
    用 `python extract_workshop_lua.py --src <steamcmd 目录> --out ...\_提取暂存\_new` 提取。"""
    srcs, out = [], DEFAULT_OUT
    i = 0
    while i < len(argv):
        a = argv[i]
        if a == "--src" and i + 1 < len(argv):
            srcs.append(argv[i + 1]); i += 2
        elif a == "--out" and i + 1 < len(argv):
            out = argv[i + 1]; i += 2
        elif not a.startswith("-"):
            srcs.append(a); i += 1
        else:
            i += 1
    return (srcs or [DEFAULT_SRC]), out

SRCS, OUT = parse_args(sys.argv[1:])
os.makedirs(OUT, exist_ok=True)

# <object ... script='...' 或 script="..." ；内部 XML 转义后不含裸引号，故安全
pat = re.compile(r"<object\b[^>]*\bscript=(['\"])(.*?)\1", re.S)

manifest = {}
total_blocks = 0
total_chars = 0
skipped_no_callback = 0

for SRC in SRCS:
  if not os.path.isdir(SRC):
    print(f"[skip] 源目录不存在: {SRC}")
    continue
  for tid in sorted(os.listdir(SRC)):
    base = os.path.join(SRC, tid)
    if not os.path.isdir(base) or not tid.isdigit():
        continue

    entry = manifest.setdefault(tid, {"id": tid, "files": {}, "blocks": 0, "chars": 0})
    for fn in ("vehicle.xml", "microcontroller.xml"):
        p = os.path.join(base, fn)
        if not os.path.isfile(p):
            continue
        try:
            with open(p, encoding="utf-8", errors="ignore") as f:   # 仅读
                txt = f.read()
        except Exception:
            continue

        kind = fn.split(".")[0]
        blocks = []
        for i, m in enumerate(pat.findall(txt)):
            lua = html.unescape(m[1])          # 反转义还原真 Lua
            if "onTick" not in lua and "onDraw" not in lua:
                skipped_no_callback += 1
                continue                       # 非游戏内 Lua 脚本块，跳过
            lines = lua.count("\n") + 1
            blocks.append({
                "idx": i,
                "file": f"{tid}_{kind}_{i}.lua",
                "chars": len(lua),
                "lines": lines,
                "minified": lines <= 3 and len(lua) > 400,   # 单行/极少数行 = 疑似压缩
            })
            with open(os.path.join(OUT, f"{tid}_{kind}_{i}.lua"), "w", encoding="utf-8") as f:
                f.write(f"-- source: steam id {tid} / {fn} block#{i}\n")
                f.write(f"-- url: https://steamcommunity.com/sharedfiles/filedetails/?id={tid}\n")
                f.write(lua)
            total_blocks += 1
            total_chars += len(lua)

        if blocks:
            entry["files"][kind] = blocks
            entry["blocks"] += len(blocks)
            entry["chars"] += sum(b["chars"] for b in blocks)

    if entry["blocks"]:
        manifest[tid] = entry

with open(os.path.join(OUT, "_manifest.json"), "w", encoding="utf-8") as f:
    json.dump(manifest, f, ensure_ascii=False, indent=1)

print(f"items_with_lua : {len(manifest)}")
print(f"lua_blocks     : {total_blocks}")
print(f"total_chars    : {total_chars}")
print(f"minified_blocks: {sum(1 for e in manifest.values() for b in e['files'] if any(x['minified'] for x in e['files'][b]))}")
print(f"skipped(no cb) : {skipped_no_callback}")
print(f"output         : {OUT}")
