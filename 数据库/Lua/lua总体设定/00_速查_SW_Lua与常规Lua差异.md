> **AI 阅读规则（先读这段，先于正文）**
> 本册只讲一件事：**Stormworks Lua 和标准 Lua 不一样的地方**。标准 Lua（5.1/5.3 通用写法）在 SW 里踩的坑，全在这里。
> 阅读顺序：先扫「差异总表」建立直觉，再按需看各节陷阱。所有结论来自 `原始抓取_*/`，标注 ⚠ 的是高概率 bug 源。

# Stormworks Lua 与常规 Lua 的关键差异

Stormworks 用的是 Lua 5.3 语法（全局函数 `pairs/ipairs/next/tostring/tonumber/type` + `math/table/string` 库），
但运行环境是**游戏沙盒**，不是通用解释器。下面按「踩坑频率」排序。

## 差异总表（一眼版）

| # | 差异点 | 标准 Lua | Stormworks Lua | 坑级 |
| --- | --- | --- | --- | --- |
| 1 | 执行端 | 单进程 | **同时跑在 server 和每个 client** | 🔴高 |
| 2 | 主循环 | `while` 死循环 | `onTick()` 每物理帧（~60Hz）回调 | 🔴高 |
| 3 | 画图 | 无内置 | `onDraw()` 每渲染帧回调，与 `onTick` 严格分离 | 🔴高 |
| 4 | 超时 | 看你机器 | `onTick`/`onDraw` >16ms 拖慢游戏，>100ms **丢弃本次计算**；附加 Lua 总上限 1000ms | 🔴高 |
| 5 | 坐标系 | 右手系习惯 | 世界系 **Y=垂直轴**；矩阵 4×4；角度单位是「圈」不是弧度 | 🔴高 |
| 6 | `math.atan2` | 存在（两参数） | **不存在**；用 `math.atan`（支持 1 或 2 参数）代替 | 🟠中 |
| 7 | `table.maxn` | 存在 | **未实现** | 🟢低 |
| 8 | `#` / `ipairs` | 通用 | **只对从 1 起始的连续表安全**；稀疏/非连续表返回 0，要用 `pairs` + 计数函数 | 🔴高 |
| 9 | 持久化 | 文件/全局 | 存 `g_savedata` 表 → 自动读写 `lua_data.xml` | 🟠中 |
| 10 | HTTP | `socket`/库 | 仅 `async.httpGet` + `httpReply`，**只能连本机 localhost 端口**，1 请求/tick 排队 | 🟠中 |
| 11 | `print` | 标准输出 | **不支持**；用 PonyIDE/VSCode 调试器 | 🟢低 |
| 12 | 沙盒 | 系统调用 | 禁系统调用；写崩游戏是**你自己的责任**（开发者明示） | 🟢低 |
| 13 | 源码字符集 | 任意 UTF-8 | **仅 ASCII**；中文/日文/反斜杠 `\` 都非法（中文显示须走本机 unicode 后端） | 🔴高 |
| 14 | 源码长度 | 任意 | **单脚本方块上限 8192 字符**（含空格换行）；超长截断/拒存 | 🔴高 |
| 15 | 多人变量同步 | 共享内存 | 脚本级变量**在 server/client 间不同步**；纯 Lua 状态机在多人易异步漂移 | 🔴高 |
| 16 | 专属全局 `property` | 无 | 脚本 Lua 可读**属性滑块** `property.getBool/getNumber/getText(index)`（编辑器给方块设的滑块值） | 🟢低 |
| 17 | 专属全局 `map` | 无 | 脚本 Lua 有 `map.mapToScreen` / `map.screenToMap` 做地图坐标↔屏幕坐标换算 | 🟢低 |

## 1. 双端执行（server + client 各跑一份）⚠

- Lua 脚本在**服务端**和**每个客户端**都执行一份。复合信号 `input/output` 是同步的，但**屏幕输出不同步**。
- 典型 bug：`math.random()` 在 server 和 client 产生**不同序列** → 多人游戏里两端状态漂移。需要随机数时，务必用确定性的、基于 tick 计数的伪随机，或只在某一端执行。
- 载具离太远会被卸载（despawn）；重新靠近时 **Memory 方块的值会恢复，但 Lua 脚本会重置**（等效于从工作台重新加载）。需要持久数据 → 用 Memory 方块，或用附加 Lua 的 `g_savedata`（见第 9 节）。
- **确定性随机的官方手段**：不要用 `math.random()`（双端不同序列）。附加 Lua 可用 `server.getTimeMillisec()` 取系统时间戳作种子，或基于 `onTick` 累计 tick 数构造伪随机；脚本 Lua 则用复合信号/外部设备同步。

## 2. onTick 与 onDraw 严格分离（脚本 Lua）⚠

脚本 Lua（载具方块）只有两个主回调，且**权限互斥**：

```lua
function onTick()   -- 每物理帧调用，~60Hz（大载具/多人会掉到更低）
    -- 只能读/写复合信号：input.getNumber/setNumber, getBool/setBool
    -- 禁止调用任何 screen.* 函数（会报错）
