#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""按 id / 英文 / 中文模糊检索部件条目（sw_batch 未命中时的兜底手段）。

sw_batch.py 只认精确或包含匹配的英文原文，但 wiki 的部件名经常和游戏内名不一致
（例如 wiki 写 `Motor Small`，对照表里是 `Electric Motor (Small)`）。
这个脚本直接在完整对照表里按关键词捞部件条目，用来人工确认对应关系。

用法::

    python sw_find.py Motor Rocket          # 多关键词，任一命中即列出
    python sw_find.py Motor --field id      # 只在 id 字段里搜（如 def_motor_）
    python sw_find.py Motor --parts-only    # 只列部件（排除 UI 文案）
    python sw_find.py Motor --limit 50
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

BASE = Path(__file__).resolve().parent.parent
GLOSSARY = BASE / "数据" / "sw_glossary.jsonl"


def load_rows(path: Path = GLOSSARY):
    return [json.loads(line) for line in path.read_text(encoding="utf-8").splitlines() if line.strip()]


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description="按关键词检索 Stormworks 对照表条目")
    ap.add_argument("keywords", nargs="+", help="关键词，大小写不敏感，任一命中即列出")
    ap.add_argument("--field", choices=("any", "en", "zh", "id"), default="any",
                    help="检索字段，默认 any（en/zh/id/family 全部）")
    ap.add_argument("--parts-only", action="store_true", help="只列部件条目（排除界面文案）")
    ap.add_argument("--limit", type=int, default=30, help="最多输出条数，默认 30")
    args = ap.parse_args(argv)

    rows = load_rows()
    keys = [k.lower() for k in args.keywords]
    fields = ("en", "zh", "id", "family") if args.field == "any" else (args.field,)

    hits = []
    for r in rows:
        if args.parts_only and not (r.get("id") or "").startswith("def_"):
            continue
        blob = " ".join(str(r.get(f) or "") for f in fields).lower()
        if any(k in blob for k in keys):
            hits.append(r)

    # 部件优先，且 id 以 _name 结尾的（正式部件名）排前面
    hits.sort(key=lambda r: (
        0 if (r.get("id") or "").endswith("_name") else 1,
        0 if (r.get("id") or "").startswith("def_") else 1,
        len(r.get("en") or ""),
    ))
    for r in hits[: args.limit]:
        rid = r.get("id") or "-"
        print(f'{rid:44s} {r.get("en","")[:52]:54s} → {r.get("zh","")}')
    print(f'\n共 {len(hits)} 条，显示 {min(len(hits), args.limit)} 条', file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
