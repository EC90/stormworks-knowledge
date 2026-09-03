# 汉化相关 · 目录记忆

你正在操作 **Stormworks 中英对照表** 的目录。它是本工作区的术语基准，
由创意工坊简体中文汉化补丁 `language.tsv` 自动生成。

## 改动本目录前须知

1. **不要手改 `README_中英对照表.md` / `常用术语速查.md` / `词典/*.md`**——
   这些都是 `脚本/build_glossary.py` 的生成物，下次重建会被覆盖。
   要改内容，改 `脚本/build_glossary.py` 里的模板或分类映射。
2. `数据/sw_glossary.jsonl`、`数据/sw_glossary.tsv`、`数据/sw_core_dict.json`、`数据/_snapshot.jsonl`
   同为生成物，不要手工编辑。
3. `数据/last_update.json` 是状态文件（更新时间节点 + 源文件指纹），由脚本维护。
4. `数据/_cache/` 只保留最近 3 份 GitHub 上游缓存，可安全删除。

## 常用命令

```bash
PY="<PY>"     # 由 工作区导航\脚本\sw_paths.py 解析；没有托管 Python 时系统 python 3.8+ 亦可

"$PY" 脚本/sw_check.py --auto          # 新鲜度检查 + 按需重建
"$PY" 脚本/update_glossary.py          # 强制完整同步（默认只用工坊文件）
"$PY" 脚本/build_glossary.py           # 只重建，不做增量比对
"$PY" 脚本/sw_lookup.py "关键词"        # 查询
```

## 完整规则

见根目录 `<WS>\术语对照指南.md`（`D:\STORMWORKS\术语对照指南.md`）与本目录 `README_中英对照表.md`。

> 📌 路径占位符（`<WS>`/`<PY>`…）含义与解析见 `工作区导航\07_路径占位符约定.md`。
