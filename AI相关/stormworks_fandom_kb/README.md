# Stormworks Fandom 知识库抓取工具

面向 AI / RAG 知识库的数据采集工具。它通过 Fandom 提供的 **MediaWiki API** 枚举并读取
`https://stormworks.fandom.com/wiki/Stormworks_Build_and_Rescue_Wiki` 所属 Wiki 的主命名空间条目，
不会抓取带广告、导航栏和推荐卡片的完整网页外壳。

## 主要能力

- 默认枚举主命名空间（当前站点约 558 篇正文条目）
- 遵守 `robots.txt`，默认每次请求至少间隔 1 秒
- 对 429 / 5xx / 网络错误自动限次重试并指数退避
- 断点续跑：每页处理完成后立即保存；修订号未变化时自动跳过
- 正文清洗：移除目录、编辑按钮、脚注区、视频嵌入、存根提示等模板噪声
- 保留标题层级、列表、链接、图片元数据和表格结构
- 识别重定向条目并保存别名到目标条目的映射
- 同时生成页面级 JSON、Markdown、全量 JSONL 和适合向量知识库的分块 JSONL
- 每条记录保留来源 URL、页面 ID、修订 ID、修订时间、抓取时间与许可信息

## 环境准备

推荐使用 WorkBuddy 托管的 Python 3.13 虚拟环境：

```bash
"<PYX>" -m pip install -r "<WS>/AI相关/stormworks_fandom_kb/requirements.txt"
```

也可使用其他 Python 3.11+ 虚拟环境。不要把依赖安装到系统全局 Python。

## 快速验证

先只抓取 3 个条目：

```bash
"<PYX>" \
  "<WS>/AI相关/stormworks_fandom_kb/stormworks_fandom_crawler.py" \
  --max-pages 3
```

只抓取指定条目（参数可重复）：

```bash
"<PYX>" \
  "<WS>/AI相关/stormworks_fandom_kb/stormworks_fandom_crawler.py" \
  --title "Stormworks: Build and Rescue" \
  --title "Wiki/Guides/Engine"
```

仅查看将要处理的条目，不抓取正文：

```bash
"<PYX>" \
  "<WS>/AI相关/stormworks_fandom_kb/stormworks_fandom_crawler.py" \
  --dry-run --max-pages 20
```

## 完整抓取

```bash
"<PYX>" \
  "<WS>/AI相关/stormworks_fandom_kb/stormworks_fandom_crawler.py"
```

默认输出到工具目录下的 `output/`。再次运行同一命令会先读取 `state.json`，只抓取新增条目或
修订号发生变化的条目。需要无条件重新抓取时添加 `--force`。

指定输出位置：

```bash
"<PYX>" \
  "<WS>/AI相关/stormworks_fandom_kb/stormworks_fandom_crawler.py" \
  --output "<WS>/数据库/stormworks_fandom"
```

## 范围筛选

```text
--title TITLE              精确条目标题；可重复
--category CATEGORY        抓取某类别中的主命名空间条目
--category-depth N         递归进入子类别的深度，默认 1
--prefix PREFIX            仅保留指定标题前缀
--exclude-pattern REGEX    排除匹配正则表达式的标题
--namespace N              MediaWiki 命名空间，默认 0（正文）
--max-pages N              最多处理 N 页，适合冒烟测试
--force                    忽略本地修订状态，强制重新抓取
--dry-run                  只列出页面，不读取正文
--verbose                  输出调试日志
```

类别模式依赖 Wiki 自身的类别维护质量。若目标是建立完整参考库，建议使用默认的主命名空间全量模式。

## 输出结构

```text
output/
├─ manifest.json          数据集摘要、站点版本、条目/分块/质量统计
├─ pages.jsonl            最新页面记录集合，每行一个 JSON 对象
├─ chunks.jsonl           RAG/向量库摄取文件，每行一个带来源信息的文本块
├─ state.json             断点与页面修订状态
├─ failures.jsonl         失败记录；后续再次运行会自动重试失败页
├─ crawl.log              运行日志
├─ records/               每个页面一个完整 JSON，文件名为 page_id
├─ markdown/              每个页面一个可读 Markdown 文件
└─ page_chunks/           每页独立的分块 JSONL
```

### 推荐给 AI 的文件

1. **向量检索 / RAG**：直接导入 `chunks.jsonl`。
2. **结构化问答**：使用 `pages.jsonl`，可读取类别、章节、表格、链接和图片元数据。
3. **人工审阅或 Markdown 知识库**：使用 `markdown/`。
4. **增量同步程序**：读取 `manifest.json` 与 `state.json`。

`chunks.jsonl` 的关键字段：

```json
{
  "chunk_id": "549:3924:0",
  "page_id": 549,
  "revision_id": 3924,
  "title": "Wiki/Guides/Engine",
  "section_path": ["Engine"],
  "source_url": "https://stormworks.fandom.com/wiki/Wiki/Guides/Engine",
  "license": "CC BY-NC-SA",
  "categories": ["Guides"],
  "text": "# Wiki/Guides/Engine\n\nSection: Engine\n\n...",
  "content_sha256": "..."
}
```

## 配置

`config.json` 中可以调整：

- 请求间隔、超时和最大重试次数
- 分块字符数与重叠字符数
- HTML 清洗选择器
- 需要移除的模板提示文本

建议保持请求间隔不低于 1 秒。站点结构变化时，优先修改 `config.json`，无需修改主程序。

## 常见问题

### robots.txt 返回 403

Fandom 对非浏览器 User-Agent 请求 `/robots.txt` 会返回 **403**，但该文件本身对
`User-agent: *` 是 `Allow: /api.php?`，而本工具只调用 MediaWiki API。

因此 `verify_robots()` 对 robots.txt 只做**单次尝试**；读取失败时记录一条 WARNING
并按 `config.json` 里配置的最小请求间隔继续运行，不会中断抓取。
只有「robots.txt 能读到、且明确禁止访问 API」时才会中止。

看到下面这条日志是正常现象，不是错误：

```text
WARNING | robots.txt unreadable (403 Client Error: Forbidden ...); continuing with
the configured 1.0s request delay because this crawler only calls .../api.php
```

## 数据许可与使用边界

工具代码本身不包含 Wiki 正文。抓取结果来自 Fandom 的 Stormworks Wiki，API 当前报告内容许可为
**CC BY-NC-SA**。输出中已保留原页面 URL、修订 ID和许可链接；发布、分享或再分发知识库时仍需
遵守原站许可及署名要求。

Wiki 内容由社区维护，可能过时或不准确。用于中文资料时，Stormworks 专有名词应另行对照本工作区
`<WS>/汉化相关/` 的术语基准表；本工具不擅自翻译原文。

## 测试

```bash
"<PYX>" \
  "<WS>/AI相关/stormworks_fandom_kb/test_transform.py"
```

离线测试覆盖正文清洗、表格/链接/图片保留、RAG 分块溯源和增量输出。在线抓取还取决于当前网络
能否访问 `stormworks.fandom.com` 及其 `api.php`。
