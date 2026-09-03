# -*- coding: utf-8 -*-
r"""
从 Fandom 知识库里枚举「Specialist Equipment」分类的全部成员。

背景：Fandom 没有 Specialist Equipment 分类子页（与 Weapons 一样是 ❌），
但每个 Research 页的 "Makes available" / "Unlocked by" 表里都有
`| Specialist Equipment | 部件名 |` 行。把这些行全捞出来去重，
即可得到该分类成员清单，同时记录解锁来源（研究项）。

优先用结构化字段 `tables[].rows`（比 wikitext 干净），wikitext 仅作兜底。
只读 D:\STORMWORKS\数据库\stormworks_fandom，不写任何东西。

用法：
    python 脚本\scan_specialist.py            # 列出成员 + 解锁来源
    python 脚本\scan_specialist.py --json     # 输出 JSON，便于与游戏定义比对
"""
import json
import os
import re
import sys
from collections import defaultdict

KB = r"D:\STORMWORKS\数据库\stormworks_fandom"
RECORDS = os.path.join(KB, "records")

CAT_RE = re.compile(r"^\s*Specialist\s+Equipment\s*$", re.I)
# wikitext 兜底：| Specialist Equipment | 部件名 |
ROW_RE = re.compile(r"^\s*\|\s*(?:\[\[)?Specialist\s+Equipment(?:\|[^\]]*\])?\s*\|\s*([^|]+?)\s*\|", re.I | re.M)
LINK_RE = re.compile(r"\[\[([^\]｜|]+)(?:[|｜][^\]]*)?\]\]")

SKIP = {"component", "category", "name", ""}


def clean(s):
    s = LINK_RE.sub(r"\1", str(s))
    s = s.replace("'''", "").replace("''", "").strip()
    return s


def iter_records():
    if not os.path.isdir(RECORDS):
        raise SystemExit("[x] 找不到知识库：%s" % RECORDS)
    for fn in sorted(os.listdir(RECORDS)):
        if not fn.endswith(".json"):
            continue
        with open(os.path.join(RECORDS, fn), "r", encoding="utf-8") as f:
            try:
                yield json.load(f)
            except Exception:
                continue


def main():
    members = defaultdict(set)   # 部件名 -> {解锁来源页}

    for d in iter_records():
        if d.get("redirect"):
            continue
        title = d.get("title") or ""

        # 1) 结构化表格
        for t in (d.get("tables") or []):
            rows = t.get("rows") or []
            for r in rows:
                if not isinstance(r, (list, tuple)) or len(r) < 2:
                    continue
                c0, c1 = clean(r[0]), clean(r[1])
                if CAT_RE.match(c0) and c1.lower() not in SKIP and set(c1) - set("-: "):
                    members[c1].add(title)

        # 2) wikitext 兜底（表格解析失败或未覆盖时）
        wt = d.get("wikitext") or ""
        if isinstance(wt, str) and CAT_RE.search(wt):
            for m in ROW_RE.finditer(wt):
                name = clean(m.group(1))
                if name.lower() not in SKIP and set(name) - set("-: ") and len(name) <= 60:
                    members[name].add(title)

    if "--json" in sys.argv:
        json.dump({k: sorted(v) for k, v in sorted(members.items())},
                  sys.stdout, ensure_ascii=False, indent=2)
        print()
        return 0

    print("[i] 从 Fandom 研究页枚举到 Specialist Equipment 成员 %d 个\n" % len(members))
    for name in sorted(members, key=str.lower):
        print("%-34s <- %s" % (name, ", ".join(sorted(members[name]))))
    return 0


if __name__ == "__main__":
    sys.exit(main())
