#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Offline self-test for the Stormworks Fandom KB crawler.

No network access required. The fixtures below are trimmed from real
stormworks.fandom.com API responses, so the cleaning rules are exercised
against the markup the crawler actually meets.

    python selftest.py [-v]
"""

from __future__ import annotations

import json
import sys
import tempfile
import unittest
import urllib.robotparser
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from wiki_crawl import (  # noqa: E402
    ApiClient,
    KnowledgeBaseWriter,
    PageRef,
    build_article_record,
    build_chunks,
    build_redirect_record,
    build_tree,
    extract_template_params,
    html_to_markdown,
    page_url,
    select_all,
    split_params,
)

# --------------------------------------------------------------------------
# Fixtures taken from the real wiki (action=parse&prop=text, page=Camera_gimbal)
# --------------------------------------------------------------------------

SAMPLE_HTML = """
<div class="mw-content-ltr mw-parser-output" lang="en" dir="ltr">
<p>"A gimbal camera with video output feed. Has an infrared mode as well as pivot controls,
a variable field of view."</p>
<table class="infobox" style="width:300px; float:right;">
<tbody>
<tr><td colspan="2" style="text-align:center">Camera Gimbal</td></tr>
<tr><td colspan="2" style="text-align:center">
  <span typeof="mw:File"><a href="https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/61/Camera_gimbal.png/revision/latest" class="mw-file-description image">
  <img alt="Camera gimbal" src="https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/61/Camera_gimbal.png/revision/latest/scale-to-width-down/200"
       width="200" height="190" class="mw-file-element" data-image-name="Camera_gimbal.png" /></a></span>
</td></tr>
<tr><td>Mass</td><td>50</td></tr>
<tr><td>Dimensions</td><td>3&#215;3&#215;3</td></tr>
<tr><td>Cost</td><td>$5,000</td></tr>
<tr><td>Logic inputs</td><td>Bool (Infrared mode), Numeric (Field of view)</td></tr>
<tr><td>Logic outputs</td><td>Video (Camera feed)</td></tr>
</tbody></table>
<div id="toc" class="toc"><ul><li><a href="#Notes">1 Notes</a></li></ul></div>
<h2><span class="mw-headline" id="Notes">Notes</span><span class="mw-editsection">
<span class="mw-editsection-bracket">[</span><a href="/wiki/Camera_gimbal?action=edit&amp;section=1">edit</a>
<span class="mw-editsection-bracket">]</span></span></h2>
<p>A <a href="/wiki/Camera" title="Camera">camera</a> with telescopic zoom, as well as
<a href="/wiki/Infrared_mode">infrared mode</a>. It is <b>expensive</b>.</p>
<table class="wikitable"><tr><th>Input</th><th>Type</th></tr>
<tr><td>Throttle</td><td>Number</td></tr><tr><td>Field of view</td><td>Number</td></tr></table>
<h3><span class="mw-headline" id="FOV">FOV / Zoom</span></h3>
<ul><li>Wide: 135 degrees</li><li>Narrow: 1.43 degrees<ul><li>28x zoom</li></ul></li></ul>
<p>The following function can be used in a <a href="/wiki/Microcontroller">microcontroller</a>:</p>
<pre>1-(2*(180/pi)*(atan (tan ((pi/180)*(70/2.0))/x)))/(135-1.43)</pre>
<div class="stub">This article is a stub. You can help Us by expanding it.</div>
</div>
"""

SAMPLE_WIKITEXT = """"A gimbal camera with video output feed. Has an infrared mode as well as pivot controls,
a variable field of view."

{{Infobox component
|Name = Camera Gimbal
|Image = [[File:Camera_gimbal.png|200px]]
|Mass = 50
|Dimensions = 3×3×3
|Cost = $5,000
|Logic inputs = Bool (Infrared mode), Numeric (Field of view), Numeric (Pitch rotation)
|Logic outputs = Video (Camera feed)
|Connections = Electric
|Since version = [[V0.7.1]]
}}

