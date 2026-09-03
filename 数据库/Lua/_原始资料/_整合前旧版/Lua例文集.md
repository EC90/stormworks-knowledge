> **AI 阅读规则（先读这段，先于正文）**
> 本例文集只收**游戏内 Lua 脚本方块（脚本 Lua）与 Stormworks 功能部件结合**的实战片段——
> 即「接什么方块、走哪些复合通道、有什么游戏内特有的坑」。
> **已剔除** AI 本就熟知的通用 Lua 写法（标准 `clamp=math.max(math.min(...))`、`switch` 模拟、通用 PID 类、标准矩阵乘法等），
> 这些若需要请直接写，不要在这里找。
> **游戏内三铁律（必须先看 `lua总体设定/00_速查_SW_Lua与常规Lua差异.md`）**：
> ① 源码**仅 ASCII**；② 单方块**上限 8192 字符**；③ **多人下脚本变量不同步**，状态记忆必须走复合信号/Memory。
> 本文所有片段默认跑在脚本 Lua（`input`/`output`/`screen`/`property`/`async` 可用），非附加 Lua。

# 游戏内 Lua 例文集（脚本方块 × 功能部件）

来源融合：`BKN46-bknsw-6300d21`（BKN 实战手册）+ `wikiwiki.jp/sbarjp/Lua例文集`（日文官方例文集）。
组织方式：按「**接什么部件**」分节，每段标注通道约定与游戏内特有坑。

## 目录
- §1 字数压缩（8192 上限逼出来的惯用法，必背）
- §2 Logic 方块功能用 Lua 复现（接复合输入/输出）
- §3 批量 32 通道 IO（接任意 Logic/传感器阵列）
- §4 物理传感器欧拉角 → 自机姿态（接 Physics Sensor）
- §5 雷达数据解包（接新雷达混合信号）
- §6 三項演算子もどき（Bool 切数值，接开关/模式）
- §7 PID 接执行器（接电机/舵机等模拟输出）
- §8 多人同步注意（哪些片段不能直接用）

---

## §1 字数压缩（8192 上限逼出来的，必背）

游戏内单方块 **8192 字符**封顶，所以起手就把长名缩成单字母。**3 次以上使用的调用都值得压**。

```lua
-- IO 压缩（放 onTick）
i,o=input,output
gn,gb,sn,sb=i.getNumber,i.getBool,o.setNumber,o.setBool
-- 属性 / 屏幕 同理：p=property; pn,pb,pt=p.getNumber,p.getBool,p.getText
-- s=screen; 绘图函数别名见各绘图片段
```
要点（来自日文例文集「文字数削減系」）：
- `m=math; sin,cos,abs,pi=m.sin,m.cos,m.abs,m.pi` → `A=sin(pi)` 等同 `math.sin(math.pi)`。
- 变量名按出现频率压成 `a,b,c…`（可读性换字数）；若保留可读性，用「功能首字母+编号」如 `ER1,ER2`（Engine RPS）。
- 用编辑器左下角**语法检查**按钮确认没压错（去空格后易漏运算符/括号）。

---

## §2 Logic 方块功能用 Lua 复现（接复合输入/输出）

用 Lua 脚本方块替代/增强 Logic 方块。**所有状态都从 `input`/`output` 通道进出**，不要只存脚本变量（多人会不同步，见 §8）。

### 2.1 pulse（边沿检测，接一个 Bool 输入通道）
1 tick 前输入与当前不同 → 仅变化那 1 tick 输出 true。
```lua
prev=false
function onTick()
  v=gb(1)                 -- 接按钮/开关的 Bool 通道
  p=not (v==prev)        -- 上升沿+下降沿都触发
  sb(1,p)
  prev=v
end
```

### 2.2 toggle（接 pulse，做翻转锁存）
⚠ 纯脚本变量 `toggle` 在**多人下会异步漂移**（见 §8）。真要联机可靠，把 `toggle` 经 `output` 写出、再 `input` 读回自身来对齐。
```lua
prev,toggle=false,false
function onTick()
  v=gb(1)
  p=not (v==prev); prev=v
  if p then toggle=not toggle end
  sb(1,toggle)
end
```

### 2.3 timer（用 tick 累加做 TON/TOFF）
⚠ onTick 频率不稳（约 60Hz，大载具/多人会掉），**只做粗略定时**；精确边沿定时改用外部 blinker 信号。
```lua
t,tick=0,120          -- tick=120 ≈ 2 秒
function onTick()
  t=t+1
  TON=t>tick; TOFF=t<tick
end
```

---

## §3 批量 32 通道 IO（接任意 Logic/传感器阵列）

游戏内复合信号 **32 个数字 + 32 个 Bool 通道**。用 `for` 一次性搬运，再在循环里做处理。
```lua
B,N={},{}
function onTick()
  for c=1,32 do B[c]=gb(c); N[c]=gn(c) end
  -- 在此处理 N[1..32] / B[1..32]
  for c=1,32 do sb(c,B[c]); sn(c,N[c]) end
end
```
⚠ `#N`/`ipairs` 对「从 1 起始的连续表」才安全；这里 `N` 是连续数字表，可用。稀疏/字符串键表改用 `pairs`（见 00 册 §6）。

---

## §4 物理传感器欧拉角 → 自机姿态（接 Physics Sensor）

物理传感器方块输出 12 通道：**1-3 位置、4-6 欧拉角(x,y,z)、7-9 线性速度、10-12 角速度**（左手系：X东/Y上/Z北；不接电无输出）。
下面从欧拉角构旋转矩阵，反解出**仰角/方位角/横滚**（接飞行器 HUD、自动驾驶姿态基准）。

