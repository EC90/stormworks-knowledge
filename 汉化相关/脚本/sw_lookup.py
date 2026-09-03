#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
sw_lookup.py — Stormworks 中英对照表查询工具（给 AI 和人都用）。

用法：
    python sw_lookup.py "modular engine cylinder"    # 英文/中文关键词，模糊匹配
    python sw_lookup.py --zh 螺旋桨                  # 只搜中文字段
    python sw_lookup.py --en propeller               # 只搜英文字段
    python sw_lookup.py --id def_giga_prop_small_name # 按 id（支持前缀/子串）
    python sw_lookup.py --cat 引擎与动力 --limit 40   # 按模块/族浏览
    python sw_lookup.py --exact "Giant Propeller"    # 英文精确匹配
    python sw_lookup.py --kind name --cat 引擎与动力 # 只看部件名
    python sw_lookup.py --json "propeller"           # 以 JSON 输出（便于程序消费）

输出格式（默认）：
    中文 \t 英文 \t [模块/族] \t id
"""

import argparse
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
DATA = os.path.join(os.path.dirname(HERE), "数据", "sw_glossary.jsonl")
CORE = os.path.join(os.path.dirname(HERE), "数据", "sw_core_dict.json")


def warn_if_stale():
    """查表前顺带看一眼新鲜度；过期就在 stderr 提示，不影响正常查询结果。"""
    try:
        import sw_state
        r = sw_state.check()
        sw_state.save_state(last_check=sw_state.now_iso())
        if r["need_update"]:
            print("[!] 对照表可能过期：%s。请执行 python 脚本/sw_check.py --auto" % r["reason"],
                  file=sys.stderr)
    except Exception:
        pass                      # 状态检查失败绝不能影响查表


def load():
    if not os.path.exists(DATA):
        sys.exit("找不到数据文件 %s，请先运行 build_glossary.py" % DATA)
    with open(DATA, encoding="utf-8") as f:
        return [json.loads(line) for line in f if line.strip()]


def score(e, q, field):
    v = (e.get(field) or "")
    if v == q:
        return 0
    if v.lower() == q.lower():
        return 1
    if q.lower() in v.lower():
        return 2
    return 99


def main():
    ap = argparse.ArgumentParser(add_help=True)
    ap.add_argument("query", nargs="?", default="", help="关键词（同时搜中英文）")
    ap.add_argument("--en", help="只搜英文")
    ap.add_argument("--zh", help="只搜中文")
    ap.add_argument("--id", dest="by_id", help="按 id 查（支持子串）")
    ap.add_argument("--cat", help="按模块/族/主题过滤，如 引擎与动力 / gun")
    ap.add_argument("--kind", help="类型过滤：name/desc/s_desc/label/ui")
    ap.add_argument("--exact", help="英文精确匹配")
    ap.add_argument("--limit", type=int, default=30, help="最多输出条数，默认 30")
    ap.add_argument("--json", action="store_true", help="以 JSON 输出")
    ap.add_argument("--all", action="store_true", help="不过滤，输出全部（慎用）")
    ap.add_argument("--no-stale-check", action="store_true",
                    help="跳过新鲜度检查（默认会在过期时于 stderr 提示）")
    a = ap.parse_args()

    if not a.no_stale_check:
        warn_if_stale()

    rows = load()

    # ---- 精确 EN 查（走去重词典，最快）
    if a.exact:
        core = json.load(open(CORE, encoding="utf-8"))["dict"]
        zh = core.get(a.exact)
        if zh is None:
            print("（未找到）%s" % a.exact)
            return 1
        print("%s\t%s" % (a.exact, zh))
        return 0

    # ---- 过滤
    res = rows
    if a.by_id:
        res = [e for e in res if a.by_id.lower() in (e["id"] or "").lower()]
    if a.cat:
        c = a.cat.lower()
        res = [e for e in res if c in (e["module"] or "").lower()
               or c in (e["family"] or "").lower()
               or c in (e["family_cn"] or "").lower()
               or c in (e["topic"] or "").lower()]
    if a.kind:
        res = [e for e in res if e["kind"] == a.kind]

    # ---- 关键词
    qs = [a.en] if a.en else []
    if a.zh:
        qs.append(a.zh)
    if a.query:
        qs.append(a.query)

    if qs and not a.en and not a.zh:
        # 普通 query：中英文都搜
        def match(e):
            q = qs[0].lower()
            return q in (e["en"] or "").lower() or q in (e["zh"] or "").lower()
        res = [e for e in res if match(e)]
    else:
        for q in qs:
            res = [e for e in res if q.lower() in (e["en"] or "").lower()
                   or q.lower() in (e["zh"] or "").lower()]

    if not a.all and not qs and not a.by_id and not a.cat and not a.kind:
        ap.print_help()
        return 1

    res.sort(key=lambda e: min(score(e, qs[0], "en"), score(e, qs[0], "zh")) if qs else 0)

    if a.json:
        print(json.dumps(res[:a.limit], ensure_ascii=False, indent=1))
        return 0

    if not res:
        print("（无匹配结果）")
        return 1

    shown = 0
    seen = set()
    for e in res:
        key = (e["en"], e["zh"])
        if key in seen:            # 去重：同一对譯文只显示一次
            continue
        seen.add(key)
        zh = e["zh"] or "（未翻译）"
        tag = "%s/%s" % (e["module"], e["family_cn"] or e["topic"] or e["kind"])
        print("%s\t%s\t[%s]\t%s" % (zh, e["en"], tag, e["id"] or "-"))
        shown += 1
        if shown >= a.limit:
            break
    print("---")
    print("命中 %d 条（去重后显示 %d 条）" % (len(res), shown))
    return 0


if __name__ == "__main__":
    sys.exit(main())
