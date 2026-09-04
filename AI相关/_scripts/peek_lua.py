#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""极低上下文的 Lua 批量速览 + 字符预算装箱。

目的：让 AI 用几十行输出覆盖几十上百个脚本，只在真正值得时才全文 dump，
从而在上下文上限内把「每轮学透的作品数」最大化。

用法（SRC 默认 D:\\STORMWORKS\\AI相关\\_提取暂存）：
  peek_lua.py [--src <目录>] [--topn 30]                 # 速览：每文件 1 行
  peek_lua.py --src <目录> --budget 25000                # 按 score 贪心装箱到 N 字符预算
  peek_lua.py --src <目录> --budget 25000 --emit-cmd     # 额外打印可直接执行的 dump 命令
输出字段：字符数 行数 | 主题 | api种类 | 自定义/回调函数名 | 文件名
"""
import os
import re
import sys
import json
import collections

SRC = r"D:\STORMWORKS\AI相关\_提取暂存"


def take(flag, default=None):
    """从 argv 取一个可选参数，取到后从 argv 中移除（保持位置参数干净）。"""
    a = sys.argv
    if flag in a:
        k = a.index(flag)
        v = a[k + 1] if k + 1 < len(a) else None
        del a[k:k + 2]
        return v
    return default


topn = take("--topn", "30")
topn = int(topn) if str(topn).isdigit() else 30
budget = take("--budget")
budget = int(budget) if budget and budget.isdigit() else None
src = take("--src") or SRC
if not os.path.isabs(src):                    # 相对目录一律挂到 BASE 下，与 dump/diff 口径一致
    src = os.path.join(SRC, src)
emit = "--emit-cmd" in sys.argv and sys.argv.remove("--emit-cmd") is None

CB = ("onTick", "onDraw", "onLBSimTick", "httpReply")
SIG = ("screen.", "map.", "property.", "matrix.", "input.", "output.",
       "server.", "httpGet", "async.", "string.", "table.", "math.")


def peek(path):
    try:
        t = open(path, encoding="utf-8", errors="ignore").read()
    except Exception:
        return None
    fn = os.path.basename(path)
    funcs = re.findall(r"^\s*function\s+([\w.:]+)", t, re.M)
    fns, seen = [], set()
    for f in funcs:
        if f not in seen:
            seen.add(f)
            fns.append(f)
    low = t.lower()
    topics = []
    for key, kws in {
        "radar": ("radar", "contact", "bearing"),
        "hud": ("screen.draw", "drawtext", "touch"),
        "weapon": ("missile", "turret", "gun", "torpedo"),
        "engine": ("rps", "throttle", "fuel", "temperature"),
        "autopilot": ("autopilot", "waypoint", "heading"),
        "comm": ("radio", "channel", "http"),
        "logic": ("pid", "filter", "state machine"),
    }.items():
        if any(k in low for k in kws):
            topics.append(key)
    kinds = sum(1 for s in SIG if s in t)
    # 分数沿用 census 口径的量级：API 种类 + 函数数 + 长度惩罚（偏好精炼脚本）
    score = kinds * 3 + len(fns) * 2 + (6 if all(c in t for c in ("onTick", "onDraw")) else 0)
    score -= max(0, len(t) - 6000) / 4000.0
    return {
        "file": fn, "chars": len(t), "lines": t.count("\n") + 1,
        "topics": topics, "api_kinds": kinds, "funcs": fns[:8], "score": round(score, 2),
        "minified": t.count("\n") <= 3 and len(t) > 400,
    }


pick = take("--pick")                         # 只在这些文件里装箱（配合 diff 的全新+补学清单）
pickset = {x.strip() for x in pick.split(",") if x.strip()} if pick else None

rows = [r for r in (peek(os.path.join(src, f)) for f in sorted(os.listdir(src))
                    if f.endswith(".lua")) if r]
if pickset is not None:
    hit = {r["file"] for r in rows} & pickset
    miss = pickset - hit
    rows = [r for r in rows if r["file"] in pickset]
    if miss:
        print(f"[pick] ⚠ 清单中 {len(miss)} 个文件不在 {src}：{' '.join(sorted(miss))[:300]}")
if not rows:
    print(f"（{src} 下没有 .lua）")
    raise SystemExit(0)

rows.sort(key=lambda r: (-r["score"], -r["chars"]))
print(f"== peek {len(rows)} files, {sum(r['chars'] for r in rows):,} chars  src={src}")

if budget is None:
    for r in rows[:topn]:
        print(f"{r['score']:>6} {r['chars']:>6}c {r['lines']:>4}L | {','.join(r['topics']) or '-':<24}"
              f" | api={r['api_kinds']:<3}{'M' if r['minified'] else ' '}| "
              f"{','.join(r['funcs']) or '-'} | {r['file']}")
    if len(rows) > topn:
        print(f"...（共 {len(rows)} 个，仅显示前 {topn}；加 --budget N 可按上下文预算装箱）")
else:
    # 单个文件最多占预算 maxfile（默认 1/5）：防止一个巨无霸脚本吃掉整批预算，
    # 这是在固定上下文里把「学透文件数」最大化的关键约束。
    maxfile = int(take("--maxfile") or 0) or max(budget // 5, 600)
    picked, used, oversized = [], 0, 0
    for r in rows:
        if r["chars"] > maxfile:
            oversized += 1
            continue
        if used + r["chars"] <= budget:
            picked.append(r)
            used += r["chars"]
    # 零头利用：大文件挑完后，用剩余预算塞入能装下的小文件
    if picked:
        have = {r["file"] for r in picked}
        for r in reversed(rows):
            if r["chars"] > maxfile or r["file"] in have:
                continue
            if used + r["chars"] <= budget:
                picked.append(r)
                used += r["chars"]
                have.add(r["file"])
    for r in picked:
        print(f"{r['score']:>6} {r['chars']:>6}c {r['lines']:>4}L | {','.join(r['topics']) or '-':<24}"
              f" | api={r['api_kinds']:<3}{'M' if r['minified'] else ' '}| "
              f"{','.join(r['funcs']) or '-'} | {r['file']}")
    print(f"\n[budget] 选中 {len(picked)}/{len(rows)} 个，合计 {used:,}/{budget:,} 字符"
          f"（超限跳过 {oversized} 个；未入选 {len(rows) - len(picked) - oversized} 个，留待下批/下轮）")
    if emit and picked:
        print("\n[dump 命令]")
        print(" ".join(r["file"] for r in picked))