```lua
function onTick()
  ex,ey,ez=gn(4),gn(5),gn(6)   -- 物理传感器 4/5/6 = 欧拉角(弧度)
  cx,sy=math.cos(ey),math.sin(ey)
  sx,sz=math.sin(ex),math.sin(ez)
  cz=math.cos(ez)
  R={                       -- 由欧拉角构造旋转矩阵
    {cy*cz, sx*sy*cz-cx*sz, cx*sy*cz+sx*sz},
    {cy*sz, sx*sy*sz+cx*cz, cx*sy*sz-sx*cz},
    {-sy,   sx*cy,          cx*cy}
  }
  Elev =math.asin(R[2][3])                       -- 仰角
  Azim =math.atan(R[1][3], R[3][3])             -- 方位角（math.atan 两参数=atan2）
  Roll =math.atan(R[1][2], R[2][2])             -- 横滚
end
```
⚠ 物理传感器系 **Y=垂直**，与雷达/世界系的「圈」单位、**与 GPS 系（X东/Y北/Z高）完全不同**，别混（坐标系换算见 `数据库/方块数据/17_传感器与雷达.md`）。

---

## §5 雷达数据解包（接新雷达混合信号）

新雷达（1.2.30+）**8 目标 × 4 值**，通道顺序 = `距离 · 方位角 · 仰角 · 时间(tick)`；
角度 `ang`/`tilt` 是 **0~1 圈**，喂 `math.cos/sin` **必须 ×2π**（最高频 bug 源）。
```lua
function onTick()
  T={}
  for k=1,8 do
    T[k]={lock=gb(k), dist=gn(k*4-3), ang=gn(k*4-2), tilt=gn(k*4-1), tick=gn(k*4)}
  end
  -- 目标1 球面→笛卡尔（ang=方位角圈, tilt=仰角圈）
  d,tg,pg=T[1].dist,T[1].ang,T[1].tilt
  xy=d*math.cos(pg*2*math.pi)
  x=xy*math.cos(ag*2*math.pi); y=xy*math.sin(ag*2*math.pi); z=d*math.sin(pg*2*math.pi)
end
```
⚠ 旧雷达通道顺序不同（距离·信号强度·仰角·方位角），且无信号强度；混用旧存档会错位（详见 `17_传感器与雷达.md`）。

---

## §6 三項演算子もどき（Bool 切数值，接开关/模式）

没有 `?:` 运算符，用 `and/or` 在单行里按 Bool 切数值（比 if 省字符，适合塞进 8192）：
```lua
A=true; n1,n2=100,200
B=A and n1 or n2        -- A=true→n1, false→n2
```
⚠ 仅当 `n1` 永不为 `false/nil` 时等价；若 `n1` 可能为假值，要用完整 `if` 或显式判断。

---

## §7 PID 接执行器（接电机/舵机等模拟输出）

PID 本体是通用控制算法（AI 自写即可），这里只标**游戏内接法**：误差/反馈走 `gn()` 通道，输出 `sn()` 到执行器（电机 RPS、舵机角度等）。
```lua
-- PID 实例（P/I/D/dt 自定）；update(target, current) 返回输出
pid=PID.new(1,0,1,1)
function onTick()
  target=gn(1); cur=gn(2)     -- 目标值/反馈值走复合通道
  out=pid:update(target,cur)
  sn(1,out)                   -- 输出到执行器（如电机/舵机）
end
```
⚠ 积分项要限幅防 windup（日文例文集 PID 用 `maxInt=10` 夹住 `integral`）；多人下 `pid` 实例状态也属脚本变量，会不同步——联机控制回路建议把关键状态经复合信号回环。

---

## §8 多人同步注意（哪些片段不能直接抄）

来自日文例文集的明确警告 + 00 册 §15：
- **§2.2 toggle、§2.3 timer 累计、§7 的 `pid` 实例**：都靠脚本级变量记忆状态，在 server/client 各跑一份且**不共享** → 多人下分叉。
- 需要联机一致：① 状态走 `output` 写出 + 自身 `input` 读回（借复合信号同步性）；② 或改用 Memory 方块；③ 或把关卡逻辑放进附加 Lua（用 `g_savedata`，见 00 册 §7）。
- **`math.random` 两端不一致**（00 册 §1），联机随机要用基于 tick 的确定性伪随机。

---

## 原始来源
| 片段 | 来源 |
| --- | --- |
| §2.1/2.2/2.3 pulse·toggle·timer | 日文 `Lua例文集` Logic再現系 |
| §1 压缩 / §6 三項演算子 / §3 批量IO / §8 同步警示 | 日文 `Lua例文集` 文字数削減系 + その他 |
| §4 物理传感器欧拉角 | 日文 `Lua例文集` フィジックスセンサーのオイラー角 |
| §5 雷达解包 + ×2π 修正 | BKN `Tools/Radar` + `17_传感器与雷达.md` |
| §7 PID 接法 | 日文 `Lua例文集` PID + BKN 通用写法 |

> 本地副本：`D:\STORMWORKS\数据库\Lua\Lua示例\BKN的Stormworks Lua手册\BKN46-bknsw-6300d21\docs\`
> 在线：https://bkn46.github.io/bknsw/ ｜ 日文例文集：https://wikiwiki.jp/sbarjp/Lua例文集

**给 AI**：本集只讲「脚本方块 × 部件」的咬合点。通用 Lua 自己写；真正要核对的是 00 册三铁律（英文/8192/多人不同步）与各部件的**通道约定 + 单位陷阱**（雷达圈、传感器系 Y 垂直）。