end

function onDraw()   -- 每渲染帧调用，取决于 FPS（无 vsync ~60Hz / 有 vsync ~30Hz）
    -- 只能画 screen.* ；禁止访问 input/output
    -- 每个连接的显示器各调用一次（5 个屏 = 一帧调 5 次）
end
```

- 数据从 `onTick` 算好、**存成变量**，`onDraw` 里读变量来画。两者不能直接跨调用共享局部状态以外的东西（脚本级变量是共享的，但时序要自己管）。
- 显示器分辨率按屏尺寸不同 → 用 `screen.getWidth()/getHeight()` 自适应，别写死像素。
- ⚠ `onDraw` 首次运行（或游戏暂停时）`onTick` 可能还没跑过 → `onTick` 里算好的变量可能**尚未初始化（nil）**。`onDraw` 开头务必做 nil 守卫（如 `if t1==nil then return end`），否则首帧/暂停恢复瞬间会报错或画错（见社区脚手架的 `if t1==nil then return true end` 写法）。

## 3. 超时硬限制 ⚠

| 场景 | 阈值 | 后果 |
| --- | --- | --- |
| `onTick` / `onDraw` 单次执行 | > 16 ms | 开始拖慢游戏物理 / FPS |
| `onTick` / `onDraw` 单次执行 | > 100 ms | **游戏丢弃本次函数，已算的全废** |
| 附加 Lua 整体 | 1000 ms 上限 | 开发者提醒：仍可能拖垮游戏，效率是你自己的责任 |

→ 重活（寻路、大表遍历）**必须分 tick 做**，不要一帧算完。

## 4. 坐标系：Y 是垂直轴，位置用 4×4 矩阵 ⚠

- 世界系矩阵/向量 **Y = 高度**（与多数图形学「Y 水平、Z 垂直」相反，也和 SW 物理传感器系的约定不同——物理传感器系见 `数据库/方块数据/17_传感器与雷达.md`）。
- 位置一律用 `matrix`（`matrix.translation(x,y,z)` 造一个，`matrix.position(m)` 取回 `x,y,z`）。
- 旋转函数 `matrix.rotationX/Y/Z(radians)` **用弧度**，不是「圈」。⚠ 这与雷达/传感器里「角度单位是圈」是两回事，别混。
- 距离：`matrix.distance(m1, m2)`；朝向：`matrix.rotationToFaceXZ(x, z)`（注意只吃 X/Z，水平朝向）。
- 矩阵库：`multiply / invert / transpose / identity / rotationX / rotationY / rotationZ / translation / position / distance / multiplyXYZW / rotationToFaceXZ`（共 11 个，无更多）。

## 5. 标准库缺胳膊少腿 ⚠

- `math.atan2` **不存在**。标准 Lua 里 `atan2(y,x)` 两参数；SW 里用 `math.atan`（**可接收 1 或 2 个参数**，两参数时行为等同 atan2）替代：
  ```lua
  -- 标准：angle = math.atan2(y, x)
  angle = math.atan(y, x)   -- SW 合法，等价
  ```
- `table.maxn` **未实现**。遍历/求长用 `pairs` 与下面第 8 节的计数函数。
- `print` **不支持**于游戏内；只在 PonyIDE / VSCode Lifeboat 扩展里可用作调试。
- ⚠ 反向确认（避免误伤）：`table.unpack` 与 `table.insert` **可用**（社区脚手架实测，解包/构造表都没问题）。不要因为 `table.maxn` 缺失就把整个 `table` 库当不可用——**只有 `maxn` 这一项缺**，其余（`insert`/`remove`/`sort`/`concat`/`unpack`）照常。

## 6. 表长度 `#` 与 `ipairs` 的隐形坑 ⚠🔴（最高频 bug 源之一）

