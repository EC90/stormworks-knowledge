# -*- coding: utf-8 -*-
"""
pick_lua_candidates.py —— 从批次目录（_r6c/_r7c/...）挑值得精读的 Lua 候选。

与 census_lua.py 的区别：census 跑全语料、按单段打分，同一作品的多个屏会霸榜；
本脚本专治批次库存，流程是「剥头部 → 全局 MD5 去重 → 排除已学 id →
按 steam id 分组（每组只留 top N）→ 按 SW 专属 API 加权打分 → 输出候选」。

用法：
    python pick_lua_candidates.py _r6c _r7c --per-id 2 --top 30
    python pick_lua_candidates.py _r7c --min 400 --max 9000 --top 20
    python pick_lua_candidates.py _r6c --only-id 3795248103,3794647482

只做只读扫描，不写任何文件。
"""
import os
import re
import sys
import json
import hashlib
import argparse

WS = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
STAGE = os.path.join(WS, "AI相关", "_提取暂存")
LEDGER = os.path.join(WS, "AI相关", "_meta", "ws_scan_progress.json")

# SW 专属 API / 手法信号（权重越高越值得看）
SIGNALS = [
    (r"\bmatrix\.", 6, "matrix"),
    (r"property\.getText", 6, "propText"),
    (r"\bmap\.screenToMap", 5, "s2m"),
    (r"\bmap\.mapToScreen", 4, "m2s"),
    (r"\bscreen\.drawTriangle", 4, "tri"),
    (r"\bstring\.byte", 4, "byte"),
    (r"\bmath\.atan", 3, "atan"),
    (r"\basync\.httpGet", 5, "http"),
    (r"\bserver\.", -100, "SERVER"),          # 附加 Lua，不该出现
    (r"\bscreen\.drawMap", 2, "drawMap"),
    (r"\binput\.getBool", 1, "inBool"),
    (r"\boutput\.setBool", 1, "outBool"),
    (r"\bproperty\.getNumber", 1, "propNum"),
    (r"\bscreen\.setMapColor", 3, "mapColor"),
    (r"\bgps", 2, "gps"),
    (r"\bradar", 3, "radar"),
    (r"\bsonar", 3, "sonar"),
    (r"\bpid\b", 2, "pid"),
    (r"\bquaternion|euler", 4, "att"),
    (r"\bfunction\s+onDraw", 2, "onDraw"),
    (r"\bfor\s+\w+\s*=\s*[^\n]*,\s*-1\b", 3, "revFor"),
    (r"\btable\.insert", 1, "tins"),
]

ID_RE = re.compile(r"^(\d{6,})_")


def strip_head(txt):
    """剥离 extract_workshop_lua.py 写入的两行头部（跨目录哈希比对的统一口径）。"""
    if txt.startswith("-- source"):
        return "\n".join(txt.split("\n")[2:])
    return txt


def load_learned():
    try:
        with open(LEDGER, encoding="utf-8") as f:
            return set(json.load(f).get("ids_learned", []))
    except Exception:
        return set()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("dirs", nargs="+", help="相对 _提取暂存 的批次子目录名，或绝对路径")
    ap.add_argument("--per-id", type=int, default=2, help="每个 steam id 最多留几段（默认 2）")
    ap.add_argument("--top", type=int, default=25, help="输出前 N 个候选")
    ap.add_argument("--min", type=int, default=300, dest="minc", help="最小字符数")
    ap.add_argument("--max", type=int, default=9000, dest="maxc", help="最大字符数")
    ap.add_argument("--only-id", default="", help="只保留这些 steam id（逗号分隔）")
    args = ap.parse_args()

    learned = load_learned()
    only = set(x for x in args.only_id.split(",") if x.strip())

    seen_hash = {}
    cands = []
    total = 0
    for d in args.dirs:
        base = d if os.path.isabs(d) else os.path.join(STAGE, d)
        if not os.path.isdir(base):
            print(f"[skip] {base} 不是目录")
            continue
        for fn in sorted(os.listdir(base)):
            if not fn.endswith(".lua"):
                continue
            p = os.path.join(base, fn)
            try:
                raw = open(p, encoding="utf-8", errors="ignore").read()
            except Exception:
                continue
            total += 1
            body = strip_head(raw)
            n = len(body)
            if n < args.minc or n > args.maxc:
                continue
            m = ID_RE.match(fn)
            sid = m.group(1) if m else "?"
            if only and sid not in only:
                continue
            h = hashlib.md5(body.encode("utf-8", "ignore")).hexdigest()
            if h in seen_hash:
                continue
            seen_hash[h] = fn
            score = 0
            hits = []
            for pat, w, tag in SIGNALS:
                c = len(re.findall(pat, body, re.I))
                if c:
                    score += w * min(c, 3)
                    hits.append(f"{tag}x{c}")
            # 长度加成：太短没内容，太长是综合 HUD（只摘片段），中段最优
            if 800 <= n <= 4500:
                score += 6
            elif 4500 < n <= 9000:
                score += 2
            cands.append({
                "file": fn,
                "dir": os.path.basename(base),
                "id": sid,
                "len": n,
                "score": score,
                "hits": ",".join(hits[:6]),
                "learned": sid in learned,
                "path": p,
            })

    # 去掉已学 id（除非 --only-id 显式指定）
    if not only:
        cands = [c for c in cands if not c["learned"]]

    # 按 steam id 分组，每组只留 per-id 个最高分
    by_id = {}
    for c in sorted(cands, key=lambda x: -x["score"]):
        by_id.setdefault(c["id"], []).append(c)
    picked = []
    for sid, lst in by_id.items():
        picked.extend(lst[: args.per_id])
    picked.sort(key=lambda x: -x["score"])

    print(f"扫描 {total} 个文件 → 去重后 {len(cands)} 段 → 按 id 收敛 {len(picked)} 段 "
          f"（{len(by_id)} 个作品）→ 输出 TOP {min(args.top, len(picked))}\n")
    print(f"{'score':>5} {'len':>6} {'id':<11} {'批次':<7} 信号")
    print("-" * 100)
    for c in picked[: args.top]:
        flag = " [已学]" if c["learned"] else ""
        print(f"{c['score']:>5} {c['len']:>6} {c['id']:<11} {c['dir']:<7} {c['hits']}{flag}")
        print(f"        {c['path']}")


if __name__ == "__main__":
    main()
