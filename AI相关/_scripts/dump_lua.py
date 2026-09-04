#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""按文件名清单逐个打印批次目录下的 lua（只读）。
用法：dump_lua.py [--dir _new|_r6|_big] [--maxc N] f1.lua f2.lua ...
  --maxc N   单文件最多打印 N 字符，超出截断并标注 [TRUNC n/N]
  --head N   只打印每个文件前 N 行（与 --maxc 取更严者）"""
import os, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
BASE = r"D:\STORMWORKS\AI相关\_提取暂存"
_a = sys.argv[1:]
_d = "_new"
if "--dir" in _a:
    _k = _a.index("--dir")
    if len(_a) > _k + 1:
        _d = _a[_k + 1]
    _a = _a[:_k] + _a[_k + 2:]
_maxc = None
if "--maxc" in _a:
    _k = _a.index("--maxc")
    if _k + 1 < len(_a) and _a[_k + 1].isdigit():
        _maxc = int(_a[_k + 1])
    _a = _a[:_k] + _a[_k + 2:]
_head = None
if "--head" in _a:
    _k = _a.index("--head")
    if _k + 1 < len(_a) and _a[_k + 1].isdigit():
        _head = int(_a[_k + 1])
    _a = _a[:_k] + _a[_k + 2:]
# ⚠ 只有绝对路径才原样采用；相对目录一律挂到 BASE 下
# （旧版用 os.path.isdir(_d) 判断，导致 `--dir .` 被解析成当前工作目录而非 BASE，静默 MISS）
N = _d if os.path.isabs(_d) else os.path.join(BASE, _d)
for f in _a:
    p = os.path.join(N, f)
    if not os.path.isfile(p):
        print("MISS", f)
        continue
    t = open(p, encoding="utf-8", errors="ignore").read()
    if _head:
        t = "\n".join(t.split("\n")[:_head])
    if _maxc and len(t) > _maxc:
        t = t[:_maxc] + f"\n...[TRUNC {_maxc}/{len(t)} chars]"
    print("=" * 18, f, "=" * 18)
    print(t)