Lua 的 `#` 和 `ipairs` **只对「从索引 1 开始、连续无空洞」的表可靠**。Stormworks 的 API 返回表经常是：
- 以非 1 索引（如 `server.getPlayers()` 用 `peer_index` 做键）；
- 稀疏表（有 nil 空洞）；
- 用字符串键（`["name"]=...`）。

→ 这类表 `#t` 可能返回 **0**，`ipairs` 提前停。官方给的替代：

```lua
function tableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
```

遍历一律用 `pairs`，不要 `ipairs`/`#`（除非你 100% 确认是连续数字表）。

## 7. 持久化：g_savedata（附加 Lua）⚠

- 把变量存进名为 **`g_savedata`** 的表，SW 会自动序列化到**每个存档的 `lua_data.xml`**，重载/读档后恢复。
- 这是附加 Lua 跨会话保数据的唯一官方手段（`despawn` 重置不影响它，因为它存在存档里）。
- 初始化逻辑放 `onCreate(is_world_create)`，`is_world_create == true` 只在**世界首次生成**时为真（读档加载为 false）。
- ⚠ `onCreate` 里调 `server.announce()` 通常收不到——客户端还没连上。

## 8. HTTP 只能打本机 ⚠

- 脚本里 `async.httpGet(port, url)` + `function httpReply(port, request, reply) end`。
- URL 必须 `/` 开头（`/test?param=hello`）。
- **只能连运行该脚本的机器上的 localhost 端口**（server 与各 client 各自发各自机器的请求）。**不能访问公网**，也不能在玩家间直传数据。
- 想连外网（Discord/Youtube 等）→ 自己在本机起一个网关 webserver，Lua 打它，它再对外。
- 限流：**每 tick 只允许 1 个 HTTP 请求**，多余的进队列，每 tick 处理最老的 → 会有延迟。
- 连不上（本机没服务）→ `reply` 就是字符串 `"connect(): Connection refused"`。

## 9. 回调体系：脚本 Lua vs 附加 Lua ⚠（别用错对象）

- **脚本 Lua**：只有 `onTick` / `onDraw`（外加 `httpReply` 处理 HTTP）。
- **附加 Lua**：`server.*` 全局对象 + 约 40 个回调，常用：
  `onCreate(is_world_create)` `onTick(game_ticks)` `onDestroy()`
  `onCustomCommand(full, peer, admin, auth, cmd, args...)` `onChatMessage(peer, name, msg)`
  `onPlayerJoin/Leave/Die/Respawn/Sit/Unsit` `onVehicleSpawn/Despawn/Load/Unload/Teleport/Damaged`
  `onObjectLoad/Unload` `onButtonPress` `onSpawnAddonComponent` `httpReply`
  天灾类：`onTornado/onMeteor/onTsunami/onWhirlpool/onVolcano/onOilSpill/onClearOilSpill/onForestFire*`
