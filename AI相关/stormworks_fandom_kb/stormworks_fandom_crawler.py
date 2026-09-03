#!/usr/bin/env python3
"""Build an AI-ready local knowledge base from the Stormworks Fandom wiki.

The crawler uses the public MediaWiki API instead of scraping Fandom's rendered
page shell. It preserves provenance, revision IDs, tables, links, images and
RAG-friendly chunks. Outputs are incremental and resumable.
"""

from __future__ import annotations

import argparse
import hashlib
import html
import json
import logging
import os
import re
import sys
import time
import unicodedata
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Iterable, Iterator
from urllib.parse import quote, urljoin
from urllib.robotparser import RobotFileParser

import requests
from bs4 import BeautifulSoup, Comment, Tag
from markdownify import markdownify as html_to_markdown

SCHEMA_VERSION = "1.0"
TOOL_VERSION = "1.0.0"
LICENSE_NAME = "CC BY-NC-SA"
LICENSE_URL = "https://www.fandom.com/licensing"
RETRY_STATUS = {429, 500, 502, 503, 504}


class CrawlError(RuntimeError):
    """A recoverable or terminal crawl error."""


@dataclass(frozen=True)
class PageRef:
    page_id: int
    title: str
    revision_id: int
    revision_timestamp: str
    is_redirect: bool = False


class RateLimiter:
    def __init__(self, delay_seconds: float) -> None:
        self.delay_seconds = max(0.5, delay_seconds)
        self._last_request = 0.0

    def wait(self) -> None:
        elapsed = time.monotonic() - self._last_request
        remaining = self.delay_seconds - elapsed
        if remaining > 0:
            time.sleep(remaining)

    def mark(self) -> None:
        self._last_request = time.monotonic()


