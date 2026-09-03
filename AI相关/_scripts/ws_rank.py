#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
创意工坊候选作品「价值排序器」——先吃高价值作品，而不是按最新顺序硬啃全站。

为什么需要它
  直接按 mostrecent 遍历全站，前面几页往往是刚传上来的空壳作品，性价比极低。
  本脚本把三个浏览维度 + Steam Web API 的元数据合成一个加权分，按分数降序产出
  待办队列，让每一轮自动化都先处理最值得学的作品。

三个浏览维度（来自 steamcommunity.com/workshop/browse）
  trend                    当前热度（近期订阅增速）
  totaluniquesubscribers   累计独立订阅数（长线价值）
  lastupdated              最近更新（把老作品翻新过的也捞进来）

五个评分项与默认权重（可用 --weights 覆盖，和须为 1.0）
  trend  0.28   在 trend 浏览页中的位次得分，1/页码（第 1 页满分，长尾衰减）
  subs   0.24   在 totaluniquesubscribers 浏览页中的位次得分，1/页码
  upd    0.08   在 lastupdated 浏览页中的位次得分，1/页码
  pop    0.15   订阅数绝对值，log10 归一（除以本批次最大值，避免绝对阈值过时）
  fresh  0.25   更新时间新鲜度，0.5 ** (距今天数 / HALFLIFE_DAYS)，默认半衰期 540 天

成本加成（同分层里优先吃现成的，省一次下载）
  已订阅 +8 / 已免订阅暂存 +5 / Lua 已提取 +3，上限 100 分封顶后仍取原值（不截断）

用法
  python ws_rank.py --crawl 4              # 三个维度各抓前 4 页 → 拉元数据 → 算分 → 存榜
  python ws_rank.py --top 12               # 输出排名前 12 的「未学习」id（空格分隔，可直接喂 ws_download.py）
  python ws_rank.py --show 20              # 打印榜单给人看（--all 时含已学习的）
  python ws_rank.py --refresh              # 不重抓浏览页，只补全/刷新已有候选的元数据并重算分
  python ws_rank.py --crawl 4 --weights trend=0.3,subs=0.25,upd=0.05,pop=0.15,fresh=0.25
  python ws_rank.py --browse mostrecent 37 3   # 只抓浏览页并打印 id（排序 起始页 页数），
                                               # 供「完整性轨」按游标推进，不排名不写榜

产出
  D:\\STORMWORKS\\AI相关\\_meta\\ws_ranked.json

⚠ 硬性约束（与流水线其余部分一致）
  1. 只读红线：订阅目录 <SW_WORKSHOP> 只读，本脚本绝不写入/删除其中任何文件。
  2. steamcommunity.com 有 IP 级 403 限流：遇到 403 直接放弃本维度并记入榜单的
     crawl.note，**不要重试**（api.steampowered.com 与 SteamCMD 通常仍可用）。
  3. 路径不硬编码：优先读 工作区导航\\路径配置.json，其次 sw_paths.detect()，
     最后回退到 ws_reference.py 里的常量。