- ⚠ `onTick(game_ticks)` 的 `game_ticks` 是本帧经过的 tick 数（通常 1，脚本「睡眠」时为 400）。
- ⚠ 暂停游戏时 **`onDraw` 仍被调用、`onTick` 不调用**（脚本 Lua）→ 画面会刷新但逻辑不动，易出预期外行为。
- ⚠ TPS 掉 → FPS 与 `onDraw` 频率跟着掉（物理帧驱动渲染帧）。

### 附加 Lua 完整回调清单（来自官方汉化手册，补全集）

`00_*` 上文只列了常用回调。官方手册给出的**完整回调集**如下（凡标 ⚠ 的是上文未列、易漏写的）：

| 回调 | 签名 | 触发 |
| --- | --- | --- |
| `onCreate` | `(is_world_create)` | 初始化/首次生成 |
| `onDestroy` | `()` | 退出世界 |
| `onTick` | `(game_ticks)` | 每物理帧 |
| `onCustomCommand` | `(full, peer, is_admin, is_auth, command, args...)` | 聊天框 `?` 指令（args 须显式展开为 `arg1..arg4`）⚠ |
| `onChatMessage` | `(peer, name, msg)` | 任意聊天 |
| `onPlayerJoin` | `(steam_id, name, peer_id, is_admin, is_auth)` | 玩家加入 |
| `onPlayerLeave` | `(steam_id, name, peer_id, is_admin, is_auth)` | 玩家离开 |
| `onPlayerSit` | `(peer_id, vehicle_id, seat_name)` | 玩家入座 |
| `onPlayerUnsit` | `(peer_id, vehicle_id, seat_name)` | 玩家离座 |
| `onPlayerRespawn` | `(peer_id)` ⚠ | 玩家复活 |
| `onPlayerDie` | `(steam_id, name, peer_id, is_admin, is_auth)` | 玩家死亡 |
| `onToggleMap` | `(peer_id, is_open)` ⚠ | 地图开关 |
| `onCharacterSit` | `(object_id, vehicle_id, seat_name)` ⚠ | 任意角色入座 |
| `onCharacterUnsit` | `(object_id, vehicle_id, seat_name)` ⚠ | 任意角色离座 |
| `onCharacterPickup` | `(actor_id, target_id)` ⚠ | 角色扛起另一角色 |
| `onEquipmentPickup` | `(actor_id, target_id, EQUIPMENT_ID)` ⚠ | 角色拾装备 |
| `onEquipmentDrop` | `(actor_id, target_id, EQUIPMENT_ID)` ⚠ | 角色丢装备 |
| `onCreaturePickup` | `(actor_id, target_id, CREATURE_TYPE)` ⚠ | 角色拾生物 |
| `onVehicleSpawn` | `(vehicle_id, peer_id, x, y, z, cost)` | 载具生成（脚本生成 peer=-1） |
| `onVehicleLoad` | `(vehicle_id)` ⚠ | 载具加载就绪 |
| `onVehicleUnload` | `(vehicle_id)` ⚠ | 载具卸载 |
| `onVehicleTeleport` | `(vehicle_id, peer_id, x, y, z)` ⚠ | 载具传送/回工作台 |
| `onVehicleDespawn` | `(vehicle_id, peer_id)` | 载具摧毁（脚本触发 peer=-1） |
| `onVehicleDamaged` | `(vehicle_id, dmg, vx, vy, vz)` ⚠ | 损伤/修复（修复时 dmg 为负，v* 为相对车辆原点位置） |
| `onObjectLoad/Unload` | `(object_id)` | 物体加载/卸载 |
| `onButtonPress` | `(vehicle_id, peer_id, button_name)` | 按钮按下 |
| `onSpawnAddonComponent` | `(id/vehicle_id, component_name, TYPE_STRING, addon_index)` | 脚本生成组件 |
| `httpReply` | `(port, request, reply)` | HTTP 返回 |
| `onFireExtinguished` | `(x, y, z)` ⚠ | 火灾扑灭 |
| `onForestFireSpawned` | `(objective_id, x, y, z)` ⚠ | 5+ 树着火 |
| `onForestFireExtinguished` | `(objective_id, x, y, z)` ⚠ | 森林火灾全灭 |
| `onTornado/Meteor/Tsunami/Whirlpool/Volcano` | `(transform[, magnitude])` | 天灾生成 |