class MediaWikiClient:
    def __init__(self, config: dict[str, Any]) -> None:
        self.base_url = config["base_url"].rstrip("/")
        self.api_url = config.get("api_url") or f"{self.base_url}/api.php"
        self.timeout = float(config.get("timeout_seconds", 30))
        self.max_retries = int(config.get("max_retries", 4))
        self.user_agent = str(config["user_agent"])
        self.limiter = RateLimiter(float(config.get("request_delay_seconds", 1.0)))
        self.session = requests.Session()
        self.session.headers.update(
            {
                "User-Agent": self.user_agent,
                "Accept": "application/json,text/plain;q=0.9,*/*;q=0.1",
                "Accept-Language": "en-US,en;q=0.8",
            }
        )

    def request_text(self, url: str) -> str:
        response = self._request(url, params=None)
        return response.text

    def request_json(self, params: dict[str, Any]) -> dict[str, Any]:
        full_params = {"format": "json", "formatversion": 2, **params}
        response = self._request(self.api_url, params=full_params)
        try:
            payload = response.json()
        except ValueError as exc:
            raise CrawlError(f"API returned non-JSON content: {exc}") from exc
        if "error" in payload:
            error = payload["error"]
            raise CrawlError(
                f"MediaWiki API error {error.get('code', 'unknown')}: "
                f"{error.get('info', error)}"
            )
        return payload

    def _request(
        self, url: str, params: dict[str, Any] | None
    ) -> requests.Response:
        last_error: Exception | None = None
        for attempt in range(self.max_retries + 1):
            self.limiter.wait()
            try:
                response = self.session.get(
                    url,
                    params=params,
                    timeout=self.timeout,
                    allow_redirects=True,
                )
                self.limiter.mark()
                if response.status_code not in RETRY_STATUS:
                    response.raise_for_status()
                    return response
                retry_after = response.headers.get("Retry-After")
                if retry_after and retry_after.isdigit():
                    backoff = min(float(retry_after), 60.0)
                else:
                    backoff = min(2**attempt, 30) + (attempt * 0.17)
                logging.warning(
                    "HTTP %s from %s; retrying in %.1fs",
                    response.status_code,
                    response.url,
                    backoff,
                )
                time.sleep(backoff)
            except requests.RequestException as exc:
                self.limiter.mark()
                last_error = exc
                if attempt >= self.max_retries:
                    break
                backoff = min(2**attempt, 30) + (attempt * 0.17)
                logging.warning("Request failed: %s; retrying in %.1fs", exc, backoff)
                time.sleep(backoff)
        raise CrawlError(f"Request failed after retries: {last_error or url}")

    def verify_robots(self) -> None:
        """Check robots.txt, but never let an unreadable robots.txt abort the run.

        Fandom serves /robots.txt with 403 to non-browser user agents even though
        the file itself grants `Allow: /api.php?` to `User-agent: *`. Since this
        crawler only ever calls the MediaWiki API, a failed robots.txt lookup is
        treated as "unknown" rather than "disallowed": we log a warning and keep
        the configured conservative rate limit. A robots.txt that IS readable and
        explicitly disallows the API still stops the crawl.
        """
        robots_url = f"{self.base_url}/robots.txt"
        parser = RobotFileParser()
        parser.set_url(robots_url)
        try:
            # Single attempt, no retry loop: an unreadable robots.txt must not
            # cost four backoffs before we settle for the conservative default.
            self.limiter.wait()
            response = self.session.get(
                robots_url, timeout=min(self.timeout, 10.0), allow_redirects=True
            )
            self.limiter.mark()
            response.raise_for_status()
            parser.parse(response.text.splitlines())
        except Exception as exc:  # noqa: BLE001 - never fatal, see docstring
            logging.warning(
                "robots.txt unreadable (%s); continuing with the configured "
                "%.1fs request delay because this crawler only calls %s",
                exc,
                self.limiter.delay_seconds,
                self.api_url,
            )
            return
        probe_url = f"{self.api_url}?action=query"
        if not parser.can_fetch(self.user_agent, probe_url):
            raise CrawlError(
                f"robots.txt does not allow this crawler to access {probe_url}"
            )
        logging.info("robots.txt permits MediaWiki API access")

    def site_info(self) -> dict[str, Any]:
        payload = self.request_json(
            {
                "action": "query",
                "meta": "siteinfo",
                "siprop": "general|statistics|rightsinfo",
            }
        )
        return payload.get("query", {})

    def all_pages(self, namespace: int = 0) -> Iterator[PageRef]:
        continuation: dict[str, Any] = {}
        while True:
            payload = self.request_json(
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
            for page in payload.get("query", {}).get("pages", []):
                revision = (page.get("revisions") or [{}])[0]
                yield PageRef(
                    page_id=int(page["pageid"]),
                    title=str(page["title"]),
                    revision_id=int(revision.get("revid") or page.get("lastrevid") or 0),
                    revision_timestamp=str(revision.get("timestamp") or ""),
                    is_redirect=bool(page.get("redirect")),
                )
            continuation = payload.get("continue") or {}
            if not continuation:
                return

    def category_pages(self, category: str, depth: int = 1) -> list[PageRef]:
        category = category if category.startswith("Category:") else f"Category:{category}"
        pending: list[tuple[str, int]] = [(category, 0)]
        visited_categories: set[str] = set()
        titles: set[str] = set()
        while pending:
            current, level = pending.pop(0)
            if current in visited_categories:
                continue
            visited_categories.add(current)
            continuation: dict[str, Any] = {}
            while True:
                payload = self.request_json(
                    {
                        "action": "query",
                        "list": "categorymembers",
                        "cmtitle": current,
                        "cmtype": "page|subcat",
                        "cmlimit": "max",
                        **continuation,
                    }
                )
                for member in payload.get("query", {}).get("categorymembers", []):
                    ns = int(member.get("ns", -1))
                    title = str(member.get("title", ""))
                    if ns == 0:
                        titles.add(title)
                    elif ns == 14 and level < depth:
                        pending.append((title, level + 1))
                continuation = payload.get("continue") or {}
                if not continuation:
                    break
        return self.pages_by_titles(sorted(titles))

    def pages_by_titles(self, titles: list[str]) -> list[PageRef]:
        refs: list[PageRef] = []
        for batch in batched(titles, 50):
            payload = self.request_json(
                {
                    "action": "query",
                    "titles": "|".join(batch),
                    "prop": "info|revisions",
                    "rvprop": "ids|timestamp",
                }
            )
            for page in payload.get("query", {}).get("pages", []):
                if page.get("missing"):
                    logging.warning("Missing page: %s", page.get("title"))
                    continue
                revision = (page.get("revisions") or [{}])[0]
                refs.append(
                    PageRef(
                        page_id=int(page["pageid"]),
                        title=str(page["title"]),
                        revision_id=int(revision.get("revid") or page.get("lastrevid") or 0),
                        revision_timestamp=str(revision.get("timestamp") or ""),
                        is_redirect=bool(page.get("redirect")),
                    )
                )
        return refs

    def parse_page(self, title: str) -> dict[str, Any]:
        payload = self.request_json(
            {
                "action": "parse",
                "page": title,
                "prop": (
                    "text|sections|categories|links|externallinks|revid|displaytitle"
                ),
                "disableeditsection": 1,
                "disabletoc": 1,
            }
        )
        return payload["parse"]

    def resolve_redirect(self, title: str) -> dict[str, Any]:
        payload = self.request_json(
            {
                "action": "query",
                "titles": title,
                "redirects": 1,
                "prop": "info|revisions",
                "rvprop": "ids|timestamp",
            }
        )
        query = payload.get("query", {})
        target = (query.get("pages") or [{}])[0]
        redirects = query.get("redirects") or []
        return {
            "from": title,
            "to": redirects[-1].get("to", target.get("title", title)) if redirects else target.get("title", title),
            "target_page_id": target.get("pageid"),
            "target_revision_id": ((target.get("revisions") or [{}])[0]).get("revid"),
        }


def batched(items: Iterable[str], size: int) -> Iterator[list[str]]:
    batch: list[str] = []
    for item in items:
        batch.append(item)
        if len(batch) >= size:
            yield batch
            batch = []
    if batch:
        yield batch


def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat()


def atomic_write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_suffix(path.suffix + ".tmp")
    temporary.write_text(text, encoding="utf-8", newline="\n")
    os.replace(temporary, path)


def atomic_write_json(path: Path, data: Any) -> None:
    atomic_write_text(path, json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def safe_slug(title: str, max_length: int = 90) -> str:
    value = unicodedata.normalize("NFKC", title)
    value = re.sub(r"[<>:\"/\\|?*\x00-\x1f]", "_", value)
    value = re.sub(r"\s+", "_", value).strip(" ._")
    return (value[:max_length].rstrip(" ._") or "untitled")


def page_url(base_url: str, title: str) -> str:
    return f"{base_url.rstrip('/')}/wiki/{quote(title.replace(' ', '_'), safe='/:')}"


def normalize_text(text: str) -> str:
    text = unicodedata.normalize("NFKC", html.unescape(text))
    text = text.replace("\u00a0", " ")
    text = re.sub(r"[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]", "", text)
    text = re.sub(r"[ \t]+\n", "\n", text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()


def absolutize_links(soup: BeautifulSoup, base_url: str) -> None:
    for tag in soup.find_all(["a", "img", "source"]):
        for attribute in ("href", "src"):
            value = tag.get(attribute)
            if value:
                tag[attribute] = urljoin(base_url + "/", value)


def remove_boilerplate(soup: BeautifulSoup, config: dict[str, Any]) -> None:
    for comment in soup.find_all(string=lambda value: isinstance(value, Comment)):
        comment.extract()
    for selector in config.get("remove_selectors", []):
        try:
            for node in soup.select(selector):
                node.decompose()
        except Exception as exc:
            logging.warning("Invalid selector %r: %s", selector, exc)
    for link in list(soup.select("a[href*='action=edit']")):
        container = link.find_parent(["span", "div"])
        if container and len(normalize_text(container.get_text(" ", strip=True))) <= 120:
            container.decompose()
        elif link.parent:
            link.decompose()
    patterns = [re.compile(value, re.IGNORECASE) for value in config.get("remove_text_patterns", [])]
    for pattern in patterns:
        for node in list(soup.find_all(string=pattern)):
            parent = node.find_parent(["table", "aside", "div", "p"])
            if parent:
                parent.decompose()
    for node in list(soup.find_all(["div", "span", "p"])):
        if isinstance(node, Tag) and not node.get_text(strip=True) and not node.find("img"):
            node.decompose()


def extract_images(soup: BeautifulSoup) -> list[dict[str, Any]]:
    images: list[dict[str, Any]] = []
    seen: set[str] = set()
    for image in soup.find_all("img"):
        source = str(image.get("src") or "")
        parent_link = image.find_parent("a")
        original = str(parent_link.get("href") or "") if parent_link else ""
        url = original or source
        if not url or url in seen:
            continue
        seen.add(url)
        images.append(
            {
                "url": url,
                "thumbnail_url": source or None,
                "alt": normalize_text(str(image.get("alt") or "")),
                "width": image.get("width"),
                "height": image.get("height"),
            }
        )
    return images


def extract_tables(soup: BeautifulSoup) -> list[dict[str, Any]]:
    tables: list[dict[str, Any]] = []
    for index, table in enumerate(soup.find_all("table"), start=1):
        rows: list[list[str]] = []
        for row in table.find_all("tr"):
            cells = [normalize_text(cell.get_text(" ", strip=True)) for cell in row.find_all(["th", "td"])]
            if cells and any(cells):
                rows.append(cells)
        if not rows:
            continue
        caption = table.find("caption")
        classes = [str(value) for value in table.get("class", [])]
        tables.append(
            {
                "index": index,
                "caption": normalize_text(caption.get_text(" ", strip=True)) if caption else None,
                "classes": classes,
                "rows": rows,
            }
        )
    return tables


def clean_markdown(markdown: str) -> str:
    markdown = normalize_text(markdown)
    markdown = re.sub(r"\[\s*edit\s*(?:page|source)?\s*\]", "", markdown, flags=re.IGNORECASE)
    markdown = re.sub(r"[ \t]+", " ", markdown)
    markdown = re.sub(r"\n[ \t]+", "\n", markdown)
    markdown = re.sub(r"\n{3,}", "\n\n", markdown)
    markdown = re.sub(r"^(?:Contents|Add Comment)\s*$", "", markdown, flags=re.IGNORECASE | re.MULTILINE)
    return markdown.strip()


def transform_html(
    raw_html: str,
    base_url: str,
    cleaning_config: dict[str, Any],
) -> dict[str, Any]:
    soup = BeautifulSoup(raw_html, "lxml")
    remove_boilerplate(soup, cleaning_config)
    absolutize_links(soup, base_url)
    images = extract_images(soup)
    tables = extract_tables(soup)
    markdown = html_to_markdown(
        str(soup),
        heading_style="ATX",
        bullets="-",
        strip=["script", "style", "iframe", "noscript"],
    )
    markdown = clean_markdown(markdown)
    plain_text = normalize_text(soup.get_text("\n", strip=True))
    return {
        "markdown": markdown,
        "plain_text": plain_text,
        "images": images,
        "tables": tables,
    }


def extract_summary(plain_text: str, max_chars: int = 600) -> str:
    paragraphs = [part.strip() for part in plain_text.split("\n\n") if part.strip()]
    for paragraph in paragraphs:
        if len(paragraph) >= 80:
            return paragraph[:max_chars].rstrip()
    return (plain_text[:max_chars].rstrip() if plain_text else "")


def assess_quality(markdown: str, sections: list[Any], tables: list[Any]) -> str:
    length = len(markdown)
    if length >= 1000 and (sections or tables):
        return "high"
    if length >= 300:
        return "medium"
    return "low"


def split_long_block(text: str, max_chars: int) -> list[str]:
    if len(text) <= max_chars:
        return [text]
    sentences = re.split(r"(?<=[.!?])\s+", text)
    pieces: list[str] = []
    current = ""
    for sentence in sentences:
        if len(current) + len(sentence) + 1 <= max_chars:
            current = f"{current} {sentence}".strip()
        else:
            if current:
                pieces.append(current)
            if len(sentence) <= max_chars:
                current = sentence
            else:
                for start in range(0, len(sentence), max_chars):
                    pieces.append(sentence[start : start + max_chars])
                current = ""
    if current:
        pieces.append(current)
    return pieces


def build_chunks(
    record: dict[str, Any], max_chars: int, overlap_chars: int
) -> list[dict[str, Any]]:
    markdown = record.get("content", {}).get("markdown", "")
    title = record["title"]
    blocks = [block.strip() for block in re.split(r"\n{2,}", markdown) if block.strip()]
    chunks: list[dict[str, Any]] = []
    current_parts: list[str] = []
    current_length = 0
    section_path: list[str] = []
    current_section = ""

    def flush() -> None:
        nonlocal current_parts, current_length
        body = "\n\n".join(current_parts).strip()
        if not body:
            return
        prefix = f"# {title}"
        if current_section:
            prefix += f"\n\nSection: {current_section}"
        text = f"{prefix}\n\n{body}".strip()
        index = len(chunks)
        chunks.append(
            {
                "schema_version": SCHEMA_VERSION,
                "chunk_id": f"{record['source']['page_id']}:{record['source']['revision_id']}:{index}",
                "page_id": record["source"]["page_id"],
                "revision_id": record["source"]["revision_id"],
                "title": title,
                "section_path": list(section_path),
                "source_url": record["source"]["url"],
                "license": record["source"]["license"],
                "categories": record.get("categories", []),
                "text": text,
                "char_count": len(text),
                "estimated_tokens": max(1, round(len(text) / 4)),
                "content_sha256": hashlib.sha256(text.encode("utf-8")).hexdigest(),
            }
        )
        overlap = body[-overlap_chars:] if overlap_chars else ""
        current_parts = [overlap] if overlap else []
        current_length = len(overlap)

    for block in blocks:
        heading = re.match(r"^(#{1,6})\s+(.+)$", block)
        if heading:
            level = len(heading.group(1))
            name = heading.group(2).strip()
            section_path[:] = section_path[: level - 1]
            while len(section_path) < level - 1:
                section_path.append("")
            section_path.append(name)
            current_section = " > ".join(part for part in section_path if part)
        for piece in split_long_block(block, max_chars):
            if current_parts and current_length + len(piece) + 2 > max_chars:
                flush()
            current_parts.append(piece)
            current_length += len(piece) + 2
    flush()
    return chunks


class KnowledgeBaseWriter:
    def __init__(self, output_dir: Path) -> None:
        self.output_dir = output_dir
        self.records_dir = output_dir / "records"
        self.markdown_dir = output_dir / "markdown"
        self.page_chunks_dir = output_dir / "page_chunks"
        self.state_path = output_dir / "state.json"
        self.failures_path = output_dir / "failures.jsonl"
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.records_dir.mkdir(parents=True, exist_ok=True)
        self.markdown_dir.mkdir(parents=True, exist_ok=True)
        self.page_chunks_dir.mkdir(parents=True, exist_ok=True)
        self.state = self._load_state()

    def _load_state(self) -> dict[str, Any]:
        if not self.state_path.exists():
            return {"schema_version": SCHEMA_VERSION, "pages": {}}
        try:
            return json.loads(self.state_path.read_text(encoding="utf-8"))
        except (OSError, ValueError) as exc:
            raise CrawlError(f"Cannot read state file {self.state_path}: {exc}") from exc

    def should_skip(self, page: PageRef, force: bool) -> bool:
        if force:
            return False
        state = self.state.get("pages", {}).get(str(page.page_id), {})
        record_path = self.records_dir / f"{page.page_id}.json"
        return (
            state.get("status") == "ok"
            and int(state.get("revision_id") or 0) == page.revision_id
            and record_path.exists()
        )

    def save_article(self, record: dict[str, Any], chunks: list[dict[str, Any]]) -> None:
        page_id = int(record["source"]["page_id"])
        slug = safe_slug(record["title"])
        record_name = f"{page_id}.json"
        markdown_name = f"{page_id}_{slug}.md"
        chunks_name = f"{page_id}.jsonl"
        atomic_write_json(self.records_dir / record_name, record)
        atomic_write_text(
            self.markdown_dir / markdown_name,
            render_markdown_document(record),
        )
        atomic_write_text(
            self.page_chunks_dir / chunks_name,
            "".join(json.dumps(chunk, ensure_ascii=False) + "\n" for chunk in chunks),
        )
        self.state.setdefault("pages", {})[str(page_id)] = {
            "title": record["title"],
            "revision_id": record["source"]["revision_id"],
            "revision_timestamp": record["source"]["revision_timestamp"],
            "status": "ok",
            "record": f"records/{record_name}",
            "markdown": f"markdown/{markdown_name}",
            "chunks": f"page_chunks/{chunks_name}",
            "content_sha256": record["content"]["sha256"],
            "updated_at": utc_now(),
        }
        atomic_write_json(self.state_path, self.state)

    def save_failure(self, page: PageRef, error: Exception) -> None:
        failure = {
            "page_id": page.page_id,
            "title": page.title,
            "revision_id": page.revision_id,
            "error": str(error),
            "failed_at": utc_now(),
        }
        with self.failures_path.open("a", encoding="utf-8", newline="\n") as handle:
            handle.write(json.dumps(failure, ensure_ascii=False) + "\n")
        self.state.setdefault("pages", {})[str(page.page_id)] = {
            "title": page.title,
            "revision_id": page.revision_id,
            "status": "failed",
            "error": str(error),
            "updated_at": utc_now(),
        }
        atomic_write_json(self.state_path, self.state)

    def rebuild_aggregates(self, run_stats: dict[str, Any], site_info: dict[str, Any]) -> dict[str, Any]:
        records: list[dict[str, Any]] = []
        for path in self.records_dir.glob("*.json"):
            try:
                records.append(json.loads(path.read_text(encoding="utf-8")))
            except (OSError, ValueError) as exc:
                logging.warning("Skipping unreadable record %s: %s", path, exc)
        records.sort(key=lambda item: str(item.get("title", "")).casefold())
        atomic_write_text(
            self.output_dir / "pages.jsonl",
            "".join(json.dumps(record, ensure_ascii=False) + "\n" for record in records),
        )
        chunk_paths = sorted(
            self.page_chunks_dir.glob("*.jsonl"),
            key=lambda path: int(path.stem) if path.stem.isdigit() else 0,
        )
        all_chunks: list[str] = []
        chunk_count = 0
        for path in chunk_paths:
            content = path.read_text(encoding="utf-8")
            all_chunks.append(content)
            chunk_count += sum(1 for line in content.splitlines() if line.strip())
        atomic_write_text(self.output_dir / "chunks.jsonl", "".join(all_chunks))
        quality_counts: dict[str, int] = {}
        article_count = 0
        redirect_count = 0
        for record in records:
            record_type = record.get("record_type")
            if record_type == "article":
                article_count += 1
                quality = record.get("data_quality", "unknown")
                quality_counts[quality] = quality_counts.get(quality, 0) + 1
            elif record_type == "redirect":
                redirect_count += 1
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
                "license": rights.get("text") or LICENSE_NAME,
                "license_url": rights.get("url") or LICENSE_URL,
            },
            "dataset": {
                "records": len(records),
                "articles": article_count,
                "redirects": redirect_count,
                "chunks": chunk_count,
                "quality": quality_counts,
            },
            "last_run": run_stats,
            "files": {
                "pages_jsonl": "pages.jsonl",
                "chunks_jsonl": "chunks.jsonl",
                "records_directory": "records/",
                "markdown_directory": "markdown/",
                "state": "state.json",
                "failures": "failures.jsonl",
            },
        }
        atomic_write_json(self.output_dir / "manifest.json", manifest)
        return manifest


def render_markdown_document(record: dict[str, Any]) -> str:
    source = record["source"]
    metadata = {
        "title": record["title"],
        "source_url": source["url"],
        "page_id": source["page_id"],
        "revision_id": source["revision_id"],
        "revision_timestamp": source["revision_timestamp"],
        "retrieved_at": source["retrieved_at"],
        "license": source["license"],
        "license_url": source["license_url"],
        "record_type": record["record_type"],
    }
    front_matter = ["---"]
    for key, value in metadata.items():
        front_matter.append(f"{key}: {json.dumps(value, ensure_ascii=False)}")
    front_matter.extend(["---", ""])
    if record["record_type"] == "redirect":
        body = f"# {record['title']}\n\nRedirects to [{record['redirect']['target_title']}]({record['redirect']['target_url']})."
    else:
        body = record["content"]["markdown"]
        if not re.match(r"^#\s", body):
            body = f"# {record['title']}\n\n{body}"
    attribution = (
        "\n\n---\n\n"
        f"Source: [{record['title']}]({source['url']}) · "
        f"Revision {source['revision_id']} · {source['license']}"
    )
    return "\n".join(front_matter) + body.strip() + attribution + "\n"


def build_article_record(
    page: PageRef,
    parsed: dict[str, Any],
    transformed: dict[str, Any],
    client: MediaWikiClient,
) -> dict[str, Any]:
    markdown = transformed["markdown"]
    categories = sorted(
        {
            str(item.get("category", ""))
            for item in parsed.get("categories", [])
            if item.get("category")
        }
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
            "title": normalize_text(
                BeautifulSoup(str(item.get("line", "")), "lxml").get_text(" ", strip=True)
            ),
            "anchor": item.get("anchor"),
        }
        for item in parsed.get("sections", [])
    ]
    retrieved_at = utc_now()
    content_hash = hashlib.sha256(markdown.encode("utf-8")).hexdigest()
    return {
        "schema_version": SCHEMA_VERSION,
        "record_type": "article",
        "title": page.title,
        "display_title": normalize_text(
            BeautifulSoup(str(parsed.get("displaytitle") or page.title), "lxml").get_text(" ", strip=True)
        ),
        "summary": extract_summary(transformed["plain_text"]),
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
            "sha256": content_hash,
        },
        "data_quality": assess_quality(markdown, sections, transformed["tables"]),
        "source": {
            "wiki": "Stormworks: Build and Rescue Wiki",
            "url": page_url(client.base_url, page.title),
            "api_url": client.api_url,
            "page_id": page.page_id,
            "revision_id": int(parsed.get("revid") or page.revision_id),
            "revision_timestamp": page.revision_timestamp,
            "retrieved_at": retrieved_at,
            "license": LICENSE_NAME,
            "license_url": LICENSE_URL,
        },
    }


