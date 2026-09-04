#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""一轮学习进度的「唯一数字来源」。每轮开场与收尾各跑一次，报告直接引用其输出。

用法：
  ws_progress.py            # 全量统计（会按需重建 learned 索引）
  ws_progress.py --fast     # 不重建索引，直接读现有 _workshop_learned.json（更快）

口径说明：
  已学习 = 例题正文里带「- 来源：steam id <id>」的作品（ws_reference 索引 learned=true）
  待学习 = 榜单候选池中 state ∉ {已学习, 无Lua} 的作品数
  无Lua  = 已确认下载过但不含游戏内 Lua，不会再进待办
"""
import os
import sys
import json
import collections

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import ws_rank as R                    # noqa: E402
import ws_reference as ref             # noqa: E402

WS = R.WS
LEDGER = os.path.join(WS, "AI相关", "_meta", "ws_scan_progress.json")
CORPUS = os.path.join(WS, "AI相关", "_提取暂存")


def main():
    fast = "--fast" in sys.argv
    idx = ref.load_index(allow_build=not fast)
    learned = {k for k, v in idx.items() if v.get("learned")}
    workshop = R.resolve_workshop()

    doc = R.load_ranked()
    items = doc.get("items") or {}
    dist = collections.Counter()
    for tid, it in items.items():
        dist[R.state_of(tid, idx, workshop)] += 1

    led = {}
    if os.path.isfile(LEDGER):
        try:
            led = json.load(open(LEDGER, encoding="utf-8"))
        except Exception:
            led = {}
    led_learned = set(led.get("ids_learned") or [])
    pending = set(led.get("pending_ids") or [])
    comp = led.get("completeness") or {}      # pages_scanned / cursor_page 在 completeness 子对象里

    corpus_n = sum(1 for f in os.listdir(CORPUS) if f.endswith(".lua")) \
        if os.path.isdir(CORPUS) else 0

    print("== WS 学习进度 ==")
    print(f"已学习(例题索引)   : {len(learned)}")
    print(f"已学习(账本)       : {len(led_learned)}"
          + ("" if len(led_learned) == len(learned) else
             f"   ⚠ 与索引差 {len(learned) - len(led_learned):+d}，以索引为准，收尾请同步账本"))
    print(f"候选池总量         : {len(items)}")
    for s in ("待学习", "已提取", "已暂存", "已订阅", "新", "已学习", "无Lua"):
        if dist.get(s):
            print(f"  - {s:<8}: {dist[s]}")
    print(f"待学习(口径)       : {dist['新'] + dist['已提取'] + dist['已暂存'] + dist['已订阅']}")
    print(f"无Lua(已标记)      : {len(R.load_no_lua())}")
    print(f"完整性待办 pending : {len(pending)}   游标页 {comp.get('cursor_page', led.get('cursor_page', '?'))}"
          f"  已扫 {comp.get('pages_scanned', '?')} 页"
          f"  完成={comp.get('done', '?')}")
    print(f"语料库 .lua 文件   : {corpus_n}")
    if "--ids" in sys.argv:
        print("\n[已学习 id] " + " ".join(sorted(learned)))
    if "--json" in sys.argv:
        print("\n[JSON] " + json.dumps({
            "learned": len(learned), "learned_ledger": len(led_learned),
            "pool": len(items), "todo": dist['新'] + dist['已提取'] + dist['已暂存'] + dist['已订阅'],
            "no_lua": len(R.load_no_lua()), "pending": len(pending),
            "cursor_page": led.get("cursor_page"), "corpus": corpus_n,
        }, ensure_ascii=False))


if __name__ == "__main__":
    main()