> 民用补充：回调变参 `args ...` 在 SW Lua **必须显式写出** `arg1, arg2, arg3, arg4`（或 `one..five`），不能像标准 Lua 用 `...` 原样转发。这是官方示例的写法。

## 10. 复合信号 BUS 时序陷阱（脚本 Lua 高级）⚠

逻辑组件处理数据要 **1 tick**。若你用脚本做「按 ID 分发」的 BUS：
- 读 composite（1 tick）+ 比对 ID（1 tick）= 2 tick 才出布尔；
- 而 composite 数据传到 switchbox 只花 1 tick。
- → 你会把「ID 匹配前 1 tick 的旧数据」转发出去（错数据）。
- **解法**：故意再串一个 composite switchbox 把 composite 也延迟 1 tick，使两者对齐。

## 11. 多返回值函数的括号陷阱 ⚠

附加 Lua 大量函数返回 `(value, is_success)` 两值。若只要第一个值，必须加括号包住调用，否则第二个值（boolean）会污染后续参数：

```lua
-- 错：getPlayerPos 返回 (matrix, is_success)，is_success 会当成别的参数
local x, y, z = matrix.position(server.getPlayerPos(id))   -- 实际传入了 (matrix, true)

-- 对：括号只取第一个返回值
local pos = (server.getPlayerPos(id))     -- 或
local x, y, z = matrix.position((server.getPlayerPos(id)))
```

## 13. 源码只能用英文字符 ⚠🔴