def build_redirect_record(
    page: PageRef, redirect: dict[str, Any], client: MediaWikiClient
) -> dict[str, Any]:
    target_title = str(redirect.get("to") or page.title)
    markdown = f"Redirect: {page.title} -> {target_title}"
    return {
        "schema_version": SCHEMA_VERSION,
        "record_type": "redirect",
        "title": page.title,
        "display_title": page.title,
        "summary": f"Alias for {target_title}",
        "categories": [],
        "sections": [],
        "internal_links": [target_title],
        "external_links": [],
        "images": [],
        "tables": [],
        "redirect": {
            "target_title": target_title,
            "target_url": page_url(client.base_url, target_title),
            "target_page_id": redirect.get("target_page_id"),
            "target_revision_id": redirect.get("target_revision_id"),
        },
        "content": {
            "markdown": markdown,
            "plain_text": markdown,
            "char_count": len(markdown),
            "word_count": len(markdown.split()),
            "sha256": hashlib.sha256(markdown.encode("utf-8")).hexdigest(),
        },
        "data_quality": "alias",
        "source": {
            "wiki": "Stormworks: Build and Rescue Wiki",
            "url": page_url(client.base_url, page.title),
            "api_url": client.api_url,
            "page_id": page.page_id,
            "revision_id": page.revision_id,
            "revision_timestamp": page.revision_timestamp,
            "retrieved_at": utc_now(),
            "license": LICENSE_NAME,
            "license_url": LICENSE_URL,
        },
    }


