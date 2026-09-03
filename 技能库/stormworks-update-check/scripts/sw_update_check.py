#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""
sw_update_check.py —— Stormworks 游戏更新检查（零依赖，纯标准库）

目的
----
用**最少的 AI 注意力**判断「是否需要查看 Steam 新闻页检查游戏更新」。
判定逻辑全部内置在脚本里，AI 只跑一个命令、读一行结论，不读新闻正文、不算日期。

判定规则（与用户约定一致）
--------------------------
状态文件里记录 `last_update` = 上次已知的「stormworks 更新时间」。
1. `last_update` 距今**不超过 7 天** → 输出 FRESH，跳过（除非 --force / 用户主动要求）。
2. 超过 7 天（或状态文件不存在）→ 拉 Steam 官方新闻 API：
   - 有新条目（时间晚于 last_update）→ 输出 UPDATED，列出新条目，回写 last_update。
   - 无新条目 → 输出 NONE，并把 last_update 刷新为**当前检查时间**
     （= 最近一次「确认无更新」的时间，7 天内不再重复联网）。

⚠ 本脚本**只判断「要不要检查」**，不读游戏根目录、不改任何数据库。
   「更新了什么 → 对应改数据库」仍需 AI 结合更新标题语义判断（见 SKILL.md 步骤 2）。

只读红线：本脚本只读 https://api.steampowered.com 的公开新闻接口，
          只写 <WS> 下的状态文件，绝不碰 <STEAM_LIB>。

用法
----
  python sw_update_check.py               # 正常检查（四态输出）
  python sw_update_check.py --force       # 忽略 7 天窗口，强制拉新闻对比
  python sw_update_check.py --state       # 只看当前状态文件内容

输出（stdout 最后一行为机器可读结论，AI 直接判断）：
  FRESH    距上次更新未满 7 天，跳过
  NONE     已检查，无新更新
  BASELINE 首次运行，刚建立基线
  UPDATED  发现新更新（下方列出条目）
  退出码：0 正常；2 网络失败
"""

import json
import os
import sys
import time
import urllib.request
import urllib.error

HERE = os.path.dirname(os.path.abspath(__file__))
STATE_FILE = os.path.abspath(os.path.join(HERE, "..", "stormworks_update_state.json"))

APPID = 573090
API = ("https://api.steampowered.com/ISteamNews/GetNewsForApp/v2/"
       "?appid=%d&count=10&maxlength=120&format=json" % APPID)
WINDOW_DAYS = 7
TIMEOUT = 20


def load_state():
    if not os.path.isfile(STATE_FILE):
        return None
    try:
        with open(STATE_FILE, "r", encoding="utf-8") as f:
            return json.load(f)
    except (json.JSONDecodeError, OSError):
        return None


def save_state(st):
    os.makedirs(os.path.dirname(STATE_FILE), exist_ok=True)
    with open(STATE_FILE, "w", encoding="utf-8", newline="\n") as f:
        json.dump(st, f, ensure_ascii=False, indent=2)


def fetch_news():
    """返回 [(unixtime, title), ...] 按时间降序。失败抛异常。"""
    req = urllib.request.Request(API, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=TIMEOUT) as r:
        data = json.loads(r.read().decode("utf-8"))
    items = data.get("appnews", {}).get("newsitems", [])
    out = []
    for it in items:
        try:
            ts = int(it.get("date", 0))
        except (TypeError, ValueError):
            ts = 0
        out.append((ts, it.get("title", "")))
    out.sort(key=lambda x: -x[0])
    return out


def fmt_dt(ts):
    return time.strftime("%Y-%m-%d %H:%M", time.localtime(ts))


def main():
    args = [a for a in sys.argv[1:]]
    if "--state" in args:
        st = load_state()
        if not st:
            print("NO_STATE 尚无状态文件（%s）" % STATE_FILE)
            return 0
        print(json.dumps(st, ensure_ascii=False, indent=2))
        return 0

    force = "--force" in args
    now = int(time.time())
    st = load_state()
    last_update = st.get("last_update") if st else None
    last_title = (st or {}).get("last_title", "")

    # 是否在 7 天窗口内
    within_window = False
    if last_update:
        try:
            within_window = (now - int(last_update)) / 86400.0 < WINDOW_DAYS
        except (TypeError, ValueError):
            within_window = False

    if within_window and not force:
        age = (now - int(last_update)) / 86400.0
        print("FRESH  距上次更新未满 7 天，跳过（last_update=%s，%.1f 天前）"
              % (fmt_dt(int(last_update)), age))
        print("       若用户主动要求检查，加 --force 重跑。")
        return 0

    # 需要检查：拉新闻
    try:
        news = fetch_news()
    except (urllib.error.URLError, urllib.error.HTTPError, OSError,
            json.JSONDecodeError) as e:
        print("NETFAIL 网络/解析失败：%s" % e, file=sys.stderr)
        return 2

    if not news:
        save_state({"last_update": now, "last_title": ""})
        print("NONE   无新闻条目（last_update 已刷新）")
        return 0

    latest_ts, latest_title = news[0]

    if last_update is None:
        # 首次运行：建立基线，last_update 记为「最新新闻发布时间」
        save_state({"last_update": latest_ts, "last_title": latest_title})
        print("BASELINE  首次运行，已建立基线")
        print("          最新：%s（%s）" % (latest_title, fmt_dt(latest_ts)))
        print("          下次 %d 天内将直接跳过（除非 --force）。" % WINDOW_DAYS)
        return 0

    # 有新条目：时间晚于 last_update
    new_items = [(ts, t) for ts, t in news if ts > int(last_update)]
    if new_items:
        save_state({"last_update": latest_ts, "last_title": latest_title})
        print("UPDATED  发现 %d 条新更新" % len(new_items))
        for ts, t in new_items:
            print("  - %s  [%s]" % (t, fmt_dt(ts)))
        print("  → 请按 SKILL.md 步骤 2，只读检查游戏根目录对应改动并更新数据库。")
        return 0

    # 无新更新：last_update 刷新为当前检查时间，7 天内不再重复联网
    save_state({"last_update": now, "last_title": latest_title})
    print("NONE   已检查，无新更新（最新仍为 %s @ %s）"
          % (latest_title, fmt_dt(latest_ts)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
