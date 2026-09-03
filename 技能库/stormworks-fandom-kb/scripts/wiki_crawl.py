#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Stormworks Fandom Wiki -> local AI / RAG knowledge base.

Zero third-party dependencies: Python 3.9+ standard library only.
Works on any machine / agent harness that has Python, no pip install needed.

Design notes
------------
* Uses the public MediaWiki API (``api.php``). stormworks.fandom.com/robots.txt
  explicitly declares ``Allow: /api.php?action=`` for ``User-agent: *``, so this
  path is permitted; the rendered /wiki/ page shell (ads, nav, recommendations)
  is intentionally never fetched.
* For each article we keep BOTH representations:
  - the rendered HTML converted to Markdown (readable prose, tables, lists)
  - the raw wikitext, from which ``{{Infobox ...}}`` parameters are parsed into
    a clean key/value ``attributes`` dict (Mass / Cost / Logic inputs / ...).
    This is the single most useful structure on this wiki for component lookups.
* Everything is incremental: state.json + per-page files, so an interrupted
  crawl resumes and a re-run only refetches changed revisions.
"""

from __future__ import annotations

import argparse
import gzip
import hashlib
import html as html_mod
import json
import logging
import os
import re
import sys
import time
import unicodedata
import urllib.error
import urllib.parse
import urllib.request
import urllib.robotparser
from datetime import datetime, timezone
from html.parser import HTMLParser
from pathlib import Path
from typing import Any, Dict, Iterable, Iterator, List, Optional, Tuple

SCHEMA_VERSION = "1.0"
TOOL_VERSION = "2.0.0"
DEFAULT_LICENSE_NAME = "CC BY-NC-SA"
DEFAULT_LICENSE_URL = "https://www.fandom.com/licensing"
RETRY_STATUS = {429, 500, 502, 503, 504}

LOG = logging.getLogger("swkb")


class CrawlError(RuntimeError):
    """Fatal, user-facing crawl error."""


# --------------------------------------------------------------------------
# Minimal DOM
# --------------------------------------------------------------------------

VOID_TAGS = {
    "area", "base", "br", "col", "embed", "hr", "img", "input",
    "link", "meta", "param", "source", "track", "wbr",
}
SKIP_TAGS = {"script", "style", "iframe", "noscript", "svg", "canvas", "template"}

# tag -> set of ancestor tags that this tag implicitly closes
AUTO_CLOSE = {
    "li": {"li"},
    "p": {"p"},
    "tr": {"tr", "td", "th"},
    "td": {"td", "th"},
    "th": {"td", "th"},
    "dt": {"dt", "dd"},
    "dd": {"dt", "dd"},
    "thead": {"td", "th", "tr"},
    "tbody": {"td", "th", "tr"},
    "tfoot": {"td", "th", "tr"},
    "option": {"option"},
}
for _level in range(1, 7):
    AUTO_CLOSE["h%d" % _level] = {"h1", "h2", "h3", "h4", "h5", "h6", "p"}


class Node:
    """A tiny element/text node. ``tag is None`` marks a text node."""

    __slots__ = ("tag", "attrs", "children", "parent", "data")

    def __init__(self, tag, attrs=None, parent=None, data=""):
        self.tag = tag
        self.attrs: Dict[str, str] = attrs or {}
        self.children: List["Node"] = []
        self.parent = parent
        self.data = data

    @property
    def classes(self) -> List[str]:
        return self.attrs.get("class", "").split()

    def get(self, name: str, default: str = "") -> str:
        return self.attrs.get(name, default)

    def detach(self) -> None:
        if self.parent is not None:
            try:
                self.parent.children.remove(self)
            except ValueError:
                pass
            self.parent = None

    def text(self, sep: str = "") -> str:
        if self.tag is None:
            return self.data
        return sep.join(child.text(sep) for child in self.children)

    def __repr__(self) -> str:  # pragma: no cover - debugging aid
        return "<Node %s>" % (self.tag or "#text")


class _TreeBuilder(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.root = Node("#root")
        self.stack: List[Node] = [self.root]
        self._skip = 0

    def handle_starttag(self, tag, attrs):
        if self._skip:
            self._skip += 1
            return
        tag = tag.lower()
        if tag in SKIP_TAGS:
            self._skip = 1
            return
        closing = AUTO_CLOSE.get(tag)
        if closing:
            while len(self.stack) > 1 and self.stack[-1].tag in closing:
                self.stack.pop()
        node = Node(tag, {k.lower(): (v or "") for k, v in attrs}, self.stack[-1])
        self.stack[-1].children.append(node)
        if tag not in VOID_TAGS:
            self.stack.append(node)

    def handle_endtag(self, tag):
        if self._skip:
            self._skip -= 1
            return
        tag = tag.lower()
        if tag in VOID_TAGS:
            return
        for index in range(len(self.stack) - 1, 0, -1):
            if self.stack[index].tag == tag:
                del self.stack[index:]
                return

    def handle_data(self, data):
        if self._skip:
            return
        if not data:
            return
        parent = self.stack[-1]
        if parent.children and parent.children[-1].tag is None:
            parent.children[-1].data += data
        else:
            parent.children.append(Node(None, {}, parent, data))


def build_tree(raw_html: str) -> Node:
    builder = _TreeBuilder()
    builder.feed(raw_html)
    builder.close()
    return builder.root


def walk(node: Node) -> Iterator[Node]:
    for child in node.children:
        if child.tag is not None:
            yield child
            for sub in walk(child):
                yield sub


# --------------------------------------------------------------------------
# CSS subset selector engine (tag, #id, .class, [attr*=v], descendant)
# --------------------------------------------------------------------------

_ATTR_RE = re.compile(
    r"\[\s*([\w:-]+)\s*(?:([~^$*|]?=)\s*(?:\"([^\"]*)\"|'([^']*)'|([^\]\s]*))\s*)?\]"
)
_TOKEN_RE = re.compile(r"[#.]?[\w-]+|\[[^\]]*\]")


def _split_top_level(selector: str, separators: str) -> List[str]:
    """Split a selector on ``separators`` that sit outside [] brackets and quotes.

    Needed because attribute values legitimately contain spaces and commas,
    e.g. ``div[style*='clear: both']``.
    """
    parts: List[str] = []
    buffer: List[str] = []
    depth = 0
    quote: Optional[str] = None
    for char in selector:
        if quote:
            buffer.append(char)
            if char == quote:
                quote = None
            continue
        if char in "\"'":
            quote = char
            buffer.append(char)
            continue
        if char == "[":
            depth += 1
        elif char == "]":
            depth = max(0, depth - 1)
        if char in separators and depth == 0:
            if buffer:
                parts.append("".join(buffer))
                buffer = []
            continue
        buffer.append(char)
    if buffer:
        parts.append("".join(buffer))
    return [part.strip() for part in parts if part.strip()]


def _parse_simple(selector: str) -> Dict[str, Any]:
    token = selector.strip()
    simple: Dict[str, Any] = {"tag": None, "id": None, "classes": [], "attrs": []}
    for raw in _TOKEN_RE.findall(token):
        if raw.startswith("#"):
            simple["id"] = raw[1:]
        elif raw.startswith("."):
            simple["classes"].append(raw[1:])
        elif raw.startswith("["):
            match = _ATTR_RE.match(raw)
            if match:
                name = match.group(1)
                op = match.group(2) or ""
                value = match.group(3) or match.group(4) or match.group(5) or ""
                simple["attrs"].append((name, op, value))
        elif not simple["tag"]:
            simple["tag"] = raw.lower()
    return simple


def _match_simple(node: Node, simple: Dict[str, Any]) -> bool:
    if simple["tag"] and node.tag != simple["tag"]:
        return False
    if simple["id"] and node.get("id") != simple["id"]:
        return False
    node_classes = node.classes
    for name in simple["classes"]:
        if name not in node_classes:
            return False
    for name, op, value in simple["attrs"]:
        actual = node.attrs.get(name)
        if actual is None:
            return False
        if op == "=" and actual != value:
            return False
        if op == "*=" and value not in actual:
            return False
        if op == "^=" and not actual.startswith(value):
            return False
        if op == "$=" and not actual.endswith(value):
            return False
        if op == "~=" and value not in actual.split():
            return False
    return True


def _match_chain(node: Node, chain: List[Dict[str, Any]]) -> bool:
    if not _match_simple(node, chain[-1]):
        return False
    index = len(chain) - 2
    current = node.parent
    while index >= 0:
        if current is None or current.tag is None:
            return False
        if _match_simple(current, chain[index]):
            index -= 1
        current = current.parent
    return True


def select_all(root: Node, selector: str) -> List[Node]:
    chains = []
    for group in _split_top_level(selector, ","):
        parts = _split_top_level(group, " \t\r\n")
        if parts:
            chains.append([_parse_simple(part) for part in parts])
    if not chains:
        return []
    found: List[Node] = []
    for node in walk(root):
        for chain in chains:
            if _match_chain(node, chain):
                found.append(node)
                break
    return found


# --------------------------------------------------------------------------
# Cleaning
# --------------------------------------------------------------------------

_WS_RE = re.compile(r"\s+")


def collapse_ws(text: str) -> str:
    return _WS_RE.sub(" ", text).strip()


def clean_text(text: str) -> str:
    text = unicodedata.normalize("NFKC", html_mod.unescape(text))
    text = text.replace("\u00a0", " ")
    text = re.sub(r"[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]", "", text)
    text = re.sub(r"[ \t]+\n", "\n", text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()


def absolutize(root: Node, base_url: str) -> None:
    base = base_url.rstrip("/") + "/"
    for node in walk(root):
        if node.tag in ("a", "img", "source"):
            for attribute in ("href", "src"):
                value = node.attrs.get(attribute)
                if value and not value.startswith("data:"):
                    node.attrs[attribute] = urllib.parse.urljoin(base, value)


def remove_boilerplate(root: Node, config: Dict[str, Any]) -> None:
    for selector in config.get("remove_selectors", []):
        try:
            for node in select_all(root, selector):
                node.detach()
        except Exception as exc:  # noqa: BLE001 - a bad selector must not kill a run
            LOG.warning("Invalid selector %r: %s", selector, exc)

    for pattern in config.get("remove_text_patterns", []):
        try:
            regex = re.compile(pattern, re.IGNORECASE)
        except re.error as exc:
            LOG.warning("Invalid text pattern %r: %s", pattern, exc)
            continue
        for node in list(walk(root)):
            first = node.children[0] if node.children else None
            if first is not None and first.tag is None and regex.search(first.data):
                node.detach()

    # Drop containers that ended up empty and carry no image.
    for _ in range(3):
        changed = False
        for node in list(walk(root)):
            if node.tag in ("div", "span", "p", "section") and not node.text().strip():
                if not select_all(node, "img"):
                    node.detach()
                    changed = True
        if not changed:
            break


# --------------------------------------------------------------------------
# Markdown rendering
# --------------------------------------------------------------------------

BLOCK_TAGS = {
    "address", "article", "aside", "blockquote", "caption", "center", "dd", "details",
    "div", "dl", "dt", "fieldset", "figcaption", "figure", "footer", "form",
    "h1", "h2", "h3", "h4", "h5", "h6", "header", "hr", "li", "main", "nav", "ol",
    "p", "pre", "section", "summary", "table", "tbody", "tfoot", "thead", "tr", "ul",
}
NESTED_IN_LI = {"ul", "ol", "table", "pre", "blockquote"}


def render_inline(node: Node) -> str:
    if node.tag is None:
        return node.data
    tag = node.tag
    inner = "".join(render_inline(child) for child in node.children)
    if tag == "a":
        href = node.get("href")
        label = collapse_ws(inner)
        if not href:
            return inner
        if not label:
            label = href
        # If the label already contains markdown (e.g. a nested image) do not
        # escape "]" - doing so would corrupt the inner ![]() syntax.
        if "](" in label:
            return "[%s](%s)" % (label, href)
        return "[%s](%s)" % (label.replace("]", "\\]"), href)
    if tag == "img":
        src = node.get("src") or node.get("data-src") or node.get("data-original-src")
        alt = collapse_ws(node.get("alt"))
        if not src and not alt:
            return ""
        return "![%s](%s)" % (alt.replace("]", "\\]"), src)
    if tag in ("b", "strong"):
        return "**%s**" % inner if inner.strip() else inner
    if tag in ("i", "em"):
        return "*%s*" % inner if inner.strip() else inner
    if tag in ("code", "kbd", "samp", "tt"):
        return "`%s`" % inner if inner.strip() else inner
    if tag == "br":
        return " "
    if tag == "hr":
        return ""
    return inner


def _has_block_child(node: Node) -> bool:
    return any(child.tag in BLOCK_TAGS for child in node.children)


def _render_list(node: Node, lines: List[str], depth: int, ordered: bool) -> None:
    """Render a list into ``lines`` (one entry per line, indentation preserved)."""
    items = [child for child in node.children if child.tag == "li"]
    if not items:
        return
    for index, item in enumerate(items, start=1):
        marker = "%d." % index if ordered else "-"
        head = collapse_ws(
            "".join(
                render_inline(child) for child in item.children if child.tag not in NESTED_IN_LI
            )
        )
        lines.append(("%s%s %s" % ("  " * depth, marker, head)).rstrip())
        for child in item.children:
            if child.tag in ("ul", "ol"):
                _render_list(child, lines, depth + 1, child.tag == "ol")
            elif child.tag in NESTED_IN_LI:
                sub: List[str] = []
                render_node(child, sub, depth + 1)
                indent = "  " * (depth + 1)
                for line in sub:
                    lines.append(indent + line if line else "")


def _render_table(node: Node, out: List[str]) -> None:
    rows: List[List[Tuple[str, str]]] = []
    for row in select_all(node, "tr"):
        cells: List[Tuple[str, str]] = []
        for cell in row.children:
            if cell.tag in ("td", "th"):
                cells.append((cell.tag, collapse_ws(render_inline(cell)).replace("|", "\\|")))
        if cells and any(text for _, text in cells):
            rows.append(cells)
    if not rows:
        return
    width = max(len(row) for row in rows)
    lines: List[str] = []
    for row_index, row in enumerate(rows):
        padded = [text for _, text in row] + [""] * (width - len(row))
        lines.append("| " + " | ".join(padded) + " |")
        if row_index == 0:
            is_header = row and all(kind == "th" for kind, _ in row)
            if is_header or width >= 2:
                lines.append("|" + "|".join([" --- "] * width) + "|")
    out.append("\n".join(lines))


def render_node(node: Node, out: List[str], list_depth: int = 0) -> None:
    if node.tag is None:
        text = collapse_ws(node.data)
        if text:
            out.append(text)
        return

    tag = node.tag

    if tag in ("h1", "h2", "h3", "h4", "h5", "h6"):
        level = int(tag[1])
        title = collapse_ws(render_inline(node))
        if title:
            out.append("#" * level + " " + title)
        return

    if tag == "p":
        text = collapse_ws(render_inline(node))
        if text:
            out.append(text)
        return

    if tag in ("ul", "ol"):
        lines: List[str] = []
        _render_list(node, lines, list_depth, tag == "ol")
        if lines:
            out.append("\n".join(lines))
        return

    if tag == "li":
        # A stray <li> outside a list: render it as a single item.
        head = collapse_ws(
            "".join(render_inline(child) for child in node.children if child.tag not in NESTED_IN_LI)
        )
        out.append(("%s- %s" % ("  " * list_depth, head)).rstrip())
        for child in node.children:
            if child.tag in ("ul", "ol"):
                sub_lines: List[str] = []
                _render_list(child, sub_lines, list_depth + 1, child.tag == "ol")
                out.append("\n".join(sub_lines))
        return

    if tag == "table":
        _render_table(node, out)
        return

    if tag == "pre":
        body = node.text().strip("\n")
        if body:
            out.append("```\n" + body + "\n```")
        return

    if tag == "blockquote":
        sub: List[str] = []
        for child in node.children:
            render_node(child, sub, 0)
        body = "\n\n".join(part for part in sub if part).strip()
        if body:
            out.append("\n".join("> " + line for line in body.splitlines()))
        return

    if tag == "hr":
        out.append("---")
        return

    if tag == "br":
        out.append("")
        return

    if tag in BLOCK_TAGS:
        if _has_block_child(node):
            for child in node.children:
                render_node(child, out, list_depth)
        else:
            text = collapse_ws(render_inline(node))
            if text:
                out.append(text)
        return

    text = collapse_ws(render_inline(node))
    if text:
        out.append(text)


def tidy_markdown(markdown: str) -> str:
    markdown = clean_text(markdown)
    markdown = re.sub(r"\[\s*edit\s*(?:page|source)?\s*\]", "", markdown, flags=re.IGNORECASE)
    markdown = re.sub(r"\[\s*\]\([^)]*action=edit[^)]*\)", "", markdown, flags=re.IGNORECASE)
    # NOTE: do not strip leading whitespace here - it carries nested-list indentation.
    markdown = markdown.replace("\t", "  ")
    markdown = re.sub(r"[ \t]+$", "", markdown, flags=re.MULTILINE)
    markdown = re.sub(r"\n{3,}", "\n\n", markdown)
    return markdown.strip()


def html_to_markdown(
    raw_html: str,
    base_url: str,
    config: Dict[str, Any],
    extra_selectors: Optional[List[str]] = None,
) -> Dict[str, Any]:
    """Convert article HTML to Markdown.

    ``extra_selectors`` are removed in addition to the configured ones. It is
    used to drop the rendered ``table.infobox`` when the same data was already
    extracted from wikitext, so facts are not duplicated in the chunk text.
    """
    root = build_tree(raw_html)
    remove_boilerplate(root, config)
    for selector in extra_selectors or []:
        for node in select_all(root, selector):
            node.detach()
    absolutize(root, base_url)
    images = extract_images(root)
    tables = extract_tables(root)
    blocks: List[str] = []
    for child in root.children:
        render_node(child, blocks, 0)
    markdown = tidy_markdown("\n\n".join(block for block in blocks if block.strip()))
    plain = clean_text(root.text("\n"))
    return {"markdown": markdown, "plain_text": plain, "images": images, "tables": tables}


def extract_images(root: Node) -> List[Dict[str, Any]]:
    images: List[Dict[str, Any]] = []
    seen = set()
    for node in select_all(root, "img"):
        src = node.get("src") or node.get("data-src") or node.get("data-original-src")
        if not src or src.startswith("data:") or src in seen:
            continue
        seen.add(src)
        parent_link = node.parent
        while parent_link is not None and parent_link.tag != "a":
            parent_link = parent_link.parent
        images.append(
            {
                "url": parent_link.get("href") if parent_link else src,
                "thumbnail_url": src,
                "alt": collapse_ws(node.get("alt")),
                "width": node.get("width") or None,
                "height": node.get("height") or None,
            }
        )
    return images


def extract_tables(root: Node) -> List[Dict[str, Any]]:
    tables: List[Dict[str, Any]] = []
    for index, table in enumerate(select_all(root, "table"), start=1):
        rows: List[List[str]] = []
        for row in select_all(table, "tr"):
            cells = [collapse_ws(render_inline(cell)) for cell in row.children if cell.tag in ("td", "th")]
            if cells and any(cells):
                rows.append(cells)
        if not rows:
            continue
        caption_nodes = select_all(table, "caption")
        tables.append(
            {
                "index": index,
                "caption": collapse_ws(caption_nodes[0].text(" ")) if caption_nodes else None,
                "classes": table.classes,
                "rows": rows,
            }
        )
    return tables


# --------------------------------------------------------------------------
# Wikitext: infobox / template parameters -> structured attributes
# --------------------------------------------------------------------------

def find_templates(wikitext: str, prefix: str = "") -> List[Tuple[str, str]]:
    """Return [(name, params_body)] for top-level ``{{...}}`` templates."""
    found: List[Tuple[str, str]] = []
    position = 0
    length = len(wikitext)
    while position < length:
        start = wikitext.find("{{", position)
        if start < 0:
            break
        depth = 0
        cursor = start
        while cursor < length:
            if wikitext.startswith("{{", cursor):
                depth += 1
                cursor += 2
                continue
            if wikitext.startswith("}}", cursor):
                depth -= 1
                cursor += 2
                if depth == 0:
                    break
                continue
            cursor += 1
        if depth != 0:
            break
        body = wikitext[start + 2: cursor - 2]
        position = cursor
        name, _, params = body.partition("|")
        name = collapse_ws(name)
        if not prefix or name.lower().startswith(prefix.lower()):
            found.append((name, params))
    return found


def split_params(body: str) -> List[str]:
    """Split template params on top-level ``|`` (inside [[ ]] / {{ }} is safe)."""
    parts: List[str] = []
    buffer: List[str] = []
    depth = 0
    index = 0
    while index < len(body):
        if body.startswith("[[", index) or body.startswith("{{", index):
            depth += 1
            buffer.append(body[index:index + 2])
            index += 2
            continue
        if body.startswith("]]", index) or body.startswith("}}", index):
            depth -= 1
            buffer.append(body[index:index + 2])
            index += 2
            continue
        char = body[index]
        if char == "|" and depth == 0:
            parts.append("".join(buffer))
            buffer = []
            index += 1
            continue
        buffer.append(char)
        index += 1
    parts.append("".join(buffer))
    return parts


def clean_wiki_value(value: str) -> str:
    value = value.strip()
    if not value:
        return ""
    code_block = re.match(r"^\{\{code-block\s*\|\s*content=(.*)\}\}$", value, re.S | re.I)
    if code_block:
        value = code_block.group(1)
    value = re.sub(r"<!--.*?-->", "", value, flags=re.S)
    value = re.sub(r"\[\[[^\]|]*\|([^\]]*)\]\]", r"\1", value)
    value = re.sub(r"\[\[([^\]]*)\]\]", r"\1", value)
    value = re.sub(r"\[https?://\S+\s+([^\]]*)\]", r"\1", value)
    value = re.sub(r"\[(https?://\S+)\]", r"\1", value)
    value = value.replace("'''", "").replace("''", "")
    value = re.sub(r"<br\s*/?>", " ", value, flags=re.I)
    value = re.sub(r"<[^>]+>", "", value)
    value = html_mod.unescape(value)
    return collapse_ws(value)


def extract_template_params(wikitext: str, prefixes: Iterable[str]) -> Dict[str, Any]:
    """Return {"_template": name, key: value} for the first matching template."""
    prefixes = [p.lower() for p in prefixes]
    for name, body in find_templates(wikitext):
        lowered = name.lower()
        if not any(lowered.startswith(prefix) for prefix in prefixes):
            continue
        params: Dict[str, Any] = {"_template": name}
        positional = 0
        for part in split_params(body):
            if "=" in part:
                key, _, value = part.partition("=")
                key = collapse_ws(key)
                value = clean_wiki_value(value)
                if key and value and key not in params:
                    params[key] = value
            else:
                value = clean_wiki_value(part)
                if value:
                    positional += 1
                    params.setdefault("_unnamed_%d" % positional, value)
        if len(params) > 1:
            return params
    return {}


# --------------------------------------------------------------------------
# HTTP + MediaWiki API
# --------------------------------------------------------------------------

class PageRef:
    __slots__ = ("page_id", "title", "revision_id", "revision_timestamp", "is_redirect")

    def __init__(self, page_id, title, revision_id, revision_timestamp, is_redirect=False):
        self.page_id = page_id
        self.title = title
        self.revision_id = revision_id
        self.revision_timestamp = revision_timestamp
        self.is_redirect = is_redirect

    def __repr__(self) -> str:  # pragma: no cover
        return "PageRef(%s, %r, rev=%s)" % (self.page_id, self.title, self.revision_id)


class ApiClient:
    def __init__(self, config: Dict[str, Any], delay: Optional[float] = None) -> None:
        self.base_url = str(config["base_url"]).rstrip("/")
        # Where the wiki is fetched from and where it canonically lives can differ
        # (mirror, proxy, local mock). Provenance URLs must always be canonical,
        # so every source_url is built from public_base_url.
        self.public_base_url = str(config.get("public_base_url") or self.base_url).rstrip("/")
        self.api_url = str(config.get("api_url") or self.base_url + "/api.php")
        self.timeout = float(config.get("timeout_seconds", 30))
        self.max_retries = int(config.get("max_retries", 4))
        self.user_agent = str(config["user_agent"])
        self.delay = max(0.2, float(delay if delay is not None else config.get("request_delay_seconds", 1.0)))
        self._last_request = 0.0

    # -- transport ---------------------------------------------------------
    def _throttle(self) -> None:
        remaining = self.delay - (time.monotonic() - self._last_request)
        if remaining > 0:
            time.sleep(remaining)
        self._last_request = time.monotonic()

    def _get(self, url: str, params: Optional[Dict[str, Any]] = None) -> str:
        if params:
            url = url + "?" + urllib.parse.urlencode(params, doseq=True)
        last_error: Optional[Exception] = None
        for attempt in range(self.max_retries + 1):
            self._throttle()
            request = urllib.request.Request(
                url,
                headers={
                    "User-Agent": self.user_agent,
                    "Accept": "application/json,text/html;q=0.9,*/*;q=0.1",
                    "Accept-Language": "en-US,en;q=0.8",
                    "Accept-Encoding": "gzip",
                },
            )
            try:
                with urllib.request.urlopen(request, timeout=self.timeout) as response:
                    payload = response.read()
                    if response.headers.get("Content-Encoding") == "gzip":
                        payload = gzip.decompress(payload)
                    charset = response.headers.get_content_charset() or "utf-8"
                    return payload.decode(charset, errors="replace")
            except urllib.error.HTTPError as exc:
                last_error = exc
                if exc.code not in RETRY_STATUS or attempt >= self.max_retries:
                    raise CrawlError("HTTP %s for %s" % (exc.code, url)) from exc
            except (urllib.error.URLError, OSError) as exc:
                last_error = exc
                if attempt >= self.max_retries:
                    break
            backoff = min(2 ** attempt, 30) + attempt * 0.17
            LOG.warning("Request failed (%s); retrying in %.1fs", last_error, backoff)
            time.sleep(backoff)
        raise CrawlError("Request failed after %d retries: %s (%s)" % (self.max_retries, url, last_error))

    def get_json(self, params: Dict[str, Any]) -> Dict[str, Any]:
        payload = self._get(self.api_url, {"format": "json", "formatversion": 2, **params})
        try:
            data = json.loads(payload)
        except ValueError as exc:
            raise CrawlError("API returned non-JSON content for %r" % (params.get("action"),)) from exc
        if "error" in data:
            info = data["error"]
            raise CrawlError(
                "MediaWiki API error %s: %s" % (info.get("code", "?"), info.get("info", info))
            )
        return data

    # -- robots ------------------------------------------------------------
    def check_robots(self) -> Tuple[bool, str]:
        robots_url = self.base_url + "/robots.txt"
        try:
            text = self._get(robots_url)
        except CrawlError as exc:
            return True, "could not read robots.txt (%s)" % exc
        parser = urllib.robotparser.RobotFileParser()
        parser.set_url(robots_url)
        parser.parse(text.splitlines())
        allowed = parser.can_fetch(self.user_agent, self.api_url + "?action=query")
        return allowed, text

    # -- queries -----------------------------------------------------------
    def site_info(self) -> Dict[str, Any]:
        data = self.get_json(
            {"action": "query", "meta": "siteinfo", "siprop": "general|statistics|rightsinfo"}
        )
        return data.get("query", {})

    def all_pages(self, namespace: int = 0) -> Iterator[PageRef]:
        continuation: Dict[str, Any] = {}
        while True:
            data = self.get_json(
                {
                    "action": "query",
                    "generator": "allpages",
                    "gapnamespace": namespace,
                    "gaplimit": "max",
                    "prop": "info|revisions",
                    "rvprop": "ids|timestamp",
                    **continuation,
                }
            )
            for page in data.get("query", {}).get("pages", []):
                yield _page_ref(page)
            continuation = data.get("continue") or {}
            if not continuation:
                return

    def pages_by_titles(self, titles: List[str]) -> List[PageRef]:
        refs: List[PageRef] = []
        titles = [t for t in titles if t]
        for start in range(0, len(titles), 50):
            batch = titles[start:start + 50]
            data = self.get_json(
                {
                    "action": "query",
                    "titles": "|".join(batch),
                    "prop": "info|revisions",
                    "rvprop": "ids|timestamp",
                }
            )
            for page in data.get("query", {}).get("pages", []):
                if page.get("missing"):
                    LOG.warning("Missing page: %s", page.get("title"))
                    continue
                refs.append(_page_ref(page))
        return refs

    def category_pages(self, category: str, depth: int = 1) -> List[PageRef]:
        if not category.lower().startswith("category:"):
            category = "Category:" + category
        queue: List[Tuple[str, int]] = [(category, 0)]
        seen_categories = set()
        titles = set()
        while queue:
            current, level = queue.pop(0)
            if current in seen_categories:
                continue
            seen_categories.add(current)
            continuation: Dict[str, Any] = {}
            while True:
                data = self.get_json(
                    {
                        "action": "query",
                        "list": "categorymembers",
                        "cmtitle": current,
                        "cmtype": "page|subcat",
                        "cmlimit": "max",
                        **continuation,
                    }
                )
                for member in data.get("query", {}).get("categorymembers", []):
                    namespace = int(member.get("ns", -1))
                    title = str(member.get("title", ""))
                    if namespace == 0:
                        titles.add(title)
                    elif namespace == 14 and level < depth:
                        queue.append((title, level + 1))
                continuation = data.get("continue") or {}
                if not continuation:
                    break
        return self.pages_by_titles(sorted(titles))

    def parse_page(self, title: str, with_wikitext: bool = True) -> Dict[str, Any]:
        props = "text|sections|categories|links|externallinks|revid|displaytitle"
        if with_wikitext:
            props += "|wikitext"
        data = self.get_json(
            {
                "action": "parse",
                "page": title,
                "prop": props,
                "disableeditsection": 1,
                "disabletoc": 1,
                "disablelimitreport": 1,
            }
        )
        return data["parse"]

    def resolve_redirect(self, title: str) -> Dict[str, Any]:
        data = self.get_json(
            {
                "action": "query",
                "titles": title,
                "redirects": 1,
                "prop": "info|revisions",
                "rvprop": "ids|timestamp",
            }
        )
        query = data.get("query", {})
        pages = query.get("pages") or [{}]
        target = pages[0]
        redirects = query.get("redirects") or []
        return {
            "to": redirects[-1].get("to", target.get("title", title)) if redirects else target.get("title", title),
            "target_page_id": target.get("pageid"),
            "target_revision_id": ((target.get("revisions") or [{}])[0]).get("revid"),
        }


def _page_ref(page: Dict[str, Any]) -> PageRef:
    revision = (page.get("revisions") or [{}])[0]
    return PageRef(
        page_id=int(page["pageid"]),
        title=str(page.get("title", "")),
        revision_id=int(revision.get("revid") or page.get("lastrevid") or 0),
        revision_timestamp=str(revision.get("timestamp") or ""),
        is_redirect=bool(page.get("redirect")),
    )


# --------------------------------------------------------------------------
# Records, chunking, storage
# --------------------------------------------------------------------------

def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat()


def sha256(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


def safe_slug(title: str, limit: int = 90) -> str:
    value = unicodedata.normalize("NFKC", title)
    value = re.sub(r"[<>:\"/\\|?*\x00-\x1f]", "_", value)
    value = re.sub(r"\s+", "_", value).strip(" ._")
    return value[:limit].rstrip(" ._") or "untitled"


def page_url(base_url: str, title: str) -> str:
    return "%s/wiki/%s" % (
        base_url.rstrip("/"),
        urllib.parse.quote(title.replace(" ", "_"), safe="/:()',!*"),
    )


def atomic_write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(path.name + ".tmp")
    temporary.write_text(text, encoding="utf-8", newline="\n")
    os.replace(temporary, path)


def atomic_write_json(path: Path, data: Any) -> None:
    atomic_write_text(path, json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def extract_summary(plain_text: str, limit: int = 600) -> str:
    paragraphs = [part.strip() for part in plain_text.split("\n\n") if part.strip()]
    for paragraph in paragraphs:
        if len(paragraph) >= 60:
            return paragraph[:limit].rstrip()
    return plain_text[:limit].rstrip()


def assess_quality(markdown: str, sections: List[Any], tables: List[Any], attributes: Dict[str, Any]) -> str:
    # A page carrying a filled-in infobox is substantive even when its prose is
    # short: the structured fields are exactly what an AI looks up.
    if len(attributes) >= 3:
        return "high"
    if len(markdown) >= 1000 and (sections or tables):
        return "high"
    if len(markdown) >= 300:
        return "medium"
    return "low"


def split_long_block(text: str, limit: int) -> List[str]:
    if len(text) <= limit:
        return [text]
    sentences = re.split(r"(?<=[.!?])\s+", text)
    pieces: List[str] = []
    current = ""
    for sentence in sentences:
        if len(current) + len(sentence) + 1 <= limit:
            current = ("%s %s" % (current, sentence)).strip()
            continue
        if current:
            pieces.append(current)
        if len(sentence) <= limit:
            current = sentence
        else:
            for start in range(0, len(sentence), limit):
                pieces.append(sentence[start:start + limit])
            current = ""
    if current:
        pieces.append(current)
    return pieces


def build_chunks(record: Dict[str, Any], max_chars: int, overlap_chars: int) -> List[Dict[str, Any]]:
    source = record["source"]
    title = record["title"]
    markdown = record["content"]["markdown"]
    attributes_md = record.get("attributes_markdown", "")

    body = ""
    if attributes_md:
        body += attributes_md + "\n\n"
    body += markdown
    blocks = [block.strip() for block in re.split(r"\n{2,}", body) if block.strip()]

    chunks: List[Dict[str, Any]] = []
    parts: List[str] = []
    length = 0
    section_path: List[str] = []
    current_section = ""

    def flush() -> None:
        nonlocal parts, length
        text = "\n\n".join(parts).strip()
        if not text:
            return
        prefix = "# " + title
        if current_section:
            prefix += "\n\nSection: " + current_section
        full = (prefix + "\n\n" + text).strip()
        chunks.append(
            {
                "schema_version": SCHEMA_VERSION,
                "chunk_id": "%s:%s:%d" % (source["page_id"], source["revision_id"], len(chunks)),
                "page_id": source["page_id"],
                "revision_id": source["revision_id"],
                "title": title,
                "section_path": list(section_path),
                "source_url": source["url"],
                "license": source["license"],
                "categories": record.get("categories", []),
                "text": full,
                "char_count": len(full),
                "estimated_tokens": max(1, round(len(full) / 4)),
                "content_sha256": sha256(full),
            }
        )
        overlap = text[-overlap_chars:] if overlap_chars else ""
        parts = [overlap] if overlap else []
        length = len(overlap)

    for block in blocks:
        heading = re.match(r"^(#{1,6})\s+(.+)$", block)
        if heading:
            level = len(heading.group(1))
            name = heading.group(2).strip()
            # "#1" is the injected page title, so a "##" heading (level 2) is a
            # top-level section with no parent: depth = level - 2.
            depth = max(0, level - 2)
            section_path[:] = section_path[:depth]
            while len(section_path) < depth:
                section_path.append("")
            section_path.append(name)
            current_section = " > ".join(part for part in section_path if part)
        for piece in split_long_block(block, max_chars):
            if parts and length + len(piece) + 2 > max_chars:
                flush()
            parts.append(piece)
            length += len(piece) + 2
    flush()
    return chunks


def render_markdown_document(record: Dict[str, Any]) -> str:
    source = record["source"]
    fields = [
        ("title", record["title"]),
        ("source_url", source["url"]),
        ("page_id", source["page_id"]),
        ("revision_id", source["revision_id"]),
        ("revision_timestamp", source["revision_timestamp"]),
        ("retrieved_at", source["retrieved_at"]),
        ("license", source["license"]),
        ("license_url", source["license_url"]),
        ("record_type", record["record_type"]),
        ("categories", record.get("categories", [])),
    ]
    lines = ["---"]
    for key, value in fields:
        lines.append("%s: %s" % (key, json.dumps(value, ensure_ascii=False)))
    lines.extend(["---", ""])

    if record["record_type"] == "redirect":
        body = "# %s\n\nRedirects to [%s](%s)." % (
            record["title"],
            record["redirect"]["target_title"],
            record["redirect"]["target_url"],
        )
    else:
        body = record["content"]["markdown"]
        if record.get("attributes_markdown"):
            body = record["attributes_markdown"] + "\n\n" + body
        if not re.match(r"^#\s", body):
            body = "# %s\n\n%s" % (record["title"], body)
    attribution = "\n\n---\n\nSource: [%s](%s) · Revision %s · %s" % (
        record["title"],
        source["url"],
        source["revision_id"],
        source["license"],
    )
    return "\n".join(lines) + body.strip() + attribution + "\n"


class KnowledgeBaseWriter:
    def __init__(self, output_dir: Path) -> None:
        self.output_dir = Path(output_dir)
        self.records_dir = self.output_dir / "records"
        self.markdown_dir = self.output_dir / "markdown"
        self.chunks_dir = self.output_dir / "page_chunks"
        self.state_path = self.output_dir / "state.json"
        self.failures_path = self.output_dir / "failures.jsonl"
        for directory in (self.output_dir, self.records_dir, self.markdown_dir, self.chunks_dir):
            directory.mkdir(parents=True, exist_ok=True)
        self.state = self._load_state()

    def _load_state(self) -> Dict[str, Any]:
        if not self.state_path.exists():
            return {"schema_version": SCHEMA_VERSION, "tool_version": TOOL_VERSION, "pages": {}}
        try:
            return json.loads(self.state_path.read_text(encoding="utf-8"))
        except (OSError, ValueError) as exc:
            raise CrawlError("Cannot read state file %s: %s" % (self.state_path, exc)) from exc

    def should_skip(self, page: PageRef, force: bool) -> bool:
        if force:
            return False
        entry = self.state.get("pages", {}).get(str(page.page_id), {})
        return (
            entry.get("status") == "ok"
            and int(entry.get("revision_id") or 0) == page.revision_id
            and (self.records_dir / ("%d.json" % page.page_id)).exists()
        )

    def save_article(self, record: Dict[str, Any], chunks: List[Dict[str, Any]]) -> None:
        page_id = int(record["source"]["page_id"])
        slug = safe_slug(record["title"])
        record_name = "%d.json" % page_id
        markdown_name = "%d_%s.md" % (page_id, slug)
        chunks_name = "%d.jsonl" % page_id
        atomic_write_json(self.records_dir / record_name, record)
        atomic_write_text(self.markdown_dir / markdown_name, render_markdown_document(record))
        atomic_write_text(
            self.chunks_dir / chunks_name,
            "".join(json.dumps(chunk, ensure_ascii=False) + "\n" for chunk in chunks),
        )
        self.state.setdefault("pages", {})[str(page_id)] = {
            "title": record["title"],
            "revision_id": record["source"]["revision_id"],
            "revision_timestamp": record["source"]["revision_timestamp"],
            "status": "ok",
            "record_type": record["record_type"],
            "record": "records/" + record_name,
            "markdown": "markdown/" + markdown_name,
            "chunks": "page_chunks/" + chunks_name,
            "content_sha256": record["content"]["sha256"],
            "updated_at": utc_now(),
        }
        atomic_write_json(self.state_path, self.state)

    def save_failure(self, page: PageRef, error: Exception) -> None:
        with self.failures_path.open("a", encoding="utf-8", newline="\n") as handle:
            handle.write(
                json.dumps(
                    {
                        "page_id": page.page_id,
                        "title": page.title,
                        "revision_id": page.revision_id,
                        "error": str(error),
                        "failed_at": utc_now(),
                    },
                    ensure_ascii=False,
                )
                + "\n"
            )
        self.state.setdefault("pages", {})[str(page.page_id)] = {
            "title": page.title,
            "revision_id": page.revision_id,
            "status": "failed",
            "error": str(error),
            "updated_at": utc_now(),
        }
        atomic_write_json(self.state_path, self.state)

    def rebuild_aggregates(self, run_stats: Dict[str, Any], site_info: Dict[str, Any]) -> Dict[str, Any]:
        records: List[Dict[str, Any]] = []
        for path in sorted(self.records_dir.glob("*.json")):
            try:
                records.append(json.loads(path.read_text(encoding="utf-8")))
            except (OSError, ValueError) as exc:
                LOG.warning("Skipping unreadable record %s: %s", path, exc)
        records.sort(key=lambda item: str(item.get("title", "")).casefold())
        atomic_write_text(
            self.output_dir / "pages.jsonl",
            "".join(json.dumps(record, ensure_ascii=False) + "\n" for record in records),
        )

        chunk_count = 0
        with (self.output_dir / "chunks.jsonl").open("w", encoding="utf-8", newline="\n") as combined:
            for path in sorted(self.chunks_dir.glob("*.jsonl"), key=_numeric_stem):
                content = path.read_text(encoding="utf-8")
                combined.write(content)
                chunk_count += sum(1 for line in content.splitlines() if line.strip())

        attributes_rows = []
        for record in records:
            attributes = record.get("attributes") or {}
            if attributes:
                attributes_rows.append(
                    json.dumps(
                        {
                            "page_id": record["source"]["page_id"],
                            "title": record["title"],
                            "url": record["source"]["url"],
                            "attributes": attributes,
                        },
                        ensure_ascii=False,
                    )
                )
        atomic_write_text(
            self.output_dir / "attributes.jsonl",
            "".join(row + "\n" for row in attributes_rows),
        )

        quality: Dict[str, int] = {}
        articles = 0
        redirects = 0
        for record in records:
            kind = record.get("record_type")
            if kind == "article":
                articles += 1
                label = str(record.get("data_quality", "unknown"))
                quality[label] = quality.get(label, 0) + 1
            elif kind == "redirect":
                redirects += 1

        general = site_info.get("general", {})
        statistics = site_info.get("statistics", {})
        rights = site_info.get("rightsinfo", {})
        manifest = {
            "schema_version": SCHEMA_VERSION,
            "tool_version": TOOL_VERSION,
            "generated_at": utc_now(),
            "source": {
                "name": general.get("sitename"),
                "base_url": general.get("server"),
                "generator": general.get("generator"),
                "reported_articles": statistics.get("articles"),
                "reported_pages": statistics.get("pages"),
                "license": rights.get("text") or DEFAULT_LICENSE_NAME,
                "license_url": rights.get("url") or DEFAULT_LICENSE_URL,
            },
            "dataset": {
                "records": len(records),
                "articles": articles,
                "redirects": redirects,
                "with_attributes": len(attributes_rows),
                "chunks": chunk_count,
                "quality": quality,
            },
            "last_run": run_stats,
            "files": {
                "pages_jsonl": "pages.jsonl",
                "chunks_jsonl": "chunks.jsonl",
                "attributes_jsonl": "attributes.jsonl",
                "records_directory": "records/",
                "markdown_directory": "markdown/",
                "state": "state.json",
                "failures": "failures.jsonl",
            },
        }
        atomic_write_json(self.output_dir / "manifest.json", manifest)
        return manifest


def _numeric_stem(path: Path) -> int:
    try:
        return int(path.stem)
    except ValueError:
        return 0


# --------------------------------------------------------------------------
# Record assembly
# --------------------------------------------------------------------------

def build_article_record(
    page: PageRef,
    parsed: Dict[str, Any],
    transformed: Dict[str, Any],
    client: ApiClient,
    wikitext: str,
    infobox_prefixes: List[str],
    attributes: Optional[Dict[str, Any]] = None,
) -> Dict[str, Any]:
    markdown = transformed["markdown"]
    if attributes is None:
        attributes = extract_template_params(wikitext, infobox_prefixes) if wikitext else {}
    attributes = dict(attributes)
    template_name = attributes.pop("_template", None)
    attributes.pop("_unnamed_1", None)

    attributes_markdown = ""
    if attributes:
        lines = ["## Specifications", "", "| Field | Value |", "| --- | --- |"]
        for key, value in attributes.items():
            lines.append("| %s | %s |" % (str(key).replace("|", "\\|"), str(value).replace("|", "\\|")))
        attributes_markdown = "\n".join(lines)

    categories = sorted(
        {str(item.get("category", "")) for item in parsed.get("categories", []) if item.get("category")}
    )
    internal_links = sorted(
        {
            str(item.get("title", ""))
            for item in parsed.get("links", [])
            if int(item.get("ns", -1)) == 0 and item.get("title")
        },
        key=str.casefold,
    )
    external_links = sorted({str(item) for item in parsed.get("externallinks", []) if item})
    sections = [
        {
            "level": int(item.get("level") or 0),
            "title": clean_text(build_tree(str(item.get("line", ""))).text(" ")),
            "anchor": item.get("anchor"),
        }
        for item in parsed.get("sections", [])
    ]

    return {
        "schema_version": SCHEMA_VERSION,
        "record_type": "article",
        "title": page.title,
        "display_title": clean_text(build_tree(str(parsed.get("displaytitle") or page.title)).text(" ")),
        "summary": extract_summary(transformed["plain_text"]),
        "template": template_name,
        "attributes": attributes,
        "attributes_markdown": attributes_markdown,
        "categories": categories,
        "sections": sections,
        "internal_links": internal_links,
        "external_links": external_links,
        "images": transformed["images"],
        "tables": transformed["tables"],
        "content": {
            "markdown": markdown,
            "plain_text": transformed["plain_text"],
            "char_count": len(markdown),
            "word_count": len(re.findall(r"\b\w+\b", transformed["plain_text"])),
            "sha256": sha256(markdown),
        },
        "wikitext": wikitext,
        "data_quality": assess_quality(markdown, sections, transformed["tables"], attributes),
        "source": {
            "wiki": "Stormworks: Build and Rescue Wiki",
            "url": page_url(client.public_base_url, page.title),
            "api_url": client.api_url,
            "page_id": page.page_id,
            "revision_id": int(parsed.get("revid") or page.revision_id),
            "revision_timestamp": page.revision_timestamp,
            "retrieved_at": utc_now(),
            "license": DEFAULT_LICENSE_NAME,
            "license_url": DEFAULT_LICENSE_URL,
        },
    }


def build_redirect_record(page: PageRef, redirect: Dict[str, Any], client: ApiClient) -> Dict[str, Any]:
    target_title = str(redirect.get("to") or page.title)
    markdown = "Redirect: %s -> %s" % (page.title, target_title)
    return {
        "schema_version": SCHEMA_VERSION,
        "record_type": "redirect",
        "title": page.title,
        "display_title": page.title,
        "summary": "Alias for %s" % target_title,
        "template": None,
        "attributes": {},
        "attributes_markdown": "",
        "categories": [],
        "sections": [],
        "internal_links": [target_title],
        "external_links": [],
        "images": [],
        "tables": [],
        "content": {
            "markdown": markdown,
            "plain_text": markdown,
            "char_count": len(markdown),
            "word_count": len(markdown.split()),
            "sha256": sha256(markdown),
        },
        "wikitext": "",
        "data_quality": "alias",
        "redirect": {
            "target_title": target_title,
            "target_url": page_url(client.public_base_url, target_title),
            "target_page_id": redirect.get("target_page_id"),
            "target_revision_id": redirect.get("target_revision_id"),
        },
        "source": {
            "wiki": "Stormworks: Build and Rescue Wiki",
            "url": page_url(client.public_base_url, page.title),
            "api_url": client.api_url,
            "page_id": page.page_id,
            "revision_id": page.revision_id,
            "revision_timestamp": page.revision_timestamp,
            "retrieved_at": utc_now(),
            "license": DEFAULT_LICENSE_NAME,
            "license_url": DEFAULT_LICENSE_URL,
        },
    }


# --------------------------------------------------------------------------
# CLI
# --------------------------------------------------------------------------

def load_config(path: Path) -> Dict[str, Any]:
    try:
        data = json.loads(Path(path).read_text(encoding="utf-8"))
    except (OSError, ValueError) as exc:
        raise CrawlError("Cannot read config %s: %s" % (path, exc)) from exc
    missing = [key for key in ("base_url", "user_agent", "cleaning", "chunking") if key not in data]
    if missing:
        raise CrawlError("Config is missing required keys: %s" % ", ".join(missing))
    return data


def configure_logging(output_dir: Path, verbose: bool) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    formatter = logging.Formatter("%(asctime)s | %(levelname)s | %(message)s")
    root = logging.getLogger()
    root.setLevel(logging.DEBUG if verbose else logging.INFO)
    for handler in list(root.handlers):
        root.removeHandler(handler)
        try:
            handler.close()
        except Exception:  # noqa: BLE001 - never fail on logging teardown
            pass
    stream = logging.StreamHandler(sys.stderr)
    stream.setFormatter(formatter)
    root.addHandler(stream)
    file_handler = logging.FileHandler(output_dir / "crawl.log", encoding="utf-8")
    file_handler.setFormatter(formatter)
    root.addHandler(file_handler)


def parse_args(argv: Optional[List[str]] = None) -> argparse.Namespace:
    here = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(
        prog="wiki_crawl.py",
        description="Build an AI-ready Stormworks Fandom knowledge base (stdlib only).",
    )
    parser.add_argument("--config", type=Path, default=here.parent / "config.json")
    parser.add_argument("--output", type=Path, default=here.parent / "kb")
    parser.add_argument("--title", action="append", help="Exact page title; repeatable.")
    parser.add_argument("--category", help="Crawl pages under one category.")
    parser.add_argument("--category-depth", type=int, default=1)
    parser.add_argument("--namespace", type=int, default=0)
    parser.add_argument("--prefix", help="Only titles starting with this prefix.")
    parser.add_argument("--exclude-pattern", help="Regex of titles to exclude.")
    parser.add_argument("--max-pages", type=int, help="Limit pages (smoke test).")
    parser.add_argument("--force", action="store_true", help="Refetch unchanged revisions.")
    parser.add_argument("--dry-run", action="store_true", help="List pages without fetching content.")
    parser.add_argument("--no-wikitext", action="store_true", help="Skip wikitext/infobox extraction.")
    parser.add_argument("--delay", type=float, help="Override request delay in seconds.")
    parser.add_argument("--ignore-robots", action="store_true", help="Crawl even if robots.txt disallows.")
    parser.add_argument("--verbose", action="store_true")
    return parser.parse_args(argv)


def select_pages(client: ApiClient, args: argparse.Namespace) -> List[PageRef]:
    if args.title:
        pages = client.pages_by_titles(args.title)
    elif args.category:
        pages = client.category_pages(args.category, args.category_depth)
    else:
        pages = list(client.all_pages(namespace=args.namespace))
    if args.prefix:
        prefix = args.prefix.casefold()
        pages = [page for page in pages if page.title.casefold().startswith(prefix)]
    if args.exclude_pattern:
        pattern = re.compile(args.exclude_pattern, re.IGNORECASE)
        pages = [page for page in pages if not pattern.search(page.title)]
    pages.sort(key=lambda page: page.title.casefold())
    if args.max_pages is not None:
        pages = pages[: max(0, args.max_pages)]
    return pages


def run(argv: Optional[List[str]] = None) -> int:
    args = parse_args(argv)
    config = load_config(args.config)
    configure_logging(args.output, args.verbose)

    client = ApiClient(config, delay=args.delay)
    LOG.info("Stormworks Fandom knowledge crawler %s", TOOL_VERSION)

    allowed, _robots = client.check_robots()
    if allowed:
        LOG.info("robots.txt permits %s", client.api_url)
    else:
        LOG.warning("robots.txt DISALLOWS this crawler for %s", client.api_url)
        if not args.ignore_robots:
            print(
                "ERROR: robots.txt disallows this user-agent on %s.\n"
                "       Re-run with --ignore-robots only if you have permission." % client.api_url,
                file=sys.stderr,
            )
            return 2
        LOG.warning("--ignore-robots given, continuing anyway")

    site_info = client.site_info()
    general = site_info.get("general", {})
    LOG.info(
        "Site: %s (%s), %s articles reported",
        general.get("sitename"),
        general.get("generator"),
        site_info.get("statistics", {}).get("articles"),
    )

    pages = select_pages(client, args)
    LOG.info("Selected %d page(s)", len(pages))
    if args.dry_run:
        for page in pages:
            print("%d\t%d\t%s\tredirect=%s" % (page.page_id, page.revision_id, page.title, page.is_redirect))
        return 0

    writer = KnowledgeBaseWriter(args.output)
    chunk_config = config.get("chunking", {})
    max_chars = int(chunk_config.get("max_chars", 3200))
    overlap_chars = int(chunk_config.get("overlap_chars", 250))
    infobox_prefixes = config.get("infobox_templates", ["Infobox", "infobox"])
    cleaning = config.get("cleaning", {})

    stats = {
        "started_at": utc_now(),
        "selected": len(pages),
        "fetched": 0,
        "skipped_unchanged": 0,
        "failed": 0,
        "redirects": 0,
        "scope": {
            "titles": args.title,
            "category": args.category,
            "category_depth": args.category_depth if args.category else None,
            "namespace": args.namespace,
            "prefix": args.prefix,
            "exclude_pattern": args.exclude_pattern,
            "max_pages": args.max_pages,
            "force": args.force,
            "wikitext": not args.no_wikitext,
        },
    }

    for index, page in enumerate(pages, start=1):
        if writer.should_skip(page, args.force):
            stats["skipped_unchanged"] += 1
            LOG.info("[%d/%d] unchanged: %s", index, len(pages), page.title)
            continue
        LOG.info("[%d/%d] fetching: %s", index, len(pages), page.title)
        try:
            if page.is_redirect:
                redirect = client.resolve_redirect(page.title)
                record = build_redirect_record(page, redirect, client)
                chunks: List[Dict[str, Any]] = []
                stats["redirects"] += 1
            else:
                parsed = client.parse_page(page.title, with_wikitext=not args.no_wikitext)
                wikitext = str(parsed.get("wikitext") or "")
                attributes = extract_template_params(wikitext, infobox_prefixes) if wikitext else {}
                # The rendered infobox duplicates the wikitext parameters. When we
                # have the structured version, drop the HTML table so the chunk
                # text does not state every fact twice.
                extra_selectors = ["table.infobox"] if attributes else []
                transformed = html_to_markdown(
                    str(parsed.get("text") or ""), client.public_base_url, cleaning, extra_selectors
                )
                record = build_article_record(
                    page, parsed, transformed, client, wikitext, infobox_prefixes, attributes
                )
                chunks = build_chunks(record, max_chars, overlap_chars)
            writer.save_article(record, chunks)
            stats["fetched"] += 1
        except KeyboardInterrupt:
            raise
        except Exception as exc:  # noqa: BLE001 - one bad page must not stop the crawl
            stats["failed"] += 1
            writer.save_failure(page, exc)
            LOG.exception("Failed page %s", page.title)

    stats["finished_at"] = utc_now()
    manifest = writer.rebuild_aggregates(stats, site_info)
    dataset = manifest["dataset"]
    LOG.info(
        "Done: records=%d articles=%d redirects=%d attributes=%d chunks=%d "
        "fetched=%d skipped=%d failed=%d",
        dataset["records"],
        dataset["articles"],
        dataset["redirects"],
        dataset["with_attributes"],
        dataset["chunks"],
        stats["fetched"],
        stats["skipped_unchanged"],
        stats["failed"],
    )
    return 1 if stats["failed"] else 0


def main() -> int:
    try:
        return run()
    except KeyboardInterrupt:
        print("Interrupted; completed pages are saved and the crawl can be resumed.", file=sys.stderr)
        return 130
    except CrawlError as exc:
        print("ERROR: %s" % exc, file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
