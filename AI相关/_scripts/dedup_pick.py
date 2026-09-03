#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
去重 + 选题：按内容 hash 合并完全相同的脚本，输出「唯一脚本」清单，
并按功能类别给出推荐精读清单（每类 top N），供后续分步读取。
"""
import os
import re
import json
import hashlib
import collections

SRC = r"D:\STORMWORKS\AI相关\_提取暂存"
census = json.load(open(os.path.join(SRC, "_census.json"), encoding="utf-8"))

groups = collections.defaultdict(list)
for r in census:
    p = os.path.join(SRC, r["file"])
    txt = open(p, encoding="utf-8", errors="ignore").read()
    body = txt.split("\n", 2)[2] if txt.startswith("-- source") else txt  # 去头两行注释
    h = hashlib.md5(body.encode("utf-8")).hexdigest()
    groups[h].append(r)

uniq = []
for h, rs in groups.items():
    best = max(rs, key=lambda x: x["score"])
    ids = sorted({x["file"].split("_")[0] for x in rs})
    best = dict(best)
    best["hash"] = h
    best["copies"] = len(rs)
    best["ids"] = ids
    uniq.append(best)

uniq.sort(key=lambda r: -r["score"])
json.dump(uniq, open(os.path.join(SRC, "_unique.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)

print(f"blocks {len(census)} -> unique {len(uniq)}  (压缩前重复率 {100*(1-len(uniq)/len(census)):.0f}%)")
print(f"unique chars: {sum(r['chars'] for r in uniq)}")
print("\n== 唯一脚本 TOP 50 ==")
for r in uniq[:50]:
    print(f"{r['score']:>6} x{r['copies']:<3} {r['chars']:>6}c {r['lines']:>4}L {'M' if r['minified'] else ' '} "
          f"| {','.join(r['topics']) or '-':<26} | {r['file']} | ids={','.join(r['ids'][:3])}")

print("\n== 按类别推荐（各类 top 8，按 score） ==")
by_topic = collections.defaultdict(list)
for r in uniq:
    for t in (r["topics"] or ["untagged"]):
        by_topic[t].append(r)
for t, rs in sorted(by_topic.items(), key=lambda kv: -len(kv[1])):
    print(f"\n### {t}  (unique {len(rs)})")
    for r in sorted(rs, key=lambda x: -x["score"])[:8]:
        print(f"   {r['score']:>6} {r['chars']:>6}c {'M' if r['minified'] else ' '} | {r['file']} | id={r['ids'][0]}")
