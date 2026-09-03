# Stormworks 中英对照表

由创意工坊简体中文汉化补丁（[BKN46/stormworks-translate-chn](https://github.com/BKN46/stormworks-translate-chn)）自动生成，
供**人和 AI** 在做 Stormworks 内容的中英互译时作为**唯一术语基准**。

- 生成时间：2026-09-03 00:47:07
- 数据源：`<SW_LANG_TSV>` = `<SW_WORKSHOP>\<工坊物品ID>\language.tsv`
  （**盘符与工坊物品 ID 都不固定**，由 `脚本/sw_locate.py` 按文件名搜索解析。
  本次实际读取：`E:\SteamLibrary\steamapps\workshop\content\573090\2019972792\language.tsv`；当前机器的解析结果见 `工作区导航\路径配置.json`）
- 条目总数：**8795**（部件 6089 + 界面文案 2706）
- 去重后英文词条：5144 ；待补翻：55

## 给 AI 的使用规则（重要）

0. **查表前先跑一遍新鲜度检查**（毫秒级，不会拖慢）：
   ```bash
   python 脚本/sw_check.py --auto
   ```
   上次更新超过 **7 天**，或创意工坊 `language.tsv` 内容发生变化时，它会自动重建对照表；
   否则什么也不做直接退出。状态码：`0`=最新，`2`=需要更新但未执行，`3`=失败。
1. 涉及 Stormworks 游戏内容（部件名、UI 文案、任务/剧情、Lua 与微控制器术语、地名生物名等）的**中译英或英译中**，
   一律**先查本目录的对照表**，采用其中的既有译法，不要自行意译。
2. 查表优先级：
   - 精确查：`数据/sw_core_dict.json`（EN→ZH 去重字典）
   - 关键字查：`python 脚本/sw_lookup.py "关键词"`（支持中英文、id、分类）
   - 整类浏览：`词典/部件_<模块>.md`、`词典/界面与文案.md`
   - 常用词很快就能在 `常用术语速查.md` 里找到，可整体读入上下文
3. 表中没有的词，才允许自行翻译，并应**沿用同族既有译法的用词习惯**（如 propeller→螺旋桨、rotor→旋翼/转子）。
4. 条目中 `###` 是游戏内的数值占位符；`[$[action_xxx]]` 是按键提示占位符，翻译时保留原样。
5. 汉化补丁本身存在少量错误，若发现明显误译，以游戏内实际功能为准，并在更新日志中记录。

## 自动更新机制（不依赖任何 AI 工具）

| 环节 | 说明 |
| --- | --- |
| **数据源** | 以创意工坊 `language.tsv` 为主（Steam 自动同步，最贴近游戏本体）；GitHub 上游仅在主数据源缺失时兜底 |
| **触发方式一** | Windows 定时任务 `StormworksGlossarySync`，**每天 10:00** 运行 `sw_check.py --auto`，开机错过会自动补跑 |
| **触发方式二** | AI 或用户手动执行 `python 脚本/sw_check.py --auto` |
| **是否重建** | 仅当「距上次更新 > 7 天」或「主数据源 SHA-256 变了」才重建，否则秒退，不产生日志噪音 |
| **时间节点** | 记录在 `数据/last_update.json`（`last_update` / `last_check` / 源文件 mtime·大小·哈希 / 条目统计） |

相关命令：

```bash
# 查看状态 / 需要则更新
python 脚本/sw_check.py                  # 只报告
python 脚本/sw_check.py --auto           # 过期就自动重建
python 脚本/sw_check.py --json           # 机器可读
python 脚本/sw_check.py --days 3         # 临时改用 3 天阈值
python 脚本/sw_check.py --force          # 无条件重建

# 手动完整同步（默认不联网，只用工坊文件）
python 脚本/update_glossary.py
python 脚本/update_glossary.py --use-github   # 额外抓 GitHub 做条目数对照
```

管理定时任务（PowerShell，需管理员身份可改其他用户）：

```powershell
Get-ScheduledTask StormworksGlossarySync      # 查看
Start-ScheduledTask StormworksGlossarySync    # 立即跑一次
Disable-ScheduledTask StormworksGlossarySync  # 暂停
Unregister-ScheduledTask StormworksGlossarySync -Confirm:$false   # 删除
```

> 任务以 S4U 方式注册（不保存密码、注销后也能运行）。因为不需要联网，功能不受影响。

## 目录结构

```
汉化相关/
├─ README_中英对照表.md      本文件（入口 + AI 规则）
├─ 常用术语速查.md           精简版，可整体读入
├─ 更新日志.md               每次同步的变更记录
├─ 词典/
│  ├─ 界面与文案.md          UI / 提示 / 剧情 / 地名 / 生物名
│  ├─ 部件_结构建材.md（432 条）
│  ├─ 部件_引擎与动力.md（1045 条）
│  ├─ 部件_流体系统.md（559 条）
│  ├─ 部件_电力与能源.md（81 条）
│  ├─ 部件_机械与传动.md（767 条）
│  ├─ 部件_逻辑与电路.md（416 条）
│  ├─ 部件_传感器与探测.md（435 条）
│  ├─ 部件_显示与控制.md（262 条）
│  ├─ 部件_通信与导航.md（247 条）
│  ├─ 部件_武器与军用.md（458 条）
│  ├─ 部件_结构与气动.md（115 条）
│  ├─ 部件_载具与交通.md（450 条）
│  ├─ 部件_座椅与载人.md（462 条）
│  ├─ 部件_工业加工.md（52 条）
│  ├─ 部件_任务与货物.md（308 条）
├─ 数据/
│  ├─ sw_glossary.jsonl      全量条目（每行一条 JSON，机器可读）
│  ├─ sw_glossary.tsv        全量条目（Excel / 人工校对）
│  ├─ sw_core_dict.json      EN→ZH 去重快查字典
│  ├─ last_update.json       更新时间节点与源文件指纹（新鲜度判定依据）
│  └─ 待补翻清单.txt
└─ 脚本/
   ├─ build_glossary.py      解析汉化补丁并生成全部文件
   ├─ update_glossary.py     以工坊文件为主源，比对 → 重建 → 写日志与状态
   ├─ sw_state.py            更新状态 / 源文件指纹 / 过期判定
   ├─ sw_check.py            新鲜度检查（过期则 --auto 重建）
   └─ sw_lookup.py           查询工具（过期会在 stderr 提示）
```

## 查询示例

```bash
python 脚本/sw_lookup.py "modular engine cylinder"   # 英文模糊查
python 脚本/sw_lookup.py --zh 螺旋桨                  # 中文反查
python 脚本/sw_lookup.py --id def_giga_prop_small_name
python 脚本/sw_lookup.py --cat 引擎与动力 --limit 40
```

## 数据字段说明（sw_glossary.jsonl）

| 字段 | 含义 |
| --- | --- |
| `id` | 汉化补丁中的标识，形如 `def_<族>_..._name`；UI 文案为空 |
| `kind` | `name` 部件名 / `desc` 详细说明 / `s_desc` 一句话简介 / `label` 逻辑节点·属性名 / `node_desc` 逻辑节点说明 / `ui` 界面文案 |
| `module` | 16 个模块之一，或 `界面文案` |
| `family` / `family_cn` | 部件族（英文 id 片段 / 中文名） |
| `topic` | UI 文案的主题分组 |
| `en` / `zh` | 英文原文 / 简体中文译文 |
| `state` | `ok` 已译 / `todo` 待补翻 |
