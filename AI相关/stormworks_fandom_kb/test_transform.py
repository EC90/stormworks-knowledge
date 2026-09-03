from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from stormworks_fandom_crawler import (
    KnowledgeBaseWriter,
    PageRef,
    build_article_record,
    build_chunks,
    transform_html,
)


class FakeClient:
    base_url = "https://stormworks.fandom.com"
    api_url = "https://stormworks.fandom.com/api.php"


class TransformTests(unittest.TestCase):
    def setUp(self) -> None:
        self.cleaning = {
            "remove_selectors": ["#toc", ".mw-editsection", "script", "style"],
            "remove_text_patterns": ["This article is a stub"],
        }

    def test_transform_preserves_content_table_links_and_images(self) -> None:
        source = """
        <div class="mw-parser-output">
          <table><tr><td>This article is a stub</td></tr></table>
          <div id="toc">Contents</div>
          <h2>Engine</h2>
          <p>A diesel engine provides <a href="/wiki/Mechanical_Power">mechanical power</a>.</p>
          <table class="wikitable"><tr><th>Input</th><th>Type</th></tr><tr><td>Throttle</td><td>Number</td></tr></table>
          <img src="//static.wikia.nocookie.net/example.png" alt="Engine diagram" width="128" />
        </div>
        """
        result = transform_html(source, FakeClient.base_url, self.cleaning)
        self.assertIn("## Engine", result["markdown"])
        self.assertIn("mechanical power", result["markdown"])
        self.assertNotIn("This article is a stub", result["markdown"])
        self.assertEqual(result["tables"][0]["rows"][1], ["Throttle", "Number"])
        self.assertTrue(result["images"][0]["url"].startswith("https://"))

    def test_chunks_keep_provenance(self) -> None:
        page = PageRef(549, "Wiki/Guides/Engine", 3924, "2024-07-20T00:53:07Z")
        parsed = {
            "revid": 3924,
            "displaytitle": "Wiki/Guides/Engine",
            "categories": [{"category": "Guides"}],
            "links": [{"ns": 0, "title": "Mechanical Power"}],
            "externallinks": [],
            "sections": [{"level": "2", "line": "Engine", "anchor": "Engine"}],
        }
        transformed = {
            "markdown": "## Engine\n\n" + ("Engine information sentence. " * 80),
            "plain_text": "Engine information sentence. " * 80,
            "images": [],
            "tables": [],
        }
        record = build_article_record(page, parsed, transformed, FakeClient())
        chunks = build_chunks(record, max_chars=500, overlap_chars=50)
        self.assertGreater(len(chunks), 1)
        self.assertTrue(all(item["page_id"] == 549 for item in chunks))
        self.assertTrue(all(item["source_url"].endswith("Wiki/Guides/Engine") for item in chunks))

    def test_writer_is_incremental_and_rebuilds_jsonl(self) -> None:
        page = PageRef(1, "Test Page", 10, "2026-01-01T00:00:00Z")
        record = {
            "schema_version": "1.0",
            "record_type": "article",
            "title": "Test Page",
            "display_title": "Test Page",
            "summary": "Summary",
            "categories": [],
            "sections": [],
            "internal_links": [],
            "external_links": [],
            "images": [],
            "tables": [],
            "content": {
                "markdown": "# Test Page\n\nBody",
                "plain_text": "Test Page Body",
                "char_count": 17,
                "word_count": 3,
                "sha256": "abc"
            },
            "data_quality": "low",
            "source": {
                "wiki": "Stormworks: Build and Rescue Wiki",
                "url": "https://stormworks.fandom.com/wiki/Test_Page",
                "api_url": "https://stormworks.fandom.com/api.php",
                "page_id": 1,
                "revision_id": 10,
                "revision_timestamp": "2026-01-01T00:00:00Z",
                "retrieved_at": "2026-01-01T00:00:01+00:00",
                "license": "CC BY-NC-SA",
                "license_url": "https://www.fandom.com/licensing"
            }
        }
        with tempfile.TemporaryDirectory() as directory:
            writer = KnowledgeBaseWriter(Path(directory))
            writer.save_article(record, [])
            self.assertTrue(writer.should_skip(page, force=False))
            manifest = writer.rebuild_aggregates(
                {"fetched": 1, "failed": 0},
                {"general": {"sitename": "Test", "server": "https://example.test"}, "statistics": {}, "rightsinfo": {}}
            )
            self.assertEqual(manifest["dataset"]["records"], 1)
            lines = (Path(directory) / "pages.jsonl").read_text(encoding="utf-8").splitlines()
            self.assertEqual(json.loads(lines[0])["title"], "Test Page")


if __name__ == "__main__":
    unittest.main()
