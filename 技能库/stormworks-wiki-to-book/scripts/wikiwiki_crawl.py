#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
wikiwiki.jp 爬虫（非 MediaWiki，MediaWiki 的 api.php 在这上面完全用不了）

站点事实（2026-08-31 实测，wikiwiki.jp/sbarjp）：
  - 引擎是 YukiWiki 系，没有 api.php。页面 URL 形如 https://wikiwiki.jp/<wiki>/<页面名>
  - 正文在 div#content（在 div#body 内）。侧边栏在 div#contents，不要抓
  - 页面名里的非 ASCII 与空格要 URL 编码（UTF-8 percent-encoding）
  - robots.txt（https://wikiwiki.jp/robots.txt）：
        User-Agent: *
        Disallow: /*?          ← 禁止带查询串
        Disallow: /*/::*       ← 禁止 ::cmd/... 内部命令页
    本爬虫只取纯页面 URL，天然符合。分节编辑链接（::cmd/edit?page=...）已过滤，不会去抓
  - 站点提供 sitemap：https://wikiwiki.jp/sitemap-index.xml → https://wikiwiki.jp/<wiki>/sitemap.txt
    可枚举该 wiki 的全部页面名（sbarjp 有 131 页）

用法：
  python wikiwiki_crawl.py --wiki sbarjp --page SENSORS --page "クラフトガイド/レーダー系" \
      --output <WS>/数据库/xxx/原始抓取      # <WS> = 工作区根，盘符不固定
  python wikiwiki_crawl.py --wiki sbarjp --pages-file pages.txt --output ...
  python wikiwiki_crawl.py --wiki sbarjp --list-pages          # 用 sitemap 列出全部页面名
"""

import argparse
import json
import os
import re
import sys
import time
import urllib.parse
import urllib.request

try:
    import requests
    from bs4 import BeautifulSoup
    from markdownify import markdownify as md
except ImportError:
    sys.exit("需要 requests / bs4 / lxml / markdownify —— 用 envs/default 的 python 运行")

BASE = "https://wikiwiki.jp"
UA = {"User-Agent": "Mozilla/5.0 (compatible; SW-WikiWiki-KB/1.0)"}
DELAY = 1.5  # 礼貌抓取间隔（秒）


def page_url(wiki: str, page: str) -> str:
    return f"{BASE}/{wiki}/{urllib.parse.quote(page, safe='/')}"


def list_pages(wiki: str) -> list:
    """用 sitemap 枚举该 wiki 的全部页面名。"""
    r = requests.get(f"{BASE}/{wiki}/sitemap.txt", headers=UA, timeout=30)
    r.raise_for_status()
    names = []
    for u in r.text.split():
        u = u.strip()
        if not u:
            continue
        path = urllib.parse.urlparse(u).path
        name = urllib.parse.unquote(path.replace(f"/{wiki}/", "", 1))
        if name:
            names.append(name)
    return names


def strip_noise(soup: BeautifulSoup) -> BeautifulSoup:
    """去掉编辑链接、广告脚本等噪声节点。"""
    for tag in soup.find_all(["script", "style"]):
        tag.decompose()
    # ::cmd/edit 之类的分节编辑链接（robots 禁止抓取，也不要留在正文里）
    for a in soup.find_all("a", href=True):
        if "::cmd/" in a["href"]:
            a.replace_with(a.get_text())
    for cls in ("system-ui", "search-words"):
        for tag in soup.find_all(class_=cls):
            tag.decompose()
    return soup


def fetch(wiki: str, page: str):
    url = page_url(wiki, page)
    r = requests.get(url, headers=UA, timeout=30)
    r.encoding = "utf-8"
    if r.status_code != 200:
        return None, url, r.status_code

    soup = BeautifulSoup(r.text, "lxml")
    content = soup.find("div", id="content")
    if content is None:
        content = soup.find("div", id="body")
    if content is None:
        return None, url, "no-content"

    content = strip_noise(content)

    lastmod = ""
    lm = soup.find("div", id="lastmodified")
    if lm:
        m = re.search(r"(\d{4}-\d{2}-\d{2})", lm.get_text())
        if m:
            lastmod = m.group(1)

    # 正文内的站内链接 = 该页面的关联页（已排除编辑链接）
    links = set()
    for a in content.find_all("a", href=True):
        m = re.match(rf"^/{re.escape(wiki)}/(.+)$", a["href"])
        if m:
            links.add(urllib.parse.unquote(m.group(1)).split("#")[0])

    markdown = md(str(content), heading_style="ATX", bullets="-")
    markdown = re.sub(r"\n{3,}", "\n\n", markdown).strip()

    rec = {
        "wiki": wiki,
        "page": page,
        "url": url,
        "last_modified": lastmod,
        "chars": len(markdown),
        "internal_links": sorted(links),
    }
    return (rec, markdown), url, 200


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--wiki", default="sbarjp")
    ap.add_argument("--page", action="append", default=[], help="页面名，可重复")
    ap.add_argument("--pages-file", help="每行一个页面名")
    ap.add_argument("--list-pages", action="store_true", help="仅列出该 wiki 全部页面名")
    ap.add_argument("--output", required=False)
    ap.add_argument("--force", action="store_true")
    args = ap.parse_args()

    if args.list_pages:
        for n in list_pages(args.wiki):
            print(n)
        return

    pages = list(args.page)
    if args.pages_file:
        with open(args.pages_file, encoding="utf-8") as f:
            pages += [l.strip() for l in f if l.strip() and not l.startswith("#")]
    if not pages:
        sys.exit("没给页面：用 --page 或 --pages-file")

    out = args.output
    if out:
        os.makedirs(os.path.join(out, "markdown"), exist_ok=True)

    results, failed = [], []
    for i, page in enumerate(pages, 1):
        if i > 1:
            time.sleep(DELAY)
        try:
            data, url, code = fetch(args.wiki, page)
        except Exception as e:
            failed.append({"page": page, "error": repr(e)})
            print(f"[{i}/{len(pages)}] 失败 {page}: {e}")
            continue
        if data is None:
            failed.append({"page": page, "error": str(code)})
            print(f"[{i}/{len(pages)}] 失败 {page}: {code}")
            continue
        rec, markdown = data
        results.append(rec)
        print(f"[{i}/{len(pages)}] OK {page:34s} {rec['chars']:>7d} 字符  {rec['last_modified']}")
        if out:
            safe = re.sub(r'[\\/:*?"<>|]', "_", page) + ".md"
            with open(os.path.join(out, "markdown", safe), "w", encoding="utf-8", newline="") as f:
                f.write(f"---\n")
                f.write(f"wiki: {rec['wiki']}\npage: {page}\n")
                f.write(f"source_url: {url}\nlast_modified: {rec['last_modified']}\n")
                f.write(f"retrieved_at: {time.strftime('%Y-%m-%dT%H:%M:%S%z')}\n")
                f.write(f"---\n\n# {page}\n\n{markdown}\n")

    if out:
        with open(os.path.join(out, "manifest.json"), "w", encoding="utf-8", newline="") as f:
            json.dump(
                {
                    "site": BASE,
                    "wiki": args.wiki,
                    "note": "wikiwiki.jp（非 MediaWiki）。正文取自 div#content，已过滤 ::cmd/edit 链接与侧边栏。",
                    "pages": results,
                    "failed": failed,
                    "ok": len(results),
                    "failed_count": len(failed),
                },
                f,
                ensure_ascii=False,
                indent=2,
            )
    print(f"\n完成：成功 {len(results)} / 失败 {len(failed)}")


if __name__ == "__main__":
    main()
