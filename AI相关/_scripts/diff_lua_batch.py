#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""本批 vs 主语料哈希差分：剔除已在主语料（_提取暂存/*.lua）出现过的脚本。
口径统一：剥离提取头部两行（-- source: / -- url:）后再取 MD5。只读。"""
import os, sys, io, hashlib

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
BASE = r"D:\STORMWORKS\AI相关\_提取暂存"
NEW = os.path.join(BASE, "_new")
IDS = sys.argv[1].split(",") if len(sys.argv) > 1 else []


def body_of(p):
    t = open(p, encoding="utf-8", errors="ignore").read()
    return t.split("\n", 2)[2] if t.startswith("-- source") else t


main = {}
for fn in os.listdir(BASE):
    if fn.endswith(".lua"):
        main[hashlib.md5(body_of(os.path.join(BASE, fn)).encode("utf-8")).hexdigest()] = fn
for d in ("_big",):
    p = os.path.join(BASE, d)
    if os.path.isdir(p):
        for fn in os.listdir(p):
            if fn.endswith(".lua"):
                main[hashlib.md5(body_of(os.path.join(p, fn)).encode("utf-8")).hexdigest()] = d + "/" + fn

print("主语料唯一脚本 %d 个\n" % len(main))
new_only, dup = [], []
seen = {}
for fn in sorted(os.listdir(NEW)):
    if not fn.endswith(".lua"):
        continue
    if IDS and fn.split("_")[0] not in IDS:
        continue
    b = body_of(os.path.join(NEW, fn))
    h = hashlib.md5(b.encode("utf-8")).hexdigest()
    if h in seen:
        continue
    seen[h] = fn
    if h in main:
        dup.append((fn, main[h]))
    else:
        new_only.append((fn, len(b)))

print("本批唯一 %d → 主语料已存在 %d / 全新 %d\n" % (len(seen), len(dup), len(new_only)))
print("== 全新（优先精读）==")
for fn, n in sorted(new_only, key=lambda x: -x[1]):
    print("  %6dc  %s" % (n, fn))
print("\n== 与主语料重复（跳过）==")
for fn, m in sorted(dup):
    print("  %-34s == %s" % (fn, m))
