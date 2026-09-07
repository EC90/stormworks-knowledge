# -*- coding: utf-8 -*-
"""lua_lex.py — 极简 Lua 词法扫描（纯标准库，供 sw_lua_lint / sw_lua_xmlsafe 共用）。

只做一件事：把源码切成「代码 / 字符串字面量 / 注释」三类的 span。
不做完整语法解析——目的是让后续检查在"挖掉字符串与注释"的骨架上进行，
避免把字符串里的 `<`、`screen.` 之类误报为代码。

约定（与 AGENTS.md §6 一致）：Stormworks 游戏内 Lua 源码仅 ASCII、反斜杠非法；
本模块按 Lua 5.3 词法处理 `--` 注释、`'...'`/`"..."` 短字符串、`[=*[...]=*]` 长字符串。
"""

import re

_LONG_OPEN = re.compile(r"\[=*\[")
_LONG_CLOSE = re.compile(r"\]=*\]")


def tokenize(src):
    """扫描源码，返回 token 列表。

    每个 token 是 dict：
      kind  : 'code' | 'string' | 'comment' | 'unterminated'
      start : 起始偏移（含引号/起始符）
      end   : 结束偏移（不含）
      line  : 1 起始行号
      col   : 1 起始列号
      quote : 短字符串的引号字符（' 或 "），字符串类才有
      level : 长字符串/长注释的等号级数（0 表示 [[ ]]），有才给
    code 段不单独出 token——调用方用 skeleton_of 自己挖。
    """
    toks = []
    n = len(src)
    i = 0
    line = 1
    col = 1

    def advance(ch):
        nonlocal line, col
        if ch == "\n":
            line += 1
            col = 1
        else:
            col += 1

    while i < n:
        c = src[i]
        if c == "-" and i + 1 < n and src[i + 1] == "-":
            start_line, start_col = line, col
            j = i + 2
            m = _LONG_OPEN.match(src, j)
            level = None
            if m:
                level = m.group(0).count("=")
                close_re = re.compile(r"\]" + "=" * level + r"\]")
                cm = close_re.search(src, m.end())
                if cm:
                    j = cm.end()
                else:
                    j = n
            else:
                nl = src.find("\n", j)
                j = n if nl < 0 else nl  # 行注释不含换行本身
            toks.append({"kind": "comment", "start": i, "end": j,
                         "line": start_line, "col": start_col, "level": level})
            for ch in src[i:j]:
                advance(ch)
            i = j
        elif c == '"' or c == "'":
            start_line, start_col = line, col
            j = i + 1
            closed = False
            while j < n:
                ch = src[j]
                if ch == "\\":
                    j += 2
                    continue
                if ch == "\n":
                    break  # 短字符串不允许裸换行
                if ch == c:
                    j += 1
                    closed = True
                    break
                j += 1
            kind = "string" if closed else "unterminated"
            toks.append({"kind": kind, "start": i, "end": min(j, n),
                         "line": start_line, "col": start_col, "quote": c})
            for ch in src[i:min(j, n)]:
                advance(ch)
            i = min(j, n)
        elif c == "[":
            m = _LONG_OPEN.match(src, i)
            if m:
                level = m.group(0).count("=")
                close_re = re.compile(r"\]" + "=" * level + r"\]")
                cm = close_re.search(src, m.end())
                start_line, start_col = line, col
                j = cm.end() if cm else n
                toks.append({"kind": "string" if cm else "unterminated",
                             "start": i, "end": j,
                             "line": start_line, "col": start_col, "level": level})
                for ch in src[i:j]:
                    advance(ch)
                i = j
            else:
                advance(c)
                i += 1
        else:
            advance(c)
            i += 1
    return toks


def skeleton_of(src, toks):
    """生成与 src 等长的「骨架」：字符串/注释内容替换为空格，保留换行。

    代码 token 原样保留；字符串与注释的引号/内容都挖掉（代码分析不需要它们）。
    骨架用于：关键字深度扫描、`screen.` 误用检测、`math.atan2` 检测等。
    """
    sk = list(src)
    for t in toks:
        if t["kind"] == "code":
            continue
        for k in range(t["start"], t["end"]):
            if sk[k] != "\n":
                sk[k] = " "
    return "".join(sk)


def string_inner(src, tok):
    """取字符串 token 的内容（去掉引号/长括号），未转义原样返回。"""
    if tok.get("level") is not None:
        body = src[tok["start"]:tok["end"]]
        open_len = 2 + tok["level"]
        return body[open_len:len(body) - (open_len if tok["kind"] == "string" else 0)]
    q = tok["quote"]
    body = src[tok["start"] + 1:tok["end"] - (1 if tok["kind"] == "string" else 0)]
    return body


def code_lines_with_offsets(src):
    """返回 [(line_no, offset_of_line_start, line_text)]，便于定位。"""
    offs = [0]
    for idx, ch in enumerate(src):
        if ch == "\n":
            offs.append(idx + 1)
    out = []
    for li, off in enumerate(offs):
        end = src.find("\n", off)
        if end < 0:
            end = len(src)
        out.append((li + 1, off, src[off:end]))
    return out


def offset_to_line_col(src, off):
    line = src.count("\n", 0, off) + 1
    col = off - (src.rfind("\n", 0, off) + 1) + 1
    return line, col