- 游戏内 Lua 脚本方块**不接受任何非 ASCII 字符**：中文、日文、全角标点、甚至反斜杠 `\` 都是非法字符，写进源码会解析失败。
- 注释也建议全英文，避免编辑器/游戏端解析异常。
- **中文要显示在显示器上**：不能写进脚本，必须走本机 unicode 后端——脚本用 `async.httpGet(5000, "/swchr?text=uniXXXX")` 拉回像素序列再逐点画（详见 `数据库/Lua/Lua示例/05_屏幕绘图与HUD.md` §7）。原 BKN 手册原话：「输入 unicode 要把 `\u` 写成 `uni`，因为这游戏不支持 `\`」。
- 这条与第 14 节（8192 上限）共同决定了游戏内 Lua 必须**极简命名 + 压缩空格**。

## 14. 单脚本方块上限 8192 字符 ⚠🔴

- 单个 Lua 脚本方块的源码**最多 8192 字符**（含空格、换行、注释）。超过会被截断或拒绝保存。
- 因此游戏内 Lua 有一整套「字数压缩」惯用法（别名化、去空格、单字母变量），详见 `数据库/Lua/Lua示例/01_基础惯用法与字数压缩.md` §2；**最强手段是把大表搬进 `property.getText`**（同文件 §3）。
- 重活/长逻辑实在放不下时，拆到多个脚本方块 + 复合信号互联，而不是硬塞一个方块。
- **别名化是社区脚手架（PonyIDE 风格 framework）的标准写法**，直接抄这套缩写能省大量字符：
  ```lua
  M=math S=screen I=input O=output P=property
  si=M.sin co=M.cos pi=M.pi pi2=pi*2
  C=S.setColor dT=S.drawText dTxB=S.drawTextBox dR=S.drawRect dRF=S.drawRectF
  tU=table.unpack   -- 解包（可用）
  ```
  原则：**库名/长函数名压成单字母或短前缀**；注释用 `--` 而非 `--[[ ]]`（后者也合法但占字符）；空格能省就省。详见 `数据库/Lua/Lua示例/01_基础惯用法与字数压缩.md` §2。

### 14.1 工坊作者常用 PonyIDE「Minify」自动压缩（有损，必须会读）⚠

`<WS>\pony IDE`（网页版 https://lua.flaffipony.rocks/）编辑器有 **Minify / Unminify** 按钮，是 §14 手工压缩的**自动化版**。源码来自其 `luamin`/`luaminy`/`luamax` 库。读工坊 Lua 时**极常遇到压缩产物**，要点：

- **两种模式**（Minify 帮助原文）：
  - **Conservative**：只改 **`local` 声明的变量/函数名**，游戏全局对象（`input`/`output`/`screen`/`property`/`map`/`async`/`matrix`/`math`/`server`）**保留原名、可读**。
  - **Agressive**：几乎把所有变量/函数名都改掉（含全局对象），帮助文案明言「偶尔会产生错误需手动修」——**风险高、工坊里少见**。
- **压缩后外观**：单行、`;` 分隔语句、去注释、去空白，局部变量改名成 `a`/`b`/`c`…（按 `a..z,A..Z,a0,a1…` 递增）。
- **三个永不改名的锚点**（PonyIDE 硬编码 `IDENTIFIERS_NOT_ALLOWED_TO_MINIFY`）：**`onTick` / `onDraw` / `httpReply`**。任何压缩工坊 Lua 里都能靠它们定位入口，先找 `function onTick()` 再顺藤摸瓜。
- **🔴 有损陷阱（最关键）**：
  - Conservative 模式**不保存原名映射**，原名被彻底丢弃——你只能恢复**结构**（重排版），**无法恢复局部变量原名**，必须按用途语义重命名（如 `a=input.getNumber(1)` 不可能是原名，要从上下文推断 `a` 是油门/航向…）。
  - Agressive 模式会在压缩结果前**内嵌一份反转义映射**：以 `--yyy--` 分隔，前面是一串 `短名=原名;` 赋值（如 `a=input;b=output;a.b=input.getNumber;…`）。**若作者保留了这段前缀**，名字可还原；但 conservative 产物没有，且作者常把前缀删掉省字符 → 默认当"原名已丢"处理。
- **给 AI 的实操**：读到压缩 Lua 时——
  1. **先 reformat**（恢复换行/缩进、必要时补空格）再分析，等价于 PonyIDE 的 Unminify（其内部 `luamax` 只恢复结构、不还原变量名）；
  2. 以 `onTick`/`onDraw` 为锚，逐段读懂每个单字母变量的实际含义；
  3. 写进示例时输出**已反压缩、按语义改名**的可读版本（参考 §14 别名化风格），**不要**把压缩 blob 原样贴出——否则浪费未来读者的注意力。
- 反压缩/美化可借助 PonyIDE 的 Unminify，或任意 Lua formatter；但**变量重命名只能靠你理解语义**，没有魔法可还原。

## 15. 多人游戏：脚本级变量不同步 ⚠🔴（最隐蔽的联机 bug）

- Lua 脚本在**服务端和每个客户端各跑一份**（见第 1 节）。但脚本方块内部的**普通变量（非复合信号）不会在两端同步**——每个端各自维护自己的副本。
- 直接用 Lua 变量做「状态记忆」（如 toggle 翻转、累计计时、状态机 `STATE`）时，各端状态会**分叉漂移**，典型表现：单机正常、一进多人就乱跳/闪烁/不同步。
- 官方例文集（`wikiwiki.jp/sbarjp/Lua例文集` 的 pulse/toggle/timer）**明确警告**：用 Lua 内部变量复现 Logic 方块功能，多人下异步 bug 概率极高。
- **解法**：
  - 需要跨端一致的状态 → 走**复合信号**（`output.setBool/setNumber` 写出、对端 `input` 读回）或 Memory 方块，不要只存脚本变量。
  - 必须纯 Lua 记忆时，把状态编码进复合输出通道，再 `input` 读回自身，借复合信号的同步性来对齐。
  - 随机数 `math.random()` 同样两端不一致（见第 1 节），联机逻辑要用确定性伪随机。

## 16. 脚本 Lua 专属全局对象清单（input/output/screen/property/map/async）⚠

脚本 Lua（载具/建筑上的 Lua 脚本方块）能用的**全局对象**比 §9 列的更多，完整清单（来自社区脚手架 `framework.lua` 实测）：

| 全局对象 | 用途 | 常用成员 |
| --- | --- | --- |
| `input` | 读复合信号入 | `getNumber(i)` `getBool(i)` |
| `output` | 写复合信号出 | `setNumber(i,v)` `setBool(i,v)` |
| `screen` | 画图（**仅 `onDraw` 内**） | 见下「screen 绘图 API」 |
| `property` | 读**属性滑块**（编辑器给方块设的滑块值） | `getBool(i)` `getNumber(i)` `getText(i)` |
| `map` | 地图坐标 ↔ 屏幕坐标换算（配合地图显示器/触控屏） | `mapToScreen(x,z)` `screenToMap(sx,sy)` |
| `async` | 本机 HTTP | `httpGet(port,url)`（回调用 `httpReply`） |

⚠ `property` 与 `map` 是**脚本 Lua 专有**全局对象，标准 Lua 没有；附加 Lua（`server.*`）也**没有**这两个——别在 addon 脚本里调。

### screen 绘图 API（Stormworks 专有函数名，非标准 Lua）

只在 `onDraw()` 里调用。常用（都是 `screen.` 前缀，脚手架常缩写 `S=`）：

`screen.setColor(r,g,b[,a])` `getWidth()` `getHeight()`
`drawLine(x1,y1,x2,y2)` `drawRect(x,y,w,h)` `drawRectF(x,y,w,h)`（实心）
`drawCircle(x,y,r)` `drawCircleF(x,y,r)`（实心）
`drawTriangle(x1,y1,x2,y2,x3,y3)` `drawTriangleF(...)`（实心）
`drawText(x,y,str)` `drawTextBox(x,y,w,h,str,horiz,vert)`

→ 这些是 Stormworks **自己的**绘图函数名（通用 LLM **不知道**这些名字），写显示器代码时按此清单调。
→ 坐标单位=像素，原点左上；尺寸用 `getWidth/getHeight` 自适应（见 §2）。

### 触控屏输入约定（社区脚手架惯用接法，进游戏实测为准）

触控屏（touch screen）把触摸数据经**复合输入通道**喂给脚本：

- `input.getNumber(1..6)` → 触摸相关坐标/尺寸（脚手架里取 `w,h,tx,ty` 等，具体哪路对应什么以游戏内 Help 为准）；
- `input.getBool(1..2)` → 触摸/点击状态（脚手架里 `t1`=触摸中、`t2`=某键）。

→ 这是「游戏内特殊输入 ↔ Lua」的绑定方式，和 §10 的 BUS 时序无关，但同样走复合信号。
→ 自己写触控 UI 时，参考脚手架的 `TOUCH` 表 + `inRect()` 命中检测写法即可（几何辅助函数属通用 Lua，本册不重复）。

## 12. 开发工具（不在游戏内）

| 工具 | 说明 |
| --- | --- |
| PonyIDE（lua.flaffipony.rocks） | 网页版，支持 `print` 调试、自动补全、模拟输入、minifier、UI Builder、分享 |
| VSCode Lifeboat 扩展 | Windows 专用；断点调试、IntelliSense、代码库复用、EmmyLua 类型提示、更准的模拟器 |

---

**一句话给 AI**：写 SW Lua 前，先确认是「脚本 Lua（方块，onTick+onDraw+screen+input）」还是「附加 Lua（server.*+g_savedata）」；
然后用本表逐条核对：双端随机、100ms 丢弃、Y 垂直轴、圈 vs 弧度、atan2 缺失、#/ipairs 避坑、多返回值加括号，
以及**游戏内脚本专属三铁律**——**仅英文源码**、**8192 字符上限**、**多人下脚本变量不同步（状态记忆必须走复合信号/Memory）**。
上述任何一条没核对就动手，基本都会出隐蔽 bug。
