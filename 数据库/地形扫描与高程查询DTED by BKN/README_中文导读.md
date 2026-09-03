# 地形扫描与高程查询（DTED）by BKN · 中文导读

> **AI 阅读规则（先读这段，先于正文）**
> - 本目录是 BKN46 的 `bkn-stormworks-utils` 仓库 `sw-dted-scan` 子目录的**原样收录**
>   （来源提交 `54fcd2b`，2026-07-11，MIT 许可），外加本篇中文导读。
> - 原始算法文档为 `algorithm_en.md`（英文），本导读是其要点中文化 + 工作区知识册交叉引用，
>   **不替代原文**；要精确参数（性能表、精度表）以 `algorithm_en.md` 为准。
> - 这是工作区**唯一**的「地形数据离线处理」材料，与 `方块数据/17_传感器与雷达.md`（雷达/声纳解算）、
>   `数据库/SW示波器v0.1.3`（httpGet 数据上传链路）互补。

## 这是什么

一条**从游戏内扫描地形 → 离线压缩 → 数据嵌回载具微控制器 → 游戏内实时查询任意 (x,z) 处高程**的完整管线。
游戏本身不提供"查任意点地形高程"的 API（`server.getOceanFloor` 只给海底），这套方案用
扫描无人机 + 点云压缩绕过了该限制，可用于地形匹配导航、巡航导弹地形跟随、地图绘制等。

## 五个阶段与对应文件

| 阶段 | 文件 | 说明 |
| --- | --- | --- |
| ① 游戏内扫描 | `scanner_drone.xml` | 扫描无人机载具存档（含结构方块 + 激光距离传感器 + httpGet 上传链路） |
| ② 数据落地 | `flask_server.py` | Flask 本地服务，`/send` 端点接收游戏 httpGet 上传（与示波器同模式） |
| ③ 点云清洗 | `dted_analysis.py` | NumPy + 并查集（Union-Find）合并近邻重复点，matplotlib 可视化 |
| ④ 压缩 | `compress_terrain.py` | 残差网格化 + Base62 编码（核心算法，见下节），输出 `.dat` + `meta.json` + 可嵌入 `.lua` |
| ⑤ 嵌入与查询 | `xml_assemble.py` + `terrain_query_sw.lua` | 压缩数据按 **4000 字符**切片写入微控属性，游戏内 Lua 分帧加载后 O(1) 查询 |

`benchmark.lua` / `test_sw.lua`：查询引擎的性能与正确性测试。

## 核心算法（压缩 + 查询）

**压缩**（`compress_terrain.py`，两级压缩，实测压缩率 31.4%）：

1. 把点云按 `RESOLUTION`（默认 20 m）网格化，每格存平均高度 `h_avg`（基础高度）；
2. 每点残差 `δ = y − h_avg`，仅保留 `|δ| ≥ 阈值`（默认 0.5–1.0 m）的**显著残差**（实测约 16% 的点）；
3. 数值先放大取整（高度精度 0.2 m）再转 **Base62** 文本，比十进制文本再省约 30%。

**查询**（`terrain_query_sw.lua`，游戏内）：

```
(x,z) → 网格索引 O(1) → LRU 缓存（128 格）→ 基础高度 h[gx][gz]
      → 残差 IDW 插值（高斯权 exp(-d²/r²)，避免 sqrt）→ y = h + δ
```

网格或残差缺失时，用 3×3 邻域均值/邻域残差兜底；查询点出界返回 `-1`。

## 值得学习的工程手法（SW Lua 通用）

1. **微控属性分帧加载**：`dat_file_num=925` 条属性文本，每 tick 只读 50 条属性、每 tick 只解析 150 行
   （`process_init` 状态机），否则初始化会卡死/超时——这是把大数据塞进脚本方块的标准姿势。
2. **`table.concat` 拼接**：大量字符串拼接严禁 `str = str .. part`，用 `table.concat` 一次连接（源码内注释明确强调）。
3. **4000 字符切片**：`xml_assemble.py` 按 4000 字符切数据块。与本项目示波器实测的
   **httpGet URL 上限 ≈ 4096 字符**互相印证（见项目记忆 2026-09-02），两者都卡在同一量级。
4. **懒加载 + LRU**：数据用不到不解析，解析结果按格缓存，查询均摊 O(1)。

## 与工作区其他材料的交叉引用

| 相关问题 | 去查 |
| --- | --- |
| httpGet 上传链路、URL 长度陷阱 | `数据库/SW示波器v0.1.3/` + 项目记忆「SW示波器 DataRecord 程序陷阱」 |
| 雷达/声纳获得目标位置（世界系解算） | `数据库/方块数据/17_传感器与雷达.md` |
| 矩阵/坐标变换的最小实现 | `数据库/Lua/_原始资料/BKN工具集_Lua参考实现/sw-bases/` |
| 附加 Lua 侧的海洋/地形 API（`getOceanFloor` 等） | `数据库/Lua/lua总体设定/01_addon_Lua_API速查.md` |
| 载具 XML 解读（scanner_drone.xml 的 d 值） | `数据库/方块数据/脚本/sw_vehicle.py` |

## 复现路线（简述）

1. `scanner_drone.xml` 放入载具目录（或用 `sw_vehicle.py stats` 先研究其构成）；
2. 运行 `flask_server.py`，游戏内飞无人机扫描，产出 CSV；
3. `dted_analysis.py` 清洗 → `compress_terrain.py` 压缩 → `xml_assemble.py` 切片生成属性 XML；
4. 把切片属性与 `terrain_query_sw.lua` 逻辑合入自己的微控制器，`terrain_h(x,z)` 即为查询接口。

上游仓库：<https://github.com/BKN46/bkn-stormworks-utils>（`sw-dted-scan/` 子目录）
