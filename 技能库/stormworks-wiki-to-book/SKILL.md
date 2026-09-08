---
name: stormworks-wiki-to-book
description: 把 Stormworks Fandom Wiki 的一个页面族（如 Gameplay/Mechanics、Gameplay/Workbench/Components、Search and Destroy DLC）抓取并整理成「对 AI 注意力友好」的中文知识册，落到 数据库/ 下。涉及 Stormworks wiki 抓取、部件/武器参数整理、中英术语批量核对时使用。
agent_created: true
---

# Stormworks Wiki → 中文知识册

> 📌 **路径占位符（因机器而异，先解析再用）**：
> `<WS>` = 工作区根（`D:\STORMWORKS`）、`<HOME>` = 用户主目录（**含用户名**）、
> `<SW_SAVE>` = Stormworks 存档目录、`<PY>` / `<PYX>` = Python 解释器（纯标准库 / 带三方包）、
> `<SW_GAME>` / `<SW_WORKSHOP>` / `<STEAM_LIB>` = 游戏根目录 / 创意工坊 / Steam 库（**盘符与目录名都不固定**）。
> 解析：`python "<WS>/工作区导航/脚本/sw_paths.py"`（`--json` / `--write`）。
> 报 `MISS` 时按其排查建议定位后回写 `工作区导航\路径配置.json` 与
> `04_环境与外部依赖.md` §7。约定见 `工作区导航\07_路径占位符约定.md`。


把一个 wiki 页面族变成可长期复用的中文知识册。已在四个页面族上验证：
`Gameplay/Mechanics`（13 篇）、`Gameplay/Workbench/Components`（18 份文档）、
`Search and Destroy DLC`（1 册 + 弹道参考实现）、
日文 wikiwiki.jp/sbarjp 传感器与雷达（17 册，见「日文 wikiwiki.jp」节）。

## 铁律（违反即返工）

**所有中文名必须来自 `<WS>\汉化相关\` 对照表，禁止凭语感意译。**
未收录的标 `※`，数值存疑的标 `⚠`，两者都要在文末汇总成清单。

## 流程

### 1. 先确认页面存在（别抓空气）

抓之前先用 API 探一遍，MediaWiki 对不存在的页面不报错、直接给空结果：

```bash
PY="<PY>"
"$PY" -c "
import urllib.request,urllib.parse,json
API='https://stormworks.fandom.com/api.php'
def q(**p):
    p.setdefault('format','json'); p.setdefault('formatversion','2')
    r=urllib.request.Request(API+'?'+urllib.parse.urlencode(p),
        headers={'User-Agent':'Mozilla/5.0 (compatible; SW-KB/1.0)'})
    return json.load(urllib.request.urlopen(r,timeout=30))
d=q(action='query',prop='info|revisions',rvprop='ids|timestamp',titles='|'.join(TITLES))
for p in d['query']['pages']:
    print('缺失' if p.get('missing') else '存在', p['title'], p.get('pageid'), p['revisions'][0]['revid'])
"
```

也用它做全文检索找关联页：`q(action='query',list='search',srsearch='关键词',srlimit=25,srnamespace=0)`。

⚠ **易错点**：wiki 里大量链接指向不存在的页面（如 `Weapon_DLC`、`Wiki/Building/Components/Weapons`）。
`Components/Search and Destroy` 是**空页面**，武器数据在独立的 `Search and Destroy DLC` 页。

### 2. 抓取

零依赖爬虫（纯标准库，任意 python3 可跑）：

```bash
PY="<PY>"
CRAWLER="<WS>/技能库/stormworks-fandom-kb/scripts/wiki_crawl.py"

"$PY" "$CRAWLER" --prefix "Gameplay/Workbench/Components" --dry-run --verbose   # 先干跑
"$PY" "$CRAWLER" --title "页面A" --title "页面B" --output "<输出目录>" --verbose
```

- `--prefix` **用空格不用下划线**（`Search and Destroy DLC`，写成下划线选中 0 页）。
- 断点续跑靠 `state.json`；加 `--title` 重跑不会重抓已有页面。
- `robots.txt unreadable (403)` 是**正常的**，不影响抓取，别去修。
- 抓完用同目录 `wiki_query.py` 检索（见 `技能库/stormworks-fandom-kb/`）。
- 2026-09-08 仓库瘦身：旧 requests/bs4 版爬虫（原 `AI相关/stormworks_fandom_kb/`）已移除，
  本版为参数兼容的等价替代（`--prefix/--title/--output/--dry-run/--force` 用法不变）。

#### 日文 wikiwiki.jp（**不是 MediaWiki，别用上面那套**）

`wikiwiki.jp` 是 YukiWiki 系，**没有 `api.php`**，Fandom 爬虫完全用不了。专用脚本：

```bash
PYV="<PYX>"
S="<WS>/技能库/stormworks-wiki-to-book/scripts/wikiwiki_crawl.py"

