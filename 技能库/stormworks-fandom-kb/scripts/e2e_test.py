#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""End-to-end test: run the real crawler against an in-process MediaWiki mock.

Everything except the socket is production code, so this covers the HTTP layer
(gzip, retries, throttling), API pagination via "continue", redirect handling,
incremental state, aggregate rebuilding and the query tool.

    python e2e_test.py [-v]
"""

from __future__ import annotations

import json
import shutil
import sys
import tempfile
import threading
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import mock_api_server  # noqa: E402
import wiki_crawl  # noqa: E402
import wiki_query  # noqa: E402

ARTICLES = 4   # Camera gimbal, Modular Engine Cylinder, Arctic, Boilers
REDIRECTS = 2  # Boiler, Camera Small
TOTAL = ARTICLES + REDIRECTS


def build_config(base_url: str) -> dict:
    return {
        "base_url": base_url,
        "public_base_url": "https://stormworks.fandom.com",
        "api_url": base_url + "/api.php",
        "user_agent": "StormworksFandomKB-e2e/1.0",
        "request_delay_seconds": 0.01,
        "timeout_seconds": 10,
        "max_retries": 3,
        "chunking": {"max_chars": 1200, "overlap_chars": 100},
        "infobox_templates": ["infobox"],
        "cleaning": wiki_crawl.load_config(
            Path(__file__).resolve().parent.parent / "config.json"
        )["cleaning"],
    }


class EndToEndTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.server = mock_api_server.make_server(port=0, throttle_once=True)
        cls.thread = threading.Thread(target=cls.server.serve_forever, daemon=True)
        cls.thread.start()
        cls.base_url = cls.server.base_url
        cls._tmp = tempfile.mkdtemp(prefix="swkb_e2e_")
        cls.tmp = Path(cls._tmp)
        config_path = cls.tmp / "config.json"
        config_path.write_text(
            json.dumps(build_config(cls.base_url), ensure_ascii=False, indent=2), encoding="utf-8"
        )
        cls.config_path = config_path

    @classmethod
    def tearDownClass(cls) -> None:
        cls.server.shutdown()
        cls.server.server_close()
        shutil.rmtree(cls._tmp, ignore_errors=True)

    def run_crawl(self, output: Path, *extra: str) -> int:
        argv = ["--config", str(self.config_path), "--output", str(output), *extra]
        return wiki_crawl.run(argv)

    def fresh_output(self, name: str) -> Path:
        target = self.tmp / name
        shutil.rmtree(target, ignore_errors=True)
        return target

    # -- tests ------------------------------------------------------------
    def test_01_full_crawl_over_paginated_api(self) -> None:
        output = self.fresh_output("full")
        code = self.run_crawl(output)
        self.assertEqual(code, 0, "crawl reported failures; see %s/crawl.log" % output)

        manifest = json.loads((output / "manifest.json").read_text(encoding="utf-8"))
        dataset = manifest["dataset"]
        # The mock serves 2 pages per request, so this only passes if "continue"
        # is followed correctly.
        self.assertEqual(dataset["records"], TOTAL)
        self.assertEqual(dataset["articles"], ARTICLES)
        self.assertEqual(dataset["redirects"], REDIRECTS)
        self.assertEqual(dataset["with_attributes"], 2)
        self.assertGreater(dataset["chunks"], 0)
        self.assertEqual(dataset["quality"].get("high"), 2)

        # the simulated 429 must have been survived
        self.assertTrue(self.server.throttled, "mock never issued its 429")
        self.assertEqual(manifest["last_run"]["failed"], 0)

    def test_02_output_files_and_provenance(self) -> None:
        output = self.tmp / "full"
        for name in ("manifest.json", "pages.jsonl", "chunks.jsonl",
                     "attributes.jsonl", "state.json"):
            self.assertTrue((output / name).exists(), "missing %s" % name)

        records = [json.loads(line) for line in
                   (output / "pages.jsonl").read_text(encoding="utf-8").splitlines() if line.strip()]
        by_title = {record["title"]: record for record in records}

        camera = by_title["Camera gimbal"]
        self.assertEqual(camera["record_type"], "article")
        self.assertEqual(camera["attributes"]["Mass"], "50")
        self.assertEqual(camera["attributes"]["Since version"], "V0.7.1")
        self.assertIn("Cameras", camera["categories"])
        self.assertEqual(camera["source"]["url"],
                         "https://stormworks.fandom.com/wiki/Camera_gimbal")
        self.assertEqual(camera["source"]["revision_id"], 3156)
        self.assertEqual(camera["source"]["license"], "CC BY-NC-SA")
        self.assertTrue(camera["source"]["retrieved_at"])

        # wikitext attributes replaced the rendered infobox (no duplicated facts)
        self.assertIn("Specifications", camera["attributes_markdown"])
        self.assertIn("## Specifications", camera["attributes_markdown"])
        self.assertNotIn("| Mass | 50 |", camera["content"]["markdown"])

        # redirects are recorded as aliases, not as empty articles
        boiler = by_title["Boiler"]
        self.assertEqual(boiler["record_type"], "redirect")
        self.assertEqual(boiler["redirect"]["target_title"], "Boilers")

        # every chunk carries provenance
        chunks = [json.loads(line) for line in
                  (output / "chunks.jsonl").read_text(encoding="utf-8").splitlines() if line.strip()]
        self.assertGreater(len(chunks), 0)
        for chunk in chunks:
            self.assertTrue(chunk["source_url"].startswith("https://stormworks.fandom.com/wiki/"))
            self.assertEqual(chunk["license"], "CC BY-NC-SA")
            self.assertTrue(chunk["content_sha256"])
            self.assertTrue(chunk["text"].startswith("# "))

        # markdown files have YAML-ish front matter with source URL
        markdown_files = list((output / "markdown").glob("*.md"))
        self.assertEqual(len(markdown_files), TOTAL)
        sample = markdown_files[0].read_text(encoding="utf-8")
        self.assertTrue(sample.startswith("---"))
        self.assertIn("source_url:", sample)

    def test_03_rerun_skips_unchanged_revisions(self) -> None:
        output = self.tmp / "full"
        code = self.run_crawl(output)
        self.assertEqual(code, 0)
        manifest = json.loads((output / "manifest.json").read_text(encoding="utf-8"))
        self.assertEqual(manifest["last_run"]["skipped_unchanged"], TOTAL)
        self.assertEqual(manifest["last_run"]["fetched"], 0)

    def test_04_force_refetches(self) -> None:
        output = self.tmp / "full"
        code = self.run_crawl(output, "--force")
        self.assertEqual(code, 0)
        manifest = json.loads((output / "manifest.json").read_text(encoding="utf-8"))
        self.assertEqual(manifest["last_run"]["fetched"], TOTAL)
        self.assertEqual(manifest["last_run"]["skipped_unchanged"], 0)

    def test_05_single_title(self) -> None:
        output = self.fresh_output("single")
        code = self.run_crawl(output, "--title", "Arctic")
        self.assertEqual(code, 0)
        records = [json.loads(line) for line in
                   (output / "pages.jsonl").read_text(encoding="utf-8").splitlines() if line.strip()]
        self.assertEqual(len(records), 1)
        self.assertEqual(records[0]["title"], "Arctic")
        # the stub notice and the TOC must not survive
        self.assertNotIn("This article is a stub", records[0]["content"]["markdown"])
        self.assertNotIn("Contents", records[0]["content"]["markdown"].split("\n"))
        self.assertIn("## Locations", records[0]["content"]["markdown"])

    def test_06_category_mode(self) -> None:
        output = self.fresh_output("cat")
        code = self.run_crawl(output, "--category", "Engines")
        self.assertEqual(code, 0)
        records = [json.loads(line) for line in
                   (output / "pages.jsonl").read_text(encoding="utf-8").splitlines() if line.strip()]
        self.assertEqual([record["title"] for record in records], ["Modular Engine Cylinder"])

    def test_07_dry_run_writes_nothing(self) -> None:
        output = self.fresh_output("dry")
        code = self.run_crawl(output, "--dry-run")
        self.assertEqual(code, 0)
        self.assertFalse((output / "pages.jsonl").exists())

    def test_08_no_wikitext_mode_still_keeps_infobox_table(self) -> None:
        output = self.fresh_output("nowt")
        code = self.run_crawl(output, "--title", "Camera gimbal", "--no-wikitext")
        self.assertEqual(code, 0)
        record = json.loads(
            (output / "pages.jsonl").read_text(encoding="utf-8").splitlines()[0]
        )
        self.assertEqual(record["attributes"], {})
        # without wikitext the rendered infobox must be kept, not dropped
        self.assertIn("| Mass | 50 |", record["content"]["markdown"])

    def test_09_query_tool_roundtrip(self) -> None:
        output = self.tmp / "full"
        kb = str(output)

        results = wiki_query.search_chunks(Path(kb), "modular engine cylinder", limit=5)
        self.assertGreater(len(results), 0)
        self.assertEqual(results[0][1]["title"], "Modular Engine Cylinder")

        results = wiki_query.search_chunks(Path(kb), "infrared", limit=5)
        self.assertTrue(any(chunk["title"] == "Camera gimbal" for _, chunk in results))

        manifest = wiki_query.load_manifest(Path(kb))
        self.assertEqual(manifest["dataset"]["articles"], ARTICLES)

        attribute_rows = list(wiki_query.read_jsonl(Path(kb) / "attributes.jsonl"))
        self.assertEqual(len(attribute_rows), 2)
        names = {row["title"] for row in attribute_rows}
        self.assertEqual(names, {"Camera gimbal", "Modular Engine Cylinder"})

    def test_10_query_cli_smoke(self) -> None:
        output = self.tmp / "full"
        argv_backup = sys.argv
        try:
            sys.argv = ["wiki_query.py", "--kb", str(output), "stats"]
            self.assertEqual(wiki_query.main(), 0)
            sys.argv = ["wiki_query.py", "--kb", str(output), "titles"]
            self.assertEqual(wiki_query.main(), 0)
            sys.argv = ["wiki_query.py", "--kb", str(output), "attr", "Camera gimbal"]
            self.assertEqual(wiki_query.main(), 0)
            sys.argv = ["wiki_query.py", "--kb", str(output), "findattr", "Mass"]
            self.assertEqual(wiki_query.main(), 0)
            sys.argv = ["wiki_query.py", "--kb", str(output), "cat", "Engines"]
            self.assertEqual(wiki_query.main(), 0)
        finally:
            sys.argv = argv_backup


if __name__ == "__main__":
    unittest.main(verbosity=2 if "-v" in sys.argv else 1)