== Notes ==
A [[Wiki/Building/Components/Video/Cameras|camera]] with telescopic zoom, as well as [[infrared mode]].

=== FOV / Zoom ===
The camera's FOV input will take values from 0-1.

[[Category: Cameras]]
[[Category: Electric components]]
"""

CLEANING = {
    "remove_selectors": [
        "script", "style", "noscript", "iframe", "svg",
        "#toc", ".toc", ".mw-editsection", ".mw-editsection-like",
        ".mw-editsection-bracket", ".navbox", ".navbar", ".metadata",
        ".nomobile", ".noprint", ".printfooter", ".catlinks", ".mw-empty-elt",
        ".reference", ".reflist", ".mw-references-wrap", ".embedvideo",
        ".wds-global-footer",
        "div[style*='clear: both'][style*='margin: 30px']",
    ],
    "remove_text_patterns": [
        "This article is a stub",
        "You can help Us by expanding it",
        "Under Construction!",
        "Add Comment",
        "This page was last edited on",
    ],
}

BASE_URL = "https://stormworks.fandom.com"


class FakeClient:
    base_url = BASE_URL
    public_base_url = BASE_URL
    api_url = BASE_URL + "/api.php"


def sample_page() -> PageRef:
    return PageRef(1359, "Camera gimbal", 3156, "2025-05-14T02:41:00Z")


class SelectorTests(unittest.TestCase):
    def setUp(self) -> None:
        self.root = build_tree(
            '<div id="wrap"><p class="lead x">a</p>'
            '<table class="infobox wikitable"><tr><td>b</td></tr></table>'
            '<div style="clear: both; margin: 30px auto">junk</div>'
            '<span data-foo="bar baz">c</span></div>'
        )

    def test_class_selector(self) -> None:
        self.assertEqual(len(select_all(self.root, ".infobox")), 1)
        self.assertEqual(len(select_all(self.root, ".lead")), 1)

    def test_id_selector(self) -> None:
        self.assertEqual(len(select_all(self.root, "#wrap")), 1)
        self.assertEqual(select_all(self.root, "#wrap")[0].tag, "div")

    def test_attribute_contains_selector(self) -> None:
        self.assertEqual(len(select_all(self.root, "div[style*='clear: both']")), 1)
        self.assertEqual(len(select_all(self.root, "div[style*='nonexistent']")), 0)

    def test_descendant_selector(self) -> None:
        self.assertEqual(len(select_all(self.root, "#wrap table.infobox")), 1)
        self.assertEqual(len(select_all(self.root, "table td")), 1)

    def test_comma_group(self) -> None:
        self.assertEqual(len(select_all(self.root, ".infobox, #wrap")), 2)


class TransformTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.result = html_to_markdown(SAMPLE_HTML, BASE_URL, CLEANING)
        cls.markdown = cls.result["markdown"]

    def test_infobox_table_survives_cleaning(self) -> None:
        # The infobox is the most valuable structure on this wiki: it must not
        # be stripped as "boilerplate", and it must come out as a Markdown table.
        infobox_tables = [t for t in self.result["tables"] if "infobox" in t["classes"]]
        self.assertEqual(len(infobox_tables), 1)
        rows = infobox_tables[0]["rows"]
        self.assertIn(["Mass", "50"], rows)
        self.assertIn(["Cost", "$5,000"], rows)
        self.assertIn("| Mass | 50 |", self.markdown)

    def test_toc_and_stub_removed(self) -> None:
        self.assertNotIn("This article is a stub", self.markdown)
        self.assertNotIn("You can help Us by expanding it", self.markdown)
        self.assertNotIn("[edit]", self.markdown.lower())

    def test_headings_and_nested_lists(self) -> None:
        self.assertIn("## Notes", self.markdown)
        self.assertIn("### FOV / Zoom", self.markdown)
        self.assertIn("- Wide: 135 degrees", self.markdown)
        self.assertIn("  - 28x zoom", self.markdown)

    def test_links_and_bold(self) -> None:
        self.assertIn("[camera](https://stormworks.fandom.com/wiki/Camera)", self.markdown)
        self.assertIn("**expensive**", self.markdown)

    def test_relative_links_are_absolutized(self) -> None:
        self.assertNotIn('href="/wiki/', self.markdown)
        self.assertNotIn("](/wiki/", self.markdown)

    def test_wikitable_and_pre_block(self) -> None:
        self.assertIn("| Input | Type |", self.markdown)
        self.assertIn("| Throttle | Number |", self.markdown)
        self.assertIn("```", self.markdown)
        self.assertIn("(2*(180/pi)", self.markdown)

    def test_images_extracted_with_absolute_urls(self) -> None:
        images = self.result["images"]
        self.assertEqual(len(images), 1)
        self.assertTrue(images[0]["thumbnail_url"].startswith("https://"))
        self.assertEqual(images[0]["alt"], "Camera gimbal")

    def test_infobox_html_table_dropped_when_wikitext_attributes_exist(self) -> None:
        # Passing extra_selectors removes the duplicated rendered infobox, so the
        # Specifications table (built from wikitext) is the single source.
        result = html_to_markdown(
            SAMPLE_HTML, BASE_URL, CLEANING, extra_selectors=["table.infobox"]
        )
        self.assertNotIn("| Mass | 50 |", result["markdown"])
        self.assertNotIn("infobox", [c for t in result["tables"] for c in t["classes"]])
        # non-infobox tables must survive
        self.assertIn("| Throttle | Number |", result["markdown"])

    def test_nested_image_link_is_not_corrupted(self) -> None:
        # An <a> wrapping an <img> must not have its inner "](" escaped.
        result = html_to_markdown(
            '<p><a href="/wiki/Camera_gimbal">'
            '<img alt="Camera gimbal" src="//static.wikia.nocookie.net/x.png" /></a></p>',
            BASE_URL,
            CLEANING,
        )
        markdown = result["markdown"]
        self.assertIn("![Camera gimbal](https://static.wikia.nocookie.net/x.png)", markdown)
        self.assertNotIn("\\]", markdown)

    def test_plain_text_has_no_markup(self) -> None:
        plain = self.result["plain_text"]
        self.assertNotIn("<", plain)
        self.assertIn("Mass", plain)


class WikitextTests(unittest.TestCase):
    def test_infobox_params_parsed(self) -> None:
        params = extract_template_params(SAMPLE_WIKITEXT, ["infobox"])
        self.assertEqual(params.get("_template"), "Infobox component")
        self.assertEqual(params.get("Mass"), "50")
        self.assertEqual(params.get("Cost"), "$5,000")
        self.assertEqual(params.get("Dimensions"), "3×3×3")
        self.assertIn("Infrared mode", params.get("Logic inputs", ""))
        self.assertEqual(params.get("Logic outputs"), "Video (Camera feed)")

    def test_wiki_markup_stripped_from_values(self) -> None:
        params = extract_template_params(SAMPLE_WIKITEXT, ["infobox"])
        # [[V0.7.1]] -> V0.7.1 and [[File:Camera_gimbal.png|200px]] -> 200px
        self.assertEqual(params.get("Since version"), "V0.7.1")
        self.assertEqual(params.get("Image"), "200px")

    def test_nested_templates_do_not_break_param_split(self) -> None:
        wikitext = "{{Infobox component|Name = {{code-block|content=abc|def}}|Mass = 5}}"
        parts = split_params("Name = {{code-block|content=abc|def}}|Mass = 5")
        self.assertEqual(parts, ["Name = {{code-block|content=abc|def}}", "Mass = 5"])
        params = extract_template_params(wikitext, ["infobox"])
        self.assertEqual(params.get("Mass"), "5")

    def test_no_infobox_returns_empty(self) -> None:
        self.assertEqual(extract_template_params("Just prose, no template.", ["infobox"]), {})


class RecordTests(unittest.TestCase):
    def test_article_record_carries_attributes(self) -> None:
        page = sample_page()
        transformed = html_to_markdown(SAMPLE_HTML, BASE_URL, CLEANING)
        parsed = {
            "revid": 3156,
            "displaytitle": "Camera gimbal",
            "categories": [{"category": "Cameras"}, {"category": "Electric components"}],
            "links": [{"ns": 0, "title": "Camera"}, {"ns": 14, "title": "Category:Cameras"}],
            "externallinks": [],
            "sections": [{"level": "2", "line": "Notes", "anchor": "Notes"}],
        }
        record = build_article_record(
            page, parsed, transformed, FakeClient(), SAMPLE_WIKITEXT, ["infobox"]
        )
        self.assertEqual(record["record_type"], "article")
        self.assertEqual(record["title"], "Camera gimbal")
        self.assertEqual(record["attributes"]["Mass"], "50")
        self.assertEqual(record["categories"], ["Cameras", "Electric components"])
        # namespace 14 (Category) links must be filtered out of internal_links
        self.assertEqual(record["internal_links"], ["Camera"])
        self.assertIn("## Specifications", record["attributes_markdown"])
        self.assertIn("| Mass | 50 |", record["attributes_markdown"])
        self.assertEqual(record["data_quality"], "high")
        self.assertTrue(record["source"]["url"].endswith("/wiki/Camera_gimbal"))

    def test_chunks_keep_provenance_and_attributes_first(self) -> None:
        page = sample_page()
        transformed = html_to_markdown(SAMPLE_HTML, BASE_URL, CLEANING)
        parsed = {
            "revid": 3156,
            "displaytitle": "Camera gimbal",
            "categories": [{"category": "Cameras"}],
            "links": [],
            "externallinks": [],
            "sections": [],
        }
        record = build_article_record(
            page, parsed, transformed, FakeClient(), SAMPLE_WIKITEXT, ["infobox"]
        )
        chunks = build_chunks(record, max_chars=400, overlap_chars=50)
        self.assertGreater(len(chunks), 1)
        for chunk in chunks:
            self.assertEqual(chunk["page_id"], 1359)
            self.assertEqual(chunk["revision_id"], 3156)
            self.assertEqual(chunk["title"], "Camera gimbal")
            self.assertTrue(chunk["source_url"].endswith("/wiki/Camera_gimbal"))
            self.assertEqual(chunk["license"], "CC BY-NC-SA")
            self.assertIn("Cameras", chunk["categories"])
            self.assertTrue(chunk["content_sha256"])
        # specifications should land in the first chunk so component facts are retrievable
        self.assertIn("Specifications", chunks[0]["text"])
        # "## Notes" is a top-level section (the "#1" heading is the injected
        # page title), so section_path must never contain empty placeholders.
        paths = [chunk["section_path"] for chunk in chunks]
        for path in paths:
            self.assertNotIn("", path)
        self.assertIn(["Notes", "FOV / Zoom"], paths)

    def test_section_path_depth_is_correct(self) -> None:
        """'## X' is a top-level section; depth must nest from there."""
        page = sample_page()
        markdown = (
            "# Intro\n\nsome text\n\n"
            "## Alpha\n\ntext\n\n"
            "### Alpha 1\n\ntext\n\n"
            "#### Alpha 1 a\n\ntext"
        )
        transformed = {"markdown": markdown, "plain_text": markdown, "images": [], "tables": []}
        parsed = {"revid": 1, "displaytitle": "x", "categories": [], "links": [],
                  "externallinks": [], "sections": []}
        record = build_article_record(page, parsed, transformed, FakeClient(), "", ["infobox"])
        chunks = build_chunks(record, max_chars=2000, overlap_chars=0)
        self.assertEqual(len(chunks), 1)
        self.assertEqual(chunks[0]["section_path"], ["Alpha", "Alpha 1", "Alpha 1 a"])
        self.assertIn("Section: Alpha > Alpha 1 > Alpha 1 a", chunks[0]["text"])

    def test_long_block_is_split_not_truncated(self) -> None:
        page = sample_page()
        transformed = html_to_markdown(SAMPLE_HTML, BASE_URL, CLEANING)
        long_text = "Sentence about engines. " * 400
        transformed["markdown"] = "## Notes\n\n" + long_text
        parsed = {"revid": 1, "displaytitle": "X", "categories": [], "links": [], "externallinks": [], "sections": []}
        record = build_article_record(page, parsed, transformed, FakeClient(), "", ["infobox"])
        chunks = build_chunks(record, max_chars=600, overlap_chars=0)
        self.assertGreater(len(chunks), 3)
        joined = "".join(chunk["text"] for chunk in chunks)
        self.assertIn("Sentence about engines.", joined)

    def test_redirect_record(self) -> None:
        page = PageRef(1844, "Boiler", 4580, "2026-08-17T15:17:57Z", is_redirect=True)
        record = build_redirect_record(
            page, {"to": "Boilers", "target_page_id": 99, "target_revision_id": 100}, FakeClient()
        )
        self.assertEqual(record["record_type"], "redirect")
        self.assertEqual(record["redirect"]["target_title"], "Boilers")
        self.assertTrue(record["redirect"]["target_url"].endswith("/wiki/Boilers"))


class WriterTests(unittest.TestCase):
    def test_incremental_skip_and_aggregates(self) -> None:
        page = sample_page()
        transformed = html_to_markdown(SAMPLE_HTML, BASE_URL, CLEANING)
        parsed = {
            "revid": 3156,
            "displaytitle": "Camera gimbal",
            "categories": [{"category": "Cameras"}],
            "links": [],
            "externallinks": [],
            "sections": [],
        }
        record = build_article_record(
            page, parsed, transformed, FakeClient(), SAMPLE_WIKITEXT, ["infobox"]
        )
        chunks = build_chunks(record, 1200, 100)
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory)
            writer = KnowledgeBaseWriter(output)
            writer.save_article(record, chunks)

            # same revision -> skipped; a new revision -> refetched
            self.assertTrue(writer.should_skip(page, force=False))
            self.assertFalse(
                writer.should_skip(PageRef(1359, "Camera gimbal", 9999, ""), force=False)
            )
            self.assertFalse(writer.should_skip(page, force=True))

            manifest = writer.rebuild_aggregates(
                {"fetched": 1, "failed": 0},
                {
                    "general": {"sitename": "Stormworks: Build and Rescue Wiki", "server": BASE_URL,
                                "generator": "MediaWiki 1.43.9"},
                    "statistics": {"articles": 558, "pages": 1798},
                    "rightsinfo": {"text": "CC BY-NC-SA", "url": "https://www.fandom.com/licensing"},
                },
            )
            self.assertEqual(manifest["dataset"]["records"], 1)
            self.assertEqual(manifest["dataset"]["articles"], 1)
            self.assertEqual(manifest["dataset"]["with_attributes"], 1)
            self.assertEqual(manifest["source"]["reported_articles"], 558)

            pages = [json.loads(line) for line in
                     (output / "pages.jsonl").read_text(encoding="utf-8").splitlines() if line.strip()]
            self.assertEqual(pages[0]["title"], "Camera gimbal")

            chunk_lines = [line for line in
                           (output / "chunks.jsonl").read_text(encoding="utf-8").splitlines() if line.strip()]
            self.assertEqual(len(chunk_lines), len(chunks))
            self.assertEqual(manifest["dataset"]["chunks"], len(chunks))

            attribute_rows = [json.loads(line) for line in
                              (output / "attributes.jsonl").read_text(encoding="utf-8").splitlines() if line.strip()]
            self.assertEqual(attribute_rows[0]["attributes"]["Mass"], "50")

            markdown_file = list((output / "markdown").glob("*.md"))[0]
            front = markdown_file.read_text(encoding="utf-8")
            self.assertTrue(front.startswith("---"))
            self.assertIn("source_url:", front)
            self.assertIn("## Specifications", front)

    def test_failures_are_recorded(self) -> None:
        page = PageRef(1, "Broken", 1, "")
        with tempfile.TemporaryDirectory() as directory:
            writer = KnowledgeBaseWriter(Path(directory))
            writer.save_failure(page, RuntimeError("boom"))
            failures = [json.loads(line) for line in
                        (Path(directory) / "failures.jsonl").read_text(encoding="utf-8").splitlines()]
            self.assertEqual(failures[0]["title"], "Broken")
            self.assertEqual(writer.state["pages"]["1"]["status"], "failed")


class RobotsTests(unittest.TestCase):
    """The crawler refuses to run when robots.txt disallows it.

    stormworks.fandom.com/robots.txt grants ``Allow: /api.php?action=`` to
    ``User-agent: *`` while banning the /wiki/Special: namespace. If the stdlib
    parser ever stops honouring query-string Allow rules, this test fails and we
    know the tool would block itself for no reason.
    """

    REAL_ROBOTS = """User-agent: SemrushBot
