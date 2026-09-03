# sw-property-options — 部件选项枚举提取（载具 XML 属性 → 游戏内下拉文本）

## 解决的问题

载具 XML（`<SW_SAVE>\data\vehicles\*.xml`）中，部件的"游戏内下拉选项"以整数代号
存在 `<o>` 具名属性上（如 `m_sweep_mode="0"`、`gear_ratio="2"`）。游戏定义 XML
（`<SW_DEFS>\*.xml`，759 个）**完全不含**选项文本（实测 grep 零命中）。
本技能从游戏可执行文件静态恢复「属性名 → 有序选项文本」映射。

## 方法原理（2026-09-03 实测验证，两处 golden 独立验证通过）

1. **唯一数据源**：`<SW_GAME>\stormworks64.exe`
   - `.rdata`：字符串池（约 2.4 万条明文），选项串与所属属性键**物理相邻**（≤0x400）；
   - `.text`：属性注册逻辑，**对选项串的 RIP-relative `lea` 引用顺序 == 下拉枚举顺序**，
     同一属性选项的引用间隔 < 0x70（跨属性 > 0x100）。
2. **枚举键权威清单**（"%lld 签名"）：键串在 `.text` 连续引用两次且其后 0x80 内紧跟
   `'%lld'` 格式串（XML 反序列化宏展开）→ 92 个整型属性键 + 2 个人工扩展键
   （`gear_ratio_1/2`，模块化引擎变速箱，不走 %lld 签名）。
3. **锚定评分**：label-run +6（标签节点后连续选项段，代码序）、key@func +3、
   pool-min≤0x400 +2、label-nb +4（**仅首字母小写**的部件区标签邻域候选，上限 14 项）。
   候选选择：n 须 > 存档实测最大值；label-run > label-nb > key@func > pool-min。
4. **标签匹配**：`norm2(标签)==normkey(键)` 或词序子序列（`water type`⊂`water component type`，
   至少 2 词）；标签分「显示标签」（首字母大写，邻域含其它属性标签，不可靠）与
   「部件区标签」（小写，与选项/图标交错）。
5. **噪音过滤**：排除 `graphics/`、`meshes/`、`inventory_`、`main_ui`、含下划线、含句点、
   超长串；无载具实测且非比值簇 → 降级 todo（序列挪入 `candidates`）。
6. **人工策展层**：`数据/property_options_manual.json` 在自动提取后合并（manual 优先），
   用于有确凿 exe 簇证据但自动锚定覆盖不到的键（如 `property_ammo_type`）。
7. **校验**：golden 断言（`m_sweep_mode`、`gear_ratio`）失败即退出码 1；
   全部存档载具 `<o>` 取值须落在 `[0, n)`。

## ⚠ 已证伪的旧结论 / 陷阱

- **`1:1→1:2→1:4→1:8→1:16→1:32` 只是炮塔座圈/枢轴（`multibody_turret_*`、
  `multibody_pivot_*`、`multibody_compact_pivot_*`）的 `gear_ratio`**；
  发动机/动力系统变速箱是另外的属性：模块化引擎变速箱 `gear_ratio_1`/`gear_ratio_2`
  = 8 项 `1:-1/1:1/6:5/3:2/9:5/2:1/5:2/3:1`；`torque_clutch` 也写 `gear_ratio_2`。
- **`input_velocity` 不是枚举**（不在 %lld 清单，是浮点标量；存档实测出现 1 与 5）。
- 二进制字符串池的**物理顺序 ≠ 枚举顺序**（雷达例：池序 Clockwise,Static,Sweep,...
  vs 真序 Static,Clockwise,...）；只有**代码引用顺序**可信。
- 字符串池存在**跨属性共享串**（如两个变速箱共用 `'1:1'`），按"最大池距"判定会假阴性，
  必须按"最小池距 + 均值消歧"。
- PE 解析两处必坑：节表字段序 = Name/VirtualSize/VirtualAddress/SizeOfRawData/
  PointerToRawData；一切 VA 必须加 ImageBase（漏加 → 全盘假阴性）。

## 使用

```bash
PY="<PY>"
S="<WS>/技能库/sw-property-options/scripts"

"$PY" "$S/extract_property_options.py" --selftest   # 仅 golden 自检（退出码判定）
"$PY" "$S/extract_property_options.py"              # 全流程：提取+校验+JSON+MD
# 日常查询（推荐，已接入 sw_defs）：
"$PY" "<WS>/数据库/方块数据/脚本/sw_defs.py" options gear_ratio   # 单个属性
"$PY" "<WS>/数据库/方块数据/脚本/sw_defs.py" options              # 列出全部已解析
```

## 产出

- `<WS>\数据库\方块数据\数据\property_options.json`：
  `properties.{attr} = {label, options[], n, verified, evidence, components, note, candidates?}`
  - `verified`：`auto`（golden/强锚定）> `partial`（比值簇/有部件实测，建议复核）> `todo`（未解析）；
  - **只有 `options` 非空的才可用于解读载具 XML**；`todo` 的序列在 `candidates`，不可直接采信。
- `<WS>\数据库\方块数据\数据\property_options_自动提取.md`：自动表格。
- `<WS>\数据库\方块数据\22_部件选项枚举映射.md`：人读知识册（结论 + 方法 + 陷阱）。

## 红线

- 游戏目录**只读**（`open(path,'rb')`），绝不写入/修改 `<SW_GAME>`/`<SW_WORKSHOP>`；
- 产出一律写 `<WS>`；路径经 `工作区导航/路径配置.json` 解析，不硬编码；
- 游戏更新后重跑 `--selftest` 防地址漂移（算法基于相对顺序，理论稳定）。
