#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""sw_lua_xmlsafe.py — 把 minify 产物整理成「可直接写进载具 XML 属性」的安全形态。

纯标准库（依赖：无）。做的事：
  1. 把 "..." 短字符串字面量改成 '...'（内容含 ' 或 \\ 的不动并报告——\\ 在游戏源码里本就非法）
  2. --strip-map-comment：删尾部 `-- //# sourceMappingURL=...` 注释（省字符；map 文件单独留存）
  3. 报告残留的 < 和 &（这两个改不了，必须在源码里按 > 方向重写后重新 minify）

用法：
  python sw_lua_xmlsafe.py <in.lua> [-o out.lua] [--strip-map-comment]
不指定 -o 时输出到输入旁的 <名字>.xmlsafe.lua。
退出码：0=已产出安全文件；1=存在改不了的违禁字符（先修源码）。
"""

import argparse
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from lua_lex import tokenize, offset_to_line_col  # noqa: E402

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

MAP_COMMENT_RE = re.compile(r"[ \t]*--[ \t]*//[# \t]*sourceMappingURL[^\n]*\n?")


def xmlsafe(src, strip_map_comment):
    """返回 (out_src, fixed_quotes, residual)。residual: [(char, line, col)]"""
    toks = tokenize(src)
    out = []
    pos = 0
    fixed = 0
    for t in toks:
        if t["kind"] == "string" and t.get("quote") == '"':
            body = src[t["start"] + 1:t["end"] - 1]
            if "'" not in body and "\\" not in body:
                out.append(src[pos:t["start"]])
                out.append("'" + body + "'")
                pos = t["end"]
                fixed += 1
        elif t["kind"] == "unterminated":
            break  # 交给 lint 报错
    out.append(src[pos:])
    res = "".join(out)

    if strip_map_comment:
        res = MAP_COMMENT_RE.sub("", res)

    residual = []
    for ch in ("<", "&", '"'):
        start = 0
        while True:
            i = res.find(ch, start)
            if i < 0:
                break
            line, col = offset_to_line_col(res, i)
            residual.append((ch, line, col))
            start = i + 1
    return res, fixed, residual


def main():
    ap = argparse.ArgumentParser(description="minify 产物 → XML 属性安全形态")
    ap.add_argument("infile")
    ap.add_argument("-o", "--out", help="输出路径（默认 <名>.xmlsafe.lua）")
    ap.add_argument("--strip-map-comment", action="store_true",
                    help="删除尾部 sourceMappingURL 注释")
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args()

    p = Path(args.infile)
    src = p.read_text(encoding="utf-8")
    res, fixed, residual = xmlsafe(src, args.strip_map_comment)

    outp = Path(args.out) if args.out else p.with_name(p.stem + ".xmlsafe.lua")
    outp.write_text(res, encoding="utf-8", newline="\n")

    summary = {"in": str(p), "out": str(outp), "quotes_fixed": fixed,
               "chars_before": len(src), "chars_after": len(res),
               "residual": [{"char": c, "line": l, "col": col} for c, l, col in residual],
               "safe": not residual}
    if args.json:
        print(json.dumps(summary, ensure_ascii=False, indent=2))
    else:
        print("✔ 双引号字面量改写 %d 处：%s → %s（%d → %d 字符）"
              % (fixed, p.name, outp.name, len(src), len(res)))
        if residual:
            print("🔴 以下违禁字符改不了，必须回源码修（比较写 > 方向；字符串内 & 用 string.char(38)）：")
            for ch, l, col in residual[:10]:
                print("   %r @%d:%d" % (ch, l, col))
            sys.exit(1)
        print("✔ 无残留违禁字符，可安全写入 XML 属性")
    sys.exit(0 if not residual else 1)


if __name__ == "__main__":
    main()
