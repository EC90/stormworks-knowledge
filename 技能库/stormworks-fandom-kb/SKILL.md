---
name: stormworks-fandom-kb
description: 抓取 Stormworks Fandom Wiki（stormworks.fandom.com）条目并构建本地 AI/RAG 知识库，同时提供本地检索工具。零第三方依赖（纯 Python 标准库），适用于 WorkBuddy / DeepSeek / Claude 等任意 AI 平台。触发场景：需要 Stormworks 部件参数、方块数据、机制说明、Lua/微控制器资料、版本更新记录；用户要求爬取/镜像 Stormworks wiki、建知识库、查 Fandom 资料；或工作区已存在本地知识库需要检索。
agent_created: true
---

# Stormworks Fandom 知识库工具

> 📌 **路径占位符（因机器而异，先解析再用）**：
> `<WS>` = 工作区根（`D:\STORMWORKS`）、`<HOME>` = 用户主目录（**含用户名**）、
> `<SW_SAVE>` = Stormworks 存档目录、`<PY>` / `<PYX>` = Python 解释器（纯标准库 / 带三方包）、
> `<SW_GAME>` / `<SW_WORKSHOP>` / `<STEAM_LIB>` = 游戏根目录 / 创意工坊 / Steam 库（**盘符与目录名都不固定**）。
> 解析：`python "<WS>/工作区导航/脚本/sw_paths.py"`（`--json` / `--write`）。
> 报 `MISS` 时按其排查建议定位后回写 `工作区导航\路径配置.json` 与
> `04_环境与外部依赖.md` §7。约定见 `工作区导航\07_路径占位符约定.md`。


