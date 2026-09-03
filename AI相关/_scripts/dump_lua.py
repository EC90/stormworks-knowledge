#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""按文件名清单逐个打印 _new 下的 lua（只读）。用法：dump_lua.py f1.lua f2.lua ..."""
import os, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
N = r"D:\STORMWORKS\AI相关\_提取暂存\_new"
for f in sys.argv[1:]:
    p = os.path.join(N, f)
    if not os.path.isfile(p):
        print("MISS", f)
        continue
    print("=" * 18, f, "=" * 18)
    print(open(p, encoding="utf-8", errors="ignore").read())