"$PYV" "$S" --wiki sbarjp --list-pages                       # 枚举全部页面（sbarjp 有 131 页）
"$PYV" "$S" --wiki sbarjp --page "SENSORS" --page "X/Y" --output "<输出目录>"
```

- 正文在 `div#content`（回退 `div#body`）；侧边栏 `div#contents` 不抓。
- 页面名需 **UTF-8 percent-encoding**；抓取间隔 1.5 s（礼貌抓取）。
- ⚠ **正文内 `::cmd/edit` 是分节编辑链接，必须剔除**——否则会误判成「几十个子页面」。
  实测 SENSORS 页 48 个链接里 37 个是它，**实际无子页面**。
- robots.txt：`Disallow: /*?` 与 `/*/::*`，只取纯页面 URL 就天然合规（不用特殊处理）。
- 日文 wiki 的**汉字名不是中文名**，中文一律回查对照表（见铁律）。

### 3. 术语批量核对（三级流程）

`sw_lookup.py` 一次只能查一词，整页几十个部件名要跑几十次。用这两个：

```bash
PY="<PY>"
S="<WS>/汉化相关/脚本"

"$PY" "$S/sw_check.py" --auto                       # 先做新鲜度检查（毫秒级）
"$PY" "$S/sw_batch.py" terms.txt --limit 2          # 批量：输出 HIT / FUZZY / MISS
"$PY" "$S/sw_find.py" Motor --parts-only --limit 8  # 兜底同义词检索
```

1. `sw_batch.py`（精确 → 包含匹配）
2. MISS 的用 `sw_find.py` 找同义词，再拿游戏内名回查
3. 仍无对应才标 `※`

⚠ **`sw_find.py` 多关键词是 OR 匹配**：`sw_find.py Sea Mine` 会命中 `def_seat_*`（"Sea" 子串）。
要精确就用**单个**关键词。

⚠ **wiki 名 ≠ 游戏内名**，这是命中率低的根因（~50% → 90%+）：
- 词序相反：`Motor Small` ↔ `Small Electric Motor`、`Rocket Booster Huge` ↔ `Huge Rocket Booster`
- 括号位置：`Wheel 3x3 Suspension` ↔ `Wheel 3x3 (Suspension)`

**最省事的一招**：直接按 id 前缀从 `汉化相关/数据/sw_glossary.jsonl` 导出整块权威部件名，
比逐个查快且准（部件名取 `def_*_name`，节点标签取 `def_*_node_*_label`）：

```bash
"$PY" -c "
import json,io,sys; sys.stdout.reconfigure(encoding='utf-8')
rows=[json.loads(l) for l in io.open('<WS>/汉化相关/数据/sw_glossary.jsonl',encoding='utf-8') if l.strip()]
for r in sorted(rows,key=lambda r:r['id']):
    i=r.get('id') or ''
    if i.startswith('def_gun') and i.endswith('_name'):
        print(f\"{i:44s} {r.get('en',''):40s} → {r.get('zh','')}\")
"
```

⚠ **译名有两套时取部件名**（`def_*_name`）。例：`Artillery Cannon` 通用词条命中「榴弹炮」，
但部件名是「**大型**榴弹炮」；`Chest Rig` 有「战术胸挂」与「胸挂」两套。

### 4. 写文档（对 AI 注意力友好的格式）

- **规则前置**：把「AI 阅读规则」放在**标题之前的引用块**里，先于正文被读到。
- **分层冗余**：`README.md`（索引 + 时效性表 + 原文错漏清单 + 重抓命令）
  → `00_速查_总表.md`（一张表覆盖全册）→ 分主题册 → `术语对照_本册.md` → `原始抓取/`。
- **三态标记**：`⚠` 数值存疑 / `※` 对照表未收录的自译 / `✅` 已核对。
- **命令给绝对路径**，且区分两个 python：
  managed `versions/3.13.12/python.exe`（零依赖脚本）vs `envs/default/Scripts/python.exe`（旧爬虫）。
- **时效性单独列表**：pageid + rev + 页面内标注版本。修订号高 ≠ 内容新。
- **原文错漏单独列一节**，照录不擅自修正，包括 wiki 的拼写错误、单位存疑、Placeholder 空缺、
  已移除部件、汉化补丁的错字。
- **数值密集的主题（如弹道）额外给参考实现**，并做「模型 vs 标称」对照表验证自洽性。

### 5. 接入索引（容易漏）

