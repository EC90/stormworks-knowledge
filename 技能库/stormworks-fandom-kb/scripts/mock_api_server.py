#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""A tiny in-process MediaWiki API stand-in for end-to-end tests.

It speaks just enough of the MediaWiki API for wiki_crawl.py to run against it
without touching the network: robots.txt, siteinfo, allpages (with real
continuation), title lookups, redirect resolution and action=parse.

Responses are gzipped on purpose, so the crawler's Content-Encoding handling is
exercised too. The first api.php call answers 429 to exercise retry/backoff.

Used by e2e_test.py. Not needed for normal crawling.
"""

from __future__ import annotations

import gzip
import json
import re
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from typing import Any, Dict, List, Optional, Tuple
from urllib.parse import parse_qs, urlparse

ROBOTS = """User-agent: *
Allow: /api.php?
Allow: /api.php?action=
Disallow: /wiki/Special:
Disallow: /wiki/Template:
Disallow: /wiki/User:
"""

INFOTABLE_WIKITEXT = """{{Infobox component
|Name = Modular Engine Cylinder
|Mass = 40
|Cost = $1,200
|Connections = Electric|Fuel
|Since version = [[V1.0.0]]
}}

The modular engine cylinder is the core of the modular engine system.
"""

INFOTABLE_HTML = """
<div class="mw-content-ltr mw-parser-output" lang="en" dir="ltr">
<table class="infobox"><tbody>
<tr><td colspan="2">Modular Engine Cylinder</td></tr>
<tr><td>Mass</td><td>40</td></tr>
<tr><td>Cost</td><td>$1,200</td></tr>
<tr><td>Connections</td><td>Electric</td></tr>
</tbody></table>
<p>The <b>modular engine cylinder</b> is the core of the
<a href="/wiki/Modular_engine">modular engine</a> system.</p>
<h2><span class="mw-headline" id="Usage">Usage</span></h2>
<ul><li>Stack cylinders together</li><li>Add a crankshaft<ul><li>One per bank</li></ul></li></ul>
<table class="wikitable"><tr><th>RPM</th><th>Power</th></tr><tr><td>2000</td><td>120</td></tr></table>
</div>
"""

PLAIN_WIKITEXT = """'''Arctic''' is a cold biome.

== Locations ==
* Arid Island
* BVG Logistics Depot

[[Category: Biomes]]
"""

PLAIN_HTML = """
<div class="mw-content-ltr mw-parser-output" lang="en" dir="ltr">
<div id="toc" class="toc"><ul><li>Contents</li></ul></div>
<p><b>Arctic</b> is a cold biome.</p>
<h2><span class="mw-headline" id="Locations">Locations</span>
<span class="mw-editsection">[<a href="/index.php?action=edit">edit</a>]</span></h2>
<ul><li>Arid Island</li><li>BVG Logistics Depot</li></ul>
<div class="stub">This article is a stub. You can help Us by expanding it.</div>
</div>
"""

BOILERS_WIKITEXT = "A '''boiler''' heats water into steam.\n\n[[Category: Components]]"
BOILERS_HTML = (
    '<div class="mw-parser-output"><p>A <b>boiler</b> heats water into steam.</p>'
    "<h2>Notes</h2><p>Boilers need a <a href=\"/wiki/Fuel\">fuel</a> supply.</p></div>"
)

CAMERA_WIKITEXT = """"A gimbal camera with video output feed."

{{Infobox component
|Name = Camera Gimbal
|Image = [[File:Camera_gimbal.png|200px]]
|Mass = 50
|Dimensions = 3×3×3
|Cost = $5,000
|Logic inputs = Bool (Infrared mode), Numeric (Field of view)
|Logic outputs = Video (Camera feed)
|Connections = Electric
|Since version = [[V0.7.1]]
}}

== Notes ==
A [[Camera|camera]] with telescopic zoom, as well as [[infrared mode]].

=== FOV / Zoom ===
The camera's FOV input will take values from 0-1.

