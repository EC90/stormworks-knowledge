#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Query a local Stormworks Fandom knowledge base built by wiki_crawl.py.

Zero third-party dependencies. Designed to be cheap enough for an AI agent to
call repeatedly: it streams JSONL and only keeps the top-N matches in memory.

Subcommands
-----------
    stats                          dataset overview
    titles [--prefix P] [--limit N] list page titles
    search QUERY [--limit N]       full-text search over chunks
    page TITLE [--full]            dump one page as Markdown
    attr TITLE                     dump the parsed Infobox attributes
    cat CATEGORY                   pages belonging to a category
    findattr KEY [--value V]       search component attributes (e.g. Mass, Cost)

Examples
--------
    python wiki_query.py search "modular engine cylinder"
    python wiki_query.py page "Camera gimbal"
    python wiki_query.py attr "Camera gimbal" --json
    python wiki_query.py findattr "Logic inputs" --value "infrared" --limit 20
"""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
from heapq import heappush, heappushpop
from pathlib import Path
from typing import Any, Dict, Iterable, Iterator, List, Optional, Tuple

EXIT_OK = 0
EXIT_NOT_FOUND = 3


def default_kb_dir() -> Path:
    """知识库目录：环境变量 SW_KB > 技能自带 kb/ > 工作区 <WS>/数据库/stormworks_fandom。

    工作区根目录由脚本位置反推（技能位于 <WS>/技能库/<name>/scripts/ 下），
    不写死盘符，换机器直接可用。
    """
    env = os.environ.get("SW_KB")
    if env:
        return Path(env)
    here = Path(__file__).resolve().parent
    # here = <WS>/技能库/<name>/scripts
    # parents[0]=<name>  parents[1]=技能库  parents[2]=<WS>
    ws = here.parents[2] if len(here.parents) > 2 else here.parent
    candidates = [
        here.parent / "kb",
        ws / "数据库" / "stormworks_fandom",
    ]
    # 先挑真正有 manifest.json 的（空目录不算知识库）
    for candidate in candidates:
        if (candidate / "manifest.json").exists():
            return candidate
    for candidate in candidates:
        if candidate.exists():
            return candidate
    return candidates[0]


def read_jsonl(path: Path) -> Iterator[Dict[str, Any]]:
    if not path.exists():
        return
    with path.open("r", encoding="utf-8") as handle:
        for line in handle:
            line = line.strip()
            if not line:
                continue
            try:
                yield json.loads(line)
            except ValueError:
                continue


def load_manifest(kb: Path) -> Dict[str, Any]:
    manifest_path = kb / "manifest.json"
    if not manifest_path.exists():
        return {}
    try:
        return json.loads(manifest_path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return {}


def require_kb(kb: Path) -> None:
    if not (kb / "pages.jsonl").exists():
        print(
            "ERROR: no knowledge base at %s\n"
            "       Build it first:  python wiki_crawl.py --output %s" % (kb, kb),
            file=sys.stderr,
        )
        raise SystemExit(2)


# --------------------------------------------------------------------------
# search
# --------------------------------------------------------------------------

_TOKEN_RE = re.compile(r"[\w\u4e00-\u9fff]+")


def tokenize(text: str) -> List[str]:
    return [token.lower() for token in _TOKEN_RE.findall(text or "")]


def score_chunk(chunk: Dict[str, Any], tokens: List[str]) -> float:
    if not tokens:
        return 0.0
    title = (chunk.get("title") or "").lower()
    section = " > ".join(chunk.get("section_path") or []).lower()
    body = (chunk.get("text") or "").lower()
    score = 0.0
    for token in tokens:
        if token in title:
            score += 8.0
        if token in section:
            score += 3.0
        occurrences = body.count(token)
        if occurrences:
            score += min(occurrences, 12) * 1.0
            if body.startswith(token):
                score += 1.0
    if score <= 0:
        return 0.0
    # mild length normalisation so one huge page cannot dominate
    return score / (1.0 + len(body) / 12000.0)


def search_chunks(kb: Path, query: str, limit: int) -> List[Tuple[float, Dict[str, Any]]]:
    tokens = tokenize(query)
    heap: List[Tuple[float, int, Dict[str, Any]]] = []
    counter = 0
    for chunk in read_jsonl(kb / "chunks.jsonl"):
        score = score_chunk(chunk, tokens)
        if score <= 0:
            continue
        counter += 1
        entry = (score, counter, chunk)
        if len(heap) < limit:
            heappush(heap, entry)
        else:
            heappushpop(heap, entry)
    heap.sort(key=lambda item: (-item[0], item[1]))
    return [(item[0], item[2]) for item in heap]


def snippet(text: str, tokens: List[str], width: int = 320) -> str:
    lowered = text.lower()
    position = -1
    for token in tokens:
        position = lowered.find(token)
        if position >= 0:
            break
    if position < 0:
        position = 0
    start = max(0, position - width // 3)
    end = min(len(text), start + width)
    fragment = text[start:end].replace("\n", " ")
    if start > 0:
        fragment = "..." + fragment
    if end < len(text):
        fragment = fragment + "..."
    return re.sub(r"\s+", " ", fragment).strip()


# --------------------------------------------------------------------------
# subcommands
# --------------------------------------------------------------------------

def cmd_stats(kb: Path, args: argparse.Namespace) -> int:
    manifest = load_manifest(kb)
    if not manifest:
        print("No manifest.json in %s" % kb, file=sys.stderr)
        return EXIT_NOT_FOUND
    source = manifest.get("source", {})
    dataset = manifest.get("dataset", {})
    print("Knowledge base : %s" % kb)
    print("Site           : %s" % source.get("name"))
    print("Base URL       : %s" % source.get("base_url"))
    print("License        : %s <%s>" % (source.get("license"), source.get("license_url")))
    print("Generated at   : %s" % manifest.get("generated_at"))
    print("Tool version   : %s" % manifest.get("tool_version"))
    print("")
    print("Records        : %s" % dataset.get("records"))
    print("  articles     : %s" % dataset.get("articles"))
    print("  redirects    : %s" % dataset.get("redirects"))
    print("  w/ attributes: %s" % dataset.get("with_attributes"))
    print("Chunks         : %s" % dataset.get("chunks"))
    quality = dataset.get("quality") or {}
    if quality:
        print("Quality        : %s" % ", ".join("%s=%s" % kv for kv in sorted(quality.items())))
    reported = source.get("reported_articles")
    if reported:
        covered = dataset.get("articles") or 0
        print("Coverage       : %s / %s reported articles" % (covered, reported))
    return EXIT_OK


def cmd_titles(kb: Path, args: argparse.Namespace) -> int:
    prefix = (args.prefix or "").casefold()
    shown = 0
    total = 0
    for record in read_jsonl(kb / "pages.jsonl"):
        title = record.get("title", "")
        if prefix and not title.casefold().startswith(prefix):
            continue
        total += 1
        if args.limit and shown >= args.limit:
            continue
        kind = record.get("record_type", "?")
        print("%-8s %-7s %s" % (record.get("source", {}).get("page_id", "?"), kind, title))
        shown += 1
    if args.limit and total > shown:
        print("\n(%d more; use --limit to see more)" % (total - shown), file=sys.stderr)
    elif total == 0:
        print("(no match)", file=sys.stderr)
        return EXIT_NOT_FOUND
    return EXIT_OK


def cmd_search(kb: Path, args: argparse.Namespace) -> int:
    tokens = tokenize(args.query)
    results = search_chunks(kb, args.query, args.limit)
    if not results:
        print("No chunk matched %r." % args.query, file=sys.stderr)
        return EXIT_NOT_FOUND
    if args.json:
        print(
            json.dumps(
                [{"score": round(score, 3), **chunk} for score, chunk in results],
                ensure_ascii=False,
                indent=2,
            )
        )
        return EXIT_OK
    print("Top %d result(s) for %r\n" % (len(results), args.query))
    for rank, (score, chunk) in enumerate(results, start=1):
        print("[%d] %s  (score %.2f)" % (rank, chunk.get("title"), score))
        section = " > ".join(chunk.get("section_path") or [])
        if section:
            print("    section : %s" % section)
        print("    url     : %s" % chunk.get("source_url"))
        if args.full:
            print("    text    :\n%s" % chunk.get("text"))
        else:
            print("    snippet : %s" % snippet(chunk.get("text", ""), tokens, args.snippet))
        print("")
    return EXIT_OK


def _find_pages(kb: Path, needle: str) -> List[Dict[str, Any]]:
    lowered = needle.casefold()
    exact: List[Dict[str, Any]] = []
    partial: List[Dict[str, Any]] = []
    for record in read_jsonl(kb / "pages.jsonl"):
        title = record.get("title", "")
        if title.casefold() == lowered:
            exact.append(record)
        elif lowered in title.casefold():
            partial.append(record)
    return exact or partial


def cmd_page(kb: Path, args: argparse.Namespace) -> int:
    matches = _find_pages(kb, args.title)
    if not matches:
        print("No page matching %r." % args.title, file=sys.stderr)
        return EXIT_NOT_FOUND
    if len(matches) > 1 and not args.json:
        print("Multiple matches; using the closest one. Others:", file=sys.stderr)
        for record in matches[1:11]:
            print("  - %s" % record.get("title"), file=sys.stderr)
        print("", file=sys.stderr)
    record = matches[0]
    if args.json:
        print(json.dumps(record, ensure_ascii=False, indent=2))
        return EXIT_OK
    if record.get("record_type") == "redirect":
        target = record.get("redirect", {})
        print("%s is a redirect -> %s\n%s" % (record["title"], target.get("target_title"), target.get("target_url")))
        return EXIT_OK
    print("# %s" % record.get("title"))
    print("URL        : %s" % record.get("source", {}).get("url"))
    print("Revision   : %s" % record.get("source", {}).get("revision_id"))
    print("Categories : %s" % ", ".join(record.get("categories") or []) or "-")
    print("")
    attributes = record.get("attributes") or {}
    if attributes:
        print("## Specifications")
        for key, value in attributes.items():
            print("  %-24s %s" % (key, value))
        print("")
    print("## Summary")
    print(record.get("summary", ""))
    print("")
    print("## Content")
    print(record.get("content", {}).get("markdown", ""))
    if args.wikitext and record.get("wikitext"):
        print("\n## Wikitext")
        print(record["wikitext"])
    return EXIT_OK


def cmd_attr(kb: Path, args: argparse.Namespace) -> int:
    matches = _find_pages(kb, args.title)
    matches = [record for record in matches if record.get("attributes")]
    if not matches:
        print("No Infobox attributes for %r (page missing or template-less)." % args.title, file=sys.stderr)
        return EXIT_NOT_FOUND
    if args.json:
        print(
            json.dumps(
                [
                    {
                        "page_id": record.get("source", {}).get("page_id"),
                        "title": record.get("title"),
                        "url": record.get("source", {}).get("url"),
                        "template": record.get("template"),
                        "attributes": record.get("attributes"),
                    }
                    for record in matches
                ],
                ensure_ascii=False,
                indent=2,
            )
        )
        return EXIT_OK
    for record in matches:
        print("%s  (template: %s)" % (record.get("title"), record.get("template") or "-"))
        for key, value in (record.get("attributes") or {}).items():
            print("  %-24s %s" % (key, value))
        print("")
    return EXIT_OK


def cmd_cat(kb: Path, args: argparse.Namespace) -> int:
    wanted = args.category.casefold()
    found = 0
    for record in read_jsonl(kb / "pages.jsonl"):
        categories = [str(item) for item in (record.get("categories") or [])]
        if any(wanted == item.casefold() or wanted in item.casefold() for item in categories):
            print("%-8s %s" % (record.get("source", {}).get("page_id", "?"), record.get("title")))
            found += 1
            if args.limit and found >= args.limit:
                break
    if not found:
        print("No page in category %r." % args.category, file=sys.stderr)
        return EXIT_NOT_FOUND
    return EXIT_OK


def cmd_findattr(kb: Path, args: argparse.Namespace) -> int:
    needle_key = args.key.casefold()
    needle_value = (args.value or "").casefold()
    found = 0
    for record in read_jsonl(kb / "pages.jsonl"):
        attributes = record.get("attributes") or {}
        for key, value in attributes.items():
            if needle_key not in key.casefold():
                continue
            if needle_value and needle_value not in str(value).casefold():
                continue
            print("%-42s %-22s %s" % (record.get("title"), key, value))
            found += 1
            break
        if args.limit and found >= args.limit:
            break
    if not found:
        print("No attribute %r found." % args.key, file=sys.stderr)
        return EXIT_NOT_FOUND
    return EXIT_OK


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="wiki_query.py",
        description="Query a local Stormworks Fandom knowledge base.",
    )
    parser.add_argument("--kb", type=Path, default=default_kb_dir(), help="Knowledge base directory.")
    subparsers = parser.add_subparsers(dest="command", required=True)

    subparsers.add_parser("stats", help="Dataset overview.").set_defaults(func=cmd_stats)

    titles = subparsers.add_parser("titles", help="List page titles.")
    titles.add_argument("--prefix", help="Only titles with this prefix.")
    titles.add_argument("--limit", type=int, default=100)
    titles.set_defaults(func=cmd_titles)

    search = subparsers.add_parser("search", help="Full-text search over chunks.")
    search.add_argument("query")
    search.add_argument("--limit", type=int, default=8)
    search.add_argument("--snippet", type=int, default=320)
    search.add_argument("--full", action="store_true", help="Print the whole chunk text.")
    search.add_argument("--json", action="store_true")
    search.set_defaults(func=cmd_search)

    page = subparsers.add_parser("page", help="Dump one page.")
    page.add_argument("title")
    page.add_argument("--full", action="store_true", help="(deprecated) kept for compatibility.")
    page.add_argument("--wikitext", action="store_true", help="Also print raw wikitext.")
    page.add_argument("--json", action="store_true")
    page.set_defaults(func=cmd_page)

    attr = subparsers.add_parser("attr", help="Show parsed Infobox attributes.")
    attr.add_argument("title")
    attr.add_argument("--json", action="store_true")
    attr.set_defaults(func=cmd_attr)

    cat = subparsers.add_parser("cat", help="List pages in a category.")
    cat.add_argument("category")
    cat.add_argument("--limit", type=int, default=200)
    cat.set_defaults(func=cmd_cat)

    findattr = subparsers.add_parser("findattr", help="Search component attributes.")
    findattr.add_argument("key")
    findattr.add_argument("--value", help="Substring filter on the value.")
    findattr.add_argument("--limit", type=int, default=50)
    findattr.set_defaults(func=cmd_findattr)

    return parser


def main(argv: Optional[List[str]] = None) -> int:
    args = build_parser().parse_args(argv)
    kb = Path(args.kb)
    if args.command != "stats":
        require_kb(kb)
    return args.func(kb, args)


if __name__ == "__main__":
    raise SystemExit(main())
