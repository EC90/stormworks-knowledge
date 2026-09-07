#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""sw_lua_lint.py — Stormworks 载具 Lua（MC 微控制器 / 脚本方块）静态检查。

纯标准库（依赖：无），Python 3.8+。规则来源：AGENTS.md §6 + 数据库\\Lua\\lua总体设定\\00_速查。

用法：
  python sw_lua_lint.py <file.lua> [more.lua ...] [--stage source|final]
                        [--dest xml|paste] [--limit 4096] [--margin 0]
                        [--strict] [--json]

--stage source : 人工可读源码（开发阶段）
--stage final  : minify 产物（进游戏前的最后一道闸）
--dest xml     : 产物将直接写进载具 XML 属性（默认；禁 " / < / &）
--dest paste   : 产物只经游戏内编辑器粘贴（引号与 < 合法，仅查其他项）
--limit        : 字符上限；MC=4096（默认），脚本方块=8192
--margin       : 在上限基础上预留的安全余量（默认 0）

退出码：0=通过（可有 WARN/INFO）；1=存在 ERROR（--strict 时 WARN 也算）。
语法级校验请另跑 harness/sw_sim.js --check（Fengari 编译，比本工具的正则强）。
"""

import argparse
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from lua_lex import tokenize, skeleton_of, offset_to_line_col  # noqa: E402

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

CODE_RE = re.compile(r"[A-Za-z_][A-Za-z0-9_]*")


def find_findings(src, toks, skel, args, fname):
    """收集所有 findings。返回 list[dict]。"""
    F = []

    def add(sev, code, msg, off=None, hint=""):
        line, col = (1, 1)
        if off is not None:
            line, col = offset_to_line_col(src, off)
        F.append({"sev": sev, "code": code, "file": fname,
                  "line": line, "col": col, "msg": msg, "hint": hint})

    # ---------- 通用（两个 stage 都查） ----------
    # 1. 非 ASCII：游戏拒绝任何非 ASCII 源码（00_速查 §13）
    for i, ch in enumerate(src):
        if ord(ch) > 126 and ch not in "\r\n\t" or ord(ch) == 127:
            add("ERROR", "NON_ASCII",
                "非 ASCII 字符 %r——游戏内 Lua 源码仅接受 ASCII（注释也算）" % ch, i,
                "中文显示走 unicode 后端（05_屏幕绘图 §7），不要写进源码")
            break
    # 2. 反斜杠：游戏源码不支持（BKN 原话「这游戏不支持 \」）
    for i, ch in enumerate(src):
        if ch == "\\":
            add("ERROR", "BACKSLASH", "反斜杠 \\ 在游戏源码中非法", i,
                "换行用 string.char(10)，特殊字符用 string.char(n) 构造")
            break
    # 3. atan2 不存在（math.atan 支持 1 或 2 参数）。工坊惯用 M=math 别名，
    #    所以按「任何标识符 .atan2」匹配——Stormworks 里不存在任何 atan2 成员。
    for m in re.finditer(r"[A-Za-z_][A-Za-z0-9_]*\s*\.\s*atan2\b", skel):
        add("ERROR", "ATAN2", "%s 在 Stormworks 中不存在" % m.group(0).replace(" ", ""), m.start(),
            "用 math.atan(y, x)（两参数，等价 atan2）；别名别名 M=math 时同样写成 M.atan(y,x)")
    # 4. os. / io. / loadfile / dofile：沙盒不存在（final 阶段 require 也算）
    for m in re.finditer(r"\b(os|io)\s*\.", skel):
        add("WARN", "LIB_OS_IO", "os./io. 在游戏沙盒中不存在（模拟器同样拒绝）", m.start())
    for m in re.finditer(r"\brequire\s*\(", skel):
        if args.stage == "final":
            add("ERROR", "REQUIRE_LEFT", "final 产物中仍有 require( ——minify 合并未完成", m.start(),
                "检查 npx storm-lua-minify 的入口文件是否包含全部模块")
        else:
            add("INFO", "REQUIRE_SRC", "源码使用 require（开发期正常，minify 时合并）", m.start())
    # 5. onTick / onDraw 互斥（00_速查 §2）
    body_span = {}
    for name in ("onTick", "onDraw"):
        m = re.search(r"function\s+" + name + r"\s*\(", skel)
        if not m:
            m = re.search(r"local\s+function\s+" + name + r"\s*\(", skel)
        if m:
            body_span[name] = _block_span(skel, m.start())
    if "onTick" in body_span and "onDraw" in body_span:
        s1, e1 = body_span["onTick"]
        s2, e2 = body_span["onDraw"]
        _check_forbidden_call(add, skel, "onTick", "screen", s1, e1)
        _check_forbidden_call(add, skel, "onDraw", "input", s2, e2)
        _check_forbidden_call(add, skel, "onDraw", "output", s2, e2)
    # 6. async.httpGet URL 长度估算（AGENTS.md §6：<4000，超约 4096 崩溃）
    _check_httpget(add, src, toks, skel)
    # 7. 字符数
    raw_len = len(src.replace("\r\n", "\n"))
    budget = args.limit - args.margin
    if raw_len > budget:
        add("ERROR", "CHAR_LIMIT",
            "字符数 %d 超出上限 %d（limit=%d margin=%d）" % (raw_len, budget, args.limit, args.margin),
            None, "MC 上限 4096；脚本方块 8192（--limit 8192）；再超就拆多方块或挪进 property.getText")
    else:
        add("INFO", "CHAR_OK", "字符数 %d / 上限 %d（余量 %d）" % (raw_len, args.limit, args.limit - raw_len))

    # ---------- dest=xml 特有（AGENTS.md §6：XML 属性禁 " / < / &） ----------
    if args.dest == "xml":
        strict = (args.stage == "final")
        for i, ch in enumerate(src):
            if ch == "<":
                add("ERROR" if strict else "ERROR", "CHAR_LT",
                    "半角 < 在 XML 属性中非法（注释里也不行）", i,
                    "比较一律写成 > 方向：if b>a；下一帧判断用 math.min/max")
                break
        for i, ch in enumerate(src):
            if ch == "&":
                add("ERROR", "CHAR_AMP", "半角 & 在 XML 属性中非法", i,
                    "需要 & 字符用 string.char(38)")
                break
        for t in toks:
            if t["kind"] == "string" and t.get("quote") == '"':
                sev = "ERROR" if strict else "WARN"
                add(sev, "CHAR_QUOTE", "双引号字符串字面量（XML 属性中非法）", t["start"],
                    "源码就用单引号；final 产物跑 sw_lua_xmlsafe.py 归一化")
                break
            if t["kind"] == "unterminated":
                add("ERROR", "UNTERMINATED", "未闭合的字符串或注释", t["start"])
                break
    else:
        for t in toks:
            if t["kind"] == "unterminated":
                add("ERROR", "UNTERMINATED", "未闭合的字符串或注释", t["start"])
                break

    # ---------- final 特有 ----------
    if args.stage == "final":
        m = re.search(r"--\s*//\s*#\s*sourceMappingURL", src)
        if m:
            tail = src[m.start():]
            add("INFO", "MAP_COMMENT",
                "尾部 sourceMappingURL 注释占 %d 字符，粘贴进游戏可删（map 文件单独留存）"
                % len(tail), m.start())
        if "\r" in src:
            add("INFO", "CRLF", "final 产物含 CR；建议 LF（XML 属性更稳）")

    return F


def _block_span(skel, start_off):
    """从 function 声明位置求函数体 [start, end) 偏移（按关键字配对 end）。"""
    i = skel.find(")", start_off)
    if i < 0:
        return (start_off, len(skel))
    depth = 1
    for m in CODE_RE.finditer(skel, i):
        w = m.group(0)
        if w in ("function", "if", "do"):
            depth += 1
        elif w == "for" or w == "while":
            pass  # 它们的 do 已计数
        elif w == "repeat":
            depth += 1
        elif w == "until":
            depth -= 1
        elif w == "end":
            depth -= 1
            if depth == 0:
                return (start_off, m.end())
    return (start_off, len(skel))


def _check_forbidden_call(add, skel, fname, obj, s, e):
    for m in re.finditer(obj + r"\s*\.\s*[A-Za-z_]", skel[s:e]):
        add("ERROR", "CALLBACK_MIXED",
            "%s 函数体内调用了 %s.*（游戏会报错）" % (fname, obj),
            s + m.start(),
            "onTick 只碰 input/output，onDraw 只碰 screen；数据用脚本级变量中转")


def _check_httpget(add, src, toks, skel):
    for m in re.finditer(r"async\s*\.\s*httpGet\s*\(", skel):
        # 收集这对括号内的字符串字面量
        depth = 1
        j = m.end()
        inner_strings = []
        for t in toks:
            if t["kind"] == "string" and t["start"] >= m.end():
                inner_strings.append(t)
        # 粗略：取此调用行之后的 2000 字符内的字符串（嵌套括号不常见）
        est = 0
        lit = 0
        for t in inner_strings:
            if t["start"] > j + 2000:
                break
            body = src[t["start"]:t["end"]]
            est += len(body) + 2
            lit += len(body)
        nonlit = max(0, skel.count(",", m.end(), m.end() + 400))
        est += nonlit * 6  # 非字面量参数（数值拼接）按 6 字符估
        total = est + 20
        if total > 3500:
            add("WARN", "HTTPGET_LEN",
                "async.httpGet URL 估算长度 ~%d 字符，接近危险区" % total, m.start(),
                "上限 <4000（超约 4096 崩溃）：减小批量 tick 数 / 降精度 / 减通道")
        else:
            add("INFO", "HTTPGET_OK", "async.httpGet URL 估算长度 ~%d 字符" % total, m.start())


def main():
    ap = argparse.ArgumentParser(description="Stormworks MC Lua 静态检查")
    ap.add_argument("files", nargs="+", help="待检查 .lua 文件")
    ap.add_argument("--stage", choices=["source", "final"], default="source")
    ap.add_argument("--dest", choices=["xml", "paste"], default="xml")
    ap.add_argument("--limit", type=int, default=4096, help="字符上限：MC=4096 脚本方块=8192")
    ap.add_argument("--margin", type=int, default=0)
    ap.add_argument("--strict", action="store_true", help="WARN 也算失败")
    ap.add_argument("--json", action="store_true", help="输出机器可读 JSON")
    args = ap.parse_args()

    report = {"ok": True, "stage": args.stage, "dest": args.dest, "files": []}
    for f in args.files:
        p = Path(f)
        if not p.exists():
            report["files"].append({"file": f, "ok": False,
                                    "findings": [{"sev": "ERROR", "code": "NO_FILE",
                                                  "msg": "文件不存在", "line": 0, "col": 0,
                                                  "hint": "", "file": f}]})
            report["ok"] = False
            continue
        raw = p.read_bytes()
        try:
            src = raw.decode("utf-8")
        except UnicodeDecodeError:
            src = raw.decode("utf-8", "replace")
        if src.startswith("﻿"):
            src = src[1:]
        toks = tokenize(src)
        skel = skeleton_of(src, toks)
        findings = find_findings(src, toks, skel, args, str(p))
        has_err = any(x["sev"] == "ERROR" for x in findings)
        report["files"].append({"file": str(p), "ok": not has_err, "findings": findings})
        if has_err:
            report["ok"] = False

    if args.strict:
        for fr in report["files"]:
            if any(x["sev"] == "WARN" for x in fr["findings"]):
                fr["ok"] = False
                report["ok"] = False

    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
    else:
        icon = {"ERROR": "🔴", "WARN": "🟠", "INFO": "🔵"}
        for fr in report["files"]:
            print("== %s ==" % fr["file"])
            for x in sorted(fr["findings"], key=lambda d: ({"ERROR": 0, "WARN": 1, "INFO": 2}[d["sev"]],
                                                           d["line"], d["col"])):
                loc = "%d:%d" % (x["line"], x["col"]) if x["line"] else "-"
                print("  %s [%s] %s  @%s" % (icon[x["sev"]], x["code"], x["msg"], loc))
                if x.get("hint"):
                    print("       ↳ %s" % x["hint"])
            print("  → %s" % ("通过" if fr["ok"] else "未通过"))
    sys.exit(0 if report["ok"] else 1)


if __name__ == "__main__":
    main()