把 [Stormworks Fandom Wiki](https://stormworks.fandom.com/) 变成**本地可检索的 AI 知识库**，
并让 AI 能高效地查它。

## 环境要求（重点）

**零第三方依赖。** 只用 Python 标准库（`urllib` / `html.parser` / `json`），
**不需要 pip install，不需要 requests / bs4 / lxml / markdownify**。
任何装有 Python 3.9+ 的机器都能直接跑（已实测 3.13 与 3.14）。

先确认有 Python：

```bash
python --version          # 或 python3 --version
```

若 `python` 不存在，用 `python3`；Windows 可用 `py -3`。下文一律用 `PY` 指代你找到的解释器。

脚本目录（下文用 `S` 指代）：`<WS>/技能库/stormworks-fandom-kb/scripts`

## 工作流：先查，后抓

**绝大多数情况下不需要抓取。** 先查本地库：

```bash
"$PY" "$S/wiki_query.py" stats                              # 库是否存在、规模、覆盖率
"$PY" "$S/wiki_query.py" search "modular engine cylinder"   # 全文检索（最常用）
"$PY" "$S/wiki_query.py" page "Camera gimbal"               # 看整篇
"$PY" "$S/wiki_query.py" attr "Camera gimbal"               # 只看部件规格表
"$PY" "$S/wiki_query.py" findattr "Logic inputs" --value infrared
"$PY" "$S/wiki_query.py" cat "Engines"
"$PY" "$S/wiki_query.py" titles --prefix "Camera"
```

`search` 支持 `--limit N`（默认 8）、`--json`（结构化输出，便于程序消费）、`--full`（输出整块原文）。
退出码：`0` 有结果，`3` 无匹配，`2` 知识库不存在。

**只有以下情况才抓取**：库不存在、条目缺失、或 `stats` 显示覆盖率明显落后于站点条目数。

## 抓取

```bash
# 冒烟测试：只抓 3 条，验证网络与解析正常
"$PY" "$S/wiki_crawl.py" --output "<WS>/数据库/stormworks_fandom" --max-pages 3

# 只抓指定条目（--title 可重复）
"$PY" "$S/wiki_crawl.py" --output "<WS>/数据库/stormworks_fandom" \
  --title "Camera gimbal" --title "Modular Engine Cylinder"

# 全站抓取（约 558 篇正文 + 重定向，1 秒限速约 10-15 分钟）
"$PY" "$S/wiki_crawl.py" --output "<WS>/数据库/stormworks_fandom"
```

**建议把知识库放在 `<WS>/数据库/stormworks_fandom`**（`wiki_query.py` 会自动探测该路径）。

常用参数：

| 参数 | 说明 |
|---|---|
| `--output DIR` | 输出目录（含断点状态，务必固定） |
| `--title T` | 精确标题，可重复 |
| `--category C` / `--category-depth N` | 按分类抓取（依赖 wiki 自身分类质量） |
| `--max-pages N` | 限制条数，冒烟测试用 |
| `--force` | 忽略修订状态强制重抓 |
| `--dry-run` | 只列出将抓取的条目 |
| `--no-wikitext` | 跳过 wikitext/infobox 提取（更快，但丢失结构化属性） |
| `--delay SEC` | 覆盖请求间隔（默认 1.0，不建议低于 1） |
| `--ignore-robots` | robots.txt 禁止时仍抓取（仅在有授权时使用） |

抓取是**增量可续跑**的：中断后重跑同一命令即可继续；修订号未变的条目自动跳过。

## 输出结构

```text
<output>/
├─ manifest.json        数据集摘要、站点版本、条目/分块/质量统计
├─ pages.jsonl          每页一条完整记录（结构化问答用这个）
├─ chunks.jsonl         RAG/向量库摄取文件（检索用这个）
├─ attributes.jsonl     部件属性表：page_id / title / attributes
├─ state.json           断点与修订状态
├─ failures.jsonl       失败记录（重跑会自动重试）
├─ crawl.log            运行日志
├─ records/             每页完整 JSON
├─ markdown/            每页可读 Markdown（人工审阅用）
└─ page_chunks/         每页独立分块
```

`pages.jsonl` 单条记录的关键字段：
`title` / `summary` / `attributes`（infobox 解析出的键值对）/ `categories` /
`sections` / `internal_links` / `images` / `tables` / `content.markdown` /
`wikitext` / `data_quality` / `source.{url,page_id,revision_id,license}`。

`chunks.jsonl` 单块字段：
`chunk_id` / `page_id` / `revision_id` / `title` / `section_path` /
`source_url` / `license` / `categories` / `text` / `estimated_tokens`。

## 站内数据结构（重要）

Stormworks wiki 的条目几乎都靠 `{{Infobox component|Mass=…|Cost=…|Logic inputs=…}}`
承载结构化参数。本工具**同时保留两种表示**：

- `attributes`：从 wikitext 解析的干净键值对 → 生成 `## Specifications` 表，**优先用这个**
- `content.markdown`：正文转成的 Markdown

为避免重复，成功提取 `attributes` 时会剔除渲染出的 infobox 表；
`--no-wikitext` 模式下则保留该表。

## 与其他工作区资产的配合

**翻译 Stormworks 专有名词时，必须先查本工作区的中英对照表，不得自行意译：**

```bash
"<PY>" \
  "<WS>/汉化相关/脚本/sw_check.py" --auto
"<PY>" \
  "<WS>/汉化相关/脚本/sw_lookup.py" "modular engine cylinder"
```

wiki 是英文社区维护的，**内容可能过时或不准确**；涉及中文表述时以汉化对照表为术语基准，
涉及游戏机制数值时以游戏内实测为准。本工具不翻译原文。

## 合规与边界

- 走官方 MediaWiki API（`api.php`）。站点 `robots.txt` 对 `User-agent: *` 明确
  `Allow: /api.php?action=`，同时禁止抓取 `/wiki/Special:`、`/wiki/Template:` 等命名空间。
  **不要去抓渲染后的网页外壳**。
- 内容许可 **CC BY-NC-SA**，所有记录与分块都保留了来源 URL、修订号和许可信息；
  再分发时需遵守署名与非商业条款。
- 默认 1 秒请求间隔、指数退避重试。不要为提速而去掉限速。

## 自测（无需联网）

```bash
"$PY" "$S/selftest.py"      # 32 项：HTML→Markdown、清洗、wikitext 解析、分块、溯源
"$PY" "$S/e2e_test.py"      # 10 项：内置模拟 API，跑完整抓取→检索链路
```

`e2e_test.py` 会在本机起一个临时 MediaWiki 模拟服务，覆盖 gzip、429 重试、
分页续跑、重定向、增量更新，不需要访问互联网。
