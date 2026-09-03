#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
用 Steam Web API 批量取创意工坊物品元数据（标题/描述/发布/更新/标签/订阅/浏览）。
比抓 HTML 稳：一次 POST 可取多个 id，返回 JSON。结果写 _meta/items.json。
"""
import os
import re
import json
import time
import datetime
import urllib.request
import urllib.parse

IDS_FILE = r"D:\STORMWORKS\AI相关\_提取暂存\_readlist.txt"
OUT = r"D:\STORMWORKS\AI相关\_meta"
API = "https://api.steampowered.com/ISteamRemoteStorage/GetPublishedFileDetails/v1/"
os.makedirs(OUT, exist_ok=True)

ids = sorted({line.split("_")[0] for line in open(IDS_FILE, encoding="utf-8") if line.strip()})


def post(batch):
    data = {"itemcount": str(len(batch))}
    for i, tid in enumerate(batch):
        data[f"publishedfileids[{i}]"] = tid
    body = urllib.parse.urlencode(data).encode()
    req = urllib.request.Request(API, data=body,
                                 headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.loads(r.read().decode("utf-8", errors="ignore"))


def clean(desc):
    desc = re.sub(r"\[/?[a-zA-Z0-9=*\-\s\"'/.:]+\]", " ", desc)   # BBCode
    desc = re.sub(r"https?://\S+", " ", desc)
    desc = re.sub(r"[ \t]+", " ", desc)
    desc = re.sub(r"\n{3,}", "\n\n", desc)
    return desc.strip()


items = {}
B = 20
for s in range(0, len(ids), B):
    batch = ids[s:s + B]
    try:
        resp = post(batch)
    except Exception as e:
        print(f"batch {s} FAIL {type(e).__name__}")
        continue
    for fd in resp.get("response", {}).get("publishedfiledetails", []):
        tid = str(fd.get("publishedfileid"))
        if fd.get("result") != 1:
            items[tid] = {"id": tid, "error": f"result={fd.get('result')}"}
            continue
        tc, tu = fd.get("time_created", 0), fd.get("time_updated", 0)
        f = lambda t: datetime.datetime.fromtimestamp(t).strftime("%Y-%m-%d") if t else ""
        items[tid] = {
            "id": tid,
            "url": f"https://steamcommunity.com/sharedfiles/filedetails/?id={tid}",
            "title": fd.get("title", ""),
            "posted": f(tc),
            "updated": f(tu) or f(tc),
            "updated_ts": tu or tc,
            "views": fd.get("views", 0),
            "subscriptions": fd.get("subscriptions", 0),
            "favorited": fd.get("favorited", 0),
            "tags": [t["tag"] for t in fd.get("tags", [])],
            "preview": fd.get("preview_url", ""),
            "desc": clean(fd.get("description", ""))[:2500],
        }
        print(f"  {tid:<12} upd={items[tid]['updated']:<11} sub={items[tid]['subscriptions']:<6} "
              f"| {items[tid]['title'][:56]}")
    time.sleep(0.6)

json.dump(items, open(os.path.join(OUT, "items.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
ok = [k for k, v in items.items() if not v.get("error")]
no_desc = [k for k in ok if not items[k].get("desc")]
print(f"\nfetched {len(ok)}/{len(ids)}   no-desc: {len(no_desc)} {no_desc}")
