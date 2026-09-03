#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""批量中英术语查表（对照表为唯一基准）。

为什么需要它：sw_lookup.py 一次只能查一个词，整理整页部件清单时要跑几十次。
这个脚本一次吃进一批英文词，输出「命中 / 近似 / 未收录」三档结果，
未收录的词就是需要人工定名的地方，避免整篇文档悄悄混进自译词。

用法::

    python sw_batch.py terms.txt            # 每行一个英文词
    python sw_batch.py --terms "A,B,C"
    python sw_batch.py terms.txt --fuzzy    # 未命中时额外给出包含该词的候选
    python sw_batch.py terms.txt --json     # 机器可读输出

查找顺序：精确（大小写不敏感）→ 去尾点/空白后精确 → 包含匹配（取最短的若干条）。
"""

from __future__ import annotations

import argparse
import json
import re
import sys
import unicodedata
from pathlib import Path

BASE = Path(__file__).resolve().parent.parent
DICT_PATH = BASE / "数据" / "sw_core_dict.json"

HIT = "HIT"        # 精确命中对照表
FUZZY = "FUZZY"    # 只找到包含该词的条目，需人工确认
MISS = "MISS"      # 对照表未收录，需人工定名


def norm(text: str) -> str:
    """归一化：全角转半角、压空白、去首尾标点。"""
    text = unicodedata.normalize("NFKC", text)
    text = re.sub(r"\s+", " ", text).strip()
    return text.strip(" .,:;!?\"'()[]")


def load_dict(path: Path = DICT_PATH) -> dict:
    data = json.loads(path.read_text(encoding="utf-8"))
    table = data["dict"] if isinstance(data, dict) and "dict" in data else data
    return {norm(k): v for k, v in table.items() if k}


def lookup(term: str, table: dict, fuzzy: bool = True, limit: int = 3):
    """返回 (状态, 译文, 候选列表)。"""
    key = norm(term)
    if not key:
        return MISS, "", []

    if key in table:
        return HIT, table[key], []

    lowered = {k.lower(): k for k in table}
    if key.lower() in lowered:
        return HIT, table[lowered[key.lower()]], []

    if not fuzzy:
        return MISS, "", []

    needle = key.lower()
    candidates = [k for k in table if needle in k.lower()]
    # 短的更可能是部件名本身（长条目多半是说明文字）
    candidates.sort(key=lambda k: (len(k), k))
    picked = []
    for k in candidates[:limit]:
        zh = table[k]
        if len(zh) > 40:
            zh = zh[:37] + "…"
        picked.append((k, zh))
    return (FUZZY if picked else MISS), "", picked


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description="批量查 Stormworks 中英对照表")
    ap.add_argument("file", nargs="?", help="每行一个英文词的文本文件，省略则从 stdin 读")
    ap.add_argument("--terms", help="逗号分隔的英文词，优先级高于 file")
    ap.add_argument("--no-fuzzy", action="store_true", help="不做包含匹配，只认精确命中")
    ap.add_argument("--json", action="store_true", help="输出 JSON")
    ap.add_argument("--limit", type=int, default=3, help="包含匹配的候选条数，默认 3")
    args = ap.parse_args(argv)

    if args.terms:
        terms = [t for t in re.split(r"[,\n]", args.terms) if t.strip()]
    elif args.file:
        terms = [ln.strip() for ln in Path(args.file).read_text(encoding="utf-8").splitlines()]
        terms = [t for t in terms if t and not t.startswith("#")]
    else:
        terms = [ln.strip() for ln in sys.stdin.read().splitlines() if ln.strip()]

    table = load_dict()
    results = []
    for term in terms:
        status, zh, cand = lookup(term, table, fuzzy=not args.no_fuzzy, limit=args.limit)
        results.append({"term": term, "status": status, "zh": zh, "candidates": cand})

    if args.json:
        print(json.dumps(results, ensure_ascii=False, indent=2))
    else:
        mark = {HIT: "✔", FUZZY: "≈", MISS: "✘"}
        for r in results:
            if r["status"] == HIT:
                print(f'{mark[HIT]} {r["term"]} = {r["zh"]}')
            else:
                print(f'{mark[r["status"]]} {r["term"]}')
                for k, v in r["candidates"]:
                    print(f'      ? {k} = {v}')

    counts = {s: sum(1 for r in results if r["status"] == s) for s in (HIT, FUZZY, MISS)}
    print(
        f'\n合计 {len(results)}：命中 {counts[HIT]} / 待确认 {counts[FUZZY]} / 未收录 {counts[MISS]}',
        file=sys.stderr,
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
