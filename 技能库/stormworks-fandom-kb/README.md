# Stormworks Fandom 知识库工具

把 [Stormworks Fandom Wiki](https://stormworks.fandom.com/) 变成**本地可检索的 AI / RAG 知识库**。

设计目标：**让 AI 用起来高效**。所以它不只做爬取，还自带检索工具；并且不依赖任何
第三方包，换到任何 AI 平台（WorkBuddy、DeepSeek、Claude…）都能直接跑。

## 为什么重写一版

工作区里已有一个版本 `D:/STORMWORKS/AI相关/stormworks_fandom_kb/`（依赖 requests +
beautifulsoup4 + lxml + markdownify）。它本身写得不错，但有两个硬伤：

1. **装不上就跑不了** —— 目标机器必须先 pip 安装 4 个包，遇到无网/受限环境就废了。
2. **只有爬虫没有检索** —— 抓完的 JSONL 还要 AI 自己想办法读，检索效率低。

本版针对这两点：

| | 旧版 | 本版 |
|---|---|---|
| 依赖 | requests / bs4 / lxml / markdownify | **无（纯标准库）** |
| HTML 解析 | BeautifulSoup + lxml | 自研 `html.parser` 微型 DOM |
| Markdown 转换 | markdownify | 自研渲染器 |
| 结构化属性 | 无（infobox 降级成表格） | **从 wikitext 解析成键值对** |
| 检索工具 | 无 | `wiki_query.py`（7 个子命令） |
| 端口性 | 绑定 WorkBuddy 的 venv 路径 | 任意 `python3` 即可 |

> 2026-09-08 仓库瘦身：旧版（原 `D:/STORMWORKS/AI相关/stormworks_fandom_kb/`）已从仓库移除，
> 本版为唯一维护版本，CLI 参数与旧版兼容（`--prefix/--title/--output/--dry-run/--force`）。

## 快速开始

```bash
# 1) 看看库里有什么
python scripts/wiki_query.py stats

# 2) 检索
python scripts/wiki_query.py search "modular engine cylinder"

# 3) 库里没有就抓（先冒烟，再全量）
python scripts/wiki_crawl.py --output "D:/STORMWORKS/数据库/stormworks_fandom" --max-pages 3
python scripts/wiki_query.py --kb "D:/STORMWORKS/数据库/stormworks_fandom" stats
python scripts/wiki_crawl.py --output "D:/STORMWORKS/数据库/stormworks_fandom"
```

详细说明见 [SKILL.md](SKILL.md)。

## 文件说明

```text
config.json               抓取配置（限速、清洗选择器、分块大小、infobox 模板名）
scripts/
├─ wiki_crawl.py          抓取主程序（自包含，零依赖）
├─ wiki_query.py          本地检索（自包含，零依赖）
├─ selftest.py            离线单元测试 32 项
├─ e2e_test.py            端到端测试 10 项（内置模拟 API）
└─ mock_api_server.py     e2e 用的 MediaWiki API 模拟服务（测试专用）
```

`wiki_crawl.py` 与 `wiki_query.py` 各自**完全自包含**，互不 import。
这样任何一个文件单独拷到别处也能用。

## 清洗策略（踩过的坑）

- **保留 `table.infobox`**：这是 wiki 上最有价值的结构。很多通用爬虫会把它当"导航/侧栏"
  误删，这里绝不能删。
- **infobox 去重**：wikitext 提取出属性后，会剔除渲染出的 infobox 表，避免同一事实说两遍
  浪费 token。用 `--no-wikitext` 时保留该表。
- **不删 `.nomobile`/`.noprint` 之外的一切**：清洗选择器在 `config.json` 里，改配置不改代码。
- **行首空白必须保留**：嵌套列表的缩进就靠它。曾经有一版为了"整洁"把行首空白全删了，
  结果 `  - 子项` 被压平成 `- 子项`。
- **属性选择器要防空格**：`div[style*='clear: both']` 里的空格不能被简单 `split()` 切开，
  否则带空格的属性选择器静默失效。

## 测试

```bash
python scripts/selftest.py -v     # 32 项，<1s，不联网
python scripts/e2e_test.py -v     # 10 项，~11s，本机模拟服务，不联网
```

`selftest.py` 的夹具是从真实 wiki 响应里裁下来的（Camera gimbal 条目），
所以清洗规则是在真实标记上验证的，不是空想。

`e2e_test.py` 覆盖：gzip 传输、429 重试退避、分页续跑（模拟服务每批只返回 2 条）、
重定向处理、增量跳过、`--force` 重抓、单页/分类/干跑模式、以及检索工具全链路。

## 合规

内容来自 Fandom 社区 wiki，许可 **CC BY-NC-SA**。工具走官方 MediaWiki API
（robots.txt 对 `*` 明确 `Allow: /api.php?action=`），限速 1 秒 + 指数退避。
再分发知识库请保留来源 URL 与许可信息。