"""
import os
import re
import sys
import json
import time
import math
import datetime
import urllib.request

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except Exception:
    pass

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import ws_reference as ref                      # noqa: E402  复用查重逻辑与常量

APPID = 573090
UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
BROWSE = "https://steamcommunity.com/workshop/browse/"
SORTS = ["trend", "totaluniquesubscribers", "lastupdated"]

HALFLIFE_DAYS = 540          # 更新时间新鲜度的半衰期
W_DEFAULT = {"trend": 0.28, "subs": 0.24, "upd": 0.08, "pop": 0.15, "fresh": 0.25}
BONUS = {"已订阅": 8, "已暂存": 5, "已提取": 3}

WS = r"D:\STORMWORKS"
RANKED = os.path.join(WS, "AI相关", "_meta", "ws_ranked.json")
CFG = os.path.join(WS, "工作区导航", "路径配置.json")


# ---------------------------------------------------------------- 路径解析
def resolve_workshop():
    """不硬编码盘符：配置 → sw_paths.detect() → ws_reference 常量。"""
    try:
        if os.path.isfile(CFG):
            cfg = json.load(open(CFG, encoding="utf-8"))
            v = cfg.get("values", cfg)
            p = v.get("<SW_WORKSHOP>") or v.get("SW_WORKSHOP")
            if p and os.path.isdir(p):
                return p
    except Exception:
        pass
    try:
        sp = os.path.join(WS, "工作区导航", "脚本", "sw_paths.py")
        if os.path.isfile(sp):
            sys.path.insert(0, os.path.dirname(sp))
            import sw_paths
            p = sw_paths.detect().get("<SW_WORKSHOP>")
            if p and os.path.isdir(p):
                return p
    except Exception:
        pass
    return ref.SUBSCRIBED


# ---------------------------------------------------------------- 抓浏览页
def browse_pages(sort, pages, start=1):
    """返回 {id: 首次出现的页码}。403/异常时返回 (dict, error_msg)。"""
    got, err = {}, None
    for p in range(start, start + pages):
        url = (f"{BROWSE}?appid={APPID}&browsesort={sort}"
               f"&section=readytouseitems&p={p}&numperpage=30")
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA})
            h = urllib.request.urlopen(req, timeout=30).read().decode("utf-8", "ignore")
        except Exception as e:
            code = getattr(e, "code", None)
            err = f"{sort}: p{p} " + ("403 限流" if code == 403 else f"{type(e).__name__}")
            break                                  # 限流即放弃本维度，不重试
        found = re.findall(r"filedetails/\?id=(\d+)", h)
        for tid in found:
            got.setdefault(tid, p)
        if not found:
            err = err or f"{sort}: p{p} 无结果（可能已到末页）"
            break
        if p < start + pages - 1:
            time.sleep(3)                          # 礼貌间隔，降低被限流概率
    return got, err


# ---------------------------------------------------------------- 状态判定
def state_of(tid, idx, workshop):
    if idx.get(tid, {}).get("learned"):
        return "已学习"
    if os.path.isdir(os.path.join(workshop, tid)):
        return "已订阅"
    if os.path.isdir(os.path.join(ref.STAGED, tid)):
        return "已暂存"
    if ref.lua_files(tid):
        return "已提取"
    return "新"


# ---------------------------------------------------------------- 打分
def score_items(items, W):
    """items: {id: {...}}，就地写入 score。返回本批次最大订阅数。"""
    now = time.time()
    subs_list = [it.get("subs") or 0 for it in items.values()]
    maxsub = max(subs_list) if subs_list else 0
    denom = math.log10(maxsub + 1) or 1.0
    for tid, it in items.items():
        rk = it.get("rank") or {}
        trend_s = 1.0 / rk["trend"] if rk.get("trend") else 0.0
        subs_s = 1.0 / rk["subs"] if rk.get("subs") else 0.0
        upd_s = 1.0 / rk["upd"] if rk.get("upd") else 0.0
        pop = math.log10((it.get("subs") or 0) + 1) / denom
        ts = it.get("updated_ts") or 0
        age = (now - ts) / 86400.0 if ts else HALFLIFE_DAYS * 3
        fresh = 0.5 ** (max(age, 0.0) / HALFLIFE_DAYS)
        base = 100.0 * (W["trend"] * trend_s + W["subs"] * subs_s + W["upd"] * upd_s
                        + W["pop"] * pop + W["fresh"] * fresh)
        it["score"] = round(base + BONUS.get(it.get("state", "新"), 0), 2)


# ---------------------------------------------------------------- 主流程
def load_ranked():
    if os.path.isfile(RANKED):
        try:
            return json.load(open(RANKED, encoding="utf-8"))
        except Exception:
            pass
    return {"generated": None, "weights": dict(W_DEFAULT), "crawl": {},
            "items": {}, "note": ""}


def save_ranked(doc, weights, crawl_info, note=""):
    doc["generated"] = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    doc["weights"] = weights
    doc["crawl"] = crawl_info
    if note:
        doc["note"] = note
    os.makedirs(os.path.dirname(RANKED), exist_ok=True)
    json.dump(doc, open(RANKED, "w", encoding="utf-8"), ensure_ascii=False, indent=1)


def parse_weights(s):
    W = dict(W_DEFAULT)
    if not s:
        return W
    for kv in s.split(","):
        if "=" not in kv:
            continue
        k, v = kv.split("=", 1)
        k = k.strip()
        if k in W:
            try:
                W[k] = float(v)
            except ValueError:
                pass
    tot = sum(W.values())
    if tot <= 0:
        return dict(W_DEFAULT)
    return {k: round(v / tot, 4) for k, v in W.items()}     # 归一化，保证和为 1


def cmd_crawl(pages, sorts, weights, doc):
    crawl_info = doc.get("crawl") or {}
    notes = []
    merged = {}
    for s in sorts:
        got, err = browse_pages(s, pages)
        crawl_info[s] = pages
        if err:
            notes.append(err)
        for tid, p in got.items():
            merged.setdefault(tid, {})[s] = p
        print(f"[crawl] {s:<24} 抓到 {len(got):>4} 个 id" + (f"  ⚠ {err}" if err else ""))

    items = doc.setdefault("items", {})
    for tid, rk in merged.items():
        it = items.setdefault(tid, {"id": tid, "rank": {}, "state": "新"})
        old = it.setdefault("rank", {})
        # 位次取更靠前的那次（同一 id 可能多轮出现在不同页）
        for k, p in rk.items():
            if not old.get(k) or p < old[k]:
                old[k] = p

    # 拉元数据：只补缺失 / 超过 7 天的
    now = time.time()
    need = [t for t, it in items.items()
            if not it.get("meta_ts") or now - it.get("meta_ts", 0) > 7 * 86400]
    if need:
        print(f"[meta] 需要拉取 {len(need)} 个物品的元数据 …")
        meta = ref.api_meta(need)
        for tid, m in meta.items():
            it = items.setdefault(tid, {"id": tid, "rank": {}, "state": "新"})
            it["title"] = m.get("title", it.get("title", ""))
            it["subs"] = m.get("subs", it.get("subs", 0))
            ts = m.get("updated") or 0
            it["updated_ts"] = ts
            it["updated"] = (datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d")
                             if ts else it.get("updated", ""))
            it["meta_ts"] = now
        print(f"[meta] 成功 {len(meta)}/{len(need)}"
              + (f"（其余 {len(need) - len(meta)} 个 API 未返回，按浏览位次兜底打分）"
                 if len(meta) < len(need) else ""))

    workshop = resolve_workshop()
    idx = ref.load_index()
    for tid, it in items.items():
        it["state"] = state_of(tid, idx, workshop)

    score_items(items, weights)
    save_ranked(doc, weights, crawl_info, "；".join(notes))
    todo = [i for i in items.values() if i.get("state") != "已学习"]
    top = sorted(todo, key=lambda x: -x.get("score", 0))[:12]
    print(f"\n[done] 候选池 {len(items)} 个，其中待学习 {len(todo)} 个")
    print(f"[done] 榜单已写入 {RANKED}")
    print("\n本轮 TOP12 待学习：")
    for i, it in enumerate(top, 1):
        print(f"  {i:>2}. {it['score']:>6.2f}  {it.get('id'):<12} "
              f"sub={it.get('subs', 0):<7} upd={it.get('updated', '?'):<11} "
              f"[{it.get('state')}]  {(it.get('title') or '')[:44]}")


def cmd_show(n, doc, include_all):
    items = [i for i in (doc.get("items") or {}).values()
             if include_all or i.get("state") != "已学习"]
    items.sort(key=lambda x: -x.get("score", 0))
    print(f"{'#':>3} {'score':>6}  {'id':<12} {'订阅':>7}  {'更新':<11} {'状态':<6} 标题")
    print("-" * 96)
    for i, it in enumerate(items[:n], 1):
        print(f"{i:>3} {it.get('score', 0):>6.2f}  {it.get('id'):<12} "
              f"{it.get('subs', 0):>7}  {it.get('updated', '?'):<11} "
              f"{it.get('state', '?'):<6} {(it.get('title') or '')[:46]}")
    if not items:
        print("（榜单为空或全部已学习，先跑 --crawl）")


def cmd_top(n, doc):
    items = [i for i in (doc.get("items") or {}).values() if i.get("state") != "已学习"]
    items.sort(key=lambda x: -x.get("score", 0))
    print(" ".join(i["id"] for i in items[:n]))


def main():
    a = sys.argv[1:]
    if not a:
        print(__doc__)
        return
    weights = parse_weights(a[a.index("--weights") + 1]) if "--weights" in a else dict(W_DEFAULT)
    doc = load_ranked()

    if "--crawl" in a:
        k = a.index("--crawl")
        pages = int(a[k + 1]) if len(a) > k + 1 and a[k + 1].isdigit() else 4
        sorts = SORTS
        if "--sorts" in a:
            s = a.index("--sorts")
            if len(a) > s + 1:
                sorts = [x.strip() for x in a[s + 1].split(",") if x.strip()]
        cmd_crawl(pages, sorts, weights, doc)
    elif "--refresh" in a:
        workshop = resolve_workshop()
        idx = ref.load_index()
        for tid, it in (doc.get("items") or {}).items():
            it["state"] = state_of(tid, idx, workshop)
        score_items(doc.setdefault("items", {}), weights)
        save_ranked(doc, weights, doc.get("crawl", {}), "仅刷新状态与分数")
        print(f"[refresh] {len(doc['items'])} 个候选已重算，写入 {RANKED}")
    elif "--browse" in a:
        k = a.index("--browse")
        sort = a[k + 1] if len(a) > k + 1 and not a[k + 1].isdigit() else "mostrecent"
        off = k + (2 if sort != "mostrecent" else 1)
        start = int(a[off]) if len(a) > off and a[off].isdigit() else 1
        pages = int(a[off + 1]) if len(a) > off + 1 and a[off + 1].isdigit() else 1
        got, err = browse_pages(sort, pages, start)
        print(" ".join(sorted(got, key=lambda t: got[t])))
        if err:
            print(f"[browse] ⚠ {err}", file=sys.stderr)
    elif "--show" in a:
        k = a.index("--show")
        n = int(a[k + 1]) if len(a) > k + 1 and a[k + 1].isdigit() else 20
        cmd_show(n, doc, "--all" in a)
    elif "--top" in a:
        k = a.index("--top")
        n = int(a[k + 1]) if len(a) > k + 1 and a[k + 1].isdigit() else 12
        cmd_top(n, doc)
    else:
        print(__doc__)


if __name__ == "__main__":
    main()