def load_config(path: Path) -> dict[str, Any]:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError) as exc:
        raise CrawlError(f"Cannot read config {path}: {exc}") from exc
    required = ["base_url", "user_agent", "cleaning", "chunking"]
    missing = [key for key in required if key not in data]
    if missing:
        raise CrawlError(f"Config is missing required keys: {', '.join(missing)}")
    return data


def select_pages(client: MediaWikiClient, args: argparse.Namespace) -> list[PageRef]:
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


def configure_logging(output_dir: Path, verbose: bool) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    level = logging.DEBUG if verbose else logging.INFO
    formatter = logging.Formatter("%(asctime)s | %(levelname)s | %(message)s")
    root = logging.getLogger()
    root.setLevel(level)
    root.handlers.clear()
    stream = logging.StreamHandler()
    stream.setFormatter(formatter)
    root.addHandler(stream)
    file_handler = logging.FileHandler(output_dir / "crawl.log", encoding="utf-8")
    file_handler.setFormatter(formatter)
    root.addHandler(file_handler)


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(
        description="Build an AI-ready Stormworks Fandom knowledge base via MediaWiki API."
    )
    parser.add_argument("--config", type=Path, default=script_dir / "config.json")
    parser.add_argument("--output", type=Path, default=script_dir / "output")
    parser.add_argument("--title", action="append", help="Crawl one exact page title; repeatable.")
    parser.add_argument("--category", help="Crawl pages in one category.")
    parser.add_argument("--category-depth", type=int, default=1)
    parser.add_argument("--namespace", type=int, default=0)
    parser.add_argument("--prefix", help="Only titles beginning with this prefix.")
    parser.add_argument("--exclude-pattern", help="Regex of titles to exclude.")
    parser.add_argument("--max-pages", type=int, help="Limit selected pages for a smoke test.")
    parser.add_argument("--force", action="store_true", help="Refetch unchanged revisions.")
    parser.add_argument("--dry-run", action="store_true", help="List selected pages without fetching content.")
    parser.add_argument("--verbose", action="store_true")
    return parser.parse_args(argv)