Disallow: /

User-agent: GPTBot
Disallow: /

User-agent: *
Allow: /api.php?
Allow: /api.php?action=
Allow: /wiki/Special:CreateNewWiki
Noindex: /wiki/Special:
Disallow: /wiki/Special:
Disallow: /wiki/Template:
Disallow: /wiki/User:
Sitemap: https://stormworks.fandom.com/sitemap-newsitemapxml-index.xml
"""

    def setUp(self) -> None:
        self.parser = urllib.robotparser.RobotFileParser()
        self.parser.parse(self.REAL_ROBOTS.splitlines())

    def test_api_access_is_allowed(self) -> None:
        self.assertTrue(
            self.parser.can_fetch(
                "StormworksFandomKB/2.0 (test)", "https://stormworks.fandom.com/api.php?action=query"
            )
        )

    def test_special_namespace_is_disallowed(self) -> None:
        self.assertFalse(
            self.parser.can_fetch(
                "StormworksFandomKB/2.0 (test)", "https://stormworks.fandom.com/wiki/Special:AllPages"
            )
        )


class MiscTests(unittest.TestCase):
    def test_page_url_quoting(self) -> None:
        self.assertEqual(
            page_url(BASE_URL, "Camera gimbal"),
            "https://stormworks.fandom.com/wiki/Camera_gimbal",
        )
        self.assertTrue(page_url(BASE_URL, "Wiki/Guides/Engine").endswith("/wiki/Wiki/Guides/Engine"))

    def test_malformed_html_does_not_crash(self) -> None:
        for broken in [
            "<p>unclosed",
            "<div><span>a</div>",
            "<table><tr><td>x</table>",
            "",
            "<p>&amp; &lt;tag&gt; &#215;</p>",
        ]:
            result = html_to_markdown(broken, BASE_URL, CLEANING)
            self.assertIsInstance(result["markdown"], str)

    def test_client_requires_config_keys(self) -> None:
        client = ApiClient({"base_url": BASE_URL, "user_agent": "test/1.0"})
        self.assertEqual(client.api_url, BASE_URL + "/api.php")
        self.assertGreaterEqual(client.delay, 0.2)

    def test_public_base_url_separates_fetch_from_provenance(self) -> None:
        # When crawling through a mirror or proxy, recorded source URLs must
        # still point at the canonical public wiki.
        client = ApiClient(
            {"base_url": "http://127.0.0.1:8000", "public_base_url": BASE_URL,
             "user_agent": "test/1.0"}
        )
        self.assertEqual(client.base_url, "http://127.0.0.1:8000")
        self.assertEqual(client.public_base_url, BASE_URL)
        page = sample_page()
        record = build_redirect_record(
            page, {"to": "Boilers", "target_page_id": 99, "target_revision_id": 100}, client
        )
        self.assertTrue(record["source"]["url"].startswith(BASE_URL + "/wiki/"))
        self.assertTrue(record["redirect"]["target_url"].startswith(BASE_URL + "/wiki/"))


if __name__ == "__main__":
    unittest.main(verbosity=2 if "-v" in sys.argv else 1)
