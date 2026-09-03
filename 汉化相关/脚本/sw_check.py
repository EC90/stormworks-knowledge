#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
sw_check.py — 对照表新鲜度检查（AI 与定时任务都用它，秒级返回）。

默认只用「读一个 JSON + 给源文件算一次哈希」判断是否过期，不做重建，因此非常快，
适合 AI 每次查术语前先跑一遍。

判定规则（满足其一即需更新）：
  1. 距上次成功更新已超过 7 天（可用 --days 改）
  2. 主数据源（创意工坊 language.tsv）内容哈希变了，说明 Steam 同步了新补丁

用法：
    python sw_check.py                 # 只报告状态
    python sw_check.py --auto          # 若过期则自动执行 update_glossary.py
    python sw_check.py --json          # 机器可读输出
    python sw_check.py --days 3        # 临时改用 3 天阈值
    python sw_check.py --force         # 无条件更新（忽略新鲜度）

退出码：
    0  对照表为最新
    2  需要更新但本次未执行（未加 --auto）
    3  更新失败或数据源缺失
"""

import argparse
import json
import os
import subprocess
import sys
from datetime import datetime, timedelta

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import sw_state  # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))
UPDATER = os.path.join(HERE, "update_glossary.py")


def run_updater(extra=()):
    cmd = [sys.executable, UPDATER] + list(extra)
    p = subprocess.run(cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace")
    return p.returncode, (p.stdout or "") + (p.stderr or "")


def human(r):
    st = r["state"]
    if not r["src_info"]["exists"]:
        return "⚠ 主数据源不存在：%s（Steam 未订阅或未下载汉化补丁？）" % r["source"]
    if r["last_update"]:
        try:
            dt = datetime.fromisoformat(r["last_update"]).strftime("%Y-%m-%d %H:%M")
        except ValueError:
            dt = r["last_update"]
        head = "上次更新 %s（%.1f 天前）" % (dt, r["age_days"] or 0.0)
    else:
        head = "尚未建立对照表"
    s = st.get("stats") or {}
    tail = "条目 %s，待补翻 %s" % (s.get("total", "?"), s.get("todo", "?"))
    if r["need_update"]:
        return "%s；%s → 需要更新：%s" % (head, tail, r["reason"])
    nxt = ""
    if r["age_days"] is not None:
        left = max(0.0, r["stale_after_days"] - r["age_days"])
        nxt = "；约 %.1f 天后到期" % left
    return "%s；%s → 无需更新（%s）%s" % (head, tail, r["reason"], nxt)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--auto", action="store_true", help="若过期则自动执行更新")
    ap.add_argument("--force", action="store_true", help="无条件更新")
    ap.add_argument("--json", action="store_true", help="JSON 输出")
    ap.add_argument("--days", type=int, default=None, help="临时指定过期天数阈值")
    ap.add_argument("--src", default=None, help="临时指定主数据源路径")
    a = ap.parse_args()

    r = sw_state.check(src=a.src, stale_after_days=a.days)
    sw_state.save_state(last_check=sw_state.now_iso())

    payload = {
        "need_update": r["need_update"],
        "reason": r["reason"],
        "age_days": None if r["age_days"] is None else round(r["age_days"], 2),
        "stale_after_days": r["stale_after_days"],
        "source": r["source"],
        "source_exists": r["src_info"]["exists"],
        "source_changed": r["source_changed"],
        "last_update": r["last_update"],
        "last_check": r["last_check"],
        "stats": r["stats"],
        "updated_now": False,
    }

    if not r["src_info"]["exists"]:
        payload["error"] = "主数据源不存在"
        print(json.dumps(payload, ensure_ascii=False, indent=1) if a.json
              else human(r))
        return 3

    if a.force or r["need_update"]:
        if not (a.auto or a.force):
            if a.json:
                print(json.dumps(payload, ensure_ascii=False, indent=1))
            else:
                print(human(r))
                print("提示：加 --auto 可立即执行更新。")
            return 2
        if not a.json:
            print(human(r))
            print("[..] 正在更新：update_glossary.py")
        rc, out = run_updater(["--src", r["source"]] if r["source"] != sw_state.PRIMARY_SRC else [])
        payload["updated_now"] = (rc == 0)
        payload["updater_exit_code"] = rc
        tail = "\n".join(out.strip().splitlines()[-8:])
        payload["updater_output_tail"] = tail
        if a.json:
            print(json.dumps(payload, ensure_ascii=False, indent=1))
        else:
            print(tail)
            print("更新%s。" % ("完成" if rc == 0 else "失败（退出码 %d）" % rc))
        return 0 if rc == 0 else 3

    if a.json:
        print(json.dumps(payload, ensure_ascii=False, indent=1))
    else:
        print(human(r))
    return 0


if __name__ == "__main__":
    sys.exit(main())