def run(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    config = load_config(args.config)
    configure_logging(args.output, args.verbose)
    client = MediaWikiClient(config)
    writer = KnowledgeBaseWriter(args.output)
    logging.info("Stormworks Fandom knowledge crawler %s", TOOL_VERSION)
    client.verify_robots()
    site_info = client.site_info()
    pages = select_pages(client, args)
    logging.info("Selected %d page(s)", len(pages))
    if args.dry_run:
        for page in pages:
            print(f"{page.page_id}\t{page.revision_id}\t{page.title}\tredirect={page.is_redirect}")
        return 0

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
        },
    }
    chunk_config = config["chunking"]
    for index, page in enumerate(pages, start=1):
        if writer.should_skip(page, args.force):
            stats["skipped_unchanged"] += 1
            logging.info("[%d/%d] unchanged: %s", index, len(pages), page.title)
            continue
        logging.info("[%d/%d] fetching: %s", index, len(pages), page.title)
        try:
            if page.is_redirect:
                redirect = client.resolve_redirect(page.title)
                record = build_redirect_record(page, redirect, client)
                chunks: list[dict[str, Any]] = []
                stats["redirects"] += 1
            else:
                parsed = client.parse_page(page.title)
                transformed = transform_html(
                    str(parsed.get("text") or ""),
                    client.base_url,
                    config["cleaning"],
                )
                record = build_article_record(page, parsed, transformed, client)
                chunks = build_chunks(
                    record,
                    int(chunk_config.get("max_chars", 3200)),
                    int(chunk_config.get("overlap_chars", 250)),
                )
            writer.save_article(record, chunks)
            stats["fetched"] += 1
        except Exception as exc:
            stats["failed"] += 1
            writer.save_failure(page, exc)
            logging.exception("Failed page %s", page.title)
    stats["finished_at"] = utc_now()
    manifest = writer.rebuild_aggregates(stats, site_info)
    dataset = manifest["dataset"]
    logging.info(
        "Done: records=%d articles=%d redirects=%d chunks=%d fetched=%d skipped=%d failed=%d",
        dataset["records"],
        dataset["articles"],
        dataset["redirects"],
        dataset["chunks"],
        stats["fetched"],
        stats["skipped_unchanged"],
        stats["failed"],
    )
    return 1 if stats["failed"] else 0


if __name__ == "__main__":
    try:
        raise SystemExit(run())
    except KeyboardInterrupt:
        print("Interrupted; completed pages remain saved and can be resumed.", file=sys.stderr)
        raise SystemExit(130)
    except CrawlError as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(2)
