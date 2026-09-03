#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
sw_state.py — 对照表的更新状态管理（被 update_glossary.py / sw_check.py / sw_lookup.py 共用）。

状态记录在 `数据/last_update.json`：

    {
      "last_check"      : 上次「检查」时间（ISO）
      "last_update"     : 上次「成功重建」时间（ISO）
      "source"          : 主数据源路径（创意工坊 language.tsv）
      "source_mtime"    : 当时源文件的修改时间
      "source_size"     : 当时源文件字节数
      "source_sha256"   : 当时源文件哈希（判断补丁是否真的换了内容）
      "stats"           : {"total","parts","ui","todo"}
      "last_result"     : updated / unchanged / failed
      "stale_after_days": 超过多少天未更新即视为过期（默认 7）
    }

判定「需要更新」的两个条件，满足其一即可：
  1. 距 last_update 已超过 stale_after_days 天（默认 7 天）
  2. 主数据源文件的内容哈希与上次记录不一致（汉化补丁被 Steam 更新了）
"""

import hashlib
import json
import os
import sys
from datetime import datetime, timedelta

OUT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATE_FILE = os.path.join(OUT, "数据", "last_update.json")
SNAPSHOT = os.path.join(OUT, "数据", "_snapshot.jsonl")

# 主数据源：创意工坊已订阅的汉化补丁（Steam 会自动同步，永远是最贴近游戏本体的一份）
# 路径随机器而变（Steam 库盘符、汉化补丁的工坊物品 ID 都不固定），故由 sw_locate 解析：
#   环境变量 SW_LANG_TSV / SW_WORKSHOP / STEAM_LIB → 工作区导航\路径配置.json
#   → 内置旧值（存在才用） → 工作区导航\脚本\sw_paths.py 全盘探测 → 兜底
if __package__:
    from . import sw_locate                                  # 作为包被导入
else:
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import sw_locate                                         # 作为脚本直接运行

PRIMARY_SRC = sw_locate.resolve_language_tsv()
# 备用源：上游仓库（仅当主数据源不可用时使用）
FALLBACK_URL = "https://raw.githubusercontent.com/BKN46/stormworks-translate-chn/main/SimplifiedChinese.tsv"

STALE_AFTER_DAYS = 7


def now_iso():
    return datetime.now().astimezone().isoformat(timespec="seconds")


def sha256_of(path, chunk=1 << 20):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while True:
            b = f.read(chunk)
            if not b:
                break
            h.update(b)
    return h.hexdigest()


def file_info(path):
    """采集源文件指纹；不存在时返回 exists=False。"""
    if not path or not os.path.exists(path):
        return {"exists": False, "path": path, "mtime": None,
                "size": None, "sha256": None}
    st = os.stat(path)
    try:
        digest = sha256_of(path)
    except OSError:
        digest = None
    return {
        "exists": True,
        "path": path,
        "mtime": datetime.fromtimestamp(st.st_mtime).astimezone().isoformat(timespec="seconds"),
        "size": st.st_size,
        "sha256": digest,
    }


def load_state():
    if not os.path.exists(STATE_FILE):
        return None
    try:
        with open(STATE_FILE, encoding="utf-8") as f:
            return json.load(f)
    except (ValueError, OSError):
        return None


def save_state(**kw):
    st = load_state() or {}
    st.update(kw)
    st["_schema"] = 1
    os.makedirs(os.path.dirname(STATE_FILE), exist_ok=True)
    with open(STATE_FILE, "w", encoding="utf-8", newline="\n") as f:
        json.dump(st, f, ensure_ascii=False, indent=1)
    return st


def mark_checked():
    """只登记「已检查」，不改变 last_update。"""
    return save_state(last_check=now_iso())


def mark_updated(src, info, stats, result):
    return save_state(
        last_check=now_iso(),
        last_update=now_iso(),
        source=src,
        source_mtime=info.get("mtime"),
        source_size=info.get("size"),
        source_sha256=info.get("sha256"),
        stats=stats,
        last_result=result,
        stale_after_days=STALE_AFTER_DAYS,
    )


def _parse(iso):
    if not iso:
        return None
    try:
        return datetime.fromisoformat(iso)
    except ValueError:
        return None


def check(src=None, stale_after_days=None):
    """
    返回状态字典，字段：
        state, age_days, stale_by_time, source_changed, need_update,
        reason, last_update, last_check, source, stats, src_info
    """
    src = src or PRIMARY_SRC
    st = load_state() or {}
    saved = st.get("stale_after_days")
    # 注意：0 是合法值（表示「总是过期」），不能用 or 短路
    if stale_after_days is not None:
        days = stale_after_days
    elif saved is not None:
        days = saved
    else:
        days = STALE_AFTER_DAYS
    info = file_info(src)

    last_update = _parse(st.get("last_update"))
    age_days = None
    if last_update:
        age_days = (datetime.now().astimezone() - last_update).total_seconds() / 86400.0

    stale_by_time = age_days is None or age_days >= days
    source_changed = bool(
        st.get("source_sha256") and info.get("sha256")
        and st["source_sha256"] != info["sha256"]
    )

    if st.get("last_update") is None:
        reason = "尚未建立对照表"
    elif stale_by_time:
        reason = "距上次更新已 %.1f 天（阈值 %s 天）" % (age_days, days)
    elif source_changed:
        reason = "主数据源内容已变化（汉化补丁被更新）"
    else:
        reason = "对照表为最新"

    if not info["exists"]:
        reason = "主数据源不存在：%s" % src
        need_update = False
    else:
        need_update = bool(stale_by_time or source_changed)

    return {
        "state": st,
        "age_days": age_days,
        "stale_by_time": stale_by_time,
        "source_changed": source_changed,
        "need_update": need_update,
        "reason": reason,
        "last_update": st.get("last_update"),
        "last_check": st.get("last_check"),
        "source": src,
        "stats": st.get("stats") or {},
        "src_info": info,
        "stale_after_days": days,
    }


def deadline(age_days, days):
    """下次应更新的时间点提示（仅用于展示）。"""
    st = load_state() or {}
    last = _parse(st.get("last_update"))
    if not last:
        return None
    return (last + timedelta(days=days)).astimezone().isoformat(timespec="seconds")


if __name__ == "__main__":
    r = check()
    print("主数据源：%s（存在=%s）" % (r["source"], r["src_info"]["exists"]))
    print("上次更新：%s" % (r["last_update"] or "无"))
    print("已过天数：%s" % ("%.2f" % r["age_days"] if r["age_days"] is not None else "无"))
    print("判定：%s → %s" % (r["reason"], "需要更新" if r["need_update"] else "无需更新"))
