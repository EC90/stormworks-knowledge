#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
update_glossary.py — 同步 Stormworks 汉化补丁并重建中英对照表。

数据源优先级（以创意工坊为主）：
  1. 创意工坊已订阅的 language.tsv（Steam 会自动同步，最贴近游戏本体）  ← 默认，不联网
  2. 上游仓库 SimplifiedChinese.tsv  ← 仅当 1 不存在时自动兜底，或显式加 --use-github

流程：
  1. 选定数据源（默认创意工坊，不联网）
  2. 与上一次快照比对，算出 新增 / 译文变更 / 移除
  3. 重建全部对照表文件
  4. 往 更新日志.md 追加一条记录
  5. 把「更新时间节点 + 源文件指纹」写入 数据/last_update.json，供 sw_check.py 判断新鲜度

用法：
    python update_glossary.py                 # 默认：创意工坊文件
    python update_glossary.py --src 某.tsv    # 手动指定数据源
    python update_glossary.py --use-github    # 额外抓 GitHub 做对照（仍以创意工坊为准）
    python update_glossary.py --offline       # 已废弃，保留兼容（现在默认就不联网）
"""

import argparse
import json
import os
import sys
from datetime import datetime

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import build_glossary as bg  # noqa: E402
import sw_state  # noqa: E402

OUT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CACHE = os.path.join(OUT, "数据", "_cache")
SNAPSHOT = os.path.join(OUT, "数据", "_snapshot.jsonl")
LOGFILE = os.path.join(OUT, "更新日志.md")


def fetch(url, dest, timeout=90):
    import urllib.request
    d = os.path.dirname(dest)
    os.makedirs(d, exist_ok=True)
    req = urllib.request.Request(url, headers={"User-Agent": "sw-glossary-updater"})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        data = r.read()
    with open(dest, "wb") as f:
        f.write(data)
    old = sorted(f for f in os.listdir(d) if f.endswith(".tsv"))
    for f in old[:-3]:
        try:
            os.remove(os.path.join(d, f))
        except OSError:
            pass
    return len(data)


def count_entries(path):
    if not path or not os.path.exists(path):
        return 0
    rows, _ = bg.read_tsv(path)
    return sum(1 for r in rows if r[2].strip() or r[3].strip())


def load_snapshot():
    if not os.path.exists(SNAPSHOT):
        return {}
    out = {}
    with open(SNAPSHOT, encoding="utf-8") as f:
        for line in f:
            if not line.strip():
                continue
            e = json.loads(line)
            # 兼容紧凑快照 {i,e,z} 与早期完整快照 {id,en,zh}
            _id = e.get("i", e.get("id", ""))
            en = e.get("e", e.get("en", ""))
            if not en:                 # 空英文行不参与增量比对
                continue
            out[(_id, en)] = e.get("z", e.get("zh", ""))
    return out


def diff(prev, entries):
    cur = {(e["id"], e["en"]): e["zh"] for e in entries if e["en"]}
    added = [k for k in cur if k not in prev]
    removed = [k for k in prev if k not in cur]
    changed = [(k, prev[k], cur[k]) for k in cur
               if k in prev and prev[k] != cur[k]]
    return added, removed, changed


def cur_zh(entries, key):
    for e in entries:
        if (e["id"], e["en"]) == key:
            return e["zh"]
    return ""


def append_log(src, src_n, gh_n, entries, added, removed, changed, note="", is_first=False):
    total = len(entries)
    todo = sum(1 for e in entries if e["state"] == "todo")
    first = not os.path.exists(LOGFILE)
    lines = []
    if first:
        lines += ["# 更新日志", "",
                  "> 由 `脚本/update_glossary.py` 自动追加。数据源以创意工坊 `language.tsv` 为主。",
                  "> 每次同步会记录数据源指纹与增量；`数据/last_update.json` 记录更新时间节点。",
                  ""]
    ts = datetime.now().strftime("%Y-%m-%d %H:%M")
    lines.append("## %s" % ts)
    lines.append("")
    lines.append("- 数据源：`<SW_LANG_TSV>`（%d 条）" % src_n)
    lines.append("  - 本次实际读取：`%s`（**盘符与工坊物品 ID 都不固定**，见 `工作区导航\路径配置.json`）" % src)
    if gh_n:
        lines.append("- 对照参考：GitHub 上游 %d 条（仅比对，未采用）" % gh_n)
    lines.append("- 本次入库 **%d** 条，待补翻 %d 条" % (total, todo))
    if note:
        lines.append("- 备注：%s" % note)
    if is_first:
        lines.append("- 首次生成，已建立基线快照，下次起可比对增量")
        lines.append("")
    else:
        lines.append("- 增量：新增 %d，译文变更 %d，移除 %d" %
                     (len(added), len(changed), len(removed)))
        if not (added or changed or removed):
            lines.append("")
            lines.append("本次无变化。")
        if added:
            lines += ["", "**新增条目（最多 60 条）**", "",
                      "| 英文 | 中文 |", "| --- | --- |"]
            for k in added[:60]:
                zh = cur_zh(entries, k)
                lines.append("| %s | %s |" % (bg._md_escape(k[1]),
                                              bg._md_escape(zh or "（未翻译）")))
        if changed:
            lines += ["", "**译文变更（最多 60 条）**", "",
                      "| 英文 | 旧译文 | 新译文 |", "| --- | --- | --- |"]
            for k, old, new in changed[:60]:
                lines.append("| %s | %s | %s |" % (
                    bg._md_escape(k[1]), bg._md_escape(old or "（空）"),
                    bg._md_escape(new or "（空）")))
        if removed:
            lines += ["", "**移除条目（最多 30 条）**", ""]
            for k in removed[:30]:
                lines.append("- %s" % bg._md_escape(k[1] or "(空 id)"))
    lines.append("")
    with open(LOGFILE, "a", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(lines))


def pick_source(a):
    """返回 (src_path, note, gh_n)。主数据源优先，GitHub 仅兜底。"""
    if a.src:
        return a.src, "手动指定数据源", 0

    primary = sw_state.PRIMARY_SRC
    info = sw_state.file_info(primary)
    gh_path, gh_n, note = None, 0, ""

    if a.use_github:
        gh_path = os.path.join(CACHE, "SimplifiedChinese_%s.tsv"
                               % datetime.now().strftime("%Y%m%d"))
        try:
            size = fetch(sw_state.FALLBACK_URL, gh_path)
            gh_n = count_entries(gh_path)
            note = "已抓取 GitHub 上游（%d 字节 / %d 条）用于对照" % (size, gh_n)
            print("[ok] GitHub 上游已抓取：%d 条" % gh_n)
        except Exception as ex:
            gh_path, gh_n = None, 0
            note = "GitHub 抓取失败（%s），继续使用创意工坊文件" % ex
            print("[warn] %s" % note)

    if info["exists"]:
        if note:
            note += "；采用创意工坊文件（主数据源）"
        else:
            note = "采用创意工坊文件（主数据源，未联网）"
        return primary, note, gh_n

    # 主数据源不可用 → 尝试 GitHub 兜底
    if gh_path is None:
        gh_path = os.path.join(CACHE, "SimplifiedChinese_%s.tsv"
                               % datetime.now().strftime("%Y%m%d"))
        try:
            fetch(sw_state.FALLBACK_URL, gh_path)
        except Exception as ex:
            print("[error] 创意工坊文件不存在，且 GitHub 兜底失败：%s" % ex)
            return None, "数据源全部不可用", 0
    note = "创意工坊文件不存在，已回退到 GitHub 上游"
    print("[warn] %s" % note)
    return gh_path, note, count_entries(gh_path)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--src", help="手动指定数据源 tsv 路径")
    ap.add_argument("--use-github", action="store_true",
                    help="额外抓取 GitHub 上游做条目数对照（不覆盖主数据源）")
    ap.add_argument("--offline", action="store_true",
                    help="已废弃：现在默认就不联网，保留此参数仅为兼容旧命令")
    a = ap.parse_args()

    src, note, gh_n = pick_source(a)
    if src is None:
        sw_state.save_state(last_check=sw_state.now_iso(), last_result="failed")
        return 3

    print("[i] 数据源：%s" % src)
    try:
        entries, warns = bg.build(src)
    except Exception as ex:                       # 源损坏/编码异常
        print("[error] 解析数据源失败：%s" % ex)
        sw_state.save_state(last_check=sw_state.now_iso(), last_result="failed",
                            last_error=str(ex))
        return 3

    prev = load_snapshot()
    added, removed, changed = diff(prev, entries)

    rc = bg.main(["build_glossary.py", src, OUT])
    if rc != 0:
        sw_state.save_state(last_check=sw_state.now_iso(), last_result="failed")
        return rc

    src_n = sum(1 for e in entries if e["en"] or e["zh"])
    append_log(src, src_n, gh_n, entries, added, removed, changed, note,
               is_first=not prev)

    stats = {
        "total": len(entries),
        "parts": sum(1 for e in entries if e["kind"] != "ui"),
        "ui": sum(1 for e in entries if e["kind"] == "ui"),
        "todo": sum(1 for e in entries if e["state"] == "todo"),
        "added": len(added), "changed": len(changed), "removed": len(removed),
    }
    result = "updated" if (added or changed or removed) else "unchanged"
    sw_state.mark_updated(src, sw_state.file_info(src), stats, result)

    print("=" * 50)
    print("新增 %d / 变更 %d / 移除 %d" % (len(added), len(changed), len(removed)))
    print("条目总数 %d，待补翻 %d" % (stats["total"], stats["todo"]))
    print("更新时间节点已写入：%s" % sw_state.STATE_FILE)
    for w in warns[:5]:
        print("警告：%s" % w)
    if not prev:
        print("（首次运行，已建立基线快照，下次起可比对增量）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
