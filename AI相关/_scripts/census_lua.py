#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
对 _提取暂存 中的 Lua 做程序化普查：按 SW 专属 API 打标签、打分排序，
让后续精读只聚焦高价值脚本（省注意力）。只读暂存目录。
"""
import os
import re
import sys
import json
import collections

# 默认普查整个 _提取暂存；传 --src 可只普查某个批次（如 _提取暂存\_new）
SRC = r"D:\STORMWORKS\AI相关\_提取暂存"
if "--src" in sys.argv:
    SRC = sys.argv[sys.argv.index("--src") + 1]

# SW 专属手法关键词（权重 = 信息价值）
SIGNALS = {
    "screen.draw": 3, "screen.setColor": 2, "screen.drawText": 2, "screen.drawLine": 2,
    "screen.drawRect": 2, "screen.drawCircle": 2, "screen.drawTriangle": 3,
    "screen.drawMap": 4, "screen.drawTextBox": 3, "screen.drawClear": 1,
    "map.screenToMap": 4, "map.mapToScreen": 4, "map.screenToWorld": 4, "map.worldToScreen": 4,
    "property.get": 3, "property.getText": 4, "property.getBool": 3, "property.getNumber": 3,
    "matrix.": 5, "input.getBool": 1, "input.getNumber": 1, "output.setBool": 1, "output.setNumber": 1,
    "httpReply": 6, "async": 6,
    "math.atan": 2, "math.sqrt": 1, "math.sin": 1, "math.cos": 1,
    "string.format": 1, "string.sub": 1, "string.byte": 2, "string.char": 2,
    "table.insert": 1, "table.remove": 1,
    "onDraw": 2, "onTick": 0,
}
# 功能线索词（英文工坊描述常用）
TOPIC = {
    "autopilot": ["autopilot", "heading hold", "waypoint", "gps"],
    "radar": ["radar", "target", "contact", "bearing", "range"],
    "hud": ["hud", "display", "gauge", "indicator", "menu", "button", "touch"],
    "weapon": ["missile", "gun", "turret", "torpedo", "bomb", "fire", "aim", "ballistic"],
    "engine": ["engine", "fuel", "throttle", "rps", "temperature", "fuel tank"],
    "comm": ["radio", "channel", "transmit", "receive", "encrypt", "message"],
    "sensor": ["sensor", "sonar", "lidar", "altitude", "depth", "velocity", "compass", "tilt"],
    "logic": ["pid", "filter", "average", "smooth", "counter", "timer", "state machine"],
}


def analyze(path):
    try:
        with open(path, encoding="utf-8", errors="ignore") as f:
            txt = f.read()
    except Exception:
        return None
    low = txt.lower()
    lines = txt.count("\n") + 1
    chars = len(txt)
    score = 0
    hits = collections.Counter()
    for k, w in SIGNALS.items():
        c = low.count(k.lower())
        if c:
            hits[k] = c
            score += w * min(c, 3)          # 同一 API 最多计 3 次，避免大脚本霸榜
    topics = []
    for t, kws in TOPIC.items():
        if any(k in low for k in kws):
            topics.append(t)
    # 密度分：每千字符的 API 种类数（衡量单位信息量）
    density = len(hits) / max(chars / 1000.0, 0.001)
    return {
        "file": os.path.basename(path),
        "chars": chars,
        "lines": lines,
        "minified": lines <= 3 and chars > 400,
        "topics": topics,
        "api_hits": dict(hits.most_common(12)),
        "api_kinds": len(hits),
        "score": round(score, 1),
        "density": round(density, 2),
    }


rows = []
for fn in sorted(os.listdir(SRC)):
    if not fn.endswith(".lua"):
        continue
    r = analyze(os.path.join(SRC, fn))
    if r:
        rows.append(r)

rows.sort(key=lambda r: -r["score"])
with open(os.path.join(SRC, "_census.json"), "w", encoding="utf-8") as f:
    json.dump(rows, f, ensure_ascii=False, indent=1)

print(f"blocks: {len(rows)}   total_chars: {sum(r['chars'] for r in rows)}")
print(f"minified: {sum(1 for r in rows if r['minified'])}")
print(f"empty/trivial(<80 chars): {sum(1 for r in rows if r['chars'] < 80)}")
print("\n== TOP 40 by score ==")
for r in rows[:40]:
    print(f"{r['score']:>7} | {r['chars']:>7}c {r['lines']:>4}L | {','.join(r['topics']) or '-':<28} | {r['file']}")
print("\n== TOP 15 by API density ==")
for r in sorted(rows, key=lambda x: -x["density"])[:15]:
    print(f"{r['density']:>7} | {r['chars']:>7}c {r['api_kinds']:>3} kinds | {r['file']}")
print("\n== 各类别脚本数 ==")
c = collections.Counter()
for r in rows:
    for t in r["topics"]:
        c[t] += 1
for t, n in c.most_common():
    print(f"  {t:<10} {n}")