[[Category: Cameras]]
"""

CAMERA_HTML = """
<div class="mw-content-ltr mw-parser-output" lang="en" dir="ltr">
<p>"A gimbal camera with video output feed."</p>
<table class="infobox"><tbody>
<tr><td colspan="2">Camera Gimbal</td></tr>
<tr><td>Mass</td><td>50</td></tr>
<tr><td>Dimensions</td><td>3&#215;3&#215;3</td></tr>
<tr><td>Cost</td><td>$5,000</td></tr>
<tr><td>Logic inputs</td><td>Bool (Infrared mode), Numeric (Field of view)</td></tr>
</tbody></table>
<div id="toc" class="toc"><ul><li>Contents</li></ul></div>
<h2><span class="mw-headline" id="Notes">Notes</span></h2>
<p>A <a href="/wiki/Camera" title="Camera">camera</a> with telescopic zoom, as well as
<a href="/wiki/Infrared_mode">infrared mode</a>.</p>
<h3><span class="mw-headline" id="FOV">FOV / Zoom</span></h3>
<p>The camera's FOV input will take values from 0-1.</p>
</div>
"""

# title -> definition
PAGES: List[Dict[str, Any]] = [
    {"pageid": 1359, "title": "Camera gimbal", "revid": 3156,
     "wikitext": CAMERA_WIKITEXT, "html": CAMERA_HTML,
     "categories": ["Cameras", "Electric components"],
     "links": [{"ns": 0, "title": "Camera"}, {"ns": 0, "title": "Infrared mode"}]},
    {"pageid": 2001, "title": "Modular Engine Cylinder", "revid": 4400,
     "wikitext": INFOTABLE_WIKITEXT, "html": INFOTABLE_HTML,
     "categories": ["Engines"],
     "links": [{"ns": 0, "title": "Modular engine"}]},
    {"pageid": 1425, "title": "Arctic", "revid": 3609,
     "wikitext": PLAIN_WIKITEXT, "html": PLAIN_HTML,
     "categories": ["Biomes"], "links": []},
    {"pageid": 3000, "title": "Boilers", "revid": 5000,
     "wikitext": BOILERS_WIKITEXT, "html": BOILERS_HTML,
     "categories": ["Components"], "links": [{"ns": 0, "title": "Fuel"}]},
    {"pageid": 1844, "title": "Boiler", "revid": 4580, "redirect": "Boilers"},
    {"pageid": 2005, "title": "Camera Small", "revid": 3064, "redirect": "Camera small"},
]

BY_TITLE = {page["title"]: page for page in PAGES}


def _page_entry(page: Dict[str, Any]) -> Dict[str, Any]:
    entry: Dict[str, Any] = {
        "pageid": page["pageid"],
        "ns": 0,
        "title": page["title"],
        "contentmodel": "wikitext",
        "pagelanguage": "en",
        "touched": "2025-05-14T02:41:00Z",
    }
    if page.get("redirect"):
        entry["redirect"] = True
        entry["lastrevid"] = page["revid"]
        entry["length"] = 32
    else:
        entry["lastrevid"] = page["revid"]
        entry["length"] = len(page["wikitext"])
    entry["revisions"] = [{"revid": page["revid"], "timestamp": "2025-05-14T02:41:00Z"}]
    return entry


class Handler(BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"
    server_version = "MockMediaWiki/1.0"

    # -- helpers ---------------------------------------------------------
    def log_message(self, fmt: str, *args: Any) -> None:  # silence test noise
        pass

    def _send(self, body: bytes, status: int = 200, content_type: str = "application/json",
              extra: Optional[Dict[str, str]] = None) -> None:
        gzipped = gzip.compress(body)
        self.send_response(status)
        self.send_header("Content-Type", content_type + "; charset=utf-8")
        self.send_header("Content-Encoding", "gzip")
        self.send_header("Content-Length", str(len(gzipped)))
        for key, value in (extra or {}).items():
            self.send_header(key, value)
        self.end_headers()
        self.wfile.write(gzipped)

    def _send_json(self, payload: Dict[str, Any], status: int = 200) -> None:
        self._send(json.dumps(payload).encode("utf-8"), status=status)

    # -- routing ---------------------------------------------------------
    def do_GET(self) -> None:  # noqa: N802 - required name
        parsed = urlparse(self.path)
        if parsed.path.rstrip("/").endswith("robots.txt"):
            self._send(ROBOTS.encode("utf-8"), content_type="text/plain")
            return
        if parsed.path.endswith("api.php"):
            self._handle_api(parse_qs(parsed.query))
            return
        self._send(b"not found", status=404, content_type="text/plain")

    def _handle_api(self, query: Dict[str, List[str]]) -> None:
        action = (query.get("action") or [""])[0]
        server = self.server  # type: ignore[attr-defined]

        # Simulate throttling once, so the retry/backoff path is covered.
        if server.throttle_once and not server.throttled:
            server.throttled = True
            self._send(b'{"error":{"code":"ratelimited"}}', status=429)
            return

        if action == "query":
            self._handle_query(query)
            return
        if action == "parse":
            self._handle_parse(query)
            return
        self._send_json({"error": {"code": "unknownaction", "info": action}})

    def _handle_query(self, query: Dict[str, List[str]]) -> None:
        if "meta" in query:
            self._send_json(
                {
                    "batchcomplete": True,
                    "query": {
                        "general": {
                            "sitename": "Stormworks: Build and Rescue Wiki (mock)",
                            "server": "https://stormworks.fandom.com",
                            "generator": "MockMediaWiki 1.43.9",
                        },
                        "statistics": {"pages": 1798, "articles": len(PAGES), "edits": 4725},
                        "rightsinfo": {
                            "text": "CC BY-NC-SA",
                            "url": "https://www.fandom.com/licensing",
                        },
                    },
                }
            )
            return

        if "generator" in query and query["generator"][0] == "allpages":
            self._handle_allpages(query)
            return

        if "list" in query and query["list"][0] == "categorymembers":
            self._handle_categorymembers(query)
            return

        if "titles" in query:
            self._handle_titles(query)
            return

        self._send_json({"batchcomplete": True, "query": {}})

    def _handle_allpages(self, query: Dict[str, List[str]]) -> None:
        # Small page size on purpose: forces the crawler to follow "continue".
        page_size = 2
        start = (query.get("gapcontinue") or [""])[0]
        ordered = sorted(PAGES, key=lambda page: page["title"])
        if start:
            ordered = [page for page in ordered if page["title"] >= start]
        chunk = ordered[:page_size]
        remaining = ordered[page_size:]
        payload: Dict[str, Any] = {
            "batchcomplete": True,
            "query": {"pages": [_page_entry(page) for page in chunk]},
        }
        if remaining:
            payload["continue"] = {
                "gapcontinue": remaining[0]["title"],
                "continue": "gapcontinue||",
            }
        self._send_json(payload)

    def _handle_categorymembers(self, query: Dict[str, List[str]]) -> None:
        wanted = (query.get("cmtitle") or [""])[0]
        wanted = re.sub(r"^Category:", "", wanted, flags=re.IGNORECASE).casefold()
        members = [
            {"ns": 0, "title": page["title"]}
            for page in PAGES
            if wanted in [c.casefold() for c in page.get("categories", [])]
        ]
        self._send_json({"batchcomplete": True, "query": {"categorymembers": members}})

    def _handle_titles(self, query: Dict[str, List[str]]) -> None:
        titles = [part for part in query["titles"][0].split("|") if part]
        pages: List[Dict[str, Any]] = []
        redirects: List[Dict[str, Any]] = []
        for title in titles:
            page = BY_TITLE.get(title)
            if page is None:
                pages.append({"ns": 0, "title": title, "missing": True})
                continue
            pages.append(_page_entry(page))
            target = page.get("redirect")
            if target:
                redirects.append({"from": title, "to": target})
        self._send_json({"batchcomplete": True, "query": {"pages": pages, "redirects": redirects}})

    def _handle_parse(self, query: Dict[str, List[str]]) -> None:
        title = (query.get("page") or [""])[0]
        page = BY_TITLE.get(title)
        if page is None or page.get("redirect"):
            self._send_json({"error": {"code": "missingtitle", "info": "no such page"}})
            return
        props = set((query.get("prop") or [""])[0].split("|"))
        payload: Dict[str, Any] = {
            "parse": {"title": title, "pageid": page["pageid"], "revid": page["revid"]}
        }
        if "text" in props:
            payload["parse"]["text"] = page["html"]
        if "wikitext" in props:
            payload["parse"]["wikitext"] = page["wikitext"]
        if "displaytitle" in props:
            payload["parse"]["displaytitle"] = title
        if "categories" in props:
            payload["parse"]["categories"] = [
                {"category": category, "sortkey": "", "hidden": False}
                for category in page.get("categories", [])
            ]
        if "links" in props:
            payload["parse"]["links"] = page.get("links", [])
        if "externallinks" in props:
            payload["parse"]["externallinks"] = []
        if "sections" in props:
            payload["parse"]["sections"] = [
                {"level": "2", "line": "Notes", "anchor": "Notes"},
                {"level": "3", "line": "FOV / Zoom", "anchor": "FOV"},
            ]
        self._send_json(payload)


class MockApiServer(ThreadingHTTPServer):
    daemon_threads = True
    allow_reuse_address = True

    def __init__(self, port: int = 0, throttle_once: bool = True) -> None:
        super().__init__(("127.0.0.1", port), Handler)
        self.throttle_once = throttle_once
        self.throttled = False

    @property
    def base_url(self) -> str:
        host, port = self.server_address[0], self.server_address[1]
        return "http://%s:%d" % (host, port)


def make_server(port: int = 0, throttle_once: bool = True) -> MockApiServer:
    return MockApiServer(port=port, throttle_once=throttle_once)


if __name__ == "__main__":
    import sys
    import threading

    chosen = int(sys.argv[1]) if len(sys.argv) > 1 else 0
    server = make_server(chosen)
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    print("Mock MediaWiki API on %s/api.php" % server.base_url, flush=True)
    try:
        thread.join()
    except KeyboardInterrupt:
        server.shutdown()
