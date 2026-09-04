#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""按文件名清单逐个打印批次目录下的 lua（只读）。
用法：dump_lua.py [--dir _new|_r6|_big] f1.lua f2.lua ..."""
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
N = _d if os.path.isdir(_d) else os.path.join(BASE, _d)
for f in _a:
    p = os.path.join(N, f)
    if not os.path.isfile(p):
        print("MISS", f)
        continue
    print("=" * 18, f, "=" * 18)
    print(open(p, encoding="utf-8", errors="ignore").read())
