#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""只对本轮 12 个目标 id 做去重 + 选题（口径：剥离提取头部两行后取 MD5）。只读。"""
import os, sys, json, hashlib, collections, io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

BASE = r"D:\STORMWORKS\AI相关\_提取暂存"
# 用法：dedup_lua_batch.py [--] <id,id,...> [--dir _r4]
#   ids 位置参数与 "--" 占位兼容（-- 后可接 id 列表）；--dir 指定批次子目录，默认 _new
_a = sys.argv[1:]
_dir = "_new"
if "--dir" in _a:
    _k = _a.index("--dir")
    if len(_a) > _k + 1:
        _dir = _a[_k + 1]
    _a = _a[:_k] + _a[_k + 2:]          # 去掉 --dir 及其取值，避免被当成 id
NEW = _dir if os.path.isdir(_dir) else os.path.join(BASE, _dir)
_pos = [x for x in _a if x not in ("--", "-")]      # 剩下的裸参数即 id 列表
IDS = [x for x in _pos[0].split(",") if x] if _pos else []

census = {}
cp = os.path.join(NEW, "_census.json")
if os.path.isfile(cp):
    for r in json.load(open(cp, encoding="utf-8")):
        census[r["file"]] = r

rows = []
for fn in sorted(os.listdir(NEW)):
    if not fn.endswith(".lua"):
        continue
    if IDS and fn.split("_")[0] not in IDS:
        continue
    p = os.path.join(NEW, fn)
    txt = open(p, encoding="utf-8", errors="ignore").read()
    body = txt.split("\n", 2)[2] if txt.startswith("-- source") else txt
    h = hashlib.md5(body.encode("utf-8")).hexdigest()
    c = census.get(fn, {})
    rows.append({
        "file": fn, "hash": h, "chars": c.get("chars", len(body)),
        "lines": c.get("lines", body.count("\n") + 1),
        "score": c.get("score", 0), "topics": c.get("topics", []),
        "minified": c.get("minified", False),
    })

groups = collections.defaultdict(list)
for r in rows:
    groups[r["hash"]].append(r)

uniq = []
for h, rs in groups.items():
    best = max(rs, key=lambda x: x["score"])
    best = dict(best)
    best["copies"] = len(rs)
    best["files"] = sorted(x["file"] for x in rs)
    best["ids"] = sorted({x["file"].split("_")[0] for x in rs})
    uniq.append(best)

uniq.sort(key=lambda r: (-r["score"], -r["chars"]))
print(f"blocks {len(rows)} -> unique {len(uniq)}   (重复率 {100*(1-len(uniq)/max(len(rows),1)):.0f}%)")
print(f"unique chars: {sum(r['chars'] for r in uniq)}")
print()
for i, r in enumerate(uniq, 1):
    print(f"{i:>3}. sc={r['score']:<4} x{r['copies']:<3} {r['chars']:>6}c {r['lines']:>4}L "
          f"{'M' if r['minified'] else ' '} | {','.join(r['topics']) or '-':<24} | {r['file']}"
          + (f" (+{r['copies']-1})" if r["copies"] > 1 else ""))