新册写完后必须回头改三处，否则后续会话找不到：

- `README.md`：文档索引表 + 「本册怎么用」速查表 + 时效性表 + 目录树
- `00_速查_总表.md`：新增分类代号与部件表
- `术语对照_本册.md`：新增术语节 + 汉化陷阱表

根目录 `CODEBUDDY.md` / `AGENTS.md` 是五层 AI 引导体系的两层，
新增**册**时也要在那里的「先查这两册中文知识库」表里加一行。

## 已知的 wiki 缺陷清单（复用，别重复踩）

- `Components/Search and Destroy`、`Components/Space` 是空页面
- `Windows` 页的「List of all window types」是 Placeholder
- 三种声纳都写作 `Smal Sonar`；射程单位写 km —— ✅ **已核实出自游戏内 s_desc，不是笔误**
  （但数值远超地图尺度，有效距离仍需实测；**旧版声纳只有 3000 m**）
- **Fandom `Sensors` 页对雷达只写「可探测半径内的载具与人员」，无任何射程与参数**。
  雷达/声纳的准确数据只能从**游戏内 `_desc`/`_s_desc`** 与日文 wiki 补齐。
- `Pipe Angle Corner` 与 `Pipe T-Piece Corner` 都写作 `Pipe T-Pice Corner`（且拼错）
- `Propulsion` 页残留一个游离的 `}}`
- `Weapons Research` 页表格有重复行（同一部件出现 3~4 次）
- 汉化补丁错字：`火旱枪`、`水下火旱枪`（应为焊枪）；`Artillery Cannon Belt (Corner Outer)` 译文漏字
- `Magnet` 在 Mechanics 页列出但对照表无对应，疑已移除

## 弹道计算（若涉及武器）

参考实现就在 `数据库/方块数据/弹道计算参考/`（`ballistics.py` + `ballistics.lua`），直接复用。

- **弹丸重力 30 m/s²**（V1.3.6 起），**载具重力是精确的 10** —— 混用是最常见的错
- **60 tick/s**；阻力逐 tick `v ← v × (1-k)`，**不适用于弹头**
- **射程随仰角非单调**：插值表必须截断在低伸分支，否则解算取到高抛那一支
- **降表不能用 ½gt²**：阻力同样衰减垂直分量，实际下坠约为该式一半
- 机枪的 k / 存活 tick / 标称射程三者自相矛盾（模型 1198 m vs 标称 500 m）

## 传感器与雷达（若涉及解算 / 制导）

完整内容在 `数据库/方块数据/17_传感器与雷达.md`，写相关代码前先读它。要点：

- ⚠ **两套坐标系，Y/Z 轴是反的**（最高频 bug 源）：
  GPS 系 X=东/**Y=北**/**Z=高度**；物理传感器系 X=东/**Y=铅直上**/**Z=北**。
  换算 `GPS_X=PS_1, GPS_Y=PS_3, GPS_Z=PS_2`。欧拉角是 **Z-Y-X 序**。
- 物理传感器**不接电就没有坐标输出**。
- ⚠ **角度单位是「圈」不是弧度**，喂给 `math.sin/cos` 前必须 ×2π。
  **日文 wiki 的目标解算示例代码就漏了这一步（真 bug）**，照抄会完全算错。
- ⚠ **Stormworks 的坐标约定与教科书相反**：角度以 Y 轴为基线、顺时针为正。
  2D `(x,y)=(r·sinθ, r·cosθ)`；3D `(x,y,z)=(r·cos仰·sin方, r·cos仰·cos方, r·sin仰)`。
- 雷达误差 距离 ±1% / 角度 ±0.001 圈。滤波用 **ABF(α-β)** 而非 LPF（实测差 25 倍），
  **β ≈ α/10**，β=α 时速度估计会崩。滤波加在**算完的坐标**上，不是原始距离/角度上。
- ⚠ **新旧雷达 Radar Data 通道顺序不同**：旧 = 距离·信号强度·仰角·方位角；
  **新 = 距离·方位角·仰角·时间(tick)，且新雷达没有信号强度**。
- 声纳是 **16 目标 × 2 值且只有角度无距离**（雷达是 8 目标 × 4 值含距离），别照抄雷达代码。
- **新雷达具体射程未知**（游戏内只有 long/short 定性描述），需实测。

**给参考实现做数值验证**（本 skill 的做法，很有价值，建议沿用）：
wiki 的代码不要直接抄，先离线验一遍再放进知识册。
例：对旋转矩阵查正交性、行列式=+1、保长性、零姿态恒等；
对滤波器跑一遍带噪仿真对比收敛误差。验证结论写进文档，读者才知道能不能信。
