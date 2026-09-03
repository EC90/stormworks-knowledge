#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Lua 反压缩（reformat）：把 PonyIDE Minify 后的单行 Lua 恢复成带换行/缩进的可读结构。
结构可完美恢复；变量名有损，需人工按语义重命名（本脚本不做改名）。
用法: unminify.py <file.lua> [-o out.lua]
"""
import re
import sys

# 在这些 token 前后强制换行（Lua 关键字/语句边界）
BREAK_BEFORE = r"\b(function|if|for|while|repeat|local|return|elseif|else|do|then|end|until|break)\b"
BREAK_AFTER = r"\b(then|do|else|repeat|end|until)\b"


def unminify(src: str) -> str:
    # 保护字符串字面量，避免把字符串里的关键字当语句边界
    strs = []

    def stash(m):
        strs.append(m.group(0))
        return f"\x00{len(strs)-1}\x00"

    src = re.sub(r'"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|\[\[.*?\]\]', stash, src, flags=re.S)

    # 保护注释
    src = re.sub(r"--[^\n]*", lambda m: "\x01" + m.group(0).replace(" ", "\x02") + "\n", src)

    src = re.sub(r"\s*;\s*", "\n", src)                 # 语句分隔符 -> 换行
    src = re.sub(BREAK_BEFORE, lambda m: "\n" + m.group(1), src)
    src = re.sub(BREAK_AFTER, lambda m: m.group(1) + "\n", src)

    # 缩进
    out, indent = [], 0
    dec = ("end", "until", "else", "elseif")
    inc = ("then", "do", "repeat", "function", "else")
    for raw in src.split("\n"):
        line = raw.strip()
        if not line:
            continue
        if any(line.startswith(k) or line == k for k in dec):
            indent = max(0, indent - 1)
        out.append("\t" * indent + line)
        # function f() / if x then / for ... do 提升下一行缩进
        head = re.match(r"^(function|if|for|while|repeat|else|elseif)\b", line)
        tail = re.search(r"(then|do)$", line)
        if head and (tail or line.startswith("function") or line in ("else", "repeat")):
            indent += 1
        elif line.startswith("end)"):
            indent = max(0, indent - 1)

    res = "\n".join(out)
    res = re.sub(r"\x01([^\n]*)\n", lambda m: m.group(1).replace("\x02", " ") + "\n", res)
    res = re.sub(r"\x00(\d+)\x00", lambda m: strs[int(m.group(1))], res)
    return res


if __name__ == "__main__":
    src = open(sys.argv[1], encoding="utf-8", errors="ignore").read()
    body = "\n".join(src.split("\n")[2:]) if src.startswith("-- source") else src
    out = unminify(body)
    if "-o" in sys.argv:
        open(sys.argv[sys.argv.index("-o") + 1], "w", encoding="utf-8").write(out)
        print(f"written {sys.argv[sys.argv.index('-o')+1]}  ({len(body)} -> {len(out)} chars)")
    else:
        print(out)
