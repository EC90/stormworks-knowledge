# 05 · 屏幕绘图与 HUD

> 来源融合：BKN `docs/Screen/`（按钮/扇面/多边形/箭头/五角星/虚线/贝塞尔/HSL）
> + 日文 `Lua例文集` + 本机工坊实测（2900758088 / 2774712393 / 1815902922 / 2551954944 / 2751468095）。
>
> 屏幕 API 完整清单见 `../lua总体设定/00_速查_SW_Lua与常规Lua差异.md` §16。
> **贝塞尔曲线见 `04_数学·滤波·数据工具.md` §4**（归类为数学工具）。

---

## §0 四条必须先知道的约定

| # | 约定 | 后果 |
| --- | --- | --- |
| 1 | **屏幕 Y 轴向下** | 画向上的柱状图要用**负高度**（见 §2） |
| 2 | `setColor(r,g,b,a)` **第 4 参是 alpha**（0–255） | 唯一的半透明/残影手段 |
| 3 | `onDraw` 可能被**多次调用**（接多个显示器时） | 别在里面做有副作用的计算 |
| 4 | 屏幕**不一定是正方形**（1×1 / 2×1 / 3×2 / 5×3…） | 按正方形设计的 HUD 必须做宽高比适配（见下） |

```lua
-- 起手模板
function onDraw()
  local w,h = screen.getWidth(), screen.getHeight()   -- 必须在 onDraw 内取
  screen.setColor(0,0,0)
  screen.drawClear()                                   -- 不清会残留上一帧
  screen.setColor(255,255,255)
  -- ...
end
```

### 0.1 非正方形屏幕适配（按正方形设计，左右留边）

来源：steam id **3793328793**（Nordic VISION，2026 年）。

很多 HUD（罗盘、雷达 PPI、圆表）本质上是**正方形**构图。装到 3×2、5×3 这类宽屏上时，
最省事的做法是：**把宽屏当成「正方形内容区 + 左右黑边」**，而不是重写一套布局。

```lua
-- 计算左右留边；之后所有绘制都用收缩后的 w 与 padX 偏移
padX = 0
if w > h then
  padX = (w-h)/2        -- 左右各留一半
  w = h                 -- 内容区收缩为正方形
end

-- 之后一律：x 用 w（此时 == h），并加上 padX 偏移
screen.drawCircle(w/2-0.5+padX, h/2-0.5, w/2)
screen.drawText(w/2-2.0+padX+math.cos(compass)*(h-8)/2,
                h/2-2.5+math.sin(compass)*(h-8)/2, "E")
```

**要点**
- 只处理 `w > h`（宽屏）。`w < h` 的竖屏同理可算 `padY`，但 SW 里宽屏更常见。
- **先算 `padX` 再收缩 `w`** —— 顺序反了会得到错误的边距。
- 收缩后**所有半径都基于 `w`（== h）**，保证圆是正圆、罗盘刻度间距均匀。
- 这个技巧让同一个脚本能同时适配 1×1 / 2×1 / 3×2，**不需要为每种屏幕写分支**。

> ⚠ **尺寸不能硬编码**。不同显示器（1×1 / 3×3 / 5×3）像素数不同，一律用 `getWidth/getHeight`。
> 若需要「按屏幕尺寸自适应」，可参考 steam id 2900758088 用 `property.getBool("1x1 Monitor")` 切换布局分支。

---

## §1 点阵字体（1×1 小屏唯一可行的文字方案）

### 1.1 3×4 字体（12 bit/字符，逐像素 `drawLine`）

来源：steam id **2900758088**（2022-12-21）。每个字符仅 12 bit（3 列 × 4 行），字模约 400 字符源码。

```lua
-- 68 项，索引 1..68；每项 12 bit，3 列 x 4 行（MSB 优先）
font34={
0x0D0,0xC0C,0xFAF,0x2F4,0xB2D,0x6F5,0x0C0,0x690,0x096,0xAEA,0x4E4,0x560,0x444,0x010,0x168,0x79E,0x5F1,
0x9B5,0x9DA,0x6F2,0xDDA,0x6DA,0x9AC,0x3FC,0x4A7,0x050,0x1A0,0x44A,0xAAA,0xA44,0xA41,0x69D,0x7A7,0xFD6,
0x699,0xF96,0xFD9,0xFA8,0x69B,0xF2F,0x9F9,0x19E,0xF4B,0xF11,0xF4F,0xF6F,0x696,0xFA4,0x6B7,0xFA5,0x5BA,
0x8F8,0xE1E,0xC3C,0xF5F,0x969,0xC7C,0xBD9,0xF90,0x861,0x09F,0x484,0x111,0x084,0x2F9,0x0F0,0x9F4,0x462}

-- 一个"像素" = 一条 1px 竖线（最省的点绘制法）
function dDot(x,y) screen.drawLine(x,y,x,y+1) end

function dChar(x,y,char)
  local c = string.byte(string.upper(char))-32        -- '!'->1 ... '_'->63
  if c>64 then c=c-26 end                             -- {|}~ 折进 65..68
  if c>0 and c<69 then
    for i=0,11 do
      if font34[c] & (1<<(11-i)) > 0 then             -- SW Lua 5.3 原生位运算
        dDot(x + i//4, y + i%4)                       -- 列 = i//4 (0..2)，行 = i%4 (0..3)
      end
    end
  end
end

function dStr(x,y,str)
  for i=0,string.len(str)-1 do
    dChar(x+4*i, y, string.sub(str,i+1,i+1))          -- 步进 4px（3 宽 + 1 间隔）
  end
end
```

### 1.2 3×5 字体（字模存进属性文本，不占脚本字符）

来源：steam id **2774712393**（2023-11-26）。**字模放 `property.getText`，绕开 8192 上限**（见 `01` §3）。

```lua
FONT = PT("FONT1")..PT("FONT2")                       -- 每字符 4 位十六进制 = 15 bit (3x5)
FONT_D={} FONT_S=0
for n in FONT:gmatch("....") do
  FONT_D[FONT_S+1]=tonumber(n,16) FONT_S=FONT_S+1
end

-- dst(x, y, text, scale, rotation, monospaced)
--   rotation: 1=正常 2=竖排 3/4=镜像变体
function dst(x,y,t,s,r,m)
  s=s or 1 r=r or 1
  if r>2 then t=t:reverse() end
  t=t:upper()
  for ch in t:gmatch(".") do
    local ci = ch:byte()-31
    if 0<ci and ci<=FONT_S then
      for i=1,15 do
        local p = (r>2) and 2^i or 2^(16-i)           -- 镜像时位序反转
        if FONT_D[ci] & p == p then
          local xx,yy = ((i-1)%3)*s, ((i-1)//3)*s     -- 3 列 x 5 行
          if r%2==1 then screen.drawRectF(x+xx,  y+yy, s,s)
          else           screen.drawRectF(x+5-yy, y+xx, s,s) end
        end
      end
      local adv = (FONT_D[ci]&1==1 and not m) and 2*s or 4*s   -- 末位为 1 => 窄字符
      if r%2==1 then x=x+adv else y=y+adv end
    end
  end
end
```

**要点**
- **1.1 的字模在脚本里、1.2 的字模在属性里**。字符数吃紧用 1.2，想单文件分发用 1.1。
- 两种都支持**缩放 `s`**：`s=2` 即 2 倍字号，靠 `drawRectF(x,y,s,s)` 实现。
- 字符步进 4px（3 宽 + 1 间隔），据此用 `#str*4` 精确排版居中。

---

## §2 🔑 条形图：负高度 `drawRectF`

来源：steam id **2751468095**（2025-07-11）、**2213181424**（2021-12-14）。

**这是 SW 屏幕（Y 向下）画柱状图的关键技巧**：高度为负 → 矩形向**上**延伸。

```lua
-- 单向柱（0 在 y=24，向上生长）
screen.drawRectF(0, 24, 2, -(value/maxVal)*23)

-- 双向柱（以 y=13 为中点，正=向上，负=向下）—— 一个表达式同时表达方向与长度
screen.drawRectF(30, 13, 2, -(dALT/10)*11)
```

「暗底 + 按阈值覆盖」画信号强度阶梯（比每格独立判断省一半代码）：

```lua
screen.setColor(BR,BG,BB,BRT-30)                  -- 暗底（未点亮）
screen.drawRectF(22,h-10,1,-1)
screen.drawRectF(24,h-10,1,-2)
screen.drawRectF(26,h-10,1,-3)
screen.drawRectF(28,h-10,1,-4)

screen.setColor(0,0,0,BRT)                        -- 亮色（点亮）
if rs > 0   then screen.drawRectF(22,h-10,1,-1) end
if rs > 0.4 then screen.drawRectF(24,h-10,1,-2) end
if rs > 0.6 then screen.drawRectF(26,h-10,1,-3) end
if rs > 0.8 then screen.drawRectF(28,h-10,1,-4) end
```

---

## §3 滚动罗盘带

来源：steam id **1815902922**（Customizable Compass Module，2019-07-27，独立微控可直接复用）。

> 🕒 同功能新作：**2623064051**（[DLC] T-80U，**2023-02-13**）在坦克炮手观瞄 HUD 中沿用同一套滚动带并叠加准星与弹药显示。
> **独立微控抄本例；做综合 HUD 抄 2623064051。**

```lua
function hex2rgb(hex)
  hex = hex:gsub("#","")
  return {r=tonumber("0x"..hex:sub(1,2)),
          g=tonumber("0x"..hex:sub(3,4)),
          b=tonumber("0x"..hex:sub(5,6))}
end

function onTick()
  H = (((1-GN(1))%1)*360)                  -- 罗盘是圈；1-x 使刻度随航向正确滚动
  C  = hex2rgb(PT("Bars Color (Hex)"))     -- 用户直接填 #RRGGBB
  T  = PN("Bars Transparency")
  OF = PN("Height Offset")
  FLP= PB("Flip Vertically")
  Show = PB("Show Heading")
end

function onDraw()
  local w,h = screen.getWidth(), screen.getHeight()
  local sp = H - math.floor(H/5)*5             -- 5px 格内的亚像素偏移（= H%5）
  local x  = w/2 - sp - math.ceil((w/2-sp)/5)*5
  local v  = math.floor(H-w/2+x)%360           -- 该像素对应的角度

  -- 垂直翻转只切换 3 个偏移量，不重复写绘制代码
  local PL,P1,P2 = 3,0,1
  if FLP then PL,P1,P2 = -6,1,0 end

  screen.setColor(C["r"],C["g"],C["b"],T)
  while x<w do
    if v/15 == math.floor(v/15) then           -- 每 15° 长刻度
      screen.drawLine(x, OF, x, 2+OF)
      -- N/NE/E/SE/S/SW/W/NW 标注（按 v 值分支）
    else                                       -- 短刻度
      screen.drawLine(x, P1+OF, x, P2+OF)
    end
    x = x+5
    v = (v+5)%360
  end
end
```

**要点**
- `sp = H % 5` 的亚像素偏移让刻度带**连续滚动**而不是跳格。
- `while x<w` **只画屏幕内的刻度**，不建数组不缓存，最省内存。
- 垂直翻转靠切换 `PL/P1/P2` 三个偏移量实现，值得抄的组织方式。
- 全部外观走 `property.*`，用户无需改代码——**工坊微控的标配**。

---

## §4 触控按钮与翻页菜单

### 4.1 通用按钮（BKN `docs/Screen/button.md`，支持短按/长按）

```lua
DBT,DBH,DBX,DBY = 60,0,0,0            -- DBT = 长按识别阈值(tick)
function onTick()
  GN,GB = input.getNumber, input.getBool
  inputX,inputY,isPressed = GN(3),GN(4),GB(1)
  if isPressed then DBH=DBH+1; DBX=inputX; DBY=inputY end
end

function inRect(px,py,x,y,w,h) return px>x and py>y and px<x+w and py<y+h end

-- drawButton(x,y,w,h,text, callbackShort, callbackLong, param)
function drawButton(bx,by,bw,bh,txt,cbShort,cbLong,p)
  screen.setColor(30,30,30)
  if isPressed and inRect(inputX,inputY,bx-1,by,bw,bh) then
    screen.setColor(100,100,100)
    if DBH>DBT then screen.setColor(200,0,0) end        -- 长按变红提示
  elseif DBH>DBT and inRect(DBX,DBY,bx-1,by,bw,bh) then
    cbLong(p); DBH,DBX,DBY = 0,0,0                      -- 长按回调
  elseif inRect(DBX,DBY,bx-1,by,bw,bh) then
    cbShort(p); DBH,DBX,DBY = 0,0,0                     -- 短按回调
  end
  screen.drawRectF(bx,by,bw,bh)
  screen.setColor(255,255,255)
  screen.drawTextBox(bx+1,by+1,bw-1,bh-1,txt,0,0)
end
function doNothing(a) return end
```

> 回调在**松手时**触发（用 `DBX/DBY` 记录按下位置，`isPressed` 为假时才判定），
> 这样支持「按下后拖出按钮再松手 = 取消」，手感正确。

### 4.2 翻页菜单（脉冲 vs 长按双语义）

来源：steam id **2551954944**（A-10 Warthog，2021-10-07）。

```lua
page = 0
function onTick()
  inputX, inputY = GN(3), GN(4)
  isPressedPulse = GB(3)                  -- 外部逻辑电路造的「按下沿」脉冲
  isPressedHold  = GB(1)                  -- 触控原始按住状态

  p1 = isPressedPulse and isPointInTriangle1()
  p2 = isPressedPulse and isPointInTriangle2()

  -- 「四个输入全为假」收成一个布尔，避免两段 if 互相覆盖 b
  if (enableButtons and p1) or nextPage then b=1
  elseif not1(p1,p2,nextPage,previousPage) then b=0 end
  if (enableButtons and p2) or previousPage then b=-1
  elseif not1(p1,p2,nextPage,previousPage) then b=0 end

  page = page + b
  if page > numberOfPages-1 then page = 0 end          -- 环形翻页
  if page < 0 then page = numberOfPages-1 end
end
function not1(x,y,z,w) return not (x or y or z or w) end
```

> ⚠ **触控原始信号是「按住」，直接当触发器会在一次触摸里翻很多页。**
> 要么用外部电路造 tick 脉冲（本例），要么用 `lp` 闩锁（见 `03_传感器与雷达解算.md` §6 的 `btp()`）。
> **这是 SW 触控做「按钮」的两种标准解法。**

---

## §5 图形原语（BKN `docs/Screen/`）

### 5.1 扇面 / 圆弧 / 射线

原理：从中心沿圆弧角度画线段。**控制线段长度** → 扇面还是圆弧；**控制起止角** → 可只画一条射线。

```lua
-- Curve(cx, cy, radius, width, startDeg, endDeg)
function Curve(cx,cy,radius,width,sa,ea)
  for i=sa,ea do
    local a = math.rad(i-90)                            -- -90 使 0° 朝上
    local sx,sy = cx+math.cos(a)*radius, cy+math.sin(a)*radius
    local ex,ey = sx-math.cos(a)*width,  sy-math.sin(a)*width
    screen.drawLine(sx,sy,ex,ey)
  end
end
```

### 5.2 正多边形

```lua
-- Polygon(cx, cy, radius, edges, rotationDeg)
function Polygon(cx,cy,radius,edges,rot)
  local ex,ey
  for i=0,360,360/edges do
    local a = math.rad(i-90+rot)
    local sx,sy = cx+math.cos(a)*radius, cy+math.sin(a)*radius
    if i~=0 then screen.drawLine(sx,sy,ex,ey) end
    ex,ey = sx,sy
  end
end
```

### 5.3 箭头

```lua
-- Arrow(x1,y1,x2,y2, headLength)
function Arrow(x1,y1,x2,y2,l)
  screen.drawLine(x1,y1,x2,y2)
  local a = math.atan(x2-x1, y2-y1)                     -- atan(y, x) 两参
  screen.drawLine(x2,y2, x2-math.sin(a-math.pi/4)*l, y2-math.cos(a-math.pi/4)*l)
  screen.drawLine(x2,y2, x2-math.sin(a+math.pi/4)*l, y2-math.cos(a+math.pi/4)*l)
end
```

### 5.4 五角星

```lua
function Star(cx,cy,r)                                  -- 外顶点半径 r
  for i=0,360,72 do
    local a = math.rad(i-90)
    local x1,y1 = cx+math.cos(a)*r,           cy+math.sin(a)*r
    local x2,y2 = cx-math.cos(a)*r,           cy-math.sin(a)*r
    screen.drawLine(x1,y1,x2,y2)
  end
end
```

### 5.5 虚线

```lua
-- DottedLine(x1,y1,x2,y2, dashLength, gapLength)
function DottedLine(x1,y1,x2,y2,w1,w2)
  local len = math.sqrt((x2-x1)^2+(y2-y1)^2)
  for i=1,math.floor(len/(w1+w2)) do
    local r1 = i*(w1+w2)/len
    local r2 = r1 + w1/len
    screen.drawLine(x1+r1*(x2-x1), y1+r1*(y2-y1),
                    x1+r2*(x2-x1), y1+r2*(y2-y1))
  end
end
```

### 5.6 HUD 常用：跑马灯 / 半透明信息条

```lua
-- 负 x 坐标让文字从屏幕左侧滚入（零成本跑马灯），来源 2046605849
DRAWT = DRAWT + 0.5
if DRAWT > w/2 then DRAWT = -w/2 end
screen.drawText(-DRAWT, 12, "CLIMB")

-- 底部半透明信息条（第 4 参 alpha）
screen.setColor(0,0,0,128)
screen.drawRectF(0, h-7, w, 7)
screen.setColor(255,255,255)
screen.drawText(2, h-6, string.format("%.0f,%.0f", tx, ty))
```

### 5.7 通用圆弧 / 扇形 `drawArc`

来源：steam id **2545864661**（K-19 潜艇，2021-10-09）。
**比 BKN 的 `Curve` 更完整**：支持起止角、填充/描边切换、步进密度，且自动纠正角度顺序。

```lua
-- drawArc(x, y, radius, angle1Deg, angle2Deg, filled, stepDeg)
--   filled=true  -> 用 drawTriangleF 逐三角拼扇形（实心）
--   filled=false -> 用 drawLine 连折线（描边弧）
function drawArc(...)
  local x,y,r,a1,a2,pie,step = ...
  a1 = a1 or 0
  a2 = a2 or 360
  step = step or 22.5
  if a2<a1 then a2,a1 = a1,a2 end        -- 自动纠正起止顺序
  local a,px,py,ox,oy,ar = false,0,0,0,0,0
  repeat
    a = a and math.min(a+step,a2) or a1  -- 最后一步夹到 a2，保证闭合无缺口
    ar = (a-90)*math.pi/180              -- -90 使 0° 朝上
    px,py = x+r*math.cos(ar), y+r*math.sin(ar)
    if a~=a1 then
      if pie then screen.drawTriangleF(x,y, ox,oy, px,py)
      else        screen.drawLine(ox,oy, px,py) end
    end
    ox,oy = px,py
  until a>=a2
end
```

```lua
drawArc(cx, cy, 40, 0, 360, false)       -- 整圈描边
drawArc(cx, cy, 40, 30, 120, true)       -- 30°~120° 实心扇形
drawArc(cx, cy, 40, 0, 90, false, 5)     -- 步进 5°（更平滑，更费）
```

**要点**
- `pie=true` 时用 `drawTriangleF(圆心, 上一点, 当前点)` **逐三角拼扇形**——这是 SW 里画**任意角度实心扇形**的唯一办法（没有原生 `drawArcF`）。
- `step` 越小越平滑但三角越多。默认 22.5°（16 段/圈）通常足够。
- `math.min(a+step, a2)` 保证最后一段精确落在终止角。

---

## §6 RGB / HSL 与自动对比色

### 6.1 互转（BKN `docs/Screen/rgb-hsl.md`，全部归一化到 0..1）

```lua
local function hslToRgb(h,s,l)
  if s==0 then return l,l,l end
  local function to(p,q,t)
    if t<0 then t=t+1 end
    if t>1 then t=t-1 end
    if t<.16667 then return p+(q-p)*6*t end
    if t<.5 then return q end
    if t<.66667 then return p+(q-p)*(.66667-t)*6 end
    return p
  end
  local q = l<.5 and l*(1+s) or l+s-l*s
  local p = 2*l-q
  return to(p,q,h+.33334), to(p,q,h), to(p,q,h-.33334)
end

local function rgbToHsl(r,g,b)
  local mx,mn = math.max(r,g,b), math.min(r,g,b)
  local s = mx+mn
  local h = s/2
  if mx==mn then return 0,0,h end
  local l = h
  local d = mx-mn
  s = l>.5 and d/(2-s) or d/s
  if mx==r then h=(g-b)/d + (g<b and 6 or 0)
  elseif mx==g then h=(b-r)/d+2
  else h=(r-g)/d+4 end
  return h*.16667, s, l
end
```

### 6.2 自动对比色（地图上的标记色，来源 2774712393）

思路：取地图配色的**平均色相**，**反转亮度** → 保证任何配色下标记都清晰。

```lua
function findBestContrastColor(C)              -- C = {r,g,b, r,g,b, ...}
  local totalH, totalL, n = 0, 0, 0
  for i=1,#C,3 do
    local H,S,L = rgbToHsl(C[i]/255, C[i+1]/255, C[i+2]/255)
    totalH = totalH+H; totalL = totalL+L; n = n+1
  end
  return {hslToRgb(totalH/n, 1, 1-totalL/n)}   -- 同色相、反亮度
end
```

### 6.3 地图配色（8 组 24 通道，**必须在 `drawMap` 之前调用**）

```lua
s.setMapColorOcean   (M[1],M[2],M[3])
s.setMapColorShallows(M[4],M[5],M[6])
s.setMapColorLand    (M[7],M[8],M[9])
s.setMapColorGrass   (M[10],M[11],M[12])
s.setMapColorSand    (M[13],M[14],M[15])
s.setMapColorSnow    (M[16],M[17],M[18])
s.setMapColorRock    (M[19],M[20],M[21])
s.setMapColorGravel  (M[22],M[23],M[24])
screen.drawMap(mx,my,mz)
```

地图缩放/平移的平滑跟随见 `04_数学·滤波·数据工具.md` §1.3。

---

## §7 圆形仪表（扇形填充 / 预计算刻度双指针）

两种互补做法：**A** 用放射线拼扇形（简单、可动态变色）；**B** 预计算刻度 + 三角拼指针（性能好、适合多指针）。

### 7.1 放射线拼扇形仪表（可动态渐变配色）

来源：steam id **2232448349**（Mil Mi-38，2021-11-04）—— **本批语料中评分最高的脚本（score 88）**。
独立微控，全部外观走 `property`，可直接拖进自己的作品。

```lua
-- 四舍五入到 B 位小数
function round(v,B) local m=10^(B or 0) return math.abs(math.floor(v*m+0.5)/m) end
function hex2rgb(hex)
  hex = hex:gsub("#","")
  return {r=tonumber("0x"..hex:sub(1,2)),
          g=tonumber("0x"..hex:sub(3,4)),
          b=tonumber("0x"..hex:sub(5,6))}
end

function onTick()
  Input = round(input.getNumber(1),2)
  Pos   = property.getNumber("Number Position")     -- 0=数字在左 1=在右
  yes   = property.getNumber("Dial Color Fill")     -- 0=纯色 1/2=两种渐变
  min,max = property.getNumber("Min"), property.getNumber("Max")
  if min > max then min = max end
  V = ((Input-min)/(max-min))*100                   -- 归一化到 0..100
  V = (V>100) and 100 or ((V<0) and 0 or V)
  PosX,PosY = property.getNumber("X Position"), property.getNumber("Y Position")
  t  = property.getNumber("Dial Color Transparency (0-255)")
  DC = hex2rgb(property.getText("Dial Solid Color (Hex)"))
  PC = hex2rgb(property.getText("Dial Pointer Color (Hex)"))
end

function onDraw()
  screen.setColor(BGC["r"],BGC["g"],BGC["b"],bt)
  screen.drawCircleF(PosX,PosY,8)                   -- 表盘底
  for i = 1,50 do                                   -- 50 条放射线拼出扇形
    local ang1 = -(V*0.00094)*i                     -- 50 步 * 0.00094 ≈ 270° 满量程
    -- 手写 2D 旋转：点(11,12)绕(PosX,PosY)转 ang1
    local t1x = math.cos(ang1)*(11-19) - math.sin(ang1)*(12-12) + PosX
    local t1y = math.sin(ang1)*(11-19) - math.cos(ang1)*(12-12) + PosY
    if yes == 1 then          -- 绿 -> 红
      screen.setColor(math.sin((V/80)^2)*200, math.sin(1.59-V/63)*255, 0, t)
    elseif yes == 2 then      -- 红 -> 绿
      screen.setColor(math.sin(1.59-V/63)*200, math.sin((V/80)^2)*255, 0, t)
    else
      screen.setColor(DC["r"],DC["g"],DC["b"],t)
    end
    if i == 50 then screen.setColor(PC["r"],PC["g"],PC["b"]) end   -- 末条=指针
    screen.drawLine(PosX,PosY,t1x,t1y)
  end
  screen.setColor(LC["r"],LC["g"],LC["b"])
  screen.drawCircle(PosX,PosY,8)                    -- 表盘框
  -- 数字框：随 Input 量级切换格式
  if Input < 10 then screen.drawTextBox(PosX-19,PosY-8,20,9,string.format("%.1f",Input),0,0)
  else               screen.drawTextBox(PosX-19,PosY-8,20,9,string.format("%.0f",Input),0,0) end
end
```

**要点**
- 🔑 **没有原生扇形 API**，所以用 **50 条从圆心出发的 `drawLine`** 拼出填充扇形。这是 SW 画仪表最通用的做法。
- **动态渐变配色**用 `math.sin()` 驱动：`math.sin((V/80)^2)*200` 与 `math.sin(1.59-V/63)*255` 两条曲线交叉，形成绿→黄→红的连续过渡，**不需要任何查表或分支**。
- **手写 2D 旋转**：`x' = cos(a)*dx - sin(a)*dy + cx`，`y' = sin(a)*dx - cos(a)*dy + cy`（注意本例 Y 项用的是 `-cos`，因为屏幕 Y 向下做了镜像）。
- **末条线即指针**（`if i==50` 换成指针色），省掉单独画指针的代码。
- 满量程系数 `0.00094` = 270° / (100 × 50步) × (π/180) 的合并常量，改量程时按 `目标弧度/(100*步数)` 重算。

### 7.2 预计算刻度 + 三角拼指针（多指针，性能好）

来源：steam id **2913735149**（Mig-21bis，2023-01-13）。高度表，双指针（百位/千位）。

```lua
tau = math.pi*2
function lerp(x,a,b) return (x-a)/(b-a) end
function round(x,nearest)
  return nearest and (x/nearest+.5)//1*nearest or (x+.5)//1
end

-- ⚠ 刻度在「顶层」一次性算好（onTick/onDraw 之外），每帧只画不重算
linesPerHundred = 2
lineCount = 10*linesPerHundred
lines = {}
for i=0,lineCount+1 do
  lines[i] = {{},{},{},{}}
  local lineAngle = (i/lineCount)*tau + math.pi
  lines[i][1][1] = math.sin(lineAngle)*13.5 + cX      -- 外端点
  lines[i][1][2] = math.cos(lineAngle)*13.5 + cY
  lineAngle = round(lineAngle+math.pi, math.pi/4)     -- 对齐到 45° 网格
  if i%linesPerHundred==0 then                        -- 主刻度：长
    lines[i][2][1] = math.sin(lineAngle)*3 + lines[i][1][1]
    lines[i][2][2] = math.cos(lineAngle)*3 + lines[i][1][2]
  else                                                -- 次刻度：短
    lines[i][2][1] = math.sin(lineAngle)*1   + lines[i][1][1]
    lines[i][2][2] = math.cos(lineAngle)*1.6 + lines[i][1][2]
  end
end

function onTick()
  altitude = input.getNumber(1)*PN("Units")
  hundredAngle = -altitude/1000 *tau + math.pi        -- 百位指针（1 圈 = 1000）
  thouAngle    = -altitude/10000*tau + math.pi        -- 千位指针（1 圈 = 10000）
  -- 指针 5 个顶点（尖端 + 两对翼），用三角拼出箭头形
  dialX1 = math.sin(hundredAngle)*12 + cX
  dialY1 = math.cos(hundredAngle)*12 + cY
  dialX2 = math.sin(hundredAngle+.1)*8 + cX
  dialY2 = math.cos(hundredAngle+.1)*8 + cY
  dialX3 = math.sin(hundredAngle-.1)*8 + cX
  dialY3 = math.cos(hundredAngle-.1)*8 + cY
  dialX4 = math.sin(hundredAngle+.6) + cX
  dialY4 = math.cos(hundredAngle+.6) + cY
  dialX5 = math.sin(hundredAngle-.6) + cX
  dialY5 = math.cos(hundredAngle-.6) + cY
  -- 按量级切换数字格式（含负值与补零）
  if altitude>=10000 then altString=string.format("%ik", math.floor(altitude/1000))
  elseif altitude>=1000 then altString=string.format("%.1f", math.floor(altitude/100)/10)
  elseif altitude>=100  then altString=string.format("%i", math.floor(altitude))
  elseif altitude>=10   then altString=string.format("0%i", math.floor(altitude))
  elseif altitude>=0    then altString=string.format("00%i", math.floor(altitude))
  elseif altitude>-1    then altString="000"
  elseif altitude>-10   then altString=string.format("-0%i", math.floor(math.abs(altitude)))
  else                       altString="rip" end
end

function onDraw()
  screen.setColor(40,40,40)
  for i in ipairs(lines) do
    screen.drawLine(lines[i][1][1],lines[i][1][2], lines[i][2][1],lines[i][2][2])
  end
  -- 用 3 个三角拼出指针（尖端 X1 + 翼 X2/X3 + 尾 X4/X5）
  screen.drawTriangleF(dialX1,dialY1, dialX2,dialY2, dialX3,dialY3)
  screen.drawTriangleF(dialX2,dialY2, dialX3,dialY3, dialX4,dialY4)
  screen.drawTriangleF(dialX3,dialY3, dialX4,dialY4, dialX5,dialY5)
  screen.drawCircleF(cX,cY,2.1)                       -- 中心轴
end
```

**要点**
- 🔑 **刻度在顶层（函数外）一次性算好**，不是每帧重算。1×1 屏只有 32×32 像素，这个优化直接决定帧率。
- **多指针靠"不同转速"叠加**：百位指针 1 圈 = 1000 单位，千位指针 1 圈 = 10000（即 1/10 速），这正是机械式高度表/钟表的做法。
- **指针用 `drawTriangleF` 拼**（尖端 + 翼 + 尾共 3 个三角），比 `drawLine` 画单线更像真实指针。
- `round(x, math.pi/4)` 把刻度角度**对齐到 45° 网格**，让刻度线方向整齐（避免每个角度都歪一点）。
- `lineAngle + math.pi` 的偏移是让 0 点落在表盘下方（`-cos` 语义）。
- 数字格式按量级分支，包含**补零**（`0%i`、`00%i`）与负值处理——航空仪表的要求。

---

## §8 中文渲染（**依赖本机后端，非纯游戏内方案**）

来源：BKN `docs/Telementry/chinese.md`。原理：脚本用 `async.httpGet` 打**本机 Flask 后端**，
拿回字形点阵再逐点画线（`00_速查 §10`：HTTP 只能连 localhost）。

```lua
function ChnText(x,y,code)
  registChn(code)
  local d = CHN[code]
  for e=1,#d do
    for f=1,#d[e],2 do
      local g = x+tonumber(d[e][f])
      local h = x+tonumber(d[e][math.min(f+1,#d[e])])+1
      screen.drawLine(g, y+e, h, y+e)
    end
  end
end
function registChn(a)
  if not CHN[a] then
    async.httpGet(5000, string.format("/swchr?text=%s", a))
    CHN[a]=""
  end
  return CHN[a]
end
function httpReply(port, request, body)         -- 后端回包
  local d=split(body,'|')
  CHN[d[#d]]=chnBreak(body)
end
```

> ⚠ **三个硬约束**
> 1. 必须在本机跑后端（<https://github.com/BKN46/stormworks-translate-chn/tree/main/others/unicode-backend>）。
> 2. 输入 unicode 要把 `\u` 写成 **`uni`** —— 游戏源码不支持反斜杠 `\`。
>    例：`ChnText(5,5,"uni64cduni4f60")` 。
> 3. `async.httpGet` **1 请求/tick 排队**，大量文字要分批。
>
> 后端地址（python3 + flask）：`http://localhost:5000/swchr?text=<unicode>`

---

## §9 遥测 / 数据导出（了解即可）

BKN `docs/Telementry/` 另有 `gif.md`（把屏幕画面逐帧导出成本地 GIF）与
`data-download.md`（把运行数据 dump 出来）。两者都依赖本机后端，
**属于调试辅助而非游戏功能**，需要时查 `../_原始资料/BKN的Stormworks Lua手册/BKN46-bknsw-6300d21/docs/Telementry/`。

---

## §10 周视镜 HUD：触控缩放 + 指南针刻度 + 炮塔指向双针

来源：steam id **3261800786** · <https://steamcommunity.com/sharedfiles/filedetails/?id=3261800786> · **载具**（ZTQ-15，脚本 `ztq15cmdMnt` / `PYOs FCS ... Monitor`）

车长/炮长周视镜需要**缩放视野 + 指南针 + 显示炮塔相对车体的指向**。缩放靠触控区改变倍率 `z`，视野角 `fov` 由 `z` 反算：

```lua
-- 缩放：点屏幕右半上下区 → z 翻倍/减半（触控 PB 见 §4.1）
if PB(10,10,w-20,h/2-10) then z = M.min(z*2, 32); zp = M.min(zp+1,7) end
fov  = (2.2 - (45.9/z/180)*M.pi) / 2.175            -- 视野角由倍率反算（45.9=镜头视场常数）
fovd = 45.9/z                                        -- 每像素对应的角度（度）
```

**指南针带**：按当前朝向 `dir` 只画视野内的刻度，N/E/S/W 用文字标：

```lua
dir = (cps < 0) and (-cps*360) or (360 - cps*360)     -- 罗盘角(度)：注意正负约定
for i = M.floor(dir)-M.floor(0.45*fovd), M.floor(dir)+M.floor(0.45*fovd) do
  if i%5==0 then
    if i==90 then DT(...,"E") elseif i==180 then DT(...,"S")
    elseif i==270 then DT(...,"W") elseif i==0 or i==360 then DT(...,"N")
    else DL(..., 1+mlen) end                          -- 普通刻度线
  end
end
```

**炮塔指向双针**：车体航向 `cps` 与炮塔航向 `hcps`、炮塔相对车体 `mtrtr` 各画一根针，一眼看出「车朝哪、炮朝哪」：

```lua
DL(w-7,h-9, w-7 + 9*M.sin((hcps-cps)*M.pi*2), h-9 - 9*M.cos((hcps-cps)*M.pi*2))   -- 炮塔绝对指向
DL(w-7,h-9, w-7 + 6*M.sin((hcps-mtrtr)*M.pi*2), h-9 - 6*M.cos((hcps-mtrtr)*M.pi*2))-- 炮塔相对车体
```

**要点**
- `fov = ... 45.9/z ...` 是「倍率越高视野越窄」的标准反算；常数 45.9 来自该镜头模组，换镜头要重测。
- 指南针 `cps<0 ? -cps*360 : 360-cps*360` 在处理正负罗盘角——和 `08` §2.3 的方位约定是同一坑，统一用 `CD()` 最稳。
- 双针法把「车体/炮塔/相对角」三个量一次画清，是坦克观瞄 HUD 的标配。
- IR/RDR/OVR/GPS 等模式用 §4 的 `TB/DB` 触控开关切换。
- 完整脚本：`../../../AI相关/_提取暂存/3261800786_vehicle_25.lua`、`..._vehicle_29.lua`

---

## §11 顶视损伤评估显示（旋转车体多边形 + 热力区）

来源：steam id **3261800786**（ZTQ-15，脚本 `Damage Monitor`）

把车体俯视轮廓画成一张 38 点多边形，整体按车头朝向 `ca` 旋转；16 个分区各自一个**平滑损伤值**，值越大越红，一眼看出哪块被打穿。

```lua
P = {}; for i=1,38 do P[i] = {} end                 -- 38 个顶点(相对车体坐标，预存)
function RP(x,y,a)                                    -- 绕原点旋转 a（车头朝向）
  return x*Mc(a) - y*Ms(a), x*Ms(a) + y*Mc(a)
end
function onTick()
  ca = (GN(17) - GN(18) + 0.25) * pi2                -- 车头朝向（两路罗盘差）
  for i=1,16 do
    R[i].v = Av(R[i].t, 1 - GN(i)/i, 60)             -- 每区损伤平滑(0=完好 1=全毁)
  end
end
function DRR(a,b,c,d)                                 -- 用三角形拼出多边形的一块
  D3F(dx+P[a].x, dy+P[a].y, dx+P[b].x, dy+P[b].y, dx+P[c].x, dy+P[c].y)
  D3F(dx+P[b].x, dy+P[b].y, dx+P[c].x, dy+P[c].y, dx+P[d].x, dy+P[d].y)
end
function onDraw()
  for i=1,16 do
    SC(R[i].v*95+5, R[i].v*10+5, R[i].v*2.5+5)       -- 损伤值→红绿强度（越伤越红）
    DRR(区顶点组合)                                   -- 画该区填充
  end
end
```

**要点**
- **旋转用 `RP(x,y,a)` 一次算所有顶点**，比每帧重画省事；车体轮廓只存一份相对坐标。
- 损伤值来自各分区传感器 `GN(i)`，经 `Av(...,60)` 平滑 60 帧避免闪烁。
- 配色 `R*95+5` 让「完好(0)→暗灰、全毁(1)→亮红」连续过渡，比硬开关直观。
- 多边形填充用 `drawTriangleF` 两两拼（任意多边形都能三角化），`05` §5.2 的正多边形同理。
- 完整脚本：`../../../AI相关/_提取暂存/3261800786_vehicle_32.lua`

---

## §12 NATO 战术符号库（友/敌/未知 + 11 种类型）

来源：steam id **3261800786**（ZTQ-15，脚本 `datalink3main` / `datalink3drawSelf`）

战场地图/雷达上给目标画 APP-6 风格符号：阵营 `F`（1 友军方块 / 2 敌军三角 / 其它未知空心圆），类型 `T`（1..11 各画不同内构线）。一个函数通吃：

```lua
function DNATO(d,C,F,T)                               -- d,C=屏幕坐标; F=阵营; T=类型
  local a,b,c,e,f,g,A,B,D,E = d-3,d-2,d-1,d+1,d+2,d+3, C-2,C-1,C+1,C+2
  if F==1 then                                        -- 友军：方块
    sC(V,64,U); DRF(a,A-1,7,7); sC(V,V,V); DR(a,A-1,6,6)
  else                                                -- 敌军/未知：三角
    sC(U,V,V); S.drawTriangleF(a,D,e,A-1,g+2,D); S.drawTriangleF(a,D,e,E+3,g+2,D)
    sC(V,V,V); DL(d,A-2,a-1,C); DL(a-1,C,d,E+2); DL(d,E+2,g+1,C); DL(g+1,C,d,A-2)
  end
  if T==1 then DL(d,C,d,D)                            -- 类型内构线(节选)
  elseif T==2 then DL(c,B,f,B); DL(c,D,f,D); DL(b,C,c,C); DL(f,C,e,C)
  elseif T==3 then DL(b,A,g,E+1); DL(f,A,a,E+1)
  -- ... T==4..11 各画不同识别线 ...
  end
end
```

**要点**
- 符号本体只由「**阵营形状 + 类型内构线**」两层组成，加新类型只需在 `T` 分支里加几笔。
- 坐标用 `d±3 / C±2` 的局部偏移算出 10 个参考点，所有线都引用它们——改符号大小只动这一处。
- 友军用方块、敌军用三角是北约惯例，配合 §6.2 的自动对比色，地图上敌我一目了然。
- 完整脚本：`../../../AI相关/_提取暂存/3261800786_vehicle_6.lua`、`..._vehicle_14.lua`

---

## §13 触控分区手势（九宫格方向区 + 双击 + 按钮优先 + 分级步长）

- 来源：steam id 3792235232 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3792235232 · 载具（SLAMRAAM 悍马，`_vehicle_3` 摄像机控制）
- 更新时间：2026-08-30
- 用到：触控屏（触摸坐标 / 触摸开关）、数字输入（屏幕宽高、目标距离）
- 亮点：**同一块屏同时承载「按钮区」和「方向手势区」，用 `touched` 标志做优先级仲裁**；缩放步长随倍率分级；双击用两帧状态机识别。

```lua
before_touch = false
function onTick()
  local sw, sh = input.getNumber(1), input.getNumber(2)   -- 屏幕宽高走复合输入（非 screen.getWidth）
  local tx, ty = input.getNumber(3), input.getNumber(4)   -- 触摸坐标
  local t      = input.getBool(1)                         -- 是否触摸中

  -- ① 单击沿：本帧按下且上帧未按下
  local d_t
  if t then
    d_t = not before_touch
    before_touch = true
  else
    d_t, before_touch = false, false
  end

  local touched = false                                   -- ② 优先级仲裁标志

  -- ③ 左下角两个小方块 = 放大/缩小按钮（按住连续缩放）
  if isInRect(tx, ty, 1, sh-18, 6, 6) and t then zoom = zoom + 0.01; touched = true end
  if isInRect(tx, ty, 1, sh-10, 6, 6) and t then zoom = zoom - 0.01; touched = true end

  -- ④ 分级步长：高倍用小步（精细），低倍用大步（快）
  if input.getBool(30) then zoom = zoom + (zoom > 0.84 and 0.05 or 0.15) end
  if input.getBool(31) then zoom = zoom - (zoom > 0.84 and 0.05 or 0.15) end
  zoom = math.min(math.max(zoom, 0), 1)

  -- ⑤ 稳定模式开关走「单击沿」（原脚本用双击，实测沿更可靠）
  if isInRect(tx, ty, sw/2+7, sh-9, 16, 7) and d_t then
    stable_mode = not stable_mode
    touched = true
  end

  -- ⑥ 没命中任何按钮，才把手势解释成「推动镜头」（九宫格）
  if not touched and t then
    if     isInRect(tx, ty, sw/3, 0, sw/3, sh/2)    then pitch  =  0.0001  -- 上
    elseif isInRect(tx, ty, sw/3, sh/2, sw/3, sh/2) then pitch  = -0.0001  -- 下
    elseif isInRect(tx, ty, 0, 0, sw/3, sh)         then rotate = -0.0001  -- 左
    elseif isInRect(tx, ty, sw/3*2, 0, sw/3, sh)    then rotate =  0.0001  -- 右
    end
  end

  output.setNumber(1, pitch); output.setNumber(2, rotate); output.setNumber(3, zoom)
  output.setBool(1, stable_mode)
end

function isInRect(x, y, rx, ry, rw, rh)
  return x > rx and y > ry and x < rx+rw and y < ry+rh
end
```

**要点与坑**

- **`touched` 仲裁是这类布局的关键**：按钮区与手势区重叠时（本例按钮在屏幕最底部、手势区覆盖整屏），不加仲裁会导致「点缩放按钮的同时镜头也跟着转」。
- 原脚本的双击写法（`if before_touch then d_t=false else d_t=true end`）**有 bug**：第二帧反而把沿判没了，实际退化成乱触发。可靠写法就是标准的 `t and not before_touch` 上升沿，与 `02` §1 `pulse`、`03` §6 的 `lp` 闩锁同源。
- ⚠ **原脚本在 `onDraw` 里写 `w = screen.getWidth()/2`**，等于把 `w/h` 定义成「中心坐标」而非宽高；`onTick` 里同名变量却是完整宽高——**同一份代码两套 `w` 语义**，改动时极易出错。建议统一命名。
- 分级步长（高倍小步）比固定步长手感好得多，缩放跨度大时一定要分档。
- 完整脚本：`../../../AI相关/_提取暂存/_new/3792235232_vehicle_3.lua`

---

## §14 圆形视口的**反向遮罩**与「负坐标 = 贴边」按钮表

- 来源：steam id 3788946785 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785 · 载具（MV-24 倾转旋翼机※，`_vehicle_7` 导航显示器）
- 更新时间：2026-08-26
- 用到：显示器、触控屏、属性滑块（雷达/声纳量程、默认地图模式）、点阵字体
- 亮点：**SW 没有「圆外填充」API**，本例用 4 个大三角形 + 逐行三角化把圆形地图外的区域涂黑；按钮表用**负坐标自动贴右/下边**，一套布局适配任意屏幕尺寸。

```lua
-- ① 按钮表：x/y 为负 => 相对右/下边；t=当前档位，p=是否被按下
B = {
  {title={"R","R"},     x=-6, y=1,  w=5, h=7, t=0,  p=0},   -- 贴右边
  {title={"+","+"},     x=-6, y=16, w=5, h=7, t=0,  p=0},
  {title={"-","-"},     x=-6, y=24, w=5, h=7, t=0,  p=0},
  {title={"1","2","3"}, x=1,  y=1,  w=5, h=7, t=mm, p=0},
}

function onTick()
  w, h = input.getNumber(1), input.getNumber(2)
  tx, ty, t = input.getNumber(3), input.getNumber(4), input.getBool(1)
  for i, v in pairs(B) do
    if v.x < 0 then v.x = w + v.x end      -- 贴右/下边：负坐标在这里解析
    if v.y < 0 then v.y = h + v.y end
    if t and tx > v.x and tx < v.x+v.w and ty > v.y and ty < v.y+v.h then
      v.p = 1
      if t and not last_t then             -- 上升沿才换档（见 05 §4）
        if i < 2 or i >= 4 then v.t = (v.t + 1) % (#v.title) end
      end
    else v.p = 0 end
  end
  last_t = t
end

function onDraw()
  local cx, cy = w/2 - .5, h/2
  local r = cy + 1

  -- ② 圆外遮罩：4 个大三角形盖住圆外四角
  screen.setColor(7, 7, 7)
  screen.drawTriangleF(0, 0, w, 0, cx, (h-2*r)/2)
  screen.drawTriangleF(w, 0, w, h, w-(w-2*r)/2-1, cy)
  screen.drawTriangleF(w, h, 0, h, cx, h-(h-2*r)/2-1)
  screen.drawTriangleF(0, h, 0, 0, (w-2*r)/2, cy)

  -- ③ 圆环边缘逐行三角化（补足大三角形之间的弧面空缺）
  for i = 1, h do
    local a1, a2 = (i/h)*pi2, (i/h - 1/h)*pi2
    local x1, y1 = cx + r*math.cos(a1), cy + r*math.sin(a1)
    local x2, y2 = cx + r*math.cos(a2), cy + r*math.sin(a2)
    local x3 = x1 > cx and w or 0          -- 朝最近的屏幕边延伸
    local y3 = y1 > cy and h or 0
    screen.drawTriangleF(x1, y1, x2, y2, x3, y3)
  end
end
```

**要点**

- **反向遮罩的本质**：想「只保留圆内」，就画「圆外」——把圆外区域**切成三角形**。四角用 4 个大三角，弧形边界用逐行小三角逼近，`if x>cx then w else 0 end` 决定往哪条边延伸。
- 逐行三角化的行数取屏幕高度即可（`for i=1,h`），行越多弧越光滑；1×1 小屏 32 行足够。
- **负坐标贴边**让同一份按钮表在 1×1 和 5×3 上都能用，省掉每块屏单独算坐标。⚠ 解析必须在 `onTick`（拿到 w/h 之后）**且只做一次**，否则每帧累加会漂走。
- 完整脚本：`../../../AI相关/_提取暂存/_new/3788946785_vehicle_7.lua`

---

## §15 无文本宽度 API 时的排版：**用 `log10` 算位数**决定坐标读数偏移

- 来源：steam id 3790163661 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3790163661 · 载具（Tanky McTankerface，`_vehicle_0` 地图 HUD）
- 更新时间：2026-08-26
- 用到：GPS（世界坐标）、指南针（圈）、触控屏、`map.mapToScreen` / `map.screenToMap`、属性开关
- 亮点：**SW 没有 `screen.getTextWidth()`**，本例用 `log10` 估出整数位数，自己算每个字段的 x 偏移，实现「x1234 y-567 h89」这种**右端不跑版**的坐标读数条。

```lua
function onDraw()
  w, h = screen.getWidth(), screen.getHeight()

  if SWCOO then                                   -- 属性开关：显示坐标读数条
    screen.setColor(0, 0, 0, 80)
    screen.drawRectF(5, h-8, w, 8)                -- 半透明底条
    screen.setColor(255, 255, 255)
    screen.drawText(7, h-5, "x")
    screen.drawText(12, h-5, nx)

    -- 位数 = floor(log10(|n|)) + 1；字符宽约 6 px，负号再让 5 px
    local nw = math.floor(math.log(math.abs(nx)) / math.log(10) + 1) * 6
    if math.abs(nx) - 9 < 9 then nw = 10 end      -- 1~2 位单独校准
    if nx == 1000 or nx == -1000 then nw = 24 end
    if nx < 0 then nw = nw + 5 end                -- 负号占位

    screen.drawText(nw+10, h-5, "y")
    screen.drawText(nw+14, h-5, ny)
    local nwz = math.floor(math.log(math.abs(ny)) / math.log(10) + 1) * 6
    if ny < 0 then nwz = nwz + 5 end
    screen.drawText(nw+nwz+12, h-5, "h")
    screen.drawText(nw+nwz+17, h-5, z)
  end
end
```

**同屏另一招：km 网格按缩放自适应**

```lua
if SWKM then
  local kkm  = math.max(math.floor((zoom/10)*2), 1)     -- 网格间距(km)随缩放连续变化
  local step = 1000 * kkm
  local xr   = math.floor(nx/step)*step                 -- 对齐到网格起点
  local yr   = math.floor(ny/step)*step
  screen.setColor(0, 0, 0, 30)
  for k = -5, 5 do                                      -- 上下左右各 5 条
    local gx, _ = map.mapToScreen(nx, ny, zoom, w, h, xr + k*step, yr)
    local _, gy = map.mapToScreen(nx, ny, zoom, w, h, xr, yr + k*step)
    screen.drawLine(gx, 0, gx, h)
    screen.drawLine(0, gy, w, gy)
  end
end
```

**要点与坑**

- `math.log(x)/math.log(10)` 就是 `log10`（SW 的 Lua 没有 `math.log10`）。**x 必须先取绝对值**，0 会得到 `-inf`。
- 常数 `*6` 是作者按 5 px 字宽 + 1 px 间距实测出来的；换成点阵字体 `s=2` 时要同步改。
- 与 `06` §4 的分档网格（`grids={10,100,500...}`）对比：分档是**离散跳变**，本例是**连续跟随缩放**——网格密度恒定，但会随缩放轻微游动。要稳定选分档，要平滑选连续。
- ⚠ 原脚本在 `onTick` 里就调用 `map.mapToScreen`，而 `w/h` 是在 `onDraw` 里赋值的全局量——**首帧 `w/h` 为 nil**，且用的是上一帧宽高。改屏尺寸后会错一帧。安全做法是坐标换算**全部放进 `onDraw`**。
- 完整脚本：`../../../AI相关/_提取暂存/_new/3790163661_vehicle_0.lua`

---

## §16 地图 POI 的**分级 LOD** 与「条件定义 onDraw」图层开关

- 来源：steam id 3790163661 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3790163661 · 载具（`_vehicle_9` / `_5` / `_6` 三张地图图层）
- 更新时间：2026-08-26
- 用到：GPS、属性开关（图层开关）、属性滑块（配色）、`map.mapToScreen`
- 亮点：**同一个 POI 在放大时画成点、缩小时画成多边形轮廓**（LOD）；图层开关用「在 `onTick` 里条件定义 `onDraw`」实现——关掉的图层连函数都不存在，零绘制开销。

```lua
function onTick()
  x, y   = input.getNumber(1), input.getNumber(2)
  zoom   = input.getNumber(4)
  nx, ny = math.floor(input.getNumber(5)), math.floor(input.getNumber(6))
  DL     = property.getBool("Show desert lands")   -- 图层开关
end

-- 注意：onDraw 定义在 onTick 之后的条件分支里！关掉图层时整个绘制函数不会生成
if DL then
  function onDraw()
    local w, h = screen.getWidth(), screen.getHeight()
    local function P(wx, wy, sz)                   -- POI 画点的简写
      local px, py = map.mapToScreen(nx, ny, zoom, w, h, wx, wy)
      screen.drawRectF(px, py, sz or 1, sz or 1)
    end

    screen.setColor(25, 45, 155)
    P(-6376, -32868)  P(-17857, -33464)  P(-16060, -30350)   -- 一堆固定 POI

    -- LOD：放得够大 -> 画 2x2 点；缩小 -> 改画四边形轮廓
    if zoom > (h/5) then
      P(1705, -26387, 2)                                     -- FJ Warner Docks
    else
      local ax, ay  = map.mapToScreen(nx, ny, zoom, w, h, 1705, -26387)
      local bx, by  = map.mapToScreen(nx, ny, zoom, w, h, 1720, -26446)
      local cx2,cy2 = map.mapToScreen(nx, ny, zoom, w, h, 1777, -26425)
      local dx, dy  = map.mapToScreen(nx, ny, zoom, w, h, 1760, -26370)
      screen.drawTriangleF(ax, ay, bx, by, cx2, cy2)         -- 四边形 = 两个三角形
      screen.drawTriangleF(cx2, cy2, dx, dy, ax, ay)
    end
  end
end
```

**要点**

- **「条件定义 `onDraw`」合法且有用**：SW 每 tick 先跑 `onTick` 再跑 `onDraw`，`onTick` 里定义的 `onDraw` 当帧即生效。关掉的图层省掉全部 `map.mapToScreen` 调用（最贵的操作之一）。
- 代价：**开关状态变了要等一帧**才生效；且 `onDraw` 重复定义会互相覆盖——同一脚本只能有一份，别在多个分支里各定义一次。
- **LOD 阈值用 `zoom > h/5`**（与屏幕高度挂钩）而非绝对值，换屏尺寸时行为一致。
- 每个 POI 一次 `map.mapToScreen` 不便宜；POI 超过约 50 个时应先按可见范围裁剪（见 `06` §4.3 只画可见网格）。
- 完整脚本：`../../../AI相关/_提取暂存/_new/3790163661_vehicle_9.lua`、`.../_vehicle_5.lua`、`.../_vehicle_6.lua`

---

## §17 地图配色**由单一背景色派生** + `...` 可变参数做默认参数

- 来源：steam id 3791754921 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3791754921 · 载具（MV Malahne 1937 可沉船，`_vehicle_0`）
- 更新时间：2026-08-29
- 用到：GPS、指南针（圈）、属性滑块（背景 RGB / 亮度）
- 亮点：**6 个 `setMapColor*` 只由 3 个滑块派生**（每级减 5 做亮度阶梯），省下 15 个属性槽位；指针函数用 `...` 收可选参数实现「默认半角」。

```lua
function onTick()
  zoom   = input.getNumber(3)
  mapX, mapY = input.getNumber(1), input.getNumber(2)
  compass = input.getNumber(4) * math.pi * 2 * -1     -- 圈 -> 弧度，取负是屏幕 Y 向下
  BR = property.getNumber("BackroundR")
  BG = property.getNumber("BackroundG")
  BB = property.getNumber("BackroundB")
  BRT = input.getNumber(5)                            -- 亮度(0~255)
end

function onDraw()
  local w, h = screen.getWidth(), screen.getHeight()

  -- ① 单一背景色派生 6 级地形配色（每级 -5，形成亮度阶梯）
  screen.setMapColorOcean   (BR,      BG,      BB)
  screen.setMapColorShallows(BR - 5,  BG - 5,  BB - 5)
  screen.setMapColorLand    (BR - 10, BG - 10, BB - 10)
  screen.setMapColorGrass   (BR - 15, BG - 15, BB - 15)
  screen.setMapColorSand    (BR - 20, BG - 20, BB - 20)
  screen.setMapColorSnow    (BR - 25, BG - 25, BB - 25)

  screen.drawMap(mapX, mapY, zoom)                    -- ⚠ setMapColor 必须在 drawMap 之前

  local CPX, CPY = map.mapToScreen(mapX, mapY, zoom, w, h, mapX, mapY)
  screen.setColor(0, 0, 0, BRT)
  drawPointer(CPX, CPY, 10, compass)                  -- ③ 半角用默认值 30 度
  drawPointer(CPX, CPY, 10, compass, 60)              --    也可显式覆盖

  -- ④ 四边描边（SW 没有 drawRect 描边版，用 4 个细矩形）
  screen.setColor(5, 5, 5)
  screen.drawRectF(0, 0, w, 2)   screen.drawRectF(0, 0, 2, h)
  screen.drawRectF(0, h-2, w, 2) screen.drawRectF(w-2, 0, 2, h)
end

-- ② `...` 收可选参数：不传就用默认半角 30 度
function drawPointer(x, y, s, r, ...)
  local a = ...
  a = (a or 30) * math.pi / 360                       -- 半角，度 -> 弧度
  x = x + s/2 * math.sin(r)                           -- 尖端前移半个尺寸
  y = y - s/2 * math.cos(r)
  screen.drawTriangleF(x, y,
    x - s*math.sin(r+a), y + s*math.cos(r+a),
    x - s*math.sin(r-a), y + s*math.cos(r-a))
end
```

**要点与坑**

- ⚠ **`setMapColor*` 必须在 `drawMap` 之前调用**，放在 `onDraw` 里每次绘制前设置最稳；放到 `onTick` 里无效。
- 派生配色省属性槽位，代价是**只能沿亮度轴变化**。要「绿色陆地 + 蓝色海洋」这种色相差异，还是得独立给每组 RGB（见 `05` §5.8 的 18 值写法）。
- `...` 默认参数比 `if a == nil then a = 30 end` 省字符，但**只能放在参数表末尾**；调用时不能传 `nil` 占位（传 `nil` 会真的拿到 `nil`，靠 `a or 30` 兜住）。
- 指针三角形：`s` 是**尺寸不是半径**，`s/2*sin(r)` 把尖端从中心推到圆上，两个后角按 `r ± a` 展开。
- 完整脚本：`../../../AI相关/_提取暂存/_new/3791754921_vehicle_0.lua`

---

## §18 触控按钮的**闭包写法**：一处定义、链式注册、自带按下计时

- 来源：steam id **3792551514** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3792551514> · **载具**（ABM "21X" Large Tender RHIB，`_vehicle_3`）
- 更新时间：2026-08-30
- 用到：触摸屏（触控坐标走复合输入，**不是** `screen` API）
- 亮点：把「按钮」做成一个**带私有状态的闭包**，注册回调用链式写法；按下时长用**计数器**而不是布尔，一套代码同时支持「按下瞬间 / 按住 / 松开瞬间 / 已按住 N 帧」。与 `05` §4.1（BKN 通用按钮）并列，本例更省字符、更贴合小脚本。

```lua
function cBtn()
  local c, cL = -1, -1                    -- c = 本帧计数；cL = 上一帧计数
  local oD, oP, oU                        -- 三个回调：onDown / onPressed / onUp
  return {
    onDown    = function(s, cb) oD = cb; return s end,   -- 🔑 返回 self，可链式
    onPressed = function(s, cb) oP = cb; return s end,
    onUp      = function(s, cb) oU = cb; return s end,
    isNotPressed = function() return c == -1 and cL == -1 end,
    isDown    = function() return c == 0 end,            -- 刚按下这一帧
    isPressed = function() return c > 0  end,            -- 按住中
    isUp      = function() return c == -1 and cL > -1 end,-- 松开这一帧
    handleEvents = function(s, p)
      c = p and (c + 1) or -1
      if c > 100 then c = 1 end           -- 防长时间按住溢出（视觉上无差别）
      if s:isDown()    and oD then oD() end
      if s:isPressed() and oP then oP() end
      if s:isUp()      and oU then oU() end
      cL = c
    end
  }
end

-- 注册：链式，一行一个按钮
function init()
  zIn = cBtn():onPressed(function() zoom = math.max(zoom - 0.1, 0.1) end)
  zOut= cBtn():onPressed(function() zoom = math.min(zoom + 0.1, 50)   end)
end

function onTick()
  touched = input.getBool(32)
  tX, tY  = input.getNumber(29), input.getNumber(30)
  if not touched then tX, tY = -999, -999 end     -- 🔑 没触摸时把坐标甩到屏外，命中判定自动为假
  local h2 = sh / 2
  zIn :handleEvents(touched and tX >= 0 and tX <= 8 and tY >= h2-8 and tY <= h2)
  zOut:handleEvents(touched and tX >= 0 and tX <= 8 and tY >= h2   and tY <= h2+8)
end
```

```lua
-- onDraw 里拿 isPressed() 做「按下的视觉反馈」
local c = zIn:isPressed()
screen.setColor(c and 0 or 120, c and 0 or 120, c and 0 or 120)   -- 按下时变黑
```

**要点与坑**

- 🔑 **用计数器而非布尔**：`c = -1` 未按下、`0` 刚按下、`>0` 按住中。`isUp()` 靠
  「现在是 -1 但上一帧 > -1」判定——**布尔写法抓不到「松开」这个事件**，这是本例最值钱的一点。
- **`if c > 100 then c = 1 end`** 不是为了防溢出（Lua 数字不会溢出），是为了让「按住时长」
  这个值**有界**，将来想做「按住 N 帧触发长按」时范围可控。
- 🔑 **未触摸时把坐标设成 -999** 是个小技巧：所有按钮的命中判定都写成「坐标在矩形内」的合取式，
  坐标一甩到屏外，全部自动为假，**不用给每个按钮单独写 `if touched then`**。
- 触控坐标来自**复合输入**（`input.getNumber(29/30)`），`onTick` 里取；`onDraw` 里**读不到输入**。
  屏幕宽高反过来只能在 `onDraw` 里用 `screen.getWidth()` 取——所以命中判定若要用到 `sh`，
  得在 `onDraw` 里把它存成全局（本例 `sh` 即如此）。
- 与 `05` §4.1 的 BKN 通用按钮比：BKN 版功能全（长按、双击、禁用态），本例 ~20 行、
  按下/按住/松开三语义齐全，**适合一个脚本里只有 2~5 个按钮的小 HUD**；
  与 `05` §13 的九宫格手势比：手势是**分区**，按钮是**精确矩形**，二者常共存（手势判在按钮之外）。
- 完整脚本：`../../../AI相关/_提取暂存/_new/3792551514_vehicle_3.lua`

---

## §19 不用位图：双次偏移描边 + 纯矢量小图标

- 来源：steam id **3792551514** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3792551514> · **载具**（`_vehicle_1` 开机标牌）
- 更新时间：2026-08-30
- 用到：显示器
- 亮点：**没有字宽 API、没有图片资源**时，用「同一段文字画两遍、错开 1 px」做出描边/阴影，用几条 `drawLine` 拼出可缩放的图标。

```lua
function onDraw()
  local w, h = screen.getWidth(), screen.getHeight()
  screen.setColor(0, 0, 0); screen.drawClear()

  screen.setColor(6, 6, 6)                                    -- 背景斜切色块
  screen.drawTriangleF(1, h/2+12, w, h/2, w/2+8, h/2)

  screen.setColor(180, 120, 20); screen.drawRect(0, 0, 95, 31)  -- 外框
  screen.setColor(110, 60, 4);   screen.drawRect(1, 1, 93, 29)   -- 内框（双线描边）

  -- 🔑 描边文字：先深色画在 (1,-5)，再亮色画在 (0,-5)，错开 1 px
  screen.setColor(26, 26, 26)
  screen.drawTextBox(1, -5, w, h, "AB", 0, 0)
  screen.drawTextBox(1,  2, w, h, "MARINE", 0, 0)
  screen.setColor(180, 120, 20)
  screen.drawTextBox(0, -5, w, h, "AB", 0, 0)
  screen.drawTextBox(0,  2, w, h, "MARINE", 0, 0)
end
```

```lua
-- 纯矢量图标示例：本作品导航页的「放大」图标（+ 号），6 条线搞定
screen.setColor(120, 120, 120)
screen.drawLine(4, h2-6, 4, h2-3)
screen.drawLine(3, h2-5, 6, h2-5)
```

**要点与坑**

- `drawTextBox` 的 `y` **可以是负数**（-5），文字被裁在屏幕上方只剩下半截——作者正是用这个
  做「大字只露出下半部分」的效果，比点阵字体省事。
- 双次绘制的**顺序固定：先暗后亮、亮的那次偏移更小**（或同为 0）。反过来会把亮色盖掉。
  偏移量 1 px 在 1×1（32 px）屏上已经很明显，2×2 以上建议 2 px。
- 画图标时把坐标写成 `h2±N`（相对屏幕中心）而不是绝对像素，**同一段代码在任意尺寸屏上位置都正确**，
  与 `05` §0.1 的非正方形适配是互补的两件事。
- 真要画复杂图形（NATO 符号、机型侧视图）再上 `05` §12 的符号库或点阵位图；
  只有「+ / - / R / L / C」这种单字符或小图形时，直接 `drawLine` 比维护字模表划算。
- 完整脚本：`../../../AI相关/_提取暂存/_new/3792551514_vehicle_1.lua`

---

## §20 触控工具条：`click` 闩锁做**单次触发 + 同帧互斥**，选中态用**阴影偏移**而不是变色

- 来源：steam id 3792693533 / vehicle.xml block#6（HMCS Albanel [1938]，地图标注工具条）
- 更新时间：2026-08-30
- 用到：触控屏、显示器、属性数字
- 亮点：一个 `click` 布尔既做「一次按下只触发一次」又做「同一次按下只能命中一个按钮」；
  「选中」不靠换色，而是**先在原位画一份纯黑半透明剪影、再把本体整体平移 -2 px**，
  图标看起来从面板上浮起来；同一条工具栏里混排「单选闩锁」与「瞬时长按」两种语义。

```lua
function isPointInRectangle(x,y, rx,ry,rw,rh)
  return x > rx and y > ry and x < rx+rw and y < ry+rh
end

selectedToolID = 0
click = true                                  -- KEY: 全局单次触发闩锁

function onTick()
  w, h = input.getNumber(1), input.getNumber(2)
  local iX,iY = input.getNumber(3), input.getNumber(4)
  local iP    = input.getBool(1)

  compassTool = iP and isPointInRectangle(iX,iY, 0,0,12,28)
  eraserTool  = iP and isPointInRectangle(iX,iY, 16,1,18,9)
  rulerTool   = iP and isPointInRectangle(iX,iY, w-38,1,37,9)
  pinTool     = iP and isPointInRectangle(iX,iY, w-12,13,10,11)

  if not iP then click = true end             -- KEY: 只在松手时重新上膛

  if click and compassTool then               -- 单选: 再按一次取消
    selectedToolID = (selectedToolID == 1) and 0 or 1
    click = false                             -- KEY: 吃掉本次按下
  end

  if eraserTool then                          -- 瞬时: 不占 click, 可长按连续擦
    selectedToolID = 0
    output.setBool(1, true)
  else
    output.setBool(1, false)
  end

  if click and rulerTool then
    selectedToolID = (selectedToolID == 3) and 0 or 3
    click = false
  end
  if click and pinTool then
    selectedToolID = (selectedToolID == 4) and 0 or 4
    click = false
  end
  output.setNumber(1, selectedToolID)
end

-- 每个图标写一对: 本体 + 剪影(同形状, 统一黑色半透明, 只留外轮廓)
function drawRuler(x,y, r,g,b)
  local L,H = 35,7
  screen.setColor(r,g,b) screen.drawRectF(x,y,L,H)
  screen.setColor(10,10,10)
  screen.drawLine(x+1,y+H-1, x+1,y+H-5)  screen.drawLine(x+L-2,y+H-1, x+L-2,y+H-5)
  for i=0,L-6,2 do screen.drawLine(x+3+i,y+H-1, x+3+i,y+H-3) end   -- 小刻度
  for i=6,L-6,8 do screen.drawLine(x+3+i,y+H-1, x+3+i,y+H-4) end   -- 大刻度
end
function drawRulerShadow(x,y,a)
  screen.setColor(0,0,0,a) screen.drawRectF(x,y,35,7)
end

offset = {}
function onDraw()
  w, h = screen.getWidth(), screen.getHeight()

  if selectedToolID == 3 then
    offset[3] = 2
    drawRulerShadow(w-37, 2, 100)           -- KEY: 影子留在原位
  else
    offset[3] = 0
  end
  drawRuler(w-37+offset[3], 2-offset[3], 100,50,0)   -- 本体右上平移 => 凸起

  if eraserTool then offset[2]=2 drawEraserShadow(18,2,100) else offset[2]=0 end
  drawEraser(18-offset[2], 2-offset[2], 0,0,0)
end
```

**要点与坑**

- 🔑 **`click` 闩锁比「记 `lastPress` 求上升沿」多一个副作用，而这个副作用正是想要的**：
  上升沿写法每个按钮各判各的，手指压在两个相邻按钮的重叠命中区上会**同帧触发两个**；
  本例第一个匹配到的按钮把 `click` 置 false，后面的 `if click and ...` 全部落空 ——
  天然「同帧只准一个按钮生效」，判定顺序即优先级。工具条按钮挨得近时这条很实用。
- 🔑 **「松开才重新上膛」而不是「按下才触发」**：`if not iP then click = true end` 放在所有判定之前，
  所以按住不放时 `click` 永远是 false，绝不会连发。要连发的按钮（如橡皮擦）就**别接 `click`**，
  直接用当前帧的 `eraserTool` —— 一条工具栏里同时存在「单选闩锁」和「瞬时长按」两种语义，
  区别仅在于要不要写 `and click`。这比 `02` §8 的「点动 + 长按连发」更简单，代价是没有连发速率控制。
- 🔑 **选中态 = 阴影 + 偏移，不是变色**。变色会跟「敌/友」「告警」等语义配色打架；
  偏移 2 px 是纯几何反馈，与配色完全解耦。代价是每个图标要写两份函数
  （`drawX` / `drawXShadow`），剪影版**只画外轮廓、丢掉所有内部细节**，
  统一 `screen.setColor(0,0,0,a)`，`a=100` 是半透明黑。
  与 `05` §19 的「双次偏移描边」是同一族技巧：都靠重复绘制 + 位移造立体感。
- ⚠ **命中矩形与绘制坐标是两套独立字面量**（`w-38,1,37,9` vs `w-37,2`），改图标位置必须同步改两处，
  是这段代码最大的维护隐患。建议抽成一张表 `TOOLS={{id=3,x=-38,y=1,w=37,h=9,draw=drawRuler}}`，
  命中与绘制都从表里取，参见 `05` §18 的闭包按钮注册写法。
- ⚠ `isPointInRectangle` 这里用**严格** `>` / `<`，即**不含边界像素**，
  与 `05` §13 里的 `>=` 版本差一圈 1 px。原作用 `18-2, 2-1, 18, 9` 这种「起点各退 1~2 px、
  宽高各放大 2~3 px」的写法把容错补回来了 —— 触控坐标是整数像素，边界不含时命中区实际比图标小，
  小图标（10x11）不放容错会明显点不中。
- `w`/`h` 在 `onTick` 里是从**输入通道**读的（上游传屏幕尺寸），`onDraw` 里才用 `screen.getWidth()`。
  同名全局被两个回调各写一次，靠「`onTick` 先于 `onDraw`」的执行顺序侥幸一致；
  更稳的做法是 `onDraw` 里只读不写、或统一改名。
- 完整脚本：`../../../AI相关/_提取暂存/_new/3792693533_vehicle_6.lua`

---

## §21 1x1 屏微型罗盘：刻度线端点**在 onTick 预计算** + 小刻度**吸附 45 度**去毛刺

- 来源：steam id 3794618673 / vehicle.xml block#3（Military Pilatus，1x1 HSI）
- 更新时间：2026-09-03
- 用到：显示器1x1、指南针、属性数字
- 亮点：32x32 像素塞进一整个航向指示器。三招：所有线段端点在 `onTick` 算好、`onDraw` 只遍历；
  非主方位的小刻度**把倾角吸附到最近的 45 度**，消掉小屏上的锯齿毛刺；
  度制/16 方位制由一个属性切换，2 字符方位名手动拉开间距。

```lua
tau = math.pi*2

function round(x, nearest)              -- KEY: 一行同时支持"取整"与"取到 nearest 的倍数"
  return nearest and (x/nearest+.5)//1*nearest or (x+.5)//1
end

cX, cY = 15.5, 15.5
outerLineRadius, innerLineRadius = 13.5, 10.5
degrees  = property.getNumber("Units") > 0
cardinal = {"N","NNE","NE","ENE","E","ESE","SE","SSE",
            "S","SSW","SW","WSW","W","WNW","NW","NNW","N"}   -- KEY: 17 项, 末项重复 N
lineCount = 16

lines = {}
for i = 0, lineCount+1 do lines[i] = {{},{},{},{}} end        -- 预分配

function onTick()
  heading = -input.getNumber(1)                        -- 圈值, 注意符号翻转

  if degrees then
    hdgString = math.floor(((heading+1)%1)*360 + 0.5)  -- KEY: (h+1)%1 把 -1..1 规范到 0..1
    if     hdgString < 10  then hdgString = string.format("00%i", hdgString)
    elseif hdgString < 100 then hdgString = string.format("0%i",  hdgString)
    else                        hdgString = string.format("%i",   hdgString) end
  else
    hdgString = cardinal[math.ceil(((heading+1)%1)*16 + 0.5)]
  end

  heading = (heading*tau) % tau

  for i = 0, lineCount do                              -- KEY: 端点全部预计算
    local lineAngle = ((i-1)/lineCount)*tau + heading + math.pi
    lines[i][1][1] = math.sin(lineAngle)*outerLineRadius + cX
    lines[i][1][2] = math.cos(lineAngle)*outerLineRadius + cY
    local deltaRadius = outerLineRadius - innerLineRadius

    if (i-1) % (lineCount/4) == 0 then                 -- 主方位 N/E/S/W: 真实角度, 加长 3 px
      lines[i][2][1] = math.sin(lineAngle+math.pi)*(deltaRadius+3) + lines[i][1][1]
      lines[i][2][2] = math.cos(lineAngle+math.pi)*(deltaRadius+3) + lines[i][1][2]
    else                                               -- KEY: 小刻度吸附到 45 度网格
      local snapped = round(lineAngle+math.pi, math.pi/4)
      lines[i][2][1] = math.sin(snapped)*deltaRadius + lines[i][1][1]
      lines[i][2][2] = math.cos(snapped)*deltaRadius + lines[i][1][2]
    end
  end
end

function onDraw()
  screen.setColor(2,3,4)  screen.drawRectF(-1,-1,34,34)
  screen.setColor(1,2,3)  screen.drawCircleF(cX,cY,15)

  for i = 0, lineCount-1 do
    if i == 1 then screen.setColor(60,0,0) else screen.setColor(40,40,40) end   -- i==1 是北
    screen.drawLine(lines[i][1][1],lines[i][1][2], lines[i][2][1],lines[i][2][2])
  end

  screen.setColor(0,139,139)                           -- 外环: 10 圈叠出 2 px 粗的抗锯齿边
  for i = 1, 10 do screen.drawCircle(cX,cY, outerLineRadius+1+(i/5)) end

  screen.setColor(12,13,14) screen.drawRectF(8,20,15,6) -- 读数窗
  screen.setColor(8,9,10)   screen.drawRect(8,20,15,6)
  screen.setColor(40,40,40)
  if #hdgString ~= 2 then
    screen.drawTextBox(8,21, 16,5, hdgString, 0)
  else                                                 -- KEY: 2 字符手动拉开, 别居中
    screen.drawText(11,21, string.sub(hdgString,1,1))
    screen.drawText(17,21, string.sub(hdgString,2,2))
  end
end
```

**要点与坑**

- 🔑 **`round(x, nearest)` 一行两用**：`nearest and A or B` 的短路表达式让同一函数既能
  `round(3.7)` → 4，又能 `round(3.7, 0.5)` → 3.5。`//1` 是 Lua 5.3+ 的向下整除
  （SW 的 Lua 支持），配 `+.5` 就是四舍五入；比 `math.floor(x+.5)` 少一次表查找。
- 🔑 **小刻度吸附 45 度是 1x1 屏专属技巧**。32x32 上一条 3 px 长的斜线，如果角度是任意值，
  渲染出来是几个孤立像素点，看着像脏点；吸附到 0/45/90/135 度后每条线都是标准的
  水平/垂直/对角像素序列，干净锐利。**代价是小刻度的朝向不再径向对齐**，
  但在 3 px 长度下人眼看不出来。主方位刻度（N/E/S/W）保留真实角度且加长到 6 px，
  用长度差而不是角度差来区分层级。
- 🔑 **端点预计算放 onTick、绘制放 onDraw**：一个 MC 可以驱动多块屏，`onDraw` 会**按屏数重复调用**；
  16 条线 x 4 次三角函数放在 `onDraw` 里，3 块屏就是 3 倍开销。凡「与屏幕无关的几何」
  一律上移到 `onTick`。⚠ 但 `lines` 里存的是**像素坐标**（已加 `cX/cY`），所以这份预计算
  只对固定 32x32 屏有效，多尺寸屏得改存归一化向量。
- 🔑 **`(heading+1) % 1` 把 -1..1 的圈值规范到 0..1**。SW 指南针输出可能为负，
  直接 `heading % 1` 在 Lua 里对负数返回非负（`-0.25 % 1 = 0.75`）其实也对，
  但 `+1` 写法意图更明确、也兼容其他语言习惯。参见 `04` §1.2 的角度环绕。
- 🔑 **`cardinal` 有 17 项、末项重复 `"N"`**：`math.ceil(x*16+0.5)` 在 `x` 趋近 1 时会得到 17，
  重复末项就不用写 `%16+1`，省一次取模。**「环绕查表多存一项」是省字数的通用小技巧**。
- 🔑 **2 字符与 3 字符分开排版**：`drawTextBox` 居中会把 `"NE"` 挤成中间一小坨；
  手动 `drawText(11,..)` / `drawText(17,..)` 拉开 6 px，视觉宽度与 3 字符的 `"NNE"` / `"090"` 一致。
  与 `05` §15「用 `log10` 算位数定偏移」是同一类问题的两种解法：本例只有 2/3 两种情况，
  写死比算 `log10` 便宜。
- ⚠ **`i == 1` 才是北，不是 `i == 0`**。因为角度用的是 `(i-1)/lineCount`，`lines` 表又从 0 开始存。
  这个 off-by-one 是刻意的（`i=0` 的那条线用来补屏幕边缘），抄的时候极易画错颜色。
- ⚠ **`lines[i] = {{},{},{},{}}` 分配了 4 个子表但只用前 2 个** —— 作者预留的扩展位。
  照抄时砍成 `{{},{}}`，省内存也省字数。
- **10 圈叠加画粗环**：`for i=1,10 do drawCircle(cX,cY, r+1+(i/5)) end`，半径每次 +0.2，
  叠出一条约 2 px 宽、边缘带渐变的环。SW 没有线宽 API，这是画粗圆的标准做法
  （对比 `drawCircleF` 大小圈相减 —— 后者需要背景色已知）。
- 完整脚本：`../../../AI相关/_提取暂存/_new/3794618673_vehicle_3.lua`

---

## §22 自定义位图字体（属性文本 ROM + 4 向旋转 + 位掩码解包）

- 来源：steam id 3791125295 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3791125295 · 载具（与 `3788750037` 的字体模块逐字节相同，后者 `vehicle_60` 亦同）
- 更新时间：2026-08-28
- 用到：属性文本 `property.getText`（FONT1 / FONT2 两段拼成字体 ROM）、`screen.drawRectF`、`&` 位测试
- 亮点：把 3×5 点阵字体塞进属性文本、按需旋转 4 向、用位掩码逐点解包——比 `09` §7 的整型位图更省、还能转
- 关联：`09` §7（位掩码字体）、`01` §3（大表搬进属性文本）、`05` §15（无字宽 API 时排版）

```lua
-- 字体 ROM 从两个属性文本槽拼成：每 4 字符一个 16 进制数 = 一个字符的 15 位 3×5 位图
FONT = property.getText("FONT1")..property.getText("FONT2")
FONT_D = {}  FONT_S = 0
for n in FONT:gmatch("....") do        -- 每 4 字符切一片（"0F2A" → tonumber(_,16)）
  FONT_S = FONT_S + 1
  FONT_D[FONT_S] = tonumber(n, 16)
end

-- dt(x,y,t,s,r,m): 在 (x,y) 画文字 t，s=像素大小，r=旋转(1/2横竖 3/4镜像)，m=是否留间距
function dt(x,y,t,s,r,m)
  s = s or 1  r = r or 1
  if r > 2 then t = t:reverse() end      -- 镜像：先反序
  t = t:upper()
  for c in t:gmatch(".") do
    ci = c:byte() - 31                   -- ASCII 偏移：'!'=33 → 1
    if 0 < ci and ci <= FONT_S then
      for i=1,15 do                      -- 15 位 = 3×5，逐位测试
        p = (r>2) and 2^i or 2^(16-i)    -- 位序随旋转方向翻转
        if FONT_D[ci] & p == p then
          xx, yy = ((i-1)%3)*s, ((i-1)//3)*s   -- 位序 → (列,行)
          if r%2 == 1 then screen.drawRectF(x+xx, y+yy, s, s)
          else screen.drawRectF(x+5-yy, y+xx, s, s) end   -- 竖排布局换轴
        end
      end
    end
    if FONT_D[ci] & 1 == 1 and not m then i = 2*s else i = 4*s end  -- 字符间距
    if r%2==1 then x = x+i else y = y+i end
  end
end
```

**要点速记**
- 槽位不够放大表？两段属性文本 `FONT1`+`FONT2` 用 `..` 拼，是 `01` §3 的标准做法。
- 位图存成**十六进制字符串**比整型常量更易读也好编辑；`gmatch("....")` 每 4 字切一片。
- 旋转/镜像全靠「位序翻转 + 轴交换」，不必为每朝向写一套字模。
- `&` 位测试在 SW Lua 可用（常规 Lua 5.3+ 特性，游戏内支持）。
- 没有 `getTextWidth`：字符间距用 `s` 或 `2*s/4*s` 硬算，呼应 `05` §15。

---

## §23 数值→RGB 的**分段线性色标**（温度蓝→红，4 段插值 + 钳位）

- 来源：steam id 3788743617 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617 · 载具
- 更新时间：（2026-08 批次）
- 用到：`screen.setColor`、阈值分段线性插值、`math.max/min` 钳位
- 亮点：把「一个物理量」映射成「连续渐变色」的最小实现——比查表省内存，比单阈值准
- 关联：`05` §2（负高度条形图着色）、`04` §1.4（clamp/lerp）

```lua
function temperatureColor(t)
  local r,g,b
  if t < 0 then                 -- 段1：深蓝→青
    local p = math.max(0, math.min(1, (t+20)/20))
    r = 0;  g = 45 + (70-45)*p;  b = 90 - (90-70)*p
  elseif t < 15 then            -- 段2：青→绿
    local p = t/15
    r = 0;  g = 70 - 10*p;  b = 70 - 40*p
  elseif t < 30 then            -- 段3：绿→橙
    local p = (t-15)/15
    r = 90*p;  g = 60 - 15*p;  b = 30 - 25*p
  else                         -- 段4：橙→红（封顶 p=1）
    local p = math.min(1, (t-30)/15)
    r = 90 + 10*p;  g = 45 - 40*p;  b = 5
  end
  return r,g,b
end
-- 用法：screen.setColor(temperatureColor(temp))  -- 直接喂三元组
```

**要点速记**
- 每段用 `p=(t-下界)/(上界-下界)` 归一，三通道各自线性混合；越界段把 `p` 钳到 `[0,1]`。
- 想换配色只改每段的端点 RGB，结构不变。
- 右对齐文本没有字宽 API，用 `string.len(text)*4`（4 px/字符）估偏移，呼应 `05` §15。
- 渐变背景同理：逐行 `t=y/(h-1)` 在两端色之间线性插值后 `drawLine(0,y,w,y)`。

---

## §24 量角器 + 距离环（极坐标刻度 + 扇形 `crc` + 属性滑块亮度/高亮）

- 来源：steam id 3794600080 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080 · 载具
- 更新时间：（2026-09 批次）
- 用到：属性 `property.getNumber/ getBool`（Brightness / Automatic Dimming / Highlight）、`pulse()` 闭包做长按循环、`drawCircleF` 画点
- 亮点：一个 `pulse` 闭包统一处理「边沿触发」替代多个布尔——比手写 touch 状态干净
- 关联：`05` §20（`click` 闩锁）、`02` §1（pulse 边沿检测）

```lua
-- pulse(c,b): 通道 b 的「刚按下」沿；c 当前态、用表按通道名记上次态
function pulse(c,b)
  if not a then a={}; a[b]={pulse=false,touch=false}
  elseif not a[b] then a[b]={pulse=false,touch=false} end
  a[b].pulse = c ~= a[b].touch and c   -- 仅当本次与上次不同(刚按下/刚松开)才置真
  a[b].touch = c
  return a[b].pulse
end

function protract(x,y)                  -- 量角器：每 30° 一根线、每 10° 一个点
  for i=0,330,30 do
    screen.drawLine(math.cos(i/180*pi)*25+x, math.sin(i/180*pi)*25+y, x, y)
  end
  for i=0,350,10 do
    screen.drawCircleF(math.cos(i/180*pi)*23+x, math.sin(i/180*pi)*23+y, 1)
  end
end

function crc(x,y,r,t)                   -- 距离环扇形：r/2 和 r/4 两圈虚点 + 刻度注记
  for i=0,359,1 do
    screen.drawCircleF(math.cos(i/180*pi)*(r/2)+x, math.sin(i/180*pi)*(r/2)+y, 0.7)
  end
  screen.drawText(x-4, 3+y-(w/2), t)   -- 量程数字（t="1nm" 等，来自 rng 表）
end

function onTick()
  cycle = pulse(input.getBool(1), "cycle")   -- 工具切换：点一下切一档
  manVal = property.getNumber("Brightness")
  manBool = property.getBool("Automatic Dimming")
  dark = manBool and (math.abs(time)*400) or (math.abs(manVal)*400)  -- 自动/手动调光
  if cycle then toolVal = (toolVal+1)%3 end     -- 三档工具循环
end
```

**要点速记**
- `pulse` 闭包按**通道名字符串**建状态表（不是全局变量），多路输入互不污染，且天然多人安全（状态走复合/表，见 `01` §5）。
- 角度环用 `i/180*pi` 把「度」喂给 `cos/sin`——注意这里是**度**（不是圈），别顺手 ×2π。
- `drawCircleF(...,0.7)` 半径 <1 像素 → 画成「点」，是 SW 里画虚线/散点的标准 tricks。
- 调光强度用 `abs(time)*400`，`time` 来自复合（屏幕时间），让 HUD 在夜间自动变暗。

---

## §25 全宽四等分触控行（quadrant row-band toggle + 状态配色）

- 来源：steam id 3794583580 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3794583580 · 载具
- 更新时间：（2026-09 批次）
- 用到：触摸屏复合（input1X/Y + isPressed）、`drawRectF` 行带分区、`isPointInRectangle` 命中测试
- 亮点：把屏幕**竖切成 4 条等高全宽行**做开关，比按钮网格更适合「模式选择」一类的 UI
- 关联：`05` §4（基础触控按钮）、`05` §18（`cBtn` 闭包）

```lua
function onTick()
  inputX = input.getNumber(3);  inputY = input.getNumber(4)
  isPressed = input.getBool(1)
  -- 每行 = 一条全宽带：y 起点 = k*h/4，高 = h/4
  isPressingMute = isPressed and isPointInRectangle(inputX, inputY, 0,     h/4*3, w, h/4)
  isPressingAuto = isPressed and isPointInRectangle(inputX, inputY, 0,     h/4,   w, h/4)
  output.setBool(1, isPressingMute)
  output.setBool(2, isPressingAuto)
end

function onDraw()
  w = screen.getWidth(); h = screen.getHeight()
  screen.drawLine(0, h/4,   w, h/4)     -- 三条分隔线把屏切成 4 行
  screen.drawLine(0, h/2,   w, h/2)
  screen.drawLine(0, h/4*3, w, h/4*3)
  -- 每行：开→亮底+亮字，关→暗底+暗字（状态靠配色区分，不搞图标）
  if auto then screen.setColor(0,50,0); screen.drawRectF(0, h/4*3+1, w, h/4-1)
  else        screen.setColor(0,5,0);  screen.drawRectF(0, h/4*3+1, w, h/4-1) end
  screen.drawTextBox(2, h/4*3+2, w, h/4, "auto")
end
```

**要点速记**
- 等分带比按钮网格简单：行带 y 起点 = `k*h/N`，命中测试只比 y 区间（外加 `x` 全宽）。
- 状态表现用「底色明度差」即可，`setColor(0,50,0)` vs `setColor(0,5,0)` 一目了然且省字符。
- 触控数据走复合通道 3/4（X/Y）+ 1（按下），与 `05` §4 完全一致。

---

## §26 雷达 PPI 屏绘制（距离环 + 扫描扇形 + 量程自适应）

- 来源：steam id 3788750037 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037 · 载具（同作品 `vehicle_25`；该作已学过，`06` §9 取新）
- 更新时间：（2026-08 批次）
- 用到：雷达量程 `rng`、复合方位 `rdrA`（圈）、`drawCircle` 距离环、`for k=..,0.0174533` 步进画扇形
- 亮点：把「雷达距离环 + 余晖扫描线」画法的核心两行提炼出来，量程变时环距自动变
- 关联：`03` §14（完整 PPI 渲染器）、`03` §5（PPI 基础）

```lua
function onDraw()
  rdrC = rng/2                       -- 量程(米) → 半径像素：rng/2 即「半量程=满屏宽」
  rdrCS = 25/rdrC                   -- 距离环步长：固定 25px 半径内画几圈
  screen.drawCircle(26, 27, 25)     -- 外圈
  for b=0,25,rdrCS do
    screen.drawCircle(26, 27, b)    -- 等距距离环（b 自动随量程变疏密）
  end
  -- 扫描扇形：从当前方位 rdrA 起，每 1°(0.0174533 rad) 画一条线，绿量随角度衰减
  if rad then
    for k=1.58,2.8,0.0174533 do
      screen.setColor(0, 255-(k*30), 0, 10)
      xtr = 26 + 25*math.cos(-k + rdrA)
      ytr = 27 + 25*math.sin(-k + rdrA)
      screen.drawLine(26, 27, xtr, ytr)
    end
  end
end
```

**要点速记**
- 距离环疏密随量程：用 `25/rdrC` 当 `for` 步长，`rdrC` 大→步长大→环少，自动适配。
- 扫描扇形用 `0.0174533`（=1° 的 rad）当步进，逐度画半透明线做出「余晖」感。
- 扇形起点 `1.58`、终点 `2.8` 是作者按屏布局选的角度窗口，换屏要改。
- 圆心 `(26,27)` 是 54×54 圆屏的几何中心；非正方形屏用 `(w+h)/4` 取平均半径（见 `03` §13）。


---
## §27 属性文本配色解析 + 闭包式触控组件 + 3×5 ROM 字体

- 来源：steam id 3794382107 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3794382107 · 载具（DLI Mongoose，作者 Domagoj29）
- 更新时间：2026-09-02
- 用到：`property.getText` 配色解析、闭包 `createPulse`/`createSRLatch`（触控闩锁）、3×5 ROM 点阵字体（属性文本存 hex + 位掩码解包）
- 亮点：① 属性槽位不够放多组 UI 配色 → 用 `gmatch("%d+")` 拆 `"R,G,B"`；② 触控 toggle 用"脉冲边沿 + SR 闩锁"两个闭包组合，比全局布尔稳；③ 字体塞进 3 段属性文本，4 位 hex/字符、15 位字模
- 关联：`01` §3.1（属性文本存配色）、`05` §22（同族 ROM 字体，带 4 向旋转）、`05` §18（`cBtn` 闭包按钮）

```lua
-- ① 配色解析：属性里写 "255,255,255" 这种字符串，拆成 {r,g,b} 表
local function propertyToColors(propertyName)
  local colors = property.getText(propertyName)
  local tempTable = {}
  for color in colors:gmatch("%d+") do          -- 按数字段切，自动忽略逗号
    table.insert(tempTable, tonumber(color))
  end
  return tempTable                              -- 例如 {255,127,0}
end
UIRGB = propertyToColors("UI color")            -- 之后 UIRGB[1..3] 直接喂 setColor

-- ② 闭包式触控组件：一个"边沿检测" + 一个"SR 闩锁"拼出自锁按钮
local function createPulse()
  local oldVariable = false
  return function(variable)                      -- 每次调用：上升沿才返回 true（按下的那一帧）
    local risingEdge = not oldVariable and variable
    oldVariable = variable
    return risingEdge
  end
end
local function createSRLatch()
  local output = false
  return function(set, reset)                    -- S=置位 R=复位，S&R 同为高则清零（稳妥优先）
    if set and reset then output = false
    elseif set then output = true
    elseif reset then output = false end
    return output
  end
end
local locatorPulse, locatorSRLatch = createPulse(), createSRLatch()
-- 用法：先用脉冲抓"刚按下"，再用闩锁翻状态；两个按钮互斥靠 reset 互相喂
local locatorPressed = locatorPulse(isPressed and touchRectF(...))
LocatorToggle = locatorSRLatch(locatorPressed and not LocatorToggle,
                                (locatorPressed and LocatorToggle) or TransponderToggle)

-- ③ 3×5 ROM 字体：3 段属性文本拼成字模表，每个字符 4 位 hex（15 位有效 + 1 位忽略）
FontString = property.getText("Font 1/3")..property.getText("Font 2/3")..property.getText("Font 3/3")
CharacterTable = {}
for hexValue in FontString:gmatch("....") do     -- 每 4 字符切一段 = 一个 16 位字模
  table.insert(CharacterTable, tonumber(hexValue, 16))
end
local function drawText(x, y, text, size, isUpsideDown, width, horizontalAlign)
  text = text:upper()
  for char in text:gmatch(".") do
    local key = char:byte() - 31                 -- ASCII 码 -31 当表键（空格=32→1）
    local charValue = CharacterTable[key] or 65534
    for i = 14, 0, -1 do                        -- 15 个像素位（3 列 × 5 行）
      local pixelX, pixelY = i % 3 * size, i // 3 * size
      if (charValue & 2 ^ (15 - i)) ~= 0 then   -- 位掩码逐个像素解包
        screen.drawRectF(x + pixelX, y + pixelY, size, size)
      end
    end
    x = x + 4 * size
  end
end
```

**要点速记**
- 🔑 **多组配色塞一个属性槽**：`property.getText` 返回字符串，用 `gmatch("%d+")` 按数字切分，比"一个属性放一个 0..255"省好几个槽位。注意 `tonumber` 后才进 `setColor`。
- 🔑 **触控自锁按钮 = 脉冲 + 闩锁两段**：`createPulse` 只在"刚按下那一帧"返回真（边沿），`createSRLatch` 把边沿翻成持续状态。比 `if pressed then toggle=not toggle end` 稳，因为后者在"按住不动"时会每帧翻转。
- 🔑 **两个按钮互斥**：把对方的状态喂进自己的 `reset`，谁先被按下谁清掉对方——无需全局 `if`。
- 🔑 **ROM 字体 4 位 hex/字符**：`gmatch("....")` 每 4 字符取一段；15 位有效像素（3×5），最高位忽略。`char:byte()-31` 把可打印 ASCII 映射到表下标。
- ⚠ 这套字体是 **3×5、无旋转** 的简化版；需要旋转/镜像看 `05` §22（同族、带 4 向旋转与 `&` 位掩码）。两者共用"`property.getText` 拼 ROM + `& 2^(15-i)` 解包"的思路。
- ⚠ `&`（按位与）在 SW Lua 里可用，但**只有整数参与**；字模必须是整数（hex 转来的是整数，OK）。
- 完整脚本：（../../../AI相关/_提取暂存/_new/3794382107_vehicle_8.lua）

---
## §28 自适应雷达网格 + 负坐标自动贴边按钮

- 来源：steam id 3783474598 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3783474598 · 载具（WARDEN Offshore Patrol Viewer）
- 更新时间：2026-08-14
- 用到：负坐标按钮表（解析一次 → 自动贴右/下边）、`l*w/z` 自适应量程间距、`z=z±z/170` 比例缩放、属性文本 ROM 字体 `dt()`
- 亮点：一套按钮布局用"负坐标 = 贴边"适配任意屏（1×1 / 3×2 / 5×3），只解析一次避免每帧外漂；雷达网格量程随屏占比自适应
- 关联：`05` §14（圆形视口反向遮罩 + 负坐标贴边）、`04` §9（按比例缩放 `z=z±z/170`）、`05` §22/§27（ROM 字体）

```lua
-- 按钮表：坐标用"负 = 贴右/下边"的约定，onTick 里一次性解析成绝对坐标
B={
  {title={"R","R"}, x=-6, y=1,  w=5, h=7, t=0, p=0},   -- x=-6 → 贴右边（w-6）
  {title={"+","+"}, x=-6, y=16, w=5, h=7, t=0, p=0},
  {title={"-","-"}, x=-6, y=24, w=5, h=7, t=0, p=0},
  {title={"1","2","3"}, x=1, y=1, w=5, h=7, t=mm, p=0},
}
function onTick()
  w=input.getNumber(1) h=input.getNumber(2)           -- 屏宽高（复合输入）
  for i,v in pairs(B) do
    if v.x<0 then v.x=w+v.x end                       -- ← 负 x：贴右边
    if v.y<0 then v.y=h+v.y end                       -- ← 负 y：贴下边
    if v.w<0 then v.w=w+v.w end
    if v.h<0 then v.h=h+v.h end
    if t then                                          -- 命中测试（矩形）
      if tx>v.x and tx<v.x+v.w and ty>v.y and ty<v.y+v.h then
        v.p=1
        if t and not last_t then                      -- 上升沿翻状态
          if i<2 then v.t=(v.t+1)%2 end
          if i>=4 then v.t=(v.t+1)%3 end
        end
      end
    else v.p=0 end
  end
  -- 比例缩放：按住 + 放大、按 - 缩小，步长与当前 z 成正比（不跳变）
  if z>1 and B[2].p>0 then z=z-z/170
  elseif z<math.max(rr,sr)*2/1000 and z<50 and B[3].p>0 then z=z+z/170 end
  -- 量程自适应：网格间距 l 随"l*w/z 占屏比例"翻倍/减半
  if l*w/z>h/4 then l=l/2 elseif l*w/z<h/8 then l=l*2 end
  last_t=t
end
function onDraw()
  for i=1,5 do screen.drawCircle(cx,cy,i*l*w/z) end    -- 距离环：环距随 l 自适应
  ...
  for i,v in pairs(B) do
    screen.drawRectF(v.x,v.y,v.w,v.h)                  -- 按钮框（已解析成绝对坐标）
    dt(v.x+1,v.y+1,v.title[v.t+1])                     -- ROM 字体画当前态标签
  end
end
```

**要点速记**
- 🔑 **负坐标 = 贴边**：按钮表写 `x=-6` 表示"距右边 6 px"，onTick 里 `if v.x<0 then v.x=w+v.x end` 一次性转成绝对坐标。**只解析一次**（在 onTick 开头、不在 onDraw），否则每帧都 `+w` 会越漂越远（见 `05` §14 坑）。
- 🔑 **一套布局通装多尺寸屏**：1×1 / 3×2 / 5×3 都靠"负坐标贴边 + 正坐标定左上"描述，作者不用为每种屏写一套。
- 🔑 **缩放用比例步长 `z=z±z/170`**：点一下微调、按住持续变，但每帧变化量正比于当前 z，高倍不暴冲、低倍不龟速（对比固定步长）。与 `04` §9 同源。
- 🔑 **网格量程自适应 `if l*w/z>h/4 then l=l/2 ...`**：让"可见网格间距"始终占屏合理比例，缩太小自动变稀、太大自动变密（防糊成一团或太空）。
- ⚠ `B` 表是**带状态的**（每个按钮有 `t`/`p`），多按钮共享一份表、`pairs` 遍历即可，省掉一堆独立变量。
- 完整脚本：（../../../AI相关/_提取暂存/_new/3783474598_vehicle_60.lua）


## §29 数据驱动按钮表：**绘制闭包 + 回调闭包共存一格**，每键独立冷却 + 分组互斥 + 多预设保存/加载

- 来源：steam id 3791924563 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3791924563 · 载具（Ray LX-28 OMUA 共轴双旋翼浮筒直升机，摄像头操控 HUD）
- 更新时间：2026-09-01
- 用到：按钮表 `btn`（每格带 `pos` 矩形 + `c` 绘制闭包 + `cB` 回调闭包 + `toggle` 语义）、分组门控 `dG`、每键冷却计数 `states[i].count`、三套预设 `camSettings`、窄屏自适应 `w<64`
- 亮点：**一个按钮 = 表里的一个元素**，画法与动作写在同一格里，加按钮不用改 `onTick`/`onDraw` 主体；同一张表靠 `grp` 字段切换成两套互斥面板
- 关联：`05` §18（闭包按钮 `cBtn`）、`05` §20（`click` 闩锁）、`05` §28（负坐标贴边按钮表）、`05` §0.1（非正方形适配）

```lua
-- 按钮表：pos=矩形, grp=所属分组, toggle=是否自锁, c=绘制闭包, cB=按下回调
btn={
  {grp="0",toggle=true, pos={x=1,y=1,w=11,h=11},
   c =function() screen.drawCircle(6,6,3) end,
   cB=function() dG="1" states[2].active=false end},        -- 点它 → 切到 1 组
  {grp="1",toggle=true, pos={x=1,y=1,w=11,h=11},
   c =function() screen.drawCircle(6,6,3) screen.drawLine(11,1,1,11) end,
   cB=function() dG="0" states[1].active=false end},        -- 点它 → 切回 0 组
  {grp="1",toggle=false,pos={x=13,y=1,w=10,h=10},nm="rot-",
   c =function() screen.drawTriangleF(21,3,21,9,15,6) end,
   cB=function() rot=rot-0.01*(1-zoom*0.8) end},            -- 按住连续转，步长随 zoom 收窄
  {grp="1",toggle=false,pos={x=1,y=13,w=10,h=10},nm="zoom+",
   c =function() screen.drawTextBox(2,14,8,8,"+",0,0) end,
   cB=function() zoom=zoom+0.01 end},
  {grp="1",toggle=false,pos={x=1,y=34,w=10,h=10},nm="nv",
   c =function() screen.drawTextBox(2,35,8,8,"N",0,0) end,
   cB=function() nv=not nv end},
}
function init()
  for i=1,#btn do states[i]={active=true,count=0} end
end
-- 冷却：被"禁用"的按钮数满 30 tick 自动复活（防一次按压连吞多帧）
function cooldown()
  for i=1,#btn do
    if states[i].active==false then states[i].count=states[i].count+1 end
    if states[i].count>=30 then states[i].active=true states[i].count=0 end
  end
end
function touchPad(tX,tY,tZ)
  if tZ==true then
    for i=1,#btn do
      -- 分组门控：只响应当前 dG 组的按钮；冷却中的按钮跳过
      if btn[i].grp==dG and states[i].active==true then
        if tX>=btn[i].pos.x and tX<=btn[i].pos.x+btn[i].pos.w then
          if tY>=btn[i].pos.y and tY<=btn[i].pos.y+btn[i].pos.h then
            btn[i].cB()
            if btn[i].toggle==true then states[i].active=false end  -- 自锁键按下后休眠
          end
        end
      end
    end
  end
end
```

```lua
-- 多预设：切换摄像头前先存旧的，再读新的（三套独立保存，回切不丢姿态）
function saveCamSettings()
  camSettings[curCam].pitch=pitch
  camSettings[curCam].rot=rot
  camSettings[curCam].zoom=zoom
  camSettings[curCam].nv=nv
end
function loadCamSettings()
  pitch=camSettings[curCam].pitch
  rot=camSettings[curCam].rot
  zoom=camSettings[curCam].zoom
  nv=camSettings[curCam].nv
end
-- 自动轮巡：180 tick 换一台；手动切换时立刻关掉轮巡
if autoMode then
  autoTimer=autoTimer+1
  if autoTimer>=180 then
    saveCamSettings()
    curCam=curCam+1
    if curCam>3 then curCam=1 end
    loadCamSettings()
    autoTimer=0
  end
end
```

```lua
-- onDraw：只画当前组的按钮；窄屏（1x1）自动降级配色与图标
local adv=isAdv()                                     -- 该摄像头是否高级型号
local gray=not adv and btn[i].nm
            and (btn[i].nm=="zoom+" or btn[i].nm=="zoom-" or btn[i].nm=="nv")
if gray then
  screen.setColor(10,10,10)                           -- 灰掉：外框压暗
  screen.drawRectF(btn[i].pos.x+1,btn[i].pos.y+1,btn[i].pos.w-2,btn[i].pos.h-2)
  screen.setColor(20,20,20)                           -- 图标也压暗
else
  screen.setColor(MENU_COLORS.border[1],MENU_COLORS.border[2],MENU_COLORS.border[3])
  screen.drawRectF(btn[i].pos.x,btn[i].pos.y,btn[i].pos.w,btn[i].pos.h)
  screen.setColor(MENU_COLORS.fill[1],MENU_COLORS.fill[2],MENU_COLORS.fill[3])
  screen.drawRectF(btn[i].pos.x+1,btn[i].pos.y+1,btn[i].pos.w-2,btn[i].pos.h-2)
  screen.setColor(MENU_COLORS.icon[1],MENU_COLORS.icon[2],MENU_COLORS.icon[3])
end
btn[i].c()                                            -- ← 图标由闭包自己画，主体不关心画什么
```

**要点速记**
- 🔑 **一格两闭包**：`c` 只管画、`cB` 只管做。`onDraw` 里 `btn[i].c()` 一行画完所有图标，加新按钮只往表里插一项，主循环零改动——比 `if i==1 then ... elseif i==2 then ...` 省一半字符。
- 🔑 **分组门控 `dG`**：同一张表靠 `grp` 字段分成多套面板（本例 "0"= 待机面板 / "1"= 操控面板），切换只改一个字符串。**两个位置重叠的按钮不会同时响应**（§20 的 `click` 闩锁是另一种解法：先到先得；这里是分组隔离，更彻底）。
- 🔑 **每键独立冷却 `states[i]`**：自锁键按下后 `active=false` 并计 30 tick，期间同一次长按不会反复翻转。注意它是**逐键独立**的，不像全局闩锁那样会误伤别的键。
- 🔑 **预设存/取分离**：`saveCamSettings()` / `loadCamSettings()` 包住切换动作，三台摄像头各存一套 pitch/rot/zoom/nv。这个"切走前存、切来后读"的模式，任何"一套 UI 管 N 个被控对象"的场景都能套。
- 🔑 **能力门控用同一套绘制分支**：本摄像头不支持的功能（`zoom±` / `nv`）画成灰块而不是隐藏——布局不跳、用户知道有这功能。
- ⚠ 原脚本还有个 `local pos=w<64 and -1 or 0` 的窄屏分支：1x1 屏（32 px）上把标题对齐方式从居中改成左对齐并去掉装饰，属于 `05` §0.1 的另一种做法（**按功能删减**而非留边）。
- ⚠ `toggle=false` 的按钮（zoom±、方向键）是**按住连续生效**的——`touchPad` 每帧都调 `cB()`。若想做"按一次走一格"，参考 `02` §8 的点动 + 长按连发。
- 完整脚本：（../../../AI相关/_提取暂存/_r6/3791924563_vehicle_4.lua）


## §30 横向滚轮分页（carousel）：**一条长画布 + lerp 平滑滚动**，4 页只用一套绘制代码

- 来源：steam id 3793547471 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3793547471 · 载具（Boeing 737 Max 10 freighter，客舱咖啡机 1×1 屏）
- 更新时间：2026-09-02
- 用到：页偏移 `32*(k+c[2])`、自写 `lerp`/`sgn`（不依赖 math 库）、按钮表内嵌回调 `p`、`t/2400` 进度写回数据表
- 亮点：**不做页面切换、不做裁剪**——把 N 个页面横向铺成一条 32*N 宽的长条，滚动量 `c[2]` 用 lerp 追目标页 `c[1]`，越界的页自动画到屏外。4 个页面共用同一段绘制代码
- 关联：`05` §29（按钮表闭包）、`04` §1.4b（`lerp` 归一化）、`05` §18（`cBtn` 按下/按住/松开）、`06` §6（MFD 位图按钮页框架——**另一种**分页：真切换）

```lua
s=screen
cT={{4,"Latte",1},{4,"Cappu",1},{4,"Ameri",1},{4,"Esspr",1}}  -- {单价, 名称, 制作进度 0..1}
c={0,0}          -- c[1]=目标页索引（整数，按 ←/→ 改）  c[2]=当前滚动量（浮点，lerp 追 c[1]）
bStates={        -- 按钮表：{按下态, x, w, y, h, ...} 数组槽 + p=回调闭包
  {false,1,7,-5,7,0,0,
   p=function ()                       -- 电源键（自锁）
     if not tp then
       bStates[1][1]=true
       bStates.l=1
       bStates[1][7]=1                -- [7]=目标开合动画量
       if bStates[1][6] > 0.9 then    -- [6]=当前动画量，到位后再按则关机
         on[1]=false on[3]=0 bStates[1][7]=0
       end
     end
   end},
  {false,27,4,24,5,
   p=function ()                       -- ← 上一页
     if not tp then
       bStates[2][1]=true bStates.l=2
       c[1]=c[1]+1*math.max(sgn(-c[1]-1),0)   -- 到 0 页就不再减（sgn 门控越界）
     end
   end},
  {false,7,18,4,22,
   p=function ()                       -- 确认制作
     if not tp and on[2]>0.8 and math.abs(c[1])-math.abs(c[2])< 0.2 then
       --                    ↑开机动画完成      ↑滚动还没停稳时不响应（防误触）
       bStates[4][1]=true
       cT[-c[1]+1][3]=0                -- 进度清零，开始制作
       t=0
     end
   end},
  l=1
}
function lerp(f,t)                     -- 自写：不引 math 库，20% 逼近
  return f+0.2*math.max(sgn(t-f)*t-sgn(t-f)*(f),0)*sgn(t-f)
end
function sgn(x)
  if x == 0 then return 1 end
  return (x/math.abs(x)) or 1          -- 0 返回 1（避免除零），Lua 里 0 也是真
end
function onTick()
  x, y = input.getNumber(3), input.getNumber(4)
  press = input.getBool(1)
  if on[1] and not bStates[4][1] then
    if press then
      if not tp then bStates[1][7] = 0 end   -- tp=上帧按下；新按下时清电源动画目标
      for _, bp in ipairs(bStates) do
        if x>bp[2] and x<(bp[2]+bp[3]) and y>bp[4] and y<(bp[4]+bp[5]) then
          bp.p()
          break                              -- ← 命中即停，一次只触发一个按钮
        end
      end
    else
      bStates[bStates.l][1]=false            -- 松手：清掉"上次按下的那个"的按下态
    end
  end
  -- 制作进度：2400 tick 走满（=40 s @60Hz），写回数据表第三列
  if bStates[4][1] then
    t=t+1
    cT[-c[1]+1][3]=t/2400
    if cT[-c[1]+1][3]>0.99 then bStates[4][1]=false cT[-c[1]+1][3]=1 end
  end
  on[2]=lerp(on[2],on[3])                    -- 开机淡入：0→1 平滑
  c[2]=lerp(c[2],c[1])                       -- 滚动：当前→目标页
  bStates[1][4],bStates[1][6]=-5+5*bStates[1][6],lerp(bStates[1][6],bStates[1][7])
  tp = press
end
```

```lua
-- onDraw：4 个杯子一字排开，横向坐标 = 32*(页序 + 滚动量)，屏外的自动看不见（无需裁剪）
s.drawTriangleF(7+2*(1-cT[2][3])+32*(1+c[2]), 10+15*(1-cT[2][3]),
                9+32*(1+c[2]), 25, 22+32*(1+c[2]), 25)
s.drawTriangleF(7+2*(1-cT[1][3])+32*c[2],     6+19*(1-cT[1][3]),
                9+32*c[2],     25, 22+32*c[2],     25)
s.drawTriangleF(7+2*(1-cT[3][3])+32*(2+c[2]), 6+19*(1-cT[3][3]),
                9+32*(2+c[2]), 25, 22+32*(2+c[2]), 25)
s.drawText(4+32*(1+c[2]),12.5,"Cappu")
s.drawText(4+32*c[2],    12.5,"Latte")
-- 翻页箭头：按下时换高亮色（蓝色）
s.setColor(41,137,255)
if bStates[2][1] then s.drawText(1,25,"<") end
if bStates[3][1] then s.drawText(28,25,">") end
```

**要点速记**
- 🔑 **一条长画布**：`32*(k+c[2])` 把第 k 页放到横向 32*k 处，`c[2]` 是浮点滚动量。**超出屏宽的部分 SW 会自动裁掉**（画在屏外的图元不显示），所以完全不用写裁剪逻辑——这是 1×1/窄屏做多页最省字符的办法。
- 🔑 **lerp 平滑**：`c[2]=lerp(c[2],c[1])`，按键只改整数目标 `c[1]`，视觉上滑过去。滚动未停稳时用 `math.abs(c[1])-math.abs(c[2])<0.2` 屏蔽确认键，防"滑到一半误按"。
- 🔑 **越界门控用 `sgn` 而非 `if`**：`c[1]=c[1]+1*math.max(sgn(-c[1]-1),0)` —— 到边界时 `sgn` 变负、`math.max(...,0)` 归零，加数变 0，一行搞定双向限位。**自写 `sgn(0)=1` 很关键**（否则 `0/0` 出 `nan`，`nan` 参与比较恒 false，限位失效，见 `09` §11）。
- 🔑 **按钮表用数组槽 + `p` 闭包**：`{按下态, x, w, y, h, ...}` 五项定矩形，回调挂在 `p` 上；遍历时 `break` 保证一次只触发一个（等价 `05` §20 的 `click` 闩锁）。松手清状态靠记住 `bStates.l`（上次命中的下标）。
- 🔑 **进度写回数据表**：`cT[idx][3]=t/2400`，数据（名称/价格/进度）与 UI 状态同表，绘制时直接读——不用额外维护一个平行表。
- ⚠ **翻页方向与下标符号**：本例 ← 是 `c[1]` 递增（因为画布往右移），`-c[1]+1` 换算出 `cT` 的下标。改这套代码前先确认"页序 ↔ 数据下标"的映射方向，否则按 ← 会跳到右边那页。
- ⚠ `lerp` 是**无限逼近**，永远不会精确等于目标；判"到位"要用阈值（如 `>0.9`、`abs差<0.2`），不能写 `c[2]==c[1]`。
- 完整脚本：（../../../AI相关/_提取暂存/_r6/3793547471_vehicle_16.lua）


## §31 触控手势三合一（单击 / 双击 / 长按加速）+ `button()` **绘图与命中合一**

- 来源：steam id 3786043607 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3786043607 · 载具（"the mouth" cargo crawler，地图屏）
- 更新时间：2026-08-27
- 用到：tick 计数 `t`、`lct` 上次点击时刻、`ltd` 上帧按下态；30 tick 双击窗口；`button()` 画矩形并返回命中；长按加速 `ht`；`map.screenToMap` / `map.mapToScreen`
- 亮点：**一个 `button(x,y,w,h)` 同时完成"画出来 + 判命中"**，调用处 `if button(0,0,6,6) and hbON then` 一行搞定；双击与单击共用一套边沿检测，长按带加速度
- 关联：`05` §18（`cBtn` 按下/按住/松开三语义）、`02` §8（点动 + 长按连发）、`06` §11（缩放闭包 capacitor）、`06` §8（地图三件套）

```lua
t=0      -- tick 计数（10 分钟约 3.6e4，不会溢出）
ht=0     -- 长按累积量（做加速步长）
ltd=false-- 上帧是否按下
lct=0    -- 上次"单击"发生的 tick
dc=false -- 本帧双击？
c=false  -- 本帧单击？
function onTick()
  dc=false
  c=false
  t=t+1
  hbON=t%5==0            -- 长按的重复节拍：每 5 tick 触发一次（12 次/秒）
  tx=input.getNumber(1)
  ty=input.getNumber(2)
  if input.getNumber(3)==0 then        -- ⚠ 本作品用"数值通道 0/1"表示触摸，不是 getBool
    tp=false
    if ltd then                        -- ↓ 松手这一帧才判单击/双击
      if t-lct<=30 then dc=true        --   30 tick = 0.5 s 内再次松手 → 双击
      else              c=true lct=t end
    end
    ltd=false
  else
    tp=true ltd=true
  end
  gx=input.getNumber(4) gy=input.getNumber(5)
  mx=lockplayer==0 and fx or gx        -- 0=自由视角，1=跟随 GPS
  my=lockplayer==0 and fy or gy
  if zoom<0.1 then zoom=0.1 end
  if zoom>50   then zoom=50   end
end
```

```lua
-- 🔑 画矩形 + 返回是否命中：调用处既是绘制语句又是条件
function button(rectX, rectY, rectW, rectH)
  screen.drawRectF(rectX,rectY,rectW,rectH)
  return tx > rectX and ty > rectY and tx < rectX+rectW and ty < rectY+rectH and tp
end
function onDraw()
  screen.drawMap(mx,my,zoom)
  -- 长按加速：按住时 ht 每节拍 +0.01，松手复位（步长越按越大）
  if tp and hbON then ht=ht+0.01
  else if not tp then ht=0.01 end end
  -- 双击地图任意处 → 设/清航路点（screenToMap 把像素反投影成世界坐标）
  if dc then
    wx,wy=map.screenToMap(mx,my,zoom,screen.getWidth(),screen.getHeight(),tx,ty)
    we=(we+1)%2
  end
  dist=math.floor(math.sqrt((math.abs(gx-wx)^2)+(math.abs(gy-wy)^2)))
  screen.setColor(255,255,255)
  cx,cy=map.mapToScreen(mx,my,zoom,screen.getWidth(),screen.getHeight(),wx,wy)
  px,py=map.mapToScreen(mx,my,zoom,screen.getWidth(),screen.getHeight(),gx,gy)
  screen.drawCircle(px,py,2)
  if we==1 then
    screen.drawCircle(cx,cy,2)
    screen.drawLine(px,py,cx,cy)
    -- 距离标签底衬：宽度按位数自适应（#字符串 * 5 px，SW 没有 getTextWidth）
    screen.setColor(0,0,0)
    screen.drawRectF(px-1,py+4,((#(dist..""))*5)+1,5)
    screen.setColor(255,255,255)
    screen.drawText(px,py+4,dist.."")
  end
  -- 缩放按钮：按住时每节拍走 ht（越按越快）
  screen.setColor(0,0,0)
  if button(0,0,6,6) and hbON then zoom=zoom-ht end
  if button(0,7,6,6) and hbON then zoom=zoom+ht end
  -- 跟随/自由视角切换：用"按下 → 松手单击"两段式，避免按住时反复翻转
  if screen.getHeight()>32 then
    if button(0,14,6,6) then
      lockplayerlaston=true
    else
      if lockplayerlaston and c then
        lockplayer=(lockplayer+1)%2
        fx=gx fy=gy                    -- 🔑 切到自由视角瞬间，把自由中心设为当前位置 → 不跳变
      end
      lockplayerlaston=false
    end
  end
end
```

**要点速记**
- 🔑 **`button()` 画 + 判合一**：`if button(x,y,w,h) and hbON then ...`。省掉"先画一遍、再写一个 `inRect`"，按钮多时字符数差异明显。副作用是**顺序即绘制顺序**，命中判定必须在 `onDraw`（因为要 `screen`），本例就是把输入处理整个搬进了 `onDraw`。
- 🔑 **单击 / 双击共用一次边沿**：只在**松手帧**判定，`t-lct<=30`（0.5 s）内第二次松手算双击。注意顺序——先判双击、否则才算单击并刷新 `lct`，所以双击时不会再额外触发一次单击。
- 🔑 **长按 = 节拍 + 加速**：`hbON=t%5==0` 把"每帧触发"降到 12 次/秒；`ht` 每节拍 +0.01，于是缩放步长随时间增大（先是微调，按住久了变快）。这比"固定步长 + 首次延迟"（`02` §8）手感更连续，适合连续量（缩放、平移），不适合离散量（档位）。
- 🔑 **切换视角时先同步基准**：`fx=gx fy=gy` 再切标志，否则从"跟随"切到"自由"的瞬间镜头会跳回上次自由视角的位置。
- 🔑 **底衬宽度 `#(dist.."")*5`**：SW 没有字宽 API，用字符串长度估位宽（`05` §15 用 `log10`，这里更省）。
- ⚠ **触摸状态用数值通道判**：本作品是 `input.getNumber(3)==0` 表示未触摸。多数作品用 `input.getBool(1)`。**照抄前先确认你的接线是哪种**，判反了会发现"一直处于按下状态"。
- ⚠ `dc`/`c` 在 `onTick` 里算、在 `onDraw` 里用是可以的（同一帧内 onTick 先于 onDraw）；但反过来把 `map.screenToMap` 放进 `onTick` 会拿不到触控坐标——**触控坐标只能从 input 读，而 input 在 onDraw 里读同样有效**，所以本例干脆把交互全放 onDraw。
- 完整脚本：（../../../AI相关/_提取暂存/_r6/3786043607_vehicle_0.lua）

## §32 虚拟摇杆拖动地图 + `drawTextBox` **全屏对齐**贴四边（不用 `getTextWidth` 也能精确贴边）

- 来源：steam id 2948687255 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=2948687255 · 载具（26m V80 Superyacht，`_vehicle_0` 导航屏）
- 更新时间：2023-03-19
- 用到：触控屏、`screen.drawMap` / `map.mapToScreen` / `map.screenToMap`
- 亮点：**拖动量按当前缩放加权**（`dx * z`），任何倍率下「手指挪 10 px、地图挪多远」的**视觉距离**都一致；**用一个铺满全屏的 `drawTextBox` 加对齐参数**把方位数字钉到四条边上——SW 没有 `getTextWidth`，这是唯一不依赖量字宽的贴边办法
- 关联：`05` §15（`log10` 估位宽，另一条路）、`06` §8（拖动平移）、`04` §9.1（px→m 标定）、`05` §0.1（非正方形适配）

```lua
function Norm(x,y) return M.sqrt(x^2+y^2) end
function Button(x,y,rx,ry,rw,rh)
  return x>rx and y>ry and x<rx+rw and y<ry+rh
end

function onTick()
  w,h,tx,ty = iN(1),iN(2),iN(3),iN(4)
  tp = iB(1)
  z  = M.exp(Z)                                  -- 对数域缩放，见 04 §9.1

  -- ① 🔑 虚拟摇杆：以 (w-20, h-20) 为圆心、半径 14 的圆形判定区
  if tp and Norm(w-20-tx, h-20-ty)<14 then
    -- 屏幕位移 × 倍率 = 世界位移；不乘 z 的话放大后手指一划就飞出几十公里
    x = x + (tx-w+20)*z
    y = y + (h-20-ty)*z                          -- 注意 Y 取反（屏幕向下为正）
  end

  -- ② 归位键 / 外部按钮：把地图中心拉回外部输入的坐标（例如本船 GPS）
  if (tp and Button(tx,ty,w-44,h-33,6,6)) or iB(3) then
    x,y = iN(11),iN(12)
  end
end

function onDraw()
  ...
  -- ③ 摇杆可视化：没拖时杆头在圆心，拖出去时画一根杆
  dC(w-20,h-20,15)
  if tp and Norm(w-20-tx,h-20-ty)<14 then
    dCF(tx,ty,4)  dL(w-20,h-20,tx,ty)
  else
    dCF(w-20,h-20,4)
  end

  -- ④ 🔑 一个铺满全屏的文本框 + 对齐参数，把四个方位数字钉到四条边
  --    drawTextBox(x,y,w,h, 文本, hAlign, vAlign)
  --    hAlign: -1=左 0=居中 1=右    vAlign: -1=上 0=居中 1=下
  dTxB(0,0,w,h,"0",   0,-1)   -- 上边居中
  dTxB(0,0,w,h,"90",  1, 0)   -- 右边居中
  dTxB(0,0,w,h,"180", 0, 1)   -- 下边居中
  dTxB(0,0,w,h,"270",-1, 0)   -- 左边居中
end
```

**为什么这样写**

- **拖动为什么要乘 `z`**：`drawMap(x,y,z)` 的 `z` 决定「屏幕半宽代表多少米」，屏幕 1 px 对应的世界距离正比于 `z`。不乘的话，低倍（z 小）时拖半天纹丝不动、高倍（z 大）时轻轻一划就飞出去；乘了以后**任何倍率下拖动速度都与画面变化一致**。
  - 更精确的做法是把 px→m 标定出来（用 `mapToScreen` 量 1 m 的像素数 `e`，见 `04` §9.1），位移写成 `dx/e`。本例直接用 `z` 是省事版，误差在一个常数因子内，手感调 `z` 的系数即可。
- **摇杆 vs 全屏拖动**：摇杆只占右下角一块固定区，好处是「不拖动的地方可以直接点选」——本例点空白处是取坐标、测距离（见 `06` §16）；坏处是拖动手感不如全屏直接拖。选哪个看这块屏还要不要干别的事：要干就用摇杆，纯地图就全屏拖。
- **圆形判定区用 `Norm(dx,dy)<R`** 而不是矩形，是因为手指落点在摇杆边缘时矩形会把角上的点也算进来，拖动会「跳」。半径 14、底盘 15 是配套的。
- **`drawTextBox` 贴边比手算坐标可靠**：SW 没有 `getTextWidth`，用 `drawText` 想贴右/贴下只能靠 `log10` 估位宽（`05` §15），换字号、换内容就失准。文本框的对齐参数是引擎算的，永远准，而且**一次调用把整个屏幕当容器**，四个方向各调一次即可。
- ⚠ 本例的方位排布是 0(上) / 90(右) / 180(下) / 270(左)，与常见罗盘玫瑰（0 在右、90 在下）不同。抄之前先确认你的屏是「北朝上」还是「船艏朝上」，别把顺序也一起抄了。
- 完整脚本：`../../../AI相关/_提取暂存/_r7/2948687255_vehicle_0.lua`

## §33 地图配色：**方案表 + 函数指针表**批量调用 + `setMapColor*` 写在 `drawMap` 之后的真实后果

- 来源：steam id 3792551514 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3792551514 · 载具（ABM "21X" Large Tender RHIB，硬壳充气艇※，`_vehicle_3` 导航/雷达屏）
- 更新时间：2026-08-30
- 用到：8 个 `screen.setMapColor*`、`property.getNumber('Map Color')` 选配色方案、`map.mapToScreen` 做 px→m 标定
- 亮点：**把 8 个 `setMapColor*` 存成函数表**、`ipairs` 一一对应批量调用，三套配色只花一份代码；顺带澄清一个常见误解——**`setMapColor*` 写在 `drawMap` 之后并不会「没效果」**
- 关联：`05` §6.3（地图配色 8 组 24 通道）、`05` §17（`setMapColor*` 的调用时机）、`04` §9.1（px→m 标定）、`01` §3（大表搬进属性文本）

```lua
-- 🔑 三套配色 × 8 种地形 × RGB：索引 1 = 方案号
MCP={
  { {16,16,16},{30,30,30},{55,55,55},{35,35,35},   -- 1 Grey：Ocean/Shallow/Land/Grass
    {65,65,65},{180,180,180},{50,50,50},{70,70,70} },  --            Sand/Snow/Rock/Gravel
  { {10,30,30},{20,45,55},{60,60,55},{45,55,30},
    {85,80,35},{200,200,200},{55,55,50},{75,70,55} },  -- 2 Faded
  { {16,16,16},{10,25,10},{5,35,5},{0,55,0},
    {0,76,0},{0,76,0},{15,45,15},{25,65,25} }          -- 3 Green
}
-- 🔑 函数指针表：顺序必须与 MCP 内层顺序严格一致
MCF={sc.setMapColorOcean,sc.setMapColorShallows,sc.setMapColorLand,sc.setMapColorGrass,
     sc.setMapColorSand,sc.setMapColorSnow,sc.setMapColorRock,sc.setMapColorGravel}
MAP_COLOR=property.getNumber('Map Color')      -- 0 = 不覆盖（用游戏默认色）

function onDraw()
  sw,sh=sc.getWidth(),sc.getHeight()
  local mx,my=gpsX+mapOX,gpsY+mapOY            -- 地图中心 = 本船 + 拖动偏移
  sc.drawMap(mx,my,zoom)
  -- 🔑 原文把 setMapColor 写在 drawMap 之后（对照 05 §17 的「必须在之前」）
  if MAP_COLOR>0 and MCP[MAP_COLOR] then
    local cp=MCP[MAP_COLOR]
    for i,f in ipairs(MCF) do
      f(cp[i][1],cp[i][2],cp[i][3],200)        -- 第 4 参是 alpha
    end
  end

  -- 网格：2 的幂自适应步长（对照 04 §9.1 的十进制跳档）
  if GRID and zoom>0 then
    local g=2^(mf(math.log(zoom/0.1953125,2)))*31.25
    local xt,yt=mf(mx/g),mf(my/g)
    sC(255,255,255,15)
    for G=xt-6,xt+6 do
      local ox=map.mapToScreen(mx,my,zoom,sw,sh,g*G,my)
      sL(ox,0,ox,sh)
    end
    for H=yt-6,yt+6 do
      local _,oy=map.mapToScreen(mx,my,zoom,sw,sh,mx,g*H)
      sL(0,oy,sw,oy)
    end
  end

  -- 🔑 px→m 标定：量出「1000 m 是多少像素」，量程/距离环都基于它
  local ssx,ssy=map.mapToScreen(mx,my,zoom,sw,sh,gpsX,gpsY)
  local pxKm=math.max(0.01,math.abs(map.mapToScreen(mx,my,zoom,sw,sh,gpsX+1000,gpsY)-ssx))
  local rPx=RRange/1000*pxKm                   -- 雷达量程(m) → 像素半径
  sC(0,170,0,45) sDC(ssx,ssy,rPx)
end
```

**为什么这样写**

- **函数指针表把 24 行压成 4 行**：直接写要 `setMapColorOcean(c[1][1],c[1][2],c[1][3],200)` 重复 8 遍。存成 `MCF` 后 `for i,f in ipairs(MCF) do f(...) end` 一次搞定，还能顺手加统一 alpha。
  - ⚠ **两张表的顺序必须严格对齐**：`MCF[i]` 对应的地形要和 `MCP[..][i]` 一致，写错一个就变成「把雪的颜色刷到海面上」。建议两表紧挨着定义，并在注释里标出 8 种地形的顺序。
- **`MAP_COLOR>0` 留一个「不覆盖」档**：属性滑块默认 0 表示用游戏默认配色，玩家忘了设也不至于得到一张全黑的图。凡是「可选覆盖」的属性都该留一个 0 档。
- **关于 `setMapColor*` 的调用时机（修正 `05` §17 的绝对化表述）**：`setMapColor*` 是**全局持久状态**，不是逐帧的一次性指令。写在 `drawMap` **之后**的真实后果是**本次绘制用的是上一次设的值**——即延迟一帧生效。因为本例每帧都设，所以从第 2 帧起颜色就恒定正确，肉眼无差别；只有**第 1 帧**是默认色（一闪而过，实测基本看不出来）。
  - 所以严格写法仍是「先 `setMapColor*` 再 `drawMap`」（见 `05` §17），照抄本例的顺序属于「能跑但不严谨」。**真正会出问题的是把它放进 `onTick`**——那样跨帧时序完全不受控。
- **px→m 标定用两次 `mapToScreen` 相减**：`mapToScreen(x,y,z,w,h, gpsX, gpsY)` 与 `(..., gpsX+1000, gpsY)` 的横坐标之差就是「1000 m 折合多少像素」。比手推公式可靠，缩放/屏尺寸变了自动跟着变。取 `math.max(0.01, ...)` 是防除零（`04` §10 的同款坑）。
- **`2^(floor(log2(zoom/0.1953125)))*31.25` 自适应网格步长**：`0.1953125 = 1/5.12`、`31.25` 是作者标定出的常数，效果等价于「找最接近当前缩放的 2 的幂档」。与 `04` §9.1 的十进制跳档是两种口味，二选一即可。
- 完整脚本：`../../../AI相关/_提取暂存/_r6c/3792551514_vehicle_3.lua`

## §34 连线**两端内缩**（单位向量 × 内缩量）：让线不穿过端点标记

- 来源：steam id 3794992381 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3794992381 · 载具（BlackHawk，`_vehicle_13` 航路点地图页）
- 更新时间：2026-09-03
- 用到：`screen.drawLine`、航点坐标表
- 亮点：**先算单位向量、再在两端各退 `cal` 个像素**，航路点的小圆点/十字标记就不会被连线从中间穿过；`cal` 还按缩放同步缩放（`5/(zoo^zoom)`），放大时留白不变得突兀
- 关联：`05` §5.1（线段/射线原语）、`06` §12（航路点链式连线）、`04` §9.1（px→m 标定）

```lua
cal = 5/(zoo^zoom)          -- 🔑 内缩量按缩放同步：zoo=5, zoom 是可变指数
if cal > 5 then cal = 5 end -- 上限夹住，低倍缩放下不要缩成一大段空白

function drawEdgeLine(idxA, idxB)
  local xA,yA = TXS[idxA], TYS[idxA]     -- 已投影到屏幕的航点像素坐标
  local xB,yB = TXS[idxB], TYS[idxB]
  local dx,dy = xB-xA, yB-yA
  local len = math.sqrt(dx*dx + dy*dy)
  if len == 0 then return end            -- ⚠ 两点重合时 len=0，不判会除零得 nan
  local ux,uy = dx/len, dy/len           -- 单位向量
  s.drawLine(xA + ux*cal, yA + uy*cal,   -- 起点往前推 cal
             xB - ux*cal, yB - uy*cal)   -- 终点往回退 cal
end
```

**为什么这样写**

- **内缩的本质是「在线段两端各剪掉一小段」**：单位向量 `ux,uy` 表达了方向，乘以 `cal` 就是「沿这个方向走多少像素」。起点 `+`、终点 `-`，中间那截才是要画的线。
- **`cal` 跟着缩放走**：`5/(zoo^zoom)` 是作者用的幂函数标定（`zoo=5` 为底、指数 `zoom` 可变，是 `04` §9.1 对数域缩放之外的第三套写法）。这样放大地图时内缩量同步变小，留白在视觉上恒定。上限 `cal>5 → 5` 是防止低倍缩放下内缩量爆炸。
- ⚠ **两个必写的保护**：① `if len == 0 then return end`——两个航点重合（同一点录了两次）时 `0/0 = nan`，`nan` 传进 `drawLine` 会让整条线消失且**不报错**；② `cal` 必须夹上界，否则线段短于 `2*cal` 时会画成「反向」的一小截。
- **什么场合需要**：端点画的是实心圆点、十字、图标（有面积）时都该内缩；端点只是像素点（`drawRectF(x,y,1,1)`）时缩 1~2 px 就够，不缩也行。
- 完整脚本：`../../../AI相关/_提取暂存/_r7c/3794992381_vehicle_13.lua`

---

## §35 开机自检动画：**长按开机 + 逐行日志 + 进度条** + 窄屏双布局

- 来源：steam id 3795317652 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3795317652 · 载具（Sleipnir 6x6 01A1，`_vehicle_3` VEGVISIR 地图模块）
- 更新时间：2026-09-04
- 用到：`screen.drawClear`、触控长按计数、属性滑块（启动步长 / 自动展开延时）
- 亮点：**用「按住不放」累积一个计数器驱动整套开机演出**——松手立即归零，所以「长按多久开机」是可调的；窄屏用 `W>=80` 切两套布局，同一份代码适配 1×1 与 5×3
- 关联：`05` §0.1（非正方形适配）、`05` §4.2（长按的另一种语义）、`05` §5.6（半透明信息条）

```lua
local bt,opened = 0,false        -- bt=长按计数  opened=是否已开机
local p,pp = false,false         -- p=按键当前值  pp=上一帧（做边沿）
local st = math.max(.05, property.getNumber("Startup Step Time"))  -- 每步秒数
local ad = math.max(0,  property.getNumber("Auto Open Delay"))     -- 自动展开延时(秒)

function onTick()
  p = input.getBool(3)
  if p and not pp then bt=0 opened=false end   -- 刚按下：从零开始
  if not p        then bt=0 opened=false end   -- 🔑 松手立即归零（不做这个就是「点一下也开机」）
  pp = p

  if p and not opened then
    bt = bt+1
    local a = math.max(1, math.floor(st*60+.5))          -- 一步 = 多少 tick
    if bt >= a*5 + math.floor(ad*60+.5) then opened=true end
  end
  -- 🔑 只有「已开机 + 这一帧刚触摸」才响应点击，避免开机演出期间误触
  if p and opened and t and not pt then press() end
  pt = t
end

local function boot()
  local W,H = screen.getWidth(), screen.getHeight()
  C(45,45,45) screen.drawClear()                          -- 全屏底色（不是 drawRectF(0,0,w,h)）
  local a = math.max(1, math.floor(st*60+.5))
  local s = math.min(6, math.floor(bt/a)+1)               -- 🔑 一个计数驱动三件事
  local L = {"STARTING LOAD","LOADING MAP","LOADING GPS",
             "LOADING DATA","INITIALISING","WELCOME"}
  C(210,210,210)
  if W>=80 then
    for i=1,s do screen.drawText(2, 28+(i-1)*5, L[i]) end -- 宽屏：逐行列出
  else
    screen.drawText(2, 36, L[s])                          -- 窄屏：只显示当前那一行
  end
  C(20,20,20) screen.drawRect(1, H-5, W-3, 3)             -- 进度条底槽
  C(200,220,0) screen.drawRectF(2, H-4, math.floor((W-4)*s/6), 2)  -- 进度条填充
end
```

**为什么这样写**

- **一个计数器 `bt` 驱动三件事**（日志行数、进度条长度、是否开机），改 `st` 一个属性就能整体调快慢。这类「演出」最忌讳散落多个计时器，最后对不齐。
- **松手归零是长按语义的关键**：`if not p then bt=0 opened=false end`。少了这一句，点一下就会在几秒后自动开机（因为 `bt` 一直在涨）。所有长按交互都要写「松手清零」。
- **`floor((W-4)*s/6)` 进度条**：先算比例 `s/6`，再乘可用宽度，最后 `floor` 取整——`drawRectF` 的宽度是整数像素，不取整会有 1 px 抖动。
- **`drawClear()` 比 `drawRectF(0,0,w,h)` 略省字符**，且语义明确（清成当前颜色）。注意它同样受 `setColor` 影响，必须先设色。
- **窄屏双布局的判定点**：本例用 `W>=80`（像素宽）而不是屏型号常量。好处是同一份代码在 1×1 到 9×9 之间自动切换；判定阈值按你的内容宽度定，别照抄 80。
- ⚠ 开机演出期间**必须屏蔽点击**（本例 `p and opened` 这个条件）。否则玩家按住屏幕等待开机的那几秒里，手指移动会被当成地图点选，一开机就多出一堆航路点。
- 完整脚本：`../../../AI相关/_提取暂存/_r7c/3795317652_vehicle_3.lua`


## §36 航向刻度带（heading tape）：属性填 16 进制配色 + **双向铺到视口边缘** + 一行翻转上下

- 来源：steam id 3795251690（地图 + 航向带 HUD，载具，2026-09-01）
- 用到：指南针（罗盘，圈）、GPS、目标方位通道、属性文本 `band color` 等 5 组颜色
- 亮点：`property.getText` 直接吃 `#RRGGBB`（16 进制转数字后位运算拆通道），
  刻度从屏幕中心**向左右两侧**分别铺到边界，天然居中且不会留单边空隙
- 区别于 `05` §3（滚动罗盘带）：§3 是**单向** `while x<w` 从左画到右、固定 5 px 间距、
  翻转靠切换三个偏移量；本节是**双向** `repeat ... until`、间距随屏宽自适应、
  翻转只靠一个 `dir` 符号，并额外带目标方位游标与边距钳位

### 手法一：属性读一次就够（省 CPU）

```lua
function onTick()
  if not initialized then
    marginLR = property.getNumber("margin")
    dir      = property.getBool("alignment") and -1 or 1     -- 一行取符号：顶置/底置
    hEnabled = property.getBool("heading indicator")

    bdC = tonumber(property.getText("band color"), 16)        -- "#3C7AFF" → 数字
    b = bdC & 0xff  g = (bdC >> 8) & 0xff  r = (bdC >> 16) & 0xff
    -- target color / centerline color / button color / heading color 同构
    initialized = true
  end
  ...
end
```

- `tonumber(文本, 16)` 直接把 16 进制串转成整数（**可以带 `#` 前缀吗？不能**——
  `tonumber("#3C7AFF", 16)` 返回 `nil`，属性里请让用户填不带 `#` 的 `3C7AFF`，
  或先 `gsub("#","")`；见 `05` §3 的 `hex2rgb`）。
- 拆通道用 **Lua 5.3 位运算** `&` 与 `>>`，比 `tonumber("0x"..s:sub(1,2))` 更快也更短。
- 🔑 属性**不会**在游戏中途变化，用 `if not initialized` 只解析一次；
  每 tick 调 `property.getText` + `tonumber` 是纯浪费（微控制器 tick 预算很紧）。

### 手法二：双向 repeat 铺满视口

```lua
function onDraw()
  screen.drawMap(gpsX, gpsY, zm)
  local w, h = screen.getWidth(), screen.getHeight()
  local cx = w/2
  dx = math.ceil(math.max(2, math.min(w/30, 5)))    -- 间距随屏宽自适应：2~5 px

  local hdg  = ((1 - input.getNumber(5)) % 1) * 360 -- 圈 → 度（1-x 让刻度随航向正确滚）
  local ang0 = hdg // 5 * 5                          -- 整除取 5° 整档作为起点角度
  local x0   = math.floor(cx - (hdg - ang0)*dx/5 + .5)  -- 该整档在屏幕上的亚像素位置

  -- 向右铺
  local angle, x = ang0, x0
  repeat DrawTick(x, angle) angle = angle + 5 x = x + dx until x >= w - marginLR
  -- 向左铺
  angle, x = ang0, x0 - dx
  repeat angle = angle - 5 DrawTick(x, angle) x = x - dx until x < marginLR
end
```

要点：
- `hdg // 5 * 5` 用整除把起点吸附到 5° 整档；`x0` 里的 `(hdg-ang0)*dx/5` 是**亚刻度偏移**，
  保证刻度连续滚动而不是每 5° 跳一格（同 `05` §3 的 `sp`）。
- 两个 `repeat` 从中心向两侧展开，各自独立终止于 `marginLR`，
  比单向循环更省心：不用先算"最左边该落在哪"。
- `dx` 自适应让 1×1 窄屏（32 px）与 5×3 宽屏都能显示合理数量的刻度。

### 手法三：`dir` 一个符号搞定上下翻转

```lua
if dir > 0 then                       -- 带子在顶部
  borderY, textY, bearingY = 0, 3, 27
else                                  -- 带子在底部
  borderY, textY, bearingY = h-1, h-8, h-32
end

screen.drawLine(cx, borderY, cx, borderY + dir*2)        -- 中心线：dir 决定往下还是往上
-- 刻度
function DrawTick(x, ang)
  ang = ang % 360
  if ang % 15 == 0 then
    screen.drawLine(x, borderY, x, borderY + dir*2)      -- 长刻度
  end
end
```

翻转只影响 `borderY / textY / bearingY` 三个**锚点**和 `dir` 这个符号，
绘制代码本身一行不改。这比"写两份 onDraw"或"每个 y 都乘 dir"都稳。

### 手法四：目标方位游标 + 贴边钳位

```lua
if tEnabled then
  local relBearing = (hdg - tBearing) % 360
  if relBearing > 180 then relBearing = relBearing - 360 end   -- 归到 ±180°
  local x = math.max(marginLR, math.min(cx - relBearing*dx/5, w - marginLR - 1))
  screen.drawLine(x, borderY, x, borderY + dir*2)              -- 游标
  screen.drawLine(x-1, borderY, x+2, borderY)                  -- 游标顶部横杠
end
```

目标在视野外时游标**停在边缘**而不是跑出屏外消失——`clamp` 在这里既是美观也是信息
（"目标在左边，而且已经偏出视野"）。

### 缩放按钮的"按住只触发一次"

```lua
ZIn  = iP and isPointInRectangle(inputX, inputY,  3, bearingY, 6, 6)
ZOut = iP and isPointInRectangle(inputX, inputY, 27, bearingY, 6, 6)
if ZIn == true and psd == false then  zmIn()  psd = true
elseif ZOut == true and psd == false then zmOut() psd = true
elseif ZIn == false and ZOut == false and psd == true then psd = false end
```

`psd`（pressed）是**松手复位**的闩锁：按住期间只加/减一次，松开任一按钮后 `psd` 才清零。
这是 `02` §1 pulse 的"手动版"，好处是能同时服务两个按钮而不互相抢边沿。

- 完整脚本：`../../../AI相关/_提取暂存/_r6c/3795251690_vehicle_4.lua`

---

## §37 设置抽屉：**按系统装配情况动态建表** + onDraw 返回值回写状态 + 滑入滑出

- 来源：steam id 3794769825（多传感器显示器，载具，2026-09-01）
- 用到：属性文本 3 组 RGBA、属性布尔 `Radar In System` 等装配开关、复合输出通道 11~20
- 亮点：同一块屏在「装了雷达」和「没装雷达」的载具上**显示不同的开关列表**，
  靠的是启动时按属性拼表，而不是写两套 UI
- 区别于 `05` §29（数据驱动按钮表）：§29 侧重每键冷却、分组互斥、多预设存读；
  本节侧重**表本身在启动时动态生成** + **绘制函数把新状态回写给表** + **抽屉位移动画**

### 手法一：启动时按装配情况拼表

```lua
listitems = {}

if property.getBool("Radar In System") then table.insert(listitems, {"Radar", radar, 11}) end
if property.getBool("Lidar In System") then table.insert(listitems, {"Lidar", lidar, 12}) end
if property.getBool("Sonar In System") then table.insert(listitems, {"Sonar", sonar, 13}) end
if property.getBool("Show Remote Vehicle in Settings") then table.insert(listitems, {"Remote", remote, 17}) end
if property.getBool("Transponder locator in system")  then table.insert(listitems, {"Locato", locator, 20}) end

for i = 1, #list2 do table.insert(listitems, list2[i]) end   -- 固定项追加在后
```

每项是 `{标签, 当前值, 输出通道号}`。**通道号写在表里**，于是 `onTick` 的广播就是一行循环：

```lua
for i = 1, #listitems do
  output.setBool(listitems[i][3], listitems[i][2])
end
```

新增一个开关 = 往表里插一行，广播代码零改动。⚠ 注意这段代码在**全局作用域**（`onTick` 之外），
只在脚本加载时执行一次——属性是静态的，没必要每 tick 重拼。

### 手法二：onDraw 里改状态，onTick 里广播

```lua
function onDraw()
  ...
  for i = 1, #listitems do
    dark = (i % 2 == 0)                                   -- 斑马纹
    if dark then setC(bgR-reduction, bgG-reduction, bgB-reduction)
    else         setC(bgR, bgG, bgB) end

    local liney = (i-1)*7 + 2                             -- 7 px 行高
    screen.drawRectF(w-57, liney-1+setpos, 33, 7)
    textline(w-57, liney, listitems[i][1])

    -- 🔑 绘制函数返回「新值」，就地写回表里
    listitems[i][2] = boolbut(width, liney, listitems[i][2], dark)
  end
end

function boolbut(x, y, value, dark)
  y = y - 2 + setpos
  if value then text = "ON"  setC(0,   dark and 60 or 100, 0, 100)
  else          text = "OFF" setC(dark and 60 or 100, 0, 0, 100) end
  screen.drawRectF(x, y+scroll+1, butwidth, 7)
  screen.drawText(x+2, y+2, text)

  if pulse and isPointInRectangle(inputX, inputY, x, y+scroll, butwidth, 8) then
    value = not value                                     -- 命中就翻转
  end
  return value                                            -- 回传给调用方
end
```

关键在 `listitems[i][2] = boolbut(...)`：**绘制函数同时是命中判定函数**，
它返回"这一帧之后这个开关应该是什么值"，调用方直接写回表。
下一 tick `onTick` 把整张表广播出去。
这样"画"和"改"写在同一个地方，不会出现"按钮画在 A 处、判定写在 B 处、两处坐标不同步"的经典 bug。

> 这条链有一个隐含前提：`onDraw` 在 `onTick` **之后**执行（游戏每帧 tick→draw），
> 所以本帧改的值会在**下一 tick** 才广播出去，即 1 帧延迟。对 UI 开关无感，
> 但用它做火控门控时要记得这 16 ms（见 `00_AI写作指导.md` 的执行顺序）。

### 手法三：抽屉滑入滑出（朝目标值步进）

```lua
setpos     = 0                       -- 当前位移
setshowpos = 0                       -- 完全展开的目标
sethidepos = 0                       -- 完全收起的目标（在 onTick 里更新为 h+2）
slidespeed = 2                       -- 每 tick 移动像素

function onTick()
  sethidepos = h + 2                 -- h 来自上一帧的 onDraw
  local settings = input.getBool(11)
  if settings then
    if setpos > setshowpos then setpos = setpos - slidespeed end
  else
    if setpos < sethidepos then setpos = setpos + slidespeed end
  end
end
```

不用插值 `lerp`，用**定步长朝目标逼近**：速度恒定、天然带"机械感"，
且不会出现 `lerp` 那种永远逼近不到位的尾巴。所有绘制里的 y 都加 `+setpos`，
于是整块面板（背景、行、按钮、关闭叉）一起移动。

⚠ `h` 只在 `onDraw` 里赋值，第一帧 `onTick` 时 `h` 还是 0，`sethidepos = 2`——
首帧抽屉位置不对，第二帧自愈。要严谨就给 `h` 一个初值。

### 手法四：属性文本 RGBA 解析（`gmatch` 版）

```lua
colour = property.getText("Line Color (R,G,B,A)")
t = {}
for num in colour:gmatch("[^,]+") do t[#t+1] = tonumber(num) end
liR, liG, liB, liA = t[1], t[2], t[3], t[4]
```

`[^,]+` 按逗号切分，比 `string.sub` 定宽解析更宽容（用户填 `10,200,30,255` 或
`10, 200, 30, 255` 都能过）。若属性里用 `#RRGGBB` 则改用 `05` §36 的
`tonumber(文本,16)` + 位运算拆通道。

### 手法五：关闭按钮用叉号，不用文字

```lua
setbx, setby = w-7, 0 + setpos
screen.drawLine(setbx+2, setby+2, setbx+5, setby+5)
screen.drawLine(setbx+4, setby+2, setbx+1, setby+5)
screen.drawRect(setbx, setby, 6, 6)
```

6×6 的方框 + 两条对角线 = 关闭叉，比塞一个 "X" 字符更好看且不受字体限制
（1×1 屏上 `drawText` 的字符是 5 px 宽，6 px 的框刚好放得下）。
命中判定用同一个 `isPointInRectangle`。

- 完整脚本：`../../../AI相关/_提取暂存/_r7c/3794769825_vehicle_10.lua`

---


## §38 四角角线 HUD（对角方向单位向量）+ **32 通道直通中转微控**

- 来源：steam id 3795365228（HUD 装饰模块，载具，2026-09-04）
- 用到：显示器、属性文本 `#RRGGBB`、属性布尔做方案切换
- 亮点：① **直通微控**——32 路输入输出原样转发，让一个"纯绘制"脚本能串进信号链中间而不截断；
  ② 角线长度用屏幕宽度的百分比定义，**长度随屏宽、角度随长宽比**自动适配
- ⚠ 本例的角度公式有**实测错误**，下方已给出修正版——抄修正版

### 手法一：32 通道直通（onTick 里转发一遍）

```lua
function onTick()
  for i = 1, 32 do
    inp[i]  = input.getNumber(i)
    bool[i] = input.getBool(i)
    output.setNumber(i, inp[i])       -- 原样转出：上游信号不受影响
    output.setBool(i, bool[i])
  end
  ...
end
```

这种"串在中间只做绘制"的微控制器在工坊里很常见：它既要读到全部 32 路通道，
又不能把下游设备的输入掐断。`for i=1,32` 一行循环就解决了，比手工写 64 行省 90% 字符
（关联 `01` §7 批量 IO）。

⚠ 代价是**每 tick 64 次 API 调用**；若下游只需要其中 6 路，就只转那 6 路。

### 手法二：属性布尔切换两套配色

```lua
if input.getBool(2) then
  L_sel_color = hex2rgb(property.getText("Diagonal(s) Color Scheme 2 (Hex)"))
else
  L_sel_color = hex2rgb(property.getText("Diagonal(s) Color Scheme 1 (Hex)"))
end

function hex2rgb(hex)
  hex = hex:gsub("#","")
  return {r=tonumber("0x"..hex:sub(1,2)), g=tonumber("0x"..hex:sub(3,4)), b=tonumber("0x"..hex:sub(5,6))}
end
```

`hex2rgb` 走 `tonumber("0x"..两位)`，**先 `gsub` 掉 `#`**；
`05` §36 走 `tonumber(文本,16)` + 位运算（**不接受 `#`**）。两条路都行，别混用：

| 写法 | 能否带 `#` | 拆通道 |
| --- | --- | --- |
| `tonumber("0x"..s:sub(1,2))` | 需先 `gsub("#","")` | 切片 |
| `tonumber(s,16)` | **不能带 `#`**（返回 `nil`） | `& 0xff` / `>> 8` |

### 手法三：角线长度按屏宽百分比

```lua
local v = property.getNumber("Dia Btm Right (%)") * w / 100   -- 右下角线长
```

四个角各有一个百分比属性（`Dia Top Left / Top Right / Btm Right / Btm Left`），
长度都按**屏宽** `w` 取百分比——于是在 1×1 与 5×3 上角线的视觉长度一致，
只有"贴着对角线"的角度随长宽比变化。比按对角线长取百分比更好预测。

### ⚠ 原脚本的角度公式是错的（务必改）

```lua
-- ❌ 原脚本（4 个角重复 4 遍）
tana  = distX / distY
alpha = math.atan(tana)
cosa  = math.cos(alpha)
ax    = cosa * v
ay    = (ax * distY) / distX
```

设 `L = sqrt(dx*dx + dy*dy)`。单参数 `atan` 下 `cos(atan(dx/dy)) = dy/L`，于是：

```
ax = v*dy/L          ← 拿到的是 **y** 方向的分量，却赋给了 x
ay = ax*dy/dx = v*dy²/(L*dx)
模长 = v * dy/dx     ← 只有正方形屏（dx==dy）时才等于 v
```

后果：**角线实际长度随屏幕长宽比失真**。3×2 屏上只有设定长度的约 2/3，
5×3 上偏差更大；正方形屏上恰好正确——这正是作者没发现的原因。

```lua
-- ✅ 正确写法：直接按对角线的单位向量分解
local L = math.sqrt(distX*distX + distY*distY)
local ux, uy = distX/L, distY/L        -- 对角方向单位向量
local ax, ay = v*ux, v*uy              -- 沿对角线的两分量，模长恒等于 v
local ax2, ay2 = x - ax, y - ay        -- 从对角起，向两邻边回退
```

不需要 `atan` 也不需要 `cos`：单位向量只要除以模长即可。
（`atan` + `cos` 的写法是"绕远路"，且极易把 `dx/L` 与 `dy/L` 弄反——本例就是活教材。）

### 手法四：四个角只需一套公式 + 符号镜像

```lua
-- 右下角：从 (x,y) 往左上方向回退
drawLine(x, y, x - ax, y - ay)
-- 右上角：y 分量改为向上
drawLine(x, y2, x - bx, y2 + by)
-- 左下角：x 分量改为向右
drawLine(x2, y, x2 + cx, y - cy)
-- 左上角：两个分量都反向
drawLine(x2, y2, x2 + dx, y2 + dy)
```

`x2, y2 = 1, 1`（左上角原点），`x, y = w, h`（右下角）。
把 `(ax, ay)` 按象限取正负就能覆盖四角，绘制代码只有一条 `drawLine`。

### 附：`L_alpha_ctrl` 的「属性 / 外部通道」双源开关

```lua
L_alpha = property.getNumber("Diagonal(s) (Alpha)")
L_alpha_ctrl = property.getBool("Diagonal(s) Ctrl (Alpha)")

if L_alpha_ctrl then
  L_alpha = input.getNumber(1)     -- 由外部通道接管（例如随速度动态调透明度）
end
```

一个布尔属性决定"用属性面板的值"还是"用运行时通道的值"——
**工坊模块的标配**：默认让用户填静态值，需要联动时用开关切到信号。
类似的双源写法见 `03` §13 的 `Radar Shadow Zone` 门控。

- 完整脚本：`../../../AI相关/_提取暂存/_r8c/3795365228_vehicle_19.lua`

---

## §39 地图控件：**命中区即广播** + **按屏尺寸裁剪控件**（响应式）+ 小圆拼圆环按钮

- 来源：steam id **3794389171** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3794389171> · **载具**（PzH 3000，`_vehicle_0` 地图屏）
- 更新时间：2026-09-02
- 用到：触控屏（触控 X / 触控 Y / 按下）、GPS、罗盘、缩放输入、`map.mapToScreen`
- 亮点：把「点是不是落在某个按钮上」做成**一路布尔输出广播**给下游微控；小屏**自动撤掉**放不下的按钮；圆环按钮用 24 个小实心圆拼出来（SW 没有空心圆、也没有线宽）。

```lua
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
  return x > rectX and y > rectY and x < rectX + rectW and y < rectY + rectH
end

function onTick()
  w, h = input.getNumber(1), input.getNumber(2)
  inputX, inputY, isPressed = input.getNumber(3), input.getNumber(4), input.getBool(1)

  -- ① 命中区 → 布尔输出，直接广播给别的微控（也是本屏绘制选中态的依据）
  touch1 = isPressed and isPointInRectangle(inputX, inputY, w-9, h-17, 6, 6)   -- 放大
  touch2 = isPressed and isPointInRectangle(inputX, inputY, w-9, h-9,  6, 6)   -- 缩小
  reset  = isPressed and isPointInRectangle(inputX, inputY, w-10, 2,   8, 8)   -- 回中
  -- ② 响应式：屏幕不够大就**不启用**这个按钮（`gps` 恒为 false，既不绘制也不响应）
  if w >= 64 and h >= 64 then
    gps = isPressed and isPointInRectangle(inputX, inputY, w-10, 12, 8, 8)
  end

  local cw, ch = w/2, h/2
  -- ③ 只有「按下且没按在任何按钮上」才算拖地图
  if isPressed and not touch1 and not touch2 and not reset and not gps then
    outX, outY = inputX/cw - 1, inputY/ch - 1            -- 归一到 -1..1
  else
    outX, outY = 0, 0
  end
  -- 拖动步长随缩放级别**指数**放大，缩放再深也拖得动
  nX = (1.4 ^ clamp(zoom, 0, 20)) * (outX * 4)
  nY = (1.4 ^ clamp(zoom, 0, 20)) * (outY * 4)
  nnX, nnY = nnX + nX, nnY - nY                          -- ⚠ Y 要取负：屏幕 Y 向下，地图北向相反
  if reset then nnX, nnY = 0, 0 end

  output.setBool(1, touch1) output.setBool(2, touch2)
  output.setBool(3, reset)  output.setBool(4, gps)
end

-- ④ 圆环按钮：沿圆周每 15° 画一个小实心圆，拼出一个环（替代没有的「空心圆 + 线宽」）
function circle(cx, cy, r, d)
  for i = 0, 360, 15 do
    local a = i * math.pi / 180
    screen.drawCircleF(cx + r*math.cos(a), cy + r*math.sin(a), d/2)
  end
end

function onDraw()
  screen.drawMap(cX + nnX, cY + nnY, zoom)               -- 配色写在 drawMap 之后 → 下一帧生效，见 §33
  screen.setMapColorLand(220, 35, 0)
  pX, pY = map.mapToScreen(cX + nnX, cY + nnY, zoom, w, h, cX, cY)   -- 自机在屏上的像素位
  screen.setColor(25, 25, 25, 175)
  screen.drawLine(pX, pY, pX + 12*math.cos(-1.58 + compass), pY + 12*math.sin(-1.58 + compass))

  -- ⑤ 按下反馈：整块按钮换一组配色，不需要额外的动画状态
  if touch1 then screen.setColor(35, 35, 35) else screen.setColor(50, 50, 50) end
  circle(w-6, h-14, 1, 3)
  if touch1 then screen.setColor(50, 50, 50) else screen.setColor(150, 150, 150) end
  screen.drawTextBox(w-8, h-16, 6, 6, "+", 0, 0)
end
```

**要点**

- **命中区即广播**是本例最值得抄的一点：`isPressed and isPointInRectangle(...)` 直接 `output.setBool`，下游微控（缩放、回中、切页）不用各自再判一次坐标。对比 `05` §29 的「每键回调闭包」——那套适合按钮多、逻辑复杂；本例这种 3~4 个按钮的屏，广播出去更省字符。
- **响应式裁剪**：`if w >= 64 and h >= 64 then ... end` 让同一段脚本在 1x1 / 2x2 / 3x3 屏上都能用——小屏自动不画、也不响应该按钮。因为 Lua 里未赋值的全局变量是 `nil`（布尔上下文为 `false`），`gps` 在小屏上永远是 `nil`。
- **拖地图的两处细节**：位移先归一到 `-1..1` 再乘指数缩放系数 `1.4^zoom`，这样任何缩放等级下「拖过半屏」的手感一致；`nnY = nnY - nY` 的负号来自屏幕 Y 轴向下、而地图北向在屏幕上向上。
- **小圆拼圆环**是因为 SW 的 `drawCircle` 只有实心、没有线宽参数。24 个采样点（`step = 15°`）在直径 3~4 px 的小按钮上足够圆；直径更大要把步长降到 5~10°，否则能看出多边形。
- **反面教材（原脚本）**：`if inputX > cw or inputX < cw then outX = inputX/cw - 1 end`——`or` 使得条件**恒真**（只有恰好 `inputX == cw` 时不成立），等于没有判断；而且一旦恰好相等，`outX` 会保留上一帧的值造成地图自己漂移。这类「防呆判断」要么删掉，要么写成 `and`。
- 关联：`05` §32（虚拟摇杆拖动地图的另一种写法：位移×固定倍率）、`§33`（`setMapColor*` 调用时机的实测澄清）、`§38`（按屏尺寸切换布局的同类做法）。
- 完整脚本：`../../../AI相关/_提取暂存/_r8c/3794389171_vehicle_0.lua`

---

---

## §40 屏幕上的 3D 软件渲染管线：4×4 矩阵变换 + 齐次裁剪※ + 背面剔除※ + 画家算法※

- 来源：steam id **2793934450** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=2793934450> · **载具**（`_vehicle_2`，3D 渲染屏）
- 更新时间：未取到（本轮 Steam Web API 不可达，下轮补）
- 用到：数值输入 1-16（4×4 变换矩阵，行主序）、17-19（模型平移）、20-22（欧拉角）、23 起（外部点集，每点 3 通道）、布尔 1（总开关）、布尔 2（清屏复位）、属性文本（`v*`/`t*`/`c*`/`b64`，见 `01` §10）、显示器
- 亮点：**用纯 Lua 在 2D 绘图 API 上搭出一套完整 3D 管线**——顶点变换、齐次裁剪、透视除法、背面剔除、深度排序、深度调色板一应俱全；模型常量用 base64 编码的 float32 存在属性文本里；共享顶点用「**帧号戳**」去重，每个顶点每帧只变换一次。

> 这是本工作区见到的**唯一一例在 SW 屏上跑真 3D 网格渲染**的脚本。SW 只有 `drawTriangle`/`drawTriangleF` 两个实心图元，没有深度缓冲、没有线宽、没有裁剪，所以整条管线都得手写。

```lua
-- ===== 只在加载时算一次的常量 =====
local W, H   = property.getNumber("w"), property.getNumber("h")
local HW, HH = W/2, H/2
local OFFX, OFFY = HW + property.getNumber("pxOffsetX"), HH + property.getNumber("pxOffsetY")
local NEAR, FAR  = property.getNumber("near") + 0.47, property.getNumber("far")

local m = {}                      -- 4×4 变换矩阵，行主序 16 元，每 tick 从数值输入 1-16 刷新
local mesh   = { g={}, r={}, t={}, sx={}, sy={}, dep={}, stamp={}, zok={}, infr={} }
local pts    = { g={}, r={}, t={}, sx={}, sy={}, dep={}, zok={} }
local frame  = 0

-- ① 顶点变换：行主序矩阵右乘列向量，返回 (x, y, z, w)
--    注意下标是 b[1], b[5], b[9], b[13] —— 同一行、跨 4 列
local function xform(b, x, y, z)
  return b[1]*x + b[5]*y + b[9] *z + b[13],
         b[2]*x + b[6]*y + b[10]*z + b[14],
         b[3]*x + b[7]*y + b[11]*z + b[15],
         b[4]*x + b[8]*y + b[12]*z + b[16]
end

local function clamp(v, lo, hi) return v < lo and lo or v > hi and hi or v end

-- ② 齐次裁剪 + 透视除法：一次判完 0<=z<=w、|x|<=w、|y|<=w（不做逐面裁剪，整面取舍）
local function projectPoints(b, o)
  for i = 1, #o.g do
    local x, y, z, w = xform(b, o.g[i], o.r[i], o.t[i])
    o.zok[i] = (0 <= z and z <= w) and (-w <= x and x <= w) and (-w <= y and y <= w)
    if o.zok[i] then
      local iw  = 1/w
      o.sx[i]   = x*iw*HW + OFFX      -- 屏幕 X
      o.sy[i]   = y*iw*HH + OFFY      -- 屏幕 Y
      o.dep[i]  = z*iw                -- 深度键（本例矩阵约定下，越大越远）
    end
  end
end

-- ③ 三角面装配：帧号戳去重 + 背面剔除 + 画家算法排序
local function buildTriangles(b, o, faces, f)
  local gx, gy, gz = o.g, o.r, o.t
  local sx, sy, dep = o.sx, o.sy, o.dep
  local stamp, zok, infr = o.stamp, o.zok, o.infr
  local out = {}
  for fi = 1, #faces do
    local F = faces[fi]
    for k = 1, 3 do
      local vi = F[k]
      if stamp[vi] ~= f then                        -- 🔑 本帧还没算过这个顶点
        stamp[vi] = f
        local x, y, z, w = xform(b, gx[vi], gy[vi], gz[vi])
        zok[vi]  = (0 <= z and z <= w)              -- z 在近远平面之间
        if zok[vi] then
          infr[vi] = (-w <= x and x <= w) and (-w <= y and y <= w)
          local iw = 1/w
          sx[vi], sy[vi], dep[vi] = x*iw*HW + OFFX, y*iw*HH + OFFY, z*iw
        end
      end
    end
    local a, c, d = F[1], F[2], F[3]
    -- ④ 背面剔除：屏幕空间有向面积（叉积 z 分量）> 0 才是正面
    local area = sx[a]*sy[c] - sx[c]*sy[a]
               + sx[c]*sy[d] - sx[d]*sy[c]
               + sx[d]*sy[a] - sx[a]*sy[d]
    if zok[a] and zok[c] and zok[d]
       and (infr[a] or infr[c] or infr[d])          -- 至少一角在视锥内就保留，不切分三角形
       and area > 0 then
      F[4] = dep[a] + dep[c] + dep[d]               -- ⑤ 三顶点深度之和当排序键
      out[#out+1] = F
    end
  end
  table.sort(out, function(p, q) return p[4] > q[4] end)   -- 由远及近，后画的盖住先画的
  return out
end

function onDraw()
  if not enabled then return end
  frame = frame + 1

  -- 点集：深度 → 5 级调色板线性插值，越远越小越淡
  projectPoints(m, pts)
  for i = 1, #pts.g do
    if pts.zok[i] then
      local s  = NEAR / (FAR + pts.dep[i]*(NEAR - FAR))   -- 深度 → 视觉尺度
      local dd = s * FAR                                  -- "视觉距离"，越大越远
      local t  = s * 4                                    -- 调色板浮点下标
      local n  = math.floor(t)
      local f  = t - n
      screen.setColor(PAL_R[n+1]*(1-f) + PAL_R[n+2]*f,    -- 相邻两色线性插值
                      PAL_G[n+1]*(1-f) + PAL_G[n+2]*f,
                      PAL_B[n+1]*(1-f) + PAL_B[n+2]*f,
                      clamp(300 - dd, 100, 240))           -- 越远越淡，但留 100 下限保证可见
      screen.drawCircleF(pts.sx[i], pts.sy[i], math.max(25/dd, 1))
    end
  end

  screen.setColor(0, 0, 0, 150)
  screen.drawRectF(0, 0, W, H)

  local tris = buildTriangles(m, mesh, faces, frame)
  for i = 1, #tris do
    local F = tris[i]
    local a, c, d = F[1], F[2], F[3]
    screen.setColor(F[5], F[6], F[7], 225)
    screen.drawTriangleF(mesh.sx[a], mesh.sy[a], mesh.sx[c], mesh.sy[c], mesh.sx[d], mesh.sy[d])
    screen.setColor(255, 255, 255, 100)                     -- SW 没有线宽，用线框描边补轮廓
    screen.drawTriangle (mesh.sx[a], mesh.sy[a], mesh.sx[c], mesh.sy[c], mesh.sx[d], mesh.sy[d])
  end
end
```

**要点**

- **为什么不自己算矩阵**：4×4 矩阵是从数值输入 1-16 直接灌进来的，模型旋转/平移/欧拉角在**上游微控**里算。脚本方块只有 8192 字符预算，把每帧只变一点点的矩阵运算外包出去是这类重活的标准做法；本屏只负责「变换 + 投影 + 排序 + 画」。
- **齐次裁剪的三条不等式**：`0 <= z <= w` 同时裁掉近平面后方和远平面之外，`|x| <= w`、`|y| <= w` 裁掉侧面。写成 `and` 串一行，比先算 NDC 再判省一次除法。
- **不做逐面裁剪**是有意的：只要三角面有**一个**角在视锥内就整面画出去。SW 屏很小（常见 32×32 ~ 96×96），被裁剪面切分的三角形在这么小的屏上收益极低，反而多一堆分支。代价是靠近相机的面会「糊」到屏外——`drawTriangle` 超出屏的部分自动不画，不会报错。
- **帧号戳去重**（`stamp[vi] ~= frame`）是 shared-vertex 网格的关键：一个顶点平均被 5~6 个面共用，逐面变换会做 3 倍以上的无用矩阵乘法。做法是给每个顶点记「上次变换发生在第几帧」，帧号在 `onDraw` 开头自增。⚠ 这个表**永不清理**，只靠帧号比较，所以不会泄漏内存（表长度等于顶点数）。
- **背面剔除用屏幕空间叉积**：`(xb-xa)*(yc-ya) - (yb-ya)*(xc-xa)` 展开后就是上面那 6 项。`area > 0` 还是 `< 0` 取决于你的绕序和 Y 轴方向（SW 屏幕 Y 向下），**换模型时先用一个正对着相机的单面试一下，方向反了就翻比较符**。
- **深度键取 `z/w` 之和**而不是平均：省一次除法，排序结果完全一样（三顶点求和与求均值的大小关系一致）。本例矩阵约定下 `z/w` 越大越远，所以 `>` 降序 = 由远及近。可用判据：点集部分 `dep` 越大 → `dd` 越大 → 半径 `25/dd` 越小、alpha `300-dd` 越淡，与「越远越小越淡」一致。
- **深度调色板插值**是省字符的招：5 组 RGB 存成 3 个一维表，用 `floor` 取下标 + 小数部分做线性插值，等于用 15 个数字换出连续渐变；`clamp(300-dd, 100, 240)` 让最远的点也保留 100 的 alpha，不会彻底消失。
- ⚠ **`table.sort` 的代价**：面数上百时每帧一次全排序会吃掉可观预算。若帧率吃紧，可改成桶排序（把深度量化成 16~32 个桶，桶内不排序）—— painter 算法本身有误差，桶排序的乱序在视觉上几乎看不出来。
- 关联：`01` §10（本例的顶点/面/颜色常量怎么塞进属性文本）、`05` §27（同一块屏上的网格绘制思路，2D 版）、`04` §8（矩阵乘法与转置的手写实现）。
- 完整脚本：`../../../AI相关/_提取暂存/2793934450_vehicle_2.lua`（原脚本为重度混淆版，变量名全为 2~3 字符；上面是重命名后的可读版）

---

## §41 两块 Lua 用**视频串联**做图层叠加 + 角落里的**扇形雷达指向器**

- 来源：**本地导出** `D:/Downloads/ACM HMD.xml`（微控制器 `ACM HMD`；作者未提供工坊链接）
- 更新时间：未知（文件修改时间 2026-09-04）
- 用到：Lua 脚本块 ×2（A 解算+主 HUD、B 雷达指向+扇形指示）、`screen.drawLine` / `drawCircleF` / `drawText`、视频输出桥
- 亮点：① **脚本块的视频输入会作为底图透传**，把 A 的视频输出接进 B 的视频输入，就得到「A 画底层、B 画上层」的两层 HUD；② 52×24 的小扇形指示器**用「线的长度」编码仰角**，省掉一整个 2.5D 投影
- 关联：`01` §11（同作品的数据侧：两块脚本用 `inc` 链共享混合总线）、`03` §24（A 块画的主 HUD）、`05` §26（正经 PPI 画法，与本例的迷你指示互补）

### 手法一：视频串联（Lua A → Lua B → 视频输出桥）

```
type 56 (Lua A, object 69)  -- in1 = 混合入                  node_index=1(视频出) -->
type 56 (Lua B, object 70)  -- in1 = 混合入   in2 = 69(视频入)  node_index=1(视频出) -->
桥 type 7 = 视频输出（接到驾驶座椅的头盔显示）
```

`type 56` 的引脚：`in1` = 混合输入、`in2` = **视频输入**；输出 `node_index=0` = 混合、`node_index=1` = 视频。
把 A 的视频接到 B 的 `in2`，B 的 `onDraw` 就画在 A 的画面**之上**——两层解耦，各自独立开关与复用。

**什么时候值得用**

| 场景 | 做法 |
| --- | --- |
| 单块脚本逼近 8192 字符上限 | 拆成「通用底层 HUD」+「可换上层模块」，两块各有独立预算 |
| 一个 HUD 要在多种载具上复用 | 底层（准星/刻度）固定，上层按载具换模块，接线即换装 |
| 第三方的 HUD 模块要插进自己的信号链 | 中间串一块直通脚本（数值直通见 `05` §38 手法一），画面直通就是本例手法 |

⚠ 串联是**有序**的：先画的在下层。链越长每帧绘制开销越大，实测前先想清楚是不是真需要三层以上。
⚠ 「视频输入作为底图透传」是从本例的接线与可用事实反推的语义；若你的版本行为不同，先单独做一个「A 画一个点、B 什么都不画」的最小样本验证。

### 手法二：扇形雷达指向器（线长 = 仰角）

```lua
-- 参数：扇形半角 FOVAZ、俯仰半角 FOVEL、尺寸 RW/RH/PAD
RW, RH, PAD = 52, 24, 3

function FanPoint(cx, cy, ang, r)
  return cx + math.sin(ang) * r,      -- 屏幕 X 向右
         cy - math.cos(ang) * r       -- ⚠ 屏幕 Y 向下，故取负；ang=0 指向正上方
end

function onDraw()
  local w, h = screen.getWidth(), screen.getHeight()
  local cx, cy, r = w / 2, h - PAD, RH
  local la, ra = -FOVAZ, FOVAZ          -- 扇形左右边界（弧度，0 = 正前方）

  -- ① 两侧边 + 中心瞄准线
  local lx1, ly1 = FanPoint(cx, cy, la, r)
  local rx1, ry1 = FanPoint(cx, cy, ra, r)
  screen.setColor(25, 220, 70, 170)
  screen.drawLine(cx, cy, lx1, ly1)
  screen.drawLine(cx, cy, rx1, ry1)
  local bx, by = FanPoint(cx, cy, 0, r * 0.45)
  screen.drawLine(cx, cy, bx, by)

  -- ② 外弧：没有 drawArc 时用 12 段折线逼近，够用了
  local px, py = lx1, ly1
  for i = 1, 12 do
    local a = la + (ra - la) * i / 12
    local x, y = FanPoint(cx, cy, a, r)
    screen.drawLine(px, py, x, y)
    px, py = x, y
  end

  -- ③ 🔑 指向线：长度里塞进仰角
  local a  = math.max(-FOVAZ, math.min(FOVAZ, RA))          -- 方位钳进扇形
  local rr = 0.9
  local ev = math.max(-1, math.min(1, RE / FOVEL))          -- 仰角归一化 -1..1
  rr = rr - ev * 0.18                                       -- 抬头 -> 线短；低头 -> 线长
  local ex, ey = FanPoint(cx, cy, a, r * rr)
  screen.drawLine(cx, cy, ex, ey)
  screen.drawCircleF(ex, ey, 1)                             -- 端点一个点，当"指针尖"
end
```

**要点**

- **一个二维图元表达三个量**：方向 = 线的角度（方位）、长度 = 仰角、颜色 = 工作模式。这是小角落 widget 的标准压缩思路。
- **12 段折线画弧**：`for i=1,12` 均匀插值角度即可；段数按弧长定，RH=24 px 时 12 段完全看不出折角（对比 `05` §5.7 的 `drawArc` 多边形逼近）。
- **屏幕 Y 向下**，极坐标必须 `cy - cos(ang)*r`，写成 `+` 会上下翻转。
- 模式配色 + 标签：`if MODE==0 then DT(cx-8, cy-RH-7, "ACM") end`——没有文本宽度 API 时用**固定偏移**近似居中（要精确排版见 `05` §15 的 `log10` 算位数）。
- 位置贴底边：`cy = h - PAD`，配合 `05` §14 的「负坐标 = 贴边」可同时适配 1×1 与 5×3 屏。
- 完整脚本：`../../../AI相关/_提取暂存/ACM_HMD_microcontroller_1.lua`

## §42 小图标不用矢量：位图的**行段压缩表**（扁平数组 + 步长 3）+ 按下态「换表 + 位移」

来源：steam id **3794163203** · <https://steamcommunity.com/sharedfiles/filedetails/?id=3794163203> · **载具**（flor axton）· 更新时间 **2026-09-02**

`05` §19 / §20 是用 `drawLine` 拼**矢量**图标；这节是另一条路：把一张小位图压成「**每一行里连续的像素段**」，画的时候每段一次 `drawRectF`。段数远少于像素数，字符和调用次数都省。

**用到**：触控屏（`isTouched` / 触控 X / 触控 Y）、属性文本（按钮标签）、外部布尔（决定按钮是否渲染）

**亮点**：① 位图按**行段**压缩成扁平数组，`for w=5,#t,3` 步长遍历；② **按颜色分层**，一层一个 `setColor`；③ 按下态 = **换第二张表 + 整体 +(1,2) 位移**，一行做出「凹下去」；④ 全表坐标乘 `zoom`，同一份数据任意缩放；⑤ 按钮是否渲染由外部布尔决定。

```lua
-- 图标 = 若干「颜色层」，每层 = {R,G,B,A, 然后每 3 个数一段：x, y, 段宽}
-- 段高恒为 1 px：一行里连续的同色像素并成一段，段数 << 像素数
p = {
  {106,8,15,155, 1,2,1,},
  {87,6,10,155,  2,2,11, 1,3,1, 1,4,1, 1,5,1, 1,6,1, 1,7,1, 1,8,1, 1,9,1, 1,10,1, 1,11,1, 1,12,1,},
  {67,5,10,155,  13,2,1, 1,13,1,},
  -- ... 共 5 层；p2 是同一图标的「按下态」版本，6 层
}

function drawIcon(t, ox, oy)
  for i = 1, #t do
    s.setColor(t[i][1], t[i][2], t[i][3], t[i][4])
    for w = 5, #t[i], 3 do                     -- 🔑 扁平数组 + 步长 3
      s.drawRectF(t[i][w]*zoom + ox, t[i][w+1]*zoom + oy, t[i][w+2]*zoom, 1*zoom)
    end
  end
end
```

```lua
-- 按下态：换 p2 这张「下沉版」表，并把整体右移 1 px、下移 2 px
if i3ToggledP == false and i3Toggled == false then
  drawIcon(p , x    , y + 16)                  -- 常态
else
  drawIcon(p2, x + 1, y + 18)                  -- 按下：表换掉 + 位移 (+1,+2)
end
dStr(2, 22, button4label)                      -- 标签走属性文本，换载具不改代码
```

```lua
-- 命中判定用闭区间（>= / <=）：比常见的开区间多 1 px 命中，小图标更好点
function isInRect(x1, y1, w1, h1, px, py)
  return px >= x1 and px <= x1 + w1 and py >= y1 and py <= y1 + h1
end

-- 按钮是否出现由外部布尔决定；不出现时既不画、也不写输出（输出保持上一帧的值）
if untenRechts then
  if isP1 and isInRect(18, 18, 13, 13, in1X, in1Y) then i4ToggledP = true end
  if not isP1 and i4ToggledP then i4ToggledP = false i4Toggled = not i4Toggled end
  output.setBool(4, i4Toggled)
end
```

**要点**

- **行段表 vs 逐像素**：13×13 的图标若逐像素画最多 169 次 `drawRectF`；压成行段后本例只有 ~30 段/图，**调用次数少一个量级**，`onDraw` 预算（每帧指令数）立刻松。压缩率取决于图标的横向连通性——图标越「实心、横向连续」越划算，斜线多的图反而吃亏。
- **扁平数组 + 步长 3 是为了省字符**：写成 `{{1,2,1},{2,2,11},...}` 每段多 4 个字符（`{` `}` `,` 与一层表头开销）；8192 上限下这 4 字符很贵。代价是可读性差，务必在表上方写一行注释说明布局。
- **按颜色分层**：一个 `setColor` 管一整层的全部段，`setColor` 的调用次数 = 层数（5~6），与段数无关。反例是「每段都 `setColor`」，会把调用次数拉回段数级别。
- **按下反馈用「换表 + 位移」而不是改配色**：几何位移是纯形状反馈，与主题配色完全解耦；代价是每个图标要画两份数据（`p` / `p2`）。只想省事的话可以只做位移、两态共用一张表（见 `05` §20 的剪影偏移）。
- ⚠ **命中矩形与绘制坐标是两套独立字面量**（`18,18,13,13` vs 绘制用的 `x+17/y+16`），改位置必须同步改两处；`05` §20 里已踩过同一个坑，可靠做法是**用同一组局部常量拼出两边的表达式**。
- ⚠ 本作品的 3×4 点阵字体（`font34`，12 bit/字符）与 `05` §1.1 **完全同源**，属工坊里被广泛搬运的公共代码段，不作为新手法收录。

**关联**：`05` §19 / §20（矢量图标与双次偏移描边，另一条路）· `05` §1.1（3×4 点阵字体）· `01` §2（字数压缩）· `02` §2（toggle 边沿闩锁）· 完整脚本 `../../../AI相关/_提取暂存/_r8c/3794163203_vehicle_15.lua`

---


## §43 HUD 长文本**无缝循环跑马灯** + 每 tick 清空全部布尔输出

来源：steam id **3794688360** · <https://steamcommunity.com/sharedfiles/filedetails/?id=3794688360> · **载具**（DAGGER Air Superiority Fighter）· 更新时间 **2026-09-03**

`05` §5.6 给过一版「负 x 坐标让文字从左侧滚入」的跑马灯，那只滚一次、滚完就空。这一节是**无限循环**版：把文本拼两份，偏移滚到一份宽度就归零，首尾相接，视觉上永远不断流。挂架名、弹药型号这类长短不一的字符串塞进 32 px 宽的窄屏时非它不可。

**用到**：数字输入（挂架信息 / 触控 / 主控开关）、属性文本（配色 ×6、滚动速度）、布尔输出 16 路、屏幕

**亮点**：① **双份文本拼接** `t .. "   " .. t` 实现无缝循环；② 只对**超宽的行**启用滚动，短文本静止不抖；③ 每 tick 先把 16 路 Bool **全清**再置位；④ 滚动速度由属性数值控制，玩家自己调。

```lua
-- ① 六套配色全从属性文本读："RRR,GGG,BBB" 定宽切段（与 05 §29 同一手法）
function onTick()
  cols = {}
  for i = 1, 6 do
    local s = property.getText("Color Code " .. tostring(i))
    cols[i] = {tonumber(s:sub(1,3)), tonumber(s:sub(5,7)), tonumber(s:sub(9,11))}
  end
  --  🔑 先全清，再置位：不清会留上一帧的选中态，齐射时多发一起掉
  for i = 1, 16 do output.setBool(i, false) end
  output.setBool(selIdx, armed)
end
```

```lua
-- ② 跑马灯：off[i] 是「已滚过的像素数」，滚够一份宽度就归零 → 无缝
--    文本宽度按每字符 4 px 估（SW 内置字体的实测值），再加两侧留边
local rows = {"Pos " .. tostring(sel), "Name: " .. name, "Ammo: " .. tostring(ammo)}
for i, t in ipairs(rows) do
  local wide = #t * 4 + 12
  off[i] = off[i] or 0
  if off[i] >= wide then
    off[i] = 0                                    -- 一份走完，回到原点（此时第二份正好接上）
  else
    off[i] = off[i] + property.getNumber("Scroll Speed")
  end
  if off[i] > 0 and wide > 40 then                -- 只有超宽的行才滚
    drawText(1 - off[i], (i-1)*8 + 2, t .. "   " .. t)   -- 🔑 两份首尾相接
  else
    drawText(1,            (i-1)*8 + 2, t)
  end
end
```

- ⚠ **属性为空会崩**：`property.getText` 在属性框空着时返回空串（不是 `nil`），`s:sub(1,3)` 得到 `""`，`tonumber("")` 返回 `nil`，随后 `screen.setColor(nil, ...)` 直接报错。稳妥写法是 `tonumber(s:sub(1,3)) or 0`。本例作者把六个配色框都填了默认值才没炸。
- ⚠ **速度别取太大**：`Scroll Speed` 若大于一行宽度，一拍就跨过整个循环，看起来是文字在原地乱跳。建议属性上限设成 2~3。
- 关联：`05` §5.6（负 x 一次性跑马灯，本节做成循环）/ `08` §17（同一作品的挂架管理，`cols` 与全清 Bool 都出自那里）/ `05` §36（航向刻度带的双向 repeat 铺满，另一种「重复」思路）

---

## §44 棋盘游戏 UI：**手绘像素棋子** + 深拷贝悔棋 + 长按 30 tick 弹菜单

来源：steam id **3795280695** · <https://steamcommunity.com/sharedfiles/filedetails/?id=3795280695> · **载具**（Oyster Bay | Paddle Steamer，明轮船的船舱里塞了个国际象棋）· 更新时间 **2026-09-04**

小屏上画图标有三条路：`05` §19/§20 用 `drawLine` 拼矢量、`05` §42 用行段压缩表存位图，这一节是第三条——**给每个棋子写一个只由 `drawRectF` 组成的函数**。棋子形状固定、只有 6 种，手写一次就能改，字符开销比矢量小、可读性比压缩表好。

**用到**：触控屏（按下 / 触控 X / 触控 Y）、布尔输入（按下）、屏幕

**亮点**：① 六个棋子 = 六组 `drawRectF`（各 5~15 个矩形），9×7 px 的格子里能认出形状；② `deepCopy` **递归深拷贝整盘**做悔棋；③ **长按 30 tick** 才弹菜单（Restart / Undo / Resume），短按只落子；④ 落子只判「目标格异色」即可吃子，**不做走法合法性校验**；⑤ 棋盘用 11 px 格子，`for c=4,81,22` 交错铺底色。

```lua
-- 棋子编号：0 空 / 1 王 2 后 3 车 4 象 5 马 6 兵（白），+6 = 黑（7~12）
-- 于是 d >= 7 判黑方，d 与 d+6 是同一种棋子 → 绘制时可以合并判断
reset = {{9,11,10,8,7,10,11,9},        -- 黑方底线：车 马 象 后 王 象 马 车
         {12,12,12,12,12,12,12,12},    -- 黑兵
         {0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0},
         {0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0},
         {6,6,6,6,6,6,6,6},            -- 白兵
         {3,5,4,2,1,4,5,3}}            -- 白方底线
```

```lua
-- ① 棋子 = 一组 drawRectF（a,b 是格子左上角；每个矩形最小 1 px）
function pawn(a,b)                     -- 兵：5 段
  drf(a+2,b,3,3) drf(a+3,b+3,1,1) drf(a+2,b+4,3,2) drf(a+1,b+6,5,1) drf(a,b+7,7,2)
end
function rook(a,b)                     -- 车：6 段（顶部四个垛口 + 车身 + 底座）
  drf(a,b,1,2) drf(a+2,b,1,2) drf(a+4,b,1,2) drf(a+6,b,1,2)
  drf(a+1,b+1,5,6) drf(a,b+7,7,2)
end
function king(a,b)                     -- 王：7 段（中间柱 + 两侧衣摆 + 顶部十字）
  drf(a,b,1,7) drf(a+1,b+3,1,5) drf(a+2,b+4,3,5) drf(a+5,b+3,1,5) drf(a+6,b,1,7)
  drf(a+3,b,1,3) drf(a+2,b+1,3,1)
end
-- queen / bishop / knight 同理，各 8~15 个矩形；调用处：
if     d == 1 or d == 7  then king  (xx, yy)
elseif d == 2 or d == 8  then queen (xx, yy)
elseif d == 4 or d == 10 then bishop(xx, yy)
elseif d == 5 or d == 11 then knight(xx, yy)
elseif d == 3 or d == 9  then rook  (xx, yy)
elseif d == 6 or d == 12 then pawn  (xx, yy) end
```

```lua
-- ② 长按 30 tick 弹菜单；短按只落子（同一块屏，两种语义不冲突）
if press then t = t + 1; if t == 30 then menu = true end else t = 0 end
if press and not prev then
  if menu then
    if     touch(30,21,38,9) then pos = deepCopy(reset); menu = false          -- Restart
    elseif touch(30,43,38,9) then if lastPos then pos = deepCopy(lastPos) end  -- Undo
                                  menu = false
    elseif touch(30,65,38,9) then menu = false end                             -- Resume
  else
    for a = 1, 8 do for b = 1, 8 do
      if touch(a*11-7, b*11-7, 11, 11) then
        if fromPos then
          if color(a,b) ~= color(fromPos[1], fromPos[2]) then  -- 异色即可落（含吃子）
            lastPos = deepCopy(pos)                            -- 🔑 深拷贝存档
            pos[b][a] = pos[fromPos[2]][fromPos[1]]
            pos[fromPos[2]][fromPos[1]] = 0
            fromPos = nil
          end
        elseif pos[b][a] ~= 0 then fromPos = {a, b} end
      end
    end end
  end
end
prev = press

function deepCopy(t)          -- 递归深拷贝：盘面只有 64 格，代价可以忽略
  local r = {}
  for k, v in pairs(t) do r[k] = type(v) == "table" and deepCopy(v) or v end
  return r
end
```

- 🔑 **深拷贝 vs 栈式 undo 的取舍**：`02` §10 的 α-β 引擎每步要复制整盘做搜索，64 格深拷贝太贵，改成「O(1) 改盘 + 旧值压栈」；本节每回合才走一步，**深拷贝的一次性代价完全无所谓，换来的是 Undo 只要一行**。选哪种看「复制频率 × 盘面大小」。
- ⚠ **反面教材：升变写在 `onDraw` 里**。原脚本在绘制循环中做 `if d == 6 then pos[b][a] = 2 end`（兵走到底线升后）。绘制函数只该画，不该改状态——屏幕被裁剪 / 关闭 / 该行在可视区外时，升变就不会发生，盘面与画面不一致。应移到 `onTick`。
- ⚠ **没有走法校验**是刻意的：两人对战靠自觉，省掉一整套马走日 / 象走斜 / 王车易位的合法性判断，脚本才装得进 8192 字符。要接 AI 就必须补（参见 `02` §10）。
- 关联：`05` §42（位图行段压缩表，另一种画小图的路子）/ `02` §10（同一题材的 α-β 搜索引擎）/ `05` §35（长按语义）/ `05` §31（单击 / 双击 / 长按的手势仲裁）


## §45 **手写渐变调色板** + 双窗口触控去抖 + 折线拼图标

来源：steam id **3794954536** · <https://steamcommunity.com/sharedfiles/filedetails/?id=3794954536> · **载具**（FL ST500 FW）· 更新时间 **2026-09-04**

仪表上常见的「转速条随数值变色」，多数人第一反应是运行时插值 RGB。在 MC Lua 里更省的做法是**把渐变写成一张短表**：段数够密时观感完全是连续渐变，却省掉了插值函数与浮点运算，改配色也只动一处。

**用到**：数字输入（RPS / 温度 / 电量 / 触控 X·Y）、布尔输入（按下）、属性文本（背景色 / 档位色，RRGGBB）、屏幕、数字输出（挡位）

**亮点**：① 12 档转速条用**表驱动的手写调色板**；② 触控去抖用**双窗口**（冷却计数在 0 或 5 都放行）实现「按住连发」；③ 温度计 / 电池图标全靠 `drawLine` + `drawRect` 手绘；④ ⚠ RGB 线性插值**蓝→红会穿过紫色**，不是直觉上的冷→热。

```lua
-- ① 手写渐变调色板：{阈值, R, G, B, 柱高} —— R 递增、G 递减，段够密就是连续渐变
PAL = {{3,0,255,0,1},{5,15,231,0,2},{10,39,207,0,3},{15,63,183,0,4},
       {20,87,159,0,5},{25,111,135,0,6},{30,135,111,0,7},{35,159,87,0,8},
       {40,183,63,0,9},{45,207,39,0,10},{50,231,15,0,11},{55,255,0,0,12}}
for i = 1, #PAL do
  if Rps >= PAL[i][1] then
    s.setColor(PAL[i][2], PAL[i][3], PAL[i][4])
    s.drawRectF(4 + i, h - 8, 1, -PAL[i][5])     -- 🔑 负高度：柱子从底边往上长
  end
end
```

```lua
-- ② 双窗口去抖：Wt 每 tick 减 1，在 0 和 5 两个时刻都放行 → 按住时每 10 tick 触发 2 次
if     TouchP and (Wt == 0 or Wt == 5) then Shifter = 3  Wt = 10   -- P
elseif TouchR and (Wt == 0 or Wt == 5) then Shifter = 2  Wt = 10   -- R
elseif TouchN and (Wt == 0 or Wt == 5) then Shifter = 1  Wt = 10   -- N
elseif TouchD and (Wt == 0 or Wt == 5) then Shifter = 0  Wt = 10 end  -- D
```

```lua
-- ③ 图标全靠折线拼：温度计的小圆圈 + 电池的电极与外壳，各 6 行
s.drawLine(w/4-2, h-7, w/4-2, h-3)  s.drawLine(w/4-1, h-8, w/4-1, h-7)
s.drawLine(w/4,   h-7, w/4,   h-3)  s.drawLine(w/4-3, h-3, w/4-3, h-1)
s.drawLine(w/4-2, h-1, w/4+1, h-1)  s.drawLine(w/4+1, h-3, w/4+1, h-1)
```

- ⚠ **反面教材：RGB 线性插值蓝→红会穿过紫色**。原脚本写 `Tr = line*255; Tg = 0; Tb = 255 - Tr`——中间值 (128, 0, 128) 是**紫色**，看着像警报而不是「温热」。要做直觉上的冷→热，得走多段（蓝→青→绿→黄→红，即上面的调色板思路），或转成 HSL 只动色相。
- ⚠ **原写法依赖运算符优先级**：`if TouchP and Wt==0 or TouchP and Wt==5 then` 等价于 `(TouchP and Wt==0) or (TouchP and Wt==5)`，结果正确，但这种写法极易在后续修改中读错。**一律加括号**。
- ⚠ **触控区在 `onTick` 末尾才计算**，判断语句用的却是上一帧的 `TouchP` → 所有触控慢一帧。要立刻响应就把 `TouchP = Touch and TouchZone(...)` 挪到判断之前（`03` §23 记过同款反面教材）。
- 🔑 **双窗口的意义**：单窗口（只在 `Wt == 0` 放行）是「按下一次触发一次」；双窗口在两个时刻放行，等于把冷却期切成两半，得到「按住时匀速连发」的手感，且不用额外状态机。
- 关联：`05` §2（负高度条形图）/ `05` §19（矢量图标）/ `05` §31（单击 / 双击 / 长按的手势仲裁）/ `09` §21（同一辆车的挡位选择器逻辑）


## §46 **一套脚本适配四种屏**：屏幕尺寸表 + 百分比坐标 + 手动居中文本

来源：steam id **3792849187** · <https://steamcommunity.com/sharedfiles/filedetails/?id=3792849187> · **载具**（GSP Syntia Compact Passenger Airplane）· 更新时间 **2026-08-30**

`05` §39 的响应式是「屏不够大就不画这个控件」（布尔裁剪）。这一节是另一种：**所有坐标先按 100×100 归一化，绘制时再乘当前屏的宽高**——同一套布局在 1×1 到 9×5 上自动等比缩放，不需要为每个尺寸写分支。

**用到**：触控屏、属性（显示器尺寸下拉、目标温度）、外部数字（当前温度）、布尔输出（升温/降温使能）

**亮点**：① `screenSizes` 表 + 属性索引，一次性定下逻辑画布；② `scaleX/scaleY` 把百分比换算成像素；③ `drawTextAligned` 用 `string.len(text)*5` **估宽手动居中**（`drawTextBox` 的对齐参数在窄控件里不够用）；④ 同作品时钟小组件的三个细节：`%2d` + `gsub` 补零、分钟跳变触发冒号闪烁、`drawLine` 手绘度符号。

```lua
function onTick()
  -- ① 屏幕尺寸表：属性下拉 → 逻辑画布尺寸（脚本按 100x100 设计，绘制时再缩放）
  screenSizes = {{w=32,h=32},{w=64,h=64},{w=160,h=96},{w=288,h=160}}
  screenSize  = screenSizes[property.getNumber("Monitor Size")]

  inTemp    = input.getNumber(8)
  isPressed = input.getBool(1)
  inputX, inputY = input.getNumber(3), input.getNumber(4)

  -- 按钮命中区同样用百分比坐标，四种屏共用一个判定
  buttonsOffset = {x = math.floor(screenSize.w*0.4)+5,
                   y = math.floor(screenSize.h*0.5)}
  TempUp   = isPressed and isPointInRectangle(inputX, inputY, buttonsOffset.x, buttonsOffset.y-7, 10, 7)
  TempDown = isPressed and isPointInRectangle(inputX, inputY, buttonsOffset.x, buttonsOffset.y+2, 10, 7)
  output.setBool(5, TempUp)
  output.setBool(6, TempDown)
end

-- ② 百分比 → 像素
function scaleX(x) return screen.getWidth() *(x/100) end
function scaleY(y) return screen.getHeight()*(y/100) end

-- ③ 手动居中：SW 的字符宽约 5 px，用 string.len 估宽即可
function drawTextAligned(x, y, text, alignX, alignY)
  local strWidth = string.len(text)*5
  screen.drawTextBox(x-(strWidth/2), y-2.5, strWidth, 5, text, alignX, alignY)
end

function onDraw()
  if inTemp >= desiredTemp then screen.setColor(34,177,36)   -- 达标绿
  else                          screen.setColor(237,28,26) end  -- 未达标红
  drawTextAligned(scaleX(30)-2, scaleY(40), math.floor(inTemp))
  -- 按下的三角按钮换成实心 + 换色，一行做出「按下去」的反馈
  if TempUp then
    screen.setColor(34,177,36)
    screen.drawTriangleF(buttonsOffset.x+2, buttonsOffset.y-2,
                         buttonsOffset.x+5, buttonsOffset.y-6,
                         buttonsOffset.x+9, buttonsOffset.y-2)
  end
end
```

<details><summary>同作品另一块脚本：时钟小组件的三个细节</summary>

```lua
-- ④ 游戏内时间 → 时分：以 0.5 为一天，故 1 小时 = 0.5/12
hour = math.floor(time/(0.5/12))
min  = math.floor(0.5+((time%(0.5/12))/(0.5/(12*60))))  -- 四舍五入到分，再处理进位
if min == 60 then min, hour = 0, hour+1 end
if hour == 24 then hour = 0 end

if togmin ~= min then togmin, tog = min, not tog end     -- 分钟跳变才翻转 → 冒号闪烁
dotty = tog and ":" or " "

-- %2d 补的是空格而非 0，gsub 把空格换成 0
dtime = string.gsub(string.format("%2d", hour), " ", "0") .. dotty
      .. string.gsub(string.format("%2d", min),  " ", "0")

-- 手绘度符号 °：四条 drawLine 拼一个 2x3 的小圈
screen.drawLine(x,   15+4, x,   18+4)
screen.drawLine(x+1, 15+4, x+2, 15+4)
screen.drawLine(x+1, 17+4, x+2, 18+4)
screen.drawLine(x+2, 15+4, x+2, 18+4)
```

</details>

- **百分比布局 vs 布尔裁剪**：前者让所有控件**等比缩放**，适合信息密度固定的小面板；后者（§39）适合「小屏放不下的就干脆不显示」。两者可混用。
- ⚠ `string.len` 只对 ASCII 准确；中文字符要按 2 倍宽算（见 `05` §20 一带的中文渲染说明）。
- `%2d` 补的是**空格**不是 0，`gsub(" ","0")` 是标准补零写法；`string.format("%02d", n)` 一步到位但字符更多。
- 关联：`05` §39（响应式布尔裁剪）/ `05` §38（角线长度按屏宽百分比）/ `00_速查 §16`（`drawTextBox` 对齐参数）


## §47 触控取色器：**RGB / HSV 双模式三竖条滑块** + 渐变预览条 + 日夜主题表

来源：steam id **3792089119** · <https://steamcommunity.com/sharedfiles/filedetails/?id=3792089119> · **载具**（DB BR 622 I 620 A）· 更新时间 **2026-08-29**

`05` §45 的调色板是「脚本自己算出一串颜色」。这一节反过来——**让玩家在屏上挑颜色**，而且同一组滑块能在 RGB 与 HSV 两种模式下工作（`mode` 一个布尔切换换算路径），滑块几何完全复用。列车内饰灯、暖气、车身色都能套。

**用到**：触控屏（按下 + X·Y）、布尔输入（夜间 / 手动输入使能 / 外部开关）、数字输入（屏宽高、外部 HSV 或 RGB 数值）、数字输出（R/G/B，0~1）、布尔输出（暖气）

**亮点**：① 三条触控语义一次定义（`onTouch` / `onRelease` / `onPress`），靠 `pre` 存上一帧按下状态；② 竖条滑块把 `t.y` 一行线性映射成通道值；③ `mode` 布尔在 RGB / HSV 两条换算路径间切换；④ 渐变预览条 `dGHSV` 逐像素算色、画 `1×1` 实心矩形；⑤ 手动 / UI 双输入源用布尔门控互斥；⑥ 日夜两套配色只切 `theme` 表的指向。

```lua
-- ① 三种触控语义：pre 是上一帧的 press（必须在 onTick 末尾更新）
function touch(x,y,w,h) return t.x>=x and t.y>=y and t.x<x+w and t.y<y+h end
function onTouch(x,y,w,h)   return touch(x,y,w,h) and press end
function onRelease(x,y,w,h) return touch(x,y,w,h) and pre and not press end
function onPress(x,y,w,h)   return touch(x,y,w,h) and press and not pre end
```

```lua
-- ② 三根竖条：o 是响应式左边界（屏再窄也留 29 px 给左侧开关）
o  = math.max(d.w/2-14, 29)
tA = onTouch(o,    24, 7, 33)
tB = onTouch(o+11, 24, 7, 33)
tC = onTouch(o+22, 24, 7, 33)
u  = tA or tB or tC
if u     then slide = mode and rgb2hsv(unpack(col)) or col end
if tA    then slide.a = (56 - t.y)/32 end   -- 🔑 y 从 56 到 24 线性映射到 0~1
if tB    then slide.b = (56 - t.y)/32 end
if tC    then slide.c = (56 - t.y)/32 end
if u     then col     = mode and hsv2rgb(unpack(slide)) or slide end
```

```lua
-- ③ 手动 / UI 双输入源：gB(4) 为真时完全忽略屏上选色，直接转发外部输入
if gB(4) then
  mcol = gB(5) and hsv2rgb(gN(7), gN(8), gN(9)) or {a=gN(7), b=gN(8), c=gN(9)}
  sN(1, mcol.a)  sN(2, mcol.b)  sN(3, mcol.c)
else
  sN(1, light and col.a or 0)   -- 🔑 关灯直接输出 0，下游不必再判一次
  sN(2, light and col.b or 0)
  sN(3, light and col.c or 0)
end
pre = gB(1)                     -- 必须在 onTick 末尾
```

```lua
-- ④ 渐变预览条：先算两端差值的每像素步长，再边推进边画 1×1 实心块
function dGHSV(x, y, l, c1, c2)
  dA, dB, dC = (c2.a-c1.a)/(l-1), (c2.b-c1.b)/(l-1), (c2.c-c1.c)/(l-1)
  for i = 0, l-1 do
    setC2(hsv2rgb(unpack(c1)))
    c1.a, c1.b, c1.c = c1.a+dA, c1.b+dB, c1.c+dC
    dRF(x+i, y, 1, 1)
  end
end
```

- ⚠ **`unpack` 只解包连续整数键部分**（标准 Lua 行为）：这里的 `col` / `slide` 用的是 `a/b/c` **命名键**，`unpack(col)` 在标准实现下返回**空**，`hsv2rgb()` 会收到三个 `nil`。游戏内若与标准一致，HSV 这一支会失效。**稳妥写法是显式传 `col.a, col.b, col.c`**（多 8 个字符换确定性），或干脆把通道存成 `col[1..3]` 数组。
- ⚠ `dGHSV` **会原地修改传入的 `c1`**（三条 `c1.a = c1.a + dA`）。调用前若还要用原值，先拷一份。
- 🔑 **竖条比横条好写**：映射就是一行 `(56 - t.y)/32`；横条还要处理宽度与左右方向。
- 🔑 **`theme` 表换配色**：日间 / 夜间只切换 `theme` 指向，绘制函数一律取 `theme.fg` / `theme.bg`，不必在每个绘制点写三元判断。
- ⚠ **触控时序**：`onPress` / `onRelease` 依赖 `pre`，`pre = gB(1)` 必须在 `onTick` **末尾**赋值；写在开头会让 `pre == press` 恒成立，两个语义永远为假（`05` §45 记过同款）。
- 关联：`05` §45（脚本侧手写渐变调色板）/ `05` §31（单击 / 双击 / 长按的手势仲裁）/ `05` §46（响应式布局）/ `00_速查 §16`（screen API）


## §48 触控**区间双游标**（首 / 末车厢）+ 按钮可用性由状态派生 + 门锁互锁

来源：steam id **3792089119** · <https://steamcommunity.com/sharedfiles/filedetails/?id=3792089119> · **载具**（DB BR 622 I 620 A）· 更新时间 **2026-08-29**

与 §47 同一辆车，但这是一块**纯状态 UI**：选「从第 N 节到第 M 节车厢开门」。这类「选一段连续区间」的控件在编组、编队、货架、灯带分组里都能复用。

**用到**：触控屏、数字输入（车厢总数）、布尔输入（外部开关）、数字输出（首 / 末序号）、布尔输出（开左门 / 开右门 / 开门）

**亮点**：① `first` / `last` 双游标，四个方向键各自带前置条件；② 车厢总数变化时**自动重置区间**；③ 箭头可不可用由状态**派生**（`sL1`…），并 `or pL1` 保持按下当帧高亮；④ 门锁互锁 `door = door and (left or right)`；⑤ 三角箭头用 `drawTriangleF` 三个顶点手算，不用图片。

```lua
-- ① 总数变化时把区间拉回全选；pNumWagons 是上一帧的总数
if numWagons ~= pNumWagons then
  first = 1
  last  = numWagons
end
pNumWagons = numWagons
```

```lua
-- ② 四个方向键：按下条件与移动条件分开写，越界时按了也不动
if onPress(d.w/2-28, 36, 7, 9) and first > 1        then first = first - 1 end
if onPress(d.w/2-12, 36, 7, 9) and first < last     then first = first + 1 end
if onPress(d.w/2+5,  36, 7, 9) and last  > first    then last  = last  - 1 end
if onPress(d.w/2+21, 36, 7, 9) and last  < numWagons then last = last  + 1 end
```

```lua
-- ③ 可用性由状态派生：or pL1 让「刚按下那一帧」仍保持高亮，避免箭头闪一下
sL1 = first > 1         or pL1
sR1 = first < last      or pR1
sL2 = last  > first     or pL2
sR2 = last  < numWagons or pR2
-- 门锁互锁：左右两侧都没勾，门状态强制关
door  = door and (left or right)
sDoor = left or right
```

```lua
-- ④ 三角箭头：三个顶点手算，size 约 3×6 px
function dTL(x, y, s)
  setC(s and (onTouch(x-2, y-2, 7, 9) and theme.acc or theme.fg) or theme.bg)
  dTF(x+2, y, x, y+3, x+3, y+6)
end
```

- 🔴 **反面教材：钳位函数返回值被丢弃**。原脚本写 `clamp(last,1,numWagons)` 和 `clamp(first,1,last)`——而这个 `clamp` 是自己定义的**纯函数**（`return math.min(math.max(v,x),y)`），没有副作用，**这两行等于什么都没做**。必须写成 `last = clamp(last, 1, numWagons)`。这类「写了但没赋值」的调用在 MC Lua 里极易漏看，因为不会报错。
- 🔑 **`or pLx` 的用意**：按下那一帧游标已经移动，`sL1` 的条件可能立刻变假，箭头会在按下瞬间闪灭。把上一帧的可用性 `or` 回来就稳了；`pL1` 在 `onDraw` 末尾更新（`pL1 = sL1 and onTouch(...)`）。
- ⚠ 本作品的 `first` / `last` **没有真正钳位**（见上），若 `numWagons` 在运行中变小，`last` 会大于总数、输出越界序号。修好 `clamp` 赋值即可。
- 🔑 **互锁放 `onTick` 而不是 `onDraw`**：`door` 是要输出的量，状态收敛必须在逻辑帧完成；绘制帧只负责把 `door` 画出来。
- 关联：`05` §29（数据驱动按钮表）/ `05` §31（手势仲裁）/ `02` §10（同为状态收敛的时机问题）


## §49 **表驱动的多通道触控微调器**：几何 + 配色 + 行为全塞一张表 + 按住连发

来源：steam id **2383435975** · <https://steamcommunity.com/sharedfiles/filedetails/?id=2383435975> · **载具**（ABSOLUTION）· 更新时间 **2026-08-15**

`05` §29 的按钮表是「几何表 + 回调闭包」，适合动作各异的按钮。这一节是**动作高度同质**的场景（N 个通道，每个都要 `+` / `-` / 复位）：把几何、未按下色、按下色、显示文本、**通道号**全压进一张扁平表，一个循环搞定绘制与响应，加一个通道只加一行。

**用到**：触控屏、属性数字（初值 Value 1/2、步长、下限、上限、是否显示小数）、数字输出（各通道当前值）

**亮点**：① 按钮表每行 12 列，第 11 列是动作符号、第 12 列是**通道索引**；② 按住即每 tick 增减一次 → 天然的「按住连发」，不需要冷却窗口；③ `R` 键复位到**属性里的初始值**；④ 数值正负自动换色；⑤ 绘制与命中判定共用同一份表，不会画在哪、点在哪对不上。

```lua
-- ① 按钮表：x,y,w,h, 未按下 rgb, 按下 rgb, 文本, 通道号
buttons = {
  {0, 0,  15,10, 255,255,255, 0,255,0, "+", 1},
  {17,0,  15,10, 255,255,255, 0,255,0, "+", 2},
  {0, 23, 15,10, 255,255,255, 255,0,0, "-", 1},
  {17,23, 15,10, 255,255,255, 255,0,0, "-", 2},
  {0, 12, 15,9,  16,16,16,   0,0,255,  "R", 1},
  {17,12, 15,9,  16,16,16,   0,0,255,  "R", 2}
}
values    = {property.getNumber("Value 1"), property.getNumber("Value 2")}
increment = property.getNumber("Increment Value")
min, max  = property.getNumber("Minimum Value"), property.getNumber("Maximum Value")
```

```lua
-- ② 按住连发：clicking 为真时每 tick 都走一遍，无需冷却计数
function updateOutputs()
  if clicking then
    for i = 1, #buttons do
      local b = buttons[i]
      if isMouseInRectangle(b[1], b[2], b[3], b[4]) then
        local v = b[12]                       -- 🔑 第 12 列即通道索引
        if     b[11] == "+" and values[v] + increment < max then values[v] = values[v] + increment
        elseif b[11] == "-" and values[v] - increment > min then values[v] = values[v] - increment
        elseif b[11] == "R" then values[v] = property.getNumber("Value "..v) end
      end
    end
  end
  output.setNumber(1, values[1])  output.setNumber(2, values[2])
end
```

```lua
-- ③ 数值显示：正负换色 + 属性控制小数位，取绝对值后再格式化
function drawParam(x, y, number)
  if number >= 0 then white() else red() end
  if showDec then screen.drawText(x, y, string.format("%1.1f", math.abs(number)))
  else            screen.drawText(x, y, string.format("%2f",   math.abs(number))) end
end
```

- ⚠ **反面教材：`%2f` 不是「两位小数」**。`%2f` 的意思是「**字段宽度 2、小数位数取默认 6**」，会打出 `0.500000`（8 个字符，几乎必然溢出 15 px 的按钮）。要两位小数应写 `%.2f`，要一位写 `%.1f`（原文上一分支的 `%1.1f` 才是想要的效果）。
- 🔑 **按住连发的两种做法**：这里是「按住 → 每 tick 改一次」，实现最短但速度固定为 60 次/秒，步长必须很小；`05` §45 的「双窗口冷却」是可控速度的连发。**通道值范围大就选后者**。
- ⚠ **函数定义在 `onTick` 内部**：本例的 `drawButton` / `isMouseInRectangle` 等都写在 `onTick` 里，每 tick 会重新创建一批闭包。省字符数（不必在两帧间传参，直接闭合 `mouseX` / `mouseY`），但对 60 Hz 循环有轻微开销——**短脚本值得，长 HUD 别这么写**。
- 🔑 **`R` 复位读属性而非硬编码**：初始值只写在属性面板里，脚本不含默认值，改配置不用改代码。
- ⚠ 命中使用 `x > rectX and x < rectX+rectW`（开区间），**边界那一像素不响应**；触摸精度够用时无所谓，但相邻按钮之间必须留 ≥1 px 间隙，否则缝隙里两个都不触发。
- 关联：`05` §29（动作各异的按钮表 + 每键冷却）/ `05` §45（双窗口连发）/ `05` §46（响应式布局）

## §50 3×5 字模的**单整数编码**：一个 15 bit 数装下整个字符 + `i%3` / `i//3` 解行列

- 来源：steam id **3792858949**
- 描述页：<https://steamcommunity.com/sharedfiles/filedetails/?id=3792858949>
- 类型：载具（GSP Syntia F Compact Cargo Airplane）· 更新时间：**2026-08-30**

小字号是 MC Lua 的刚需（`drawText` 最小字号仍偏大、且不能改字体）。`05` §42 给的是**行段压缩表**（扁平数组 + 步长 3，适合图标）；这一节是**字符**场景更省的写法：**每个字符压成一个 15 bit 整数**（3 列 × 5 行 = 15 个像素位），解码只要一次 `for` 加一行位运算。

**用到**：屏幕、数字输入（空速 / 高度 / 升降率 / 无线电高度）、属性（可选：告警色）

**亮点**：① 整表只有一行十六进制常量，63 个字符占约 380 字符；② 解码用 `i%3` / `i//3` 从线性下标还原行列，不用嵌套循环；③ `string.byte(string.upper(c)) - 32` 直接把 ASCII 映射到表下标，`c > 64` 再 `-26` 把小写折回大写区；④ `DOT` 用 `drawLine(x,y,x,y+1)` 画点——**`drawRectF(x,y,1,1)` 也能画，但 `drawLine` 两参数少一个字符**。

```lua
-- ① 字模表：3 列 × 5 行 = 15 bit，每字符一个十六进制整数（0~9、A~Z、符号）
font35 = {
  0x2482,0x5A00,0x5F7D,0x7CFA,0x52A5,0x2AAB,0x4800,0x1491,0x4494,0x5540,0x5D0,0x14,0x1C0,0x2,0x1494,
  0x7B6F,0x2C97,0x73E7,0x73CF,0x5BC9,0x79CF,0x79EF,0x7249,0x7BEF,0x7BCF,          -- A~J
  0x410,0x414,0x1511,0xE38,0x4454,0x6282,0xF67,                                      -- K~Q
  0x2BED,0x6BAE,0x3923,0x6B6E,0x79A7,0x79A4,0x792F,0x5BED,0x7497,0x726F,0x5BAD,0x4927,0x5F6D,
  0x7B6D,0x2B6A,0x6BA4,0x2B59,0x6BAD,0x388E,0x7492,0x5B6F,0x5B52,0x5B7D,0x5AAD,0x5A92,0x72A7}
```

```lua
-- ② 解码：i 从 0 到 14，高位在前（左上一列一列往下扫）
function DOT(x, y) DL(x, y, x, y+1) end            -- 比 drawRectF(x,y,1,1) 少一个字符
function dChar(x, y, char)
  local c = string.byte(string.upper(char)) - 32   -- 空格(0x20) → 0
  if c > 64 then c = c - 26 end                    -- 小写折回大写区
  if c > 0 and c < 59 then
    for i = 0, 14 do
      if font35[c] & (1 << (14-i)) > 0 then
        DOT(x + i%3, y + i//3)                     -- 🔑 一列一列：i%3 是列，i//3 是行
      end
    end
  end
end
function DST(x, y, str)                            -- 画整串，字符间距 4 px
  for i = 0, string.len(str)-1 do dChar(x + 4*i, y, string.sub(str, i+1, i+1)) end
end
```

- 🔑 **为什么是 15 bit 而不是 16**：3×5 正好 15 位，最高位恒为 0，所以每个常量都能写成 4 位十六进制。`1 << (14-i)` 从高位往低位取，对应「先左上角、逐列向下」。
- ⚠ **符号数量上限**：这里上限是 `#font35`（63），`font35[c]` 越界返回 `nil`，`nil & x` 会**直接报错**。务必保留 `c > 0 and c < 59` 这类边界判断——`05` §42 的表没有这个保护，靠调用方保证。
- ⚠ **`string.upper` 每次调用都建新字符串**：画长文本时开销可测。**常量文本（"SPD" / "R" 之类）直接在源码里写大写**，省掉 `upper`；只有运行期拼出来的串才需要它。
- 🔑 **这一套与 `05` §42 的分工**：§42 的「行段压缩表」适合**图标**（稀疏、形状不规则，按行存段更省）；这一套适合**字符集**（尺寸统一，位运算展开最快）。同一个项目里两者并存很常见。
- 关联：`05` §42（图标的行段压缩表）/ `01` §5 / `03` §18（另外两种 ROM 字体编码）/ `00_速查 §16`（screen API）
## §51 **手绘矢量数字字形**：0~9 各写一个 `drawRectF`/`drawLine` 函数 + 两位数靠偏移复用

- 来源：steam id **3793559370** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3793559370> · **微控制器**（my custom microcontrollers，`_vehicle_21` 发射倒计时 + 姿态球）
- 更新时间：2026-08-31
- 用到：复合数值 1~4（倒计时秒数 / 俯仰 / 滚转 / 偏航，后三者是「圈」）、复合布尔 1~2（计时使能 / 中止）、屏幕
- 亮点：`05` §50 是用**字模数据**（一个整数装 15 bit 点阵）画字符，这里走另一条路——**把每个数字写成一个绘制函数**，粗笔画用 `drawRectF`、斜笔画用 `drawLine`。字模表换成了代码，代价是字符数，收益是可以画任意粗细、斜切和连笔，两位数只要调两次。

```lua
-- 🔑 每个函数只管自己 (0,0)~(15,20) 的字身，调用处给 (x,y) 偏移
function one(x,y)
  DRF(9+x,1.5+y,3,19)          -- 竖：一个细长矩形
  DRF(1+x,17.5+y,14,3)         -- 底横
  DL(8+x,4+y,2.25+x,10.25+y)   -- 斜笔画只能用 drawLine
  DL(8+x,3+y,2.25+x,9.25+y)    -- 🔑 同一条斜线画两遍 = 加粗（drawLine 没有线宽参数）
  DL(8+x,2+y,1.25+x,9.25+y)
  DL(1+x,8+y,8.25+x,1.25+y)
end
-- two / thr / fou / fiv / six / sev / eig / nin / zer 同构，各自 5~15 行

S, SC, DRF, DL = screen, screen.setColor, screen.drawRectF, screen.drawLine
In, Ib = input.getNumber, input.getBool
Sin, Cos, Pi = math.sin, math.cos, math.pi

function onTick()
  Ten   = In(1)
  Pitch = In(2)*2*Pi
  Roll  = In(3)*2*Pi
  Timing, ABT = Ib(1), Ib(2)
  -- 🔑 姿态球：滚转给横偏、俯仰给纵偏，压成一个 2D 符号
  AIX, AIY = 28*Sin(Roll), 28*Cos(Pitch+Pi/2)
  N = 10 - math.floor(Ten)
end

function onDraw()
  SC(255,16,0,255)
  if Timing then
    if N == 0  then zer(72,20) end
    if N == 1  then one(72,20) end
    -- … 中间 2~9 省略 …
    if N == 10 then zer(82,20) one(62,20) end   -- 🔑 两位数 = 同一个字形画两遍，只改偏移
  end
  -- 姿态球本体 + 随 -AIX/-AIY 偏移的中心十字
end
```

- 🔑 **字形当函数，不当数据**：`zer`/`one`/… 是一等函数，可以直接塞进表做成 `digits[N](x,y)` 查表调用（本例为了省字符用了展开的 `if`，但改成 `({zer,one,two,…})[N+1](72,20)` 更短且更清晰）。
- 🔑 **加粗斜线的唯一办法是画两遍**：`drawLine` 没有线宽参数，`DL(8+x,4+y,…)` 与 `DL(8+x,3+y,…)` 相差 1 px 就是「两像素粗」。粗直笔画则直接用 `drawRectF`，一步到位。
- 🔑 **`DRF` 的坐标常带 `.5`**（`1.5+y`、`17.5+y`）：SW 的 `drawRectF` 按整数像素栅格化，加 0.5 能让奇数宽度的矩形视觉居中。写这类手绘字形时，先定好格子再统一加偏移。
- ⚠ **这个「姿态球」是解耦近似，不是真地平仪**：`AIX` 只由滚转决定、`AIY` 只由俯仰决定，两者互不相干。滚转到 90° 时俯仰方向就完全错了。它适合小角度、装饰性的 HUD；要真·地平仪请走 `09` §26 的**基向量投影**（滚转同时影响横偏与纵偏）。
- ⚠ `N = 10 - floor(Ten)`，当 `Ten` 超过 11 时 `N` 会变成负数，所有 `if N == …` 都不命中 → 屏幕空白。倒计时类显示**要给 `N` 加下界**（`max(0, 10-floor(Ten))`）。
- 🔑 **同源变体：3×4 字模（12 bit/字符）**——`3793560568_vehicle_5` 用 `font34` 表把字符压到 3 宽 4 高，比 `05` §50 的 3×5 再省 20%：`c = string.byte(string.upper(char)) - 32; if c > 64 then c = c - 26 end`，取位用 `font34[c] & (1 << (11-i))`，行/列用 `i//4` 与 `i%4` 拆。**注意 `//4` 不是 `//3`**——改字模高度时这两个常数必须一起改。
- 关联：`05` §50（3×5 字模单整数 15 bit 编码）/ `01` §5、`03` §18（另外两种 ROM 字体）/ `09` §13（矢量数字函数表做 PFD 鼓轮）/ `09` §26（真·俯仰梯）
- 完整脚本：`../../../AI相关/_提取暂存/3793559370_vehicle_21.lua`、`../../../AI相关/_提取暂存/3793560568_vehicle_5.lua`

## §52 **一根信号算两套精度**：取整给直线防抖、不取整给圆求顺滑

- 来源：steam id **3793554112** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3793554112> · **载具**（Ye-9 missing parts，`_vehicle_0` 陀螺瞄具）
- 更新时间：2026-08-31
- 用到：复合数值 9~10（转塔视角 X / Y）、11~12（X / Y 倍率）、13（垂直偏移）、屏幕
- 亮点：同一个瞄准点，作者**算了两套偏移**——`drawLine` 画的十字柱用取整版，`drawCircle` 画的圆环用未取整版。原因很实在：整数像素的直线在亚像素输入下会整条来回抖，而圆本身自带边缘过渡、平滑移动观感更好。成本只有一个 `math.floor`。

```lua
function onTick()
  x,  y  = input.getNumber(9),  input.getNumber(10)      -- 转塔视角（浮点）
  modx, mody = input.getNumber(11), input.getNumber(12)  -- 倍率（灵敏度）
  off = input.getNumber(13)                              -- 垂直零位偏移

  XModifier2 = x*modx                    -- 未取整：给圆
  YModifier2 = -y*mody + -off
  XModifier  = math.floor((x*modx)+0.5)          -- 取整（四舍五入）：给直线
  YModifier  = math.floor((-y*mody)+0.5+-off)
end

function onDraw()
  w = 32
  screen.setColor(200, 175, 25, 200)
  -- 🔑 十字柱用 XModifier / YModifier（整数）→ 不会在相邻像素间跳
  screen.drawLine(w/2+XModifier, w/2+2+YModifier,  w/2+XModifier, w/2+15+YModifier)
  screen.drawLine(w/2+XModifier, w/2-2+YModifier,  w/2+XModifier, w/2-15+YModifier)
  screen.drawLine(w/2+2+XModifier, w/2+YModifier,  w/2+15+XModifier, w/2+YModifier)
  screen.drawLine(w/2-2+XModifier, w/2+YModifier,  w/2-15+XModifier, w/2+YModifier)
  -- 🔑 圆环用 XModifier2 / YModifier2（浮点）→ 移动连续
  screen.drawCircle(w/2+XModifier2, w/2+YModifier2, 11)
  screen.drawCircle(w/2+XModifier2, w/2+YModifier2, 6)
end
```

- 🔑 **「取整 vs 不取整」是一组正交的设计维度**：不要全盘取整（圆环会一格一格跳），也不要全盘不取整（细直线会闪）。按图元类型分派：直线 / 细柱 / 文本 → 取整；圆 / 多边形 / 粗填充 → 保留浮点。
- 🔑 `math.floor(v + 0.5)` 就是四舍五入——SW Lua 没有 `math.round`。**对负数同样成立**（`floor(-1.4+0.5) = floor(-0.9) = -1`，符合预期），不必为负向量单独分支。
- ⚠ `+ -off` 这种连着两个符号的写法 Lua 合法（一元负号优先级高于加减），但读起来很容易看成笔误。写成 `- off` 或 `-off` 用括号包起来更稳。
- ⚠ 倍率 `modx` / `mody` 与零位偏移 `off` 都来自外部输入，**没有做范围钳位**——上游给一个 0 会让整个瞄具锁死在屏幕中心，给一个超大值会让图元直接飞出屏。凡是外部可调的标定参数，进绘制前至少 `clamp` 一次。
- 关联：`05` §46（一套脚本适配四种屏：百分比坐标）/ `05` §34（连线两端内缩，同样要先算单位向量）/ `00_速查 §16`（screen API）
- 完整脚本：`../../../AI相关/_提取暂存/3793554112_vehicle_0.lua`

## §53 **极坐标矢量骨架**：一个 `tilt` 旋转角驱动整幅图 + 顶点用「圈」写小数

- 来源：steam id **3793571871** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3793571871> · **载具**（Type XVIIA submarine，`_vehicle_11` 潜艇纵剖侧视图）
- 更新时间：2026-08-31
- 用到：复合数值 1~4（纵倾 / 深度 / 海底距离 / 垂速，前三者是「圈」或世界单位）、属性（Deck Height 甲板高、Sail Position 指挥塔位置、Depth Scale 深度比例、Alternate Bow / Stern 艏艉外形开关、Stan 彩蛋）、屏幕
- 亮点：整艘潜艇的二十来个顶点**共用同一个模板**——`(cos(θ·2π + tilt)*r) + cx`。所有形状信息全是「半径 + 圈小数」，姿态只由 `tilt` 一个数驱动，没有矩阵、没有分支。属性布尔再在两套艏/艉顶点间切换。

```lua
pi2 = math.pi*2
sin, cos = math.sin, math.cos

function onTick()
  bilt  = input.getNumber(1)          -- 纵倾（圈）
  depth = input.getNumber(2)
  dist  = input.getNumber(3)
  off    = property.getNumber("Deck Height") * -1
  tower  = property.getNumber("Sail Position")
  factor = property.getNumber("Depth Scale")
  altBow, altStern = property.getBool("Alternate Bow"), property.getBool("Alternate Stern")
end

function onDraw()
  w, h = screen.getWidth(), screen.getHeight()
  tilt = -bilt * pi2                                  -- 🔑 圈 → 弧度，负号定旋向
  gx, gy = w/2, (h/2) + 2 - tilt*12                   -- 艇体随纵倾平移一点，模拟起伏

  -- 🔑 模板：cos/sin(θ*2π + tilt) * r + 原点。θ 直接写「圈」的小数
  x1 = cos(0.02*pi2 + tilt)*23 + gx
  y1 = sin(0.02*pi2 + tilt)*23 + gy
  x2 = cos(0.48*pi2 + tilt)*23 + gx
  y2 = sin(0.48*pi2 + tilt)*23 + gy

  -- 🔑 嵌套原点：指挥塔以 cx1/cy1 为原点，而它本身也是同一个模板算出来的
  cx1 = cos(0.25*pi2 + tilt)*off + gx
  cy1 = sin(0.25*pi2 + tilt)*off + gy
  x3  = cos(0.50*pi2 + tilt)*21 + cx1
  y3  = sin(0.50*pi2 + tilt)*21 + cy1
  x4  = cos(1.00*pi2 + tilt)*25 + cx1
  y4  = sin(1.00*pi2 + tilt)*25 + cy1

  -- 海底线与深度：屏上「向下」是 +y
  floor = sin(0.25*pi2 + tilt)*dist - depth
  dy    = y1 + depth*factor

  screen.setColor(50,25,5,50)
  screen.drawLine(x1,y1, x2,y2)
  screen.drawLine(x3,y3, x4,y4)

  -- 🔑 属性布尔在「方艏」与「尖艏」两套顶点间切换，代价只有 4 行
  if altBow then
    screen.drawLine(x4,y4, ax1,ay1);  screen.drawLine(ex1,ey1, ax2,ay2)
    screen.drawLine(ax2,ay2, ax1,ay1); screen.drawLine(x1,y1, ex1,ey1)
  else
    screen.drawLine(x1,y1, x4,y4)
  end
end
```

- 🔑 **角度写成「圈」的小数而不是弧度**：`0.02` / `0.125` / `0.25` / `0.48` / `1` 一眼能看出相对方位（0.25 = 正下方、0.5 = 正后方），改形状时不用心算弧度。统一乘 `pi2` 一次即可。
- 🔑 **两级坐标传递代替矩阵**：指挥塔的原点 `cx1/cy1` 本身是「极坐标 + tilt」的结果，塔上的点再以它为原点算一次。艇体一转，塔自然跟着转，且各自还能单独缩放半径。**这种「父原点由同一模板算出」的写法是手写矢量图里最省字符的层级变换**。
- 🔑 **`drawLine` 逐段拼圆**：同作品 `_vehicle_6` 的 `circle(x,y,r,s)` 用 `s=64` 段折线拼圆环——`screen.drawCircle` 只能画固定细线，想要**粗环 / 虚线环 / 扇环**必须自己拼，改 `for i = 0, s-1` 的起止范围就能画任意角度的弧。
- ⚠ **反面教材：派生魔数散落在绘制代码里**。`tOff = (-off*0.8)+3`、`taper1 = (-off*0.5)+1` 这些由属性 `off` 派生的量，系数（0.8 / 0.5 / 1）互不相干却写在顶点计算中间。改一个 Deck Height 会同时动到塔高、艏锥度、偏移三处，且无从预判。凡是「由一个属性派生出多个量」，应当集中在一小段里算完，别和顶点混写。
- ⚠ **半透明叠画不会跨帧累积**：`setColor(50,25,5,50)` 每帧重画同一条线，看起来还是 alpha=50 那一层——屏幕每帧清空。想做「越叠越深」的余晖必须自己维护历史表（见 `03` §22 的衰减余晖）。
- 关联：`09` §26（同一思想的另一套实现：基向量投影做俯仰梯）/ `05` §34（连线两端内缩，同样是先算单位向量）/ `05` §51（手绘矢量字形）/ `00_速查 §4`（圈 ↔ 弧度）
- 完整脚本：`../../../AI相关/_提取暂存/3793571871_vehicle_11.lua`、`../../../AI相关/_提取暂存/3793571871_vehicle_6.lua`


## §54 **屏上触控数字键盘**：网格除法取键位 + 边沿触发 + 输入校验 + 按下态反馈

- 来源：steam id **3793646592** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3793646592> · **载具**（`_vehicle_14` 触控数字键盘微控）
- 更新时间：未取到（本轮 Steam Web API 不可达，下轮补）
- 用到：触控屏、复合布尔 1（触摸）、复合数值 3~4（触控 X/Y）、复合数值 1（输出值）、32×32 小屏
- 亮点：3 列 × 4 行的数字键盘（0~9 + 清空 + 确认），**不用给每个键写一遍矩形判定**——直接 `floor(tx / 格子宽)` 算出列、`floor(ty / 格子高)` 算出行，键位表用二维表查。

要在小屏上做一个数字键盘，最啰嗦的写法是给 12 个键各写一次 `isPointInRectangle`。这个作品把屏幕**均匀切成网格**，用两次除法定位，键位查表：

```lua
inputNumber, outputValue, lastTouch = "", 0, false
pressedRow, pressedCol = -1, -1

local keys = {                       -- ⚠ 见文末：这张表不该建在 onTick 里
  {"7","8","9"},
  {"4","5","6"},
  {"1","2","3"},
  {"X","0","E"},                     -- X = 清空，E = 确认
}

function onTick()
  local touch = input.getBool(1)
  local tx, ty = input.getNumber(3), input.getNumber(4)

  -- 🔑 网格除法取键位：屏宽 32 / 3 列 = 10.666，高 32 / 4 行 = 8
  local col, row = -1, -1
  if touch then
    col, row = math.floor(tx / 10.666), math.floor(ty / 8)
    pressedCol, pressedRow = col, row
  else
    pressedCol, pressedRow = -1, -1
  end

  if touch and not lastTouch then                       -- 🔑 边沿触发：一次触摸只算一次
    if col >= 0 and col <= 2 and row >= 0 and row <= 3 then
      local key = keys[row + 1][col + 1]
      if key == "X" then
        inputNumber = ""
      elseif key == "E" then
        outputValue = tonumber(inputNumber) or 0        -- 🔑 空串兜底
        inputNumber = ""
      else
        addDigit(key)
      end
    end
  end
  lastTouch = touch
  output.setNumber(1, outputValue)
end

function addDigit(d)
  if #inputNumber >= 4 then return end                  -- 位数上限
  if inputNumber == "" and d == "0" then return end      -- 拒绝前导零
  inputNumber = inputNumber .. d
end
```

**按下态反馈**：`pressedRow` / `pressedCol` 存在全局里，`onDraw` 比对「当前按的是不是我」即可——不必在绘制时再判一次矩形。

```lua
function drawButton(x, y, w, h, text, pressed)
  if pressed then
    screen.setColor(255, 255, 255)
    screen.drawRectF(x+1, y+1, w-1, h-1)
    screen.setColor(0, 0, 0)
    screen.drawText(x+3, y+2, text)                     -- 反白：按下时黑字白底
    screen.setColor(255, 255, 255)
    screen.drawRect(x, y, w, h)
  else
    -- 常态：按字符分色（X 红 / E 绿 / 数字白）
  end
end
```

- 🔑 **网格除法 vs 逐键矩形**：12 个键从 12 次判定降到 2 次除法 + 1 次查表，代码量与键数无关。**前提是格子必须均匀**——要做不同宽度的键（比如一个占两格的「0」）就得回到矩形判定，或给格子加权重表。
- 🔑 **触摸一定要做边沿**：`touch and not lastTouch`。不做的话按住一个键会每 tick 触发一次，60 Hz 下瞬间输满 4 位。
- 🔑 **`tonumber(inputNumber) or 0` 兜底**：清空后直接按确认会拿到空串，`tonumber("")` 返回 `nil`，`or 0` 让它变成 0 而不是把 `nil` 写进输出通道。
- 🔑 **按下态用「记录行列」而不是「绘制时重判」**：`onTick` 里已经算过一次 `col/row` 了，`onDraw` 再算一遍纯属浪费；而且 `onDraw` 拿不到 `input`（部分版本下 `input.*` 在 `onDraw` 里不可用），**状态必须在 `onTick` 里存好**。
- ⚠ **反面教材：`keys` 表建在 `onTick` 内部**，等于每 tick 新建一张二维表（60 次/秒）。这种**静态常量表一律提到文件顶层**（或放进属性文本，见 `01` §7）。
- ⚠ **`col <= 2` / `row <= 3` 是硬编码的上界**：改键位表时忘了同步改这两处，就会越界取到 `nil` 然后 `keys[nil]` 报错。正确写法是从表本身派生：`if keys[row+1] and keys[row+1][col+1] then`。
- ⚠ **`10.666` 是「屏宽 32 / 3 列」的硬编码结果**：换到别的屏尺寸就整体错位。应该用 `w/#keys[1]` 与 `h/#keys` 现算（`#keys[1]` = 列数、`#keys` = 行数）。
- 关联：`05` §49（表驱动多通道触控微调器，同样用表 + 格子）/ `05` §48（区间双游标）/ `06` §21（删除后批量修正索引引用，同类的「表与索引同步」问题）/ `07` §1（游戏自带键盘部件的协议解析，与本节的**自绘屏上键盘**是两条路）/ `02` §2（toggle 与边沿闩锁）
- 完整脚本：`../../../AI相关/_提取暂存/_b3/3793646592_vehicle_14.lua`


---

## §55 **走纸式多通道折线图**：定长 FIFO + 归一化后逐段 `drawLine` + 分道叠放

- 来源：steam id **3793236299** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3793236299> · **载具**（K-2865 Ukhta Class 弹道导弹潜艇，`_vehicle_1` 反应堆数据屏）
- 更新时间：2026-09-01
- 用到：复合数值 1~3（控制棒 / 棒温 / 功率）、1×1 屏（逻辑画布 96×64）
- 亮点：把「历史趋势」拆成三件小事——**定长 FIFO 存样本**、**归一化到 0..1 再乘道高**、**三条曲线各占一条基准线分道叠放**。整屏只有 `push` 与 `drawGraph` 两个函数，是所有「XX 随时间变化」类仪表的通用骨架。

**① 定长 FIFO（`table.insert` + 超长砍队首）**

```lua
maxPoints = 96
minVal, maxVal = 0, 1

function push(buf, val)
    table.insert(buf, val)
    if #buf > maxPoints then table.remove(buf, 1) end
end

function onTick()
    push(bufWOP, clamp(input.getNumber(1), minVal, maxVal))
    push(bufROM, clamp(input.getNumber(2), minVal, maxVal))
    push(bufYOB, clamp(input.getNumber(3), minVal, maxVal))
end
```

**② 归一化 + 逐段连线（关键：`y` 要取反）**

```lua
function drawGraph(buffer, r, g, b, yBase, height)
  screen.setColor(r, g, b)
  local size = #buffer
  if size < 2 then return end                     -- 🔑 少于两点画不出线段
  for i = 2, size do
    local p1 = (buffer[i-1] - minVal) / (maxVal - minVal)
    local p2 = (buffer[i]   - minVal) / (maxVal - minVal)
    -- 🔑 屏幕 Y 轴向下，所以是 yBase - p*height；x 直接用下标，天然「右端进新值」
    screen.drawLine(i-2, yBase - p1*height, i-1, yBase - p2*height)
  end
end

function onDraw()
  setC(34,34,34) screen.drawRectF(0,0,96,64)     -- 底
  setC(28,28,28) screen.drawRectF(0,0,96,9)      -- 标题条
  local laneH = 5
  drawGraph(bufWOP, 88, 6, 6,   50, laneH)       -- 🔑 三条道用不同的 yBase 分开
  drawGraph(bufROM, 63,95,50,   57, laneH)
  drawGraph(bufYOB, 96,88,42,   64, laneH)
end
function setC(r,g,b,a) screen.setColor(r,g,b,a or 255) end
```

- 🔑 **`x` 直接用数组下标**：新值从队尾进、队首被砍，所以「最新一点永远在 `size-1`」，不需要记时间戳，也不需要平移。**这是走纸图的核心**——比每帧重算所有点的 x 省得多。
- 🔑 **`if size < 2 then return end`**：`drawLine` 需要两点。首帧只有 1 个样本时直接返回，否则会取到 `buffer[0]` = `nil` 并报错。
- 🔑 **`yBase - p*height` 的负号**：屏幕 Y 向下，值越大要画得越高（Y 越小）。忘了负号曲线会整体倒过来。
- ⚠ **`table.remove(buf, 1)` 是 O(n)**：本例 3 条缓冲 × 96 点 = 每 tick 最多 288 次元素搬移，勉强能跑；**点数上百或通道数更多时必须换成环形缓冲**（`04` §4 的提醒，`08` §21 有可直接抄的写法）。
- ⚠ **`minVal / maxVal` 是硬编码的 0 和 1**：超出范围的读数被 `clamp` 削平，曲线会「贴顶/贴底」；数值量程变了要同步改这两个常数，否则整条线失去意义。要做自适应量程得在 `onTick` 里维护滑动极值。
- 关联：`08` §21（环形缓冲写法，本节 `push` 的高性能替代）/ `04` §4（队列与 O(n) 提醒）/ `09` §27（单位体系表，读数排版）/ `05` §1（1×1 屏上的点阵字体，本节仍用 `drawText` 是因为画布够宽）/ `00_速查 §16`（screen API）
- 完整脚本：`../../../AI相关/_提取暂存/_b2/3793236299_vehicle_1.lua`
- 同批未收录：`_b2/3793225196_vehicle_7.lua`（声纳 ping 往返计时，与 `03` §11 逐行相同）、`_b2/3793225196_vehicle_5.lua`（地图按钮表 `B`，与 `05` §39 同源）、`_b2/3793044262_vehicle_3.lua`（`drawPointer` 与 `06` §12 同源）


---

## §56 **屏上小游戏骨架**：拒绝采样做网格对齐随机 + 双表队列当蛇身 + 「每秒一步」步进

- 来源：steam id **3792866122** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3792866122> · **载具**（`_vehicle_9`，96×96 屏上的贪吃蛇）
- 更新时间：未取到（Steam Web API 本轮未返回该作品元数据，下轮补）
- 用到：1×1 屏（96×96）、4 个方向布尔 + 1 个开始布尔
- 亮点：屏上小游戏在 SW 里有三个专属约束——**没有 `os.time` 只能靠 tick 计数**、**`math.random` 必须自己对齐到像素网格**、**蛇身这种变长队列只能用两张并行表**。这里三件事都给出了最省字符的写法。

**① 拒绝采样：让随机数落在 5 px 网格上**

```lua
function spawn(mi, ma)
  a = 0
  while 1 do
    a = math.random(mi, ma)
    if a % 5 == 0 then return a end      -- 🔑 不满足就重摇，直到落在网格交点
  end
end
```

**② 两张并行表当蛇身：`table.insert(t,1,v)` 头插 + `table.remove(t)` 尾删**

```lua
-- 每步移动：新头插到 1 号位，删掉队尾 → 长度不变
table.insert(bx, 1, bx[1] + x)
table.insert(by, 1, by[1] + y)
table.remove(bx)
table.remove(by)

-- 吃到苹果：只头插不尾删 → 长度 +1
lenth = lenth + 1
table.insert(bx, 1, bx[1] + x)
table.insert(by, 1, by[1] + y)
```

**③ 「每秒一步」与状态机**

```lua
function snake()
  if (time % 60 == 0) then               -- 🔑 60 tick = 1 秒；SW 没有 os.time，只能数 tick
    if moves() == 1 then y, x =  5, 0    -- 方向 → 位移增量（5 px = 一个格子）
    elseif moves() == 2 then y, x = -5, 0
    elseif moves() == 3 then y, x = 0,  5
    elseif moves() == 4 then y, x = 0, -5 end
    if lenth >= 2 then
      table.insert(bx,1,bx[1]+x)  table.insert(by,1,by[1]+y)
      table.remove(bx)            table.remove(by)
    else
      bx[1], by[1] = bx[1]+x, by[1]+y    -- 🔑 长度为 1 时不能「插了再删」，直接改
    end
  end
  for i = 1, lenth do screen.drawRectF(bx[i], by[i], 5, 5) end
  apple()
  if colision() then run = false end
end
```

- 🔑 **拒绝采样是屏幕上做网格对齐的最省写法**：`math.floor(math.random(mi/5, ma/5))*5` 也能对齐，但边界要小心；`while` 重摇虽然「理论上可能死循环」，实际 `mi=5 / ma=85` 时命中概率 1/5，几步就出。
- 🔑 **两张并行表而不是一张表存 `{x,y}`**：省掉每步创建表的开销，也省字符。**代价是插入/删除必须成对写**，漏一个就错位——吃苹果那段只 `insert` 不 `remove` 正是靠这个不对称实现「变长」。
- 🔑 **`table.remove(t)` 不带参数删队尾**，与 `table.insert(t, 1, v)` 配对就是最简队列。⚠ 但两者都是 O(n)，蛇长上百就该换环形缓冲。
- ⚠ **反面教材：`if (time % 60 - (lvl * 2) == 0)` 并不能让蛇随等级加速**。原作者想用等级缩短步进间隔，但 `time%60` 的值域是 `0..59`，减掉 `lvl*2` 后**仍然每 60 tick 命中一次**，只是相位平移了 `lvl*2` tick，**帧率完全没变**。要真的加速得写成 `time % math.max(6, 60 - lvl*4) == 0`（改模数而不是改偏移量）。
- ⚠ **反面教材：`for j = 2, lenth do ... end` 自撞检测漏了首尾相接的情形**——但更严重的是它**在移动后才检测**，第一步就会把「蛇头刚离开的格子」算进去（该格已被尾删，所以没触发）；若将来改成不删尾就会立刻误判。检测顺序要固定为「先算新头 → 再判撞 → 再决定是否删尾」。
- ⚠ **`colision()` 的边界写死成 `5 / 85 / 10 / 90`**，与 `spawn(5,85)` 的范围必须一致；改画布尺寸时两处都要改。更稳的做法是用 `w = screen.getWidth()` 现算。
- 关联：`05` §55（走纸折线图，同样是表驱动绘图）/ `05` §44（屏上国际象棋 + 深拷贝悔棋，另一套小游戏骨架）/ `02` §10（国际象棋 negamax 引擎）/ `05` §1（点阵字体，本节用 `drawTextBox` 是因为 96 宽够用）/ `00_速查 §16`（screen API）
- 完整脚本：`../../../AI相关/_提取暂存/_b3/3792866122_vehicle_9.lua`
- 同批未收录：`_b3/3792941403_vehicle_3/_vehicle_8/_vehicle_13/_vehicle_19`（同一屏的四份副本，`rotatePoint` 与 `05` §53 同源）、`_b3/3792941403_vehicle_16`（3×4 点阵字体，与 `05` §1.1 同源）

## §57 缩放控件：端点先对齐步长网格 + 首触发延迟连发 + 按屏高分档布局
- 来源：steam id 3792692817 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3792692817 · 载具
- 更新时间：未取到（同上，下轮 `fetch_meta.py` 补）
- 用到：触控屏（1×1 / 2×2 / 3×3 通用）+ 属性给 `Minimum/Maximum/Start zoom distance` 与 `Zoom increment`
- 亮点：三个容易被忽略却决定手感的细节——**端点先落回步长网格**、**按住 0.15 s 后才开始连发**、**布局按屏高分三档并换两套位图**

**① 左右半屏点选 + 首触发延迟连发**

```lua
-- 右上角 10x10 是静音按钮，必须从缩放命中区里挖掉
U  = iPIR(iX,iY, w/2,0, w/2,h) and iP and not iPIR(iX,iY, w-10,0, 10,10)   -- 右半屏 = 放大
D  = iPIR(iX,iY, 0,0,   w/2,h) and iP                                       -- 左半屏 = 缩小
US, DS = U and step, D and step
if U or D then
    step = false
    T = T + 1/60                       -- 🔑 SW 没有 os.time，自己数秒
end
if not iP or T >= 0.15 then            -- 🔑 按住 0.15 s 才放行下一次跳档
    step = true
    T = 0
end
```

**② 端点先对齐步长网格再跳**

```lua
if US then
    if d == MinDis then d = math.floor(MinDis/ZStep)*ZStep end   -- 🔑 先落回网格
    d = math.min(d + ZStep, MaxDis)
elseif DS then
    if d == MaxDis then d = math.floor(MaxDis/ZStep)*ZStep end
    d = math.max(d - ZStep, MinDis)
end
```

**③ 按屏高分三档（1×1 / 2×2 / 3×3 各一套）**

```lua
if h <= 32 then
    screen.drawTextBox(w-11, h-8, 10, 7, string.format("%.0f", d/1000), 1, 1)   -- 只显示整数 km
elseif h < 96 then
    NN, OO = math.modf(d/1000)
    if OO*10 >= 9.5 then OO, NN = 0, NN+1 end          -- 🔑 防 9.97 显示成 "9.10"
    screen.drawTextBox(w-19, h-7, 10, 5, string.format("%.0f", NN), 1, 0)
    screen.drawTextBox(w-9,  h-7, 11, 5, ".")
    screen.drawTextBox(w-9,  h-7, 11, 5, string.format("%.0f", OO*10), 0, 0)
else
    -- 同上，再补一个 "km" 单位（省略）
end
```

**④ 位图图标随屏高换两套字模**

```lua
function print(x, y, Mw, Mh, M)        -- ⚠ 覆盖了同名的全局 print（SW 无内置 print，但别混用）
    for i = 0, Mw-1 do
        for j = 0, Mh-1 do
            if M[j*Mw+(i+1)] == 1 then screen.drawRectF(x+i, y+j, 1, 1) end   -- 🔑 +1：Lua 数组从 1 起
        end
    end
end
-- h > 32 用 7x7 字模，h <= 32 换 5x5（同一图标两套分辨率，窄屏才不糊）
```

- 🔑 **为什么要先 `floor(端点/步长)*步长`**：若 `MinDis` 不是 `ZStep` 的整数倍（如 `MinDis=250 / ZStep=100`），
  直接 `d = d + ZStep` 会跳到 350——一个歪值；再按减档又回到 250，端点之间来回漂移，且中间档位全不在网格上。
  先在端点处把 `d` 拉回网格（`floor(250/100)*100 = 200`），之后增档得 300、减档得 100，整条档位序列才是干净的。
- 🔑 **首触发延迟连发与 `05` §31 的长按节拍是两种思路**：§31 用 `hbON` 计数器做**固定节拍**（每 N tick 一档，节奏均匀）
  本例是**按住就计时、满 0.15 s 放行**（按下瞬间立刻跳一档，之后按 0.15 s 一档）。后者首档响应更快，适合缩放这类「点一下就够、按住才快调」的操作。
- 🔑 **静音区从命中区里挖掉，而不是反过来**：`U` 的判定写成 `右半屏 且 不在右上角 10x10`，
  这样缩放区自动避让按钮；改按钮位置时只改这一处。`D`（左半屏）不重叠所以不用挖，但**动布局时要重新检查**。
- ⚠ `T = T + 1/60` 依赖 60 Hz。掉帧 / 联机时 0.15 s 会被拉长（同 `02` §3.2），想要真实秒数要走外部计时。
- ⚠ `math.modf` 返回的第二个值是**带符号的小数部分**（负数时同为负），本例 `d` 恒正所以没问题；处理可能为负的量要先取 `abs`。
- ⚠ `print()` 用了双重循环逐像素 `drawRectF`，7×7 图标就是 49 次调用。屏上同时画多个图标时，
  改成「按行压缩成 `drawRectF(x, y, w, 1)`」能省一个数量级（见 `05` §42 的行段压缩表）。
- 关联：`05` §31（触控手势三合一，`hbON` 长按节拍）/ `05` §49（表驱动微调器的按住连发）/
  `05` §11（触控缩放控制器，闭包 capacitor/counter + 比例步长，与本例的定步长相对）/
  `05` §42（位图行段压缩表）/ `05` §39（按屏尺寸裁剪控件的响应式思路）/ `00_速查 §16`（screen API）
- 完整脚本：`../../../AI相关/_提取暂存/_b1/3792692817_vehicle_3.lua`

## §58 摄像头直通做 HUD 底图（`drawCamera` 打底 + 半透明条 + 双口径百分比）
- 来源：steam id 3793256534 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3793256534 · 载具
- 更新时间：未取到（未被价值轨榜单收录，Steam Web API 未返回元数据）
- 用到：9×5 屏（288×160）+ 摄像头 + 油门 / 刹车 / 电量三路数值 + 三路 Bool
- 亮点：**一块屏同时出摄像头画面和 HUD**，不用第二块脚本做视频透传；电量通道一行兼容「0~1」与「0~100」两种上游口径

```lua
function onDraw()
    screen.drawCamera(0, 0)                       -- 🔑 摄像头画面当底图，必须写在第一行

    -- 顶栏：半透明黑底，保证文字在任何天色/背景都可读
    screen.setColor(0, 0, 0, 140)
    screen.drawRectF(0, 0, 288, 24)
    screen.setColor(0, 255, 200, 255)
    screen.drawText(6, 8, isReverse and "REV" or "FWD")     -- 🔑 and/or 一行三目

    -- 双层进度条：先暗底（读"还剩多少"），再按值画亮条
    screen.setColor(40, 40, 40, 200);  screen.drawRectF(65, 8, 40, 8)
    screen.setColor(0, 255, 100, 255); screen.drawRectF(65, 8, math.floor(throttle*40), 8)

    -- 🔑 双口径归一化：上游给 0~1 还是 0~100 都能吃
    local battPct = math.floor(battery <= 1 and battery*100 or battery)
    screen.drawText(190, 8, string.format("BAT:%d%%", battPct))   -- ⚠ 百分号要写 %%

    if connFront then
        screen.setColor(0, 255, 0, 255); screen.drawText(10, 146, "[F-CONN: LOCKED]")
    else
        screen.setColor(150,150,150,255); screen.drawText(10, 146, "[F-CONN: OFF]")
    end
end
```

- 🔑 **`screen.drawCamera(0, 0)` 是「摄像头 + HUD 同屏」的最短路径**：不需要第二块脚本接视频输入做透传
  （对比 `05` 里「两块 Lua 用视频串联做图层叠加」的方案，那里是为了**两层脚本各自画的矢量**叠加）。
  **必须写在 `onDraw` 的第一行**——后画的才盖在画面上，写反了会被摄像头画面整个盖掉。
- 🔑 **半透明遮罩条（`alpha = 140`）而不是实色**：既压暗背景保证文字可读，又不完全挡住画面。
  这是所有「画中画 HUD」的标配；`0/0/0/140` 与 `0/0/0/255` 的观感差别很大，值得单独调。
- 🔑 **双口径归一化 `battery <= 1 and battery*100 or battery`**：一行同时兼容「0~1」和「0~100」两种上游约定。
  ⚠ 边界要自己核对一遍：`battery` 恰为 `1` 时走 `×100` 得 100（对），恰为 `0` 时也得 0（对）。
  真正的风险是**上游给 0~1 但真实值恒小于 0.01**（几乎没电）会被当成 0~100 口径。
  能从上游统一口径就统一，别依赖这种推断。
- 🔑 **双层进度条**：暗底（40,40,40,200）+ 亮条，比「只画亮条」更容易读出剩余量。
  `math.floor(v*40)` 取整避免亚像素宽度抖动（同 `08` §22 的像素取整）。
- ⚠ `string.format("BAT:%d%%", ...)` 里百分号必须写成 `%%`，漏写一个会报格式串解析错误。
- ⚠ **`onDraw` 里直接 `input.getNumber` / `getBool` 虽然能跑，但多人联机下 `onDraw` 与 `onTick` 读到的不是同一帧**。
  凡是要参与状态判断的量（`isReverse`、`connFront`）建议在 `onTick` 里读进全局再用
  （同 `04` §10「计算放 `onTick`、画弧放 `onDraw`」）。
- ⚠ 分辨率写死 288×160（9×5 屏）：换屏尺寸时全部坐标要重算。用 `w`/`h` 现算更稳——
  和 `08` §22「循环上限写死 100」是同一类问题。
- 关联：`05` §5x（两块 Lua 用视频串联做图层叠加，另一种实现）/ `09` §15（油耗与续航的进度条）/
  `08` §22（半透明条与像素取整）/ `01` §14（`2^k-1` 位掩码，把本节三路状态灯压进一条通道）/ `00_速查 §16`
- 完整脚本：`../../../AI相关/_提取暂存/_b3/3793256534_vehicle_0.lua`
- 同批未收录：`_b3/3793281684_vehicle_0` `_vehicle_1`（`g`/`b` 未定义即使用，坐标还超出屏宽，属坏样本）/
  `_b3/3793341737_microcontroller_0`（4 行的"数值不再增长就亮灯"检测，过于琐碎）

## §59 单通道热力色 `setColor(255, v, 0)` + 3×3 状态灯网格（含循环化改写）
- 来源：steam id 3793254347 · 描述页 https://steamcommunity.com/sharedfiles/filedetails/?id=3793254347 · 载具
- 更新时间：未取到（未被价值轨榜单收录，Steam Web API 未返回元数据）
- 用到：3×3 屏 + 8 路数值（每路 0~255，当绿色通道用）
- 亮点：**一路数值直接当颜色通道**做红→黄→绿的热力渐变，一行搞定，不需要任何 HSL / 调色板代码

```lua
function onTick()
    rod1 = input.getNumber(1)      -- … rod8，每路 0~255
    -- rod2 … rod8 同理（原脚本逐行写死，见下方改写）
end

function onDraw()
    w, h = screen.getWidth(), screen.getHeight()
    -- ✅ 改写后：3×3 网格用两层循环，原脚本是 9 组硬编码坐标
    screen.setColor(255, 255, 255)
    for i = 0, 2 do
        for j = 0, 2 do
            screen.drawRect(26 + j*15, 10 + i*15, 14, 14)     -- 1 px 白框
        end
    end
    -- 🔑 一路数值直接当绿色通道：0 → 纯红，128 → 橙黄，255 → 黄绿
    screen.setColor(255, rod1, 0); screen.drawRectF(27, 11, 13, 13)
    screen.setColor(255, rod2, 0); screen.drawRectF(42, 11, 13, 13)
    -- …… rod3~rod8 同法；第 2 行中间那格被强制涂黑（该槽位没有控制棒）
end
```

- 🔑 **`setColor(255, v, 0)` 是最省的红→绿热力渐变**：固定 R=255、B=0，只让 G 随数值走。
  `v=0` → (255,0,0) 红；`v=128` → (255,128,0) 橙；`v=255` → (255,255,0) 黄绿。
  想要末端收进**纯绿**（而非黄绿），把 R 也随 v 一起降：`setColor(255-v, v, 0)` 是近似版，
  严格版要分段（前一半 `setColor(255, 2*v, 0)`、后一半 `setColor(510-2*v, 255, 0)`）。
- 🔑 **连续渐变 vs 阈值表配色**：`05` §45 的阈值表适合「正常 / 警告 / 危险」这种**离散语义**，
  本例的连续渐变适合「温度 / 负载 / 液位」这类要**读趋势**的量。别用反了——
  阈值表看不出「快超温了」，连续渐变看不出「已经越线」。
- 🔑 **状态灯 = 1 px 白框 + 内缩 1 px 实心块**：`drawRect(x,y,14,14)` 画框、`drawRectF(x+1,y+1,13,13)` 填色。
  同一套路见 `09` §29 的 1×1 屏白框、`05` §5 的按钮外框。
- ⚠ **反面教材：9 个格子全硬编码**——原脚本 18 次 `drawRect` + 18 次坐标，改屏尺寸要动 36 处。
  两层 `for` 之后从 36 行压到 6 行，改格距只动一个 `15`。
  **凡是「同一形状重复 N 次」的绘制，一律先想循环**——SW 的 8192 字符上限下这笔账很划算。
- ⚠ `setColor(255, rod1, 0)` 没给 alpha（默认 255）；但 **`rod1` 上游断线时会是 `nil`**，`setColor` 直接报错。
  稳妥写法 `setColor(255, rod1 or 0, 0)`。
- ⚠ `w` / `h` 读进来却从没使用（坐标全写死），是典型的重构残留。
- 关联：`05` §45（手写渐变调色板的阈值表方案）/ `05` §6.2（HSL 自动对比色）/
  `09` §29（1×1 屏白框与分段仪表）/ `08` §22（同一形状重复用循环）/ `00_速查 §16`（screen API）
- 完整脚本：`../../../AI相关/_提取暂存/_b3/3793254347_vehicle_0.lua`


## §60 触控按钮的**按下后延时显示** + 命中即广播 + 3 位十六进制紧凑字模

- 来源：steam id 3794064264 · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3794064264> · 载具（`_vehicle_14` 一块 64×32 小屏的按钮条）
- 更新时间：未取到（Steam Web API 未返回该作品元数据）
- 用到：触控屏（数值 3/4 = 触点，布尔 1 = 按下）、布尔 10/11（外部使能 / 告警）、数值 9（待显示读数）、属性配色
- 亮点：把「按一下闪一下的临时读数」做成**一个倒计时变量**（`numberDisplayTicks`），比「按下时显示、松手就消失」好用得多；另附一小段只用**一个超长十六进制串**当字库的自绘字体。

```lua
S = screen
SC, DC, DRF, DR, DL, DTX = S.setColor, S.drawCircle, S.drawRectF, S.drawRect, S.drawLine, S.drawText

local numberDisplayTicks = 0      -- 读数还剩多少 tick 要显示
local numberMaxTicks = 100        -- 一次按下点亮多久（100 tick ≈ 1.7 s）

function onTick()
  b1 = input.getBool(10)          -- 外部使能，例如「系统就绪」
  b2 = input.getBool(11)          -- 外部告警
  in7 = input.getNumber(9)
  inputX, inputY = input.getNumber(3), input.getNumber(4)
  isPressed = input.getBool(1)

  -- ① 复合命中：把「外部使能」直接并进命中表达式，省一层嵌套
  T1 = isPressed and isPointInRectangle(inputX, inputY, 2, 25.5, 5, 5)
  T2 = isPressed and isPointInRectangle(inputX, inputY, 57, 26.5, 5, 5)
  T3 = isPressed and isPointInRectangle(inputX, inputY, 51, 26.5, 5, 5)
  T4 = isPressed and b1 and isPointInRectangle(inputX, inputY, 44, 26.5, 5, 5)
  T5 = isPressed and isPointInRectangle(inputX, inputY, 35, 26.5, 7, 5)

  -- ② 命中即广播：按下高亮与对外输出共用同一个布尔，不会不同步
  output.setBool(2, T1)
  output.setBool(3, T2 and b1)
  output.setBool(4, T3 and b1)
  output.setBool(5, T4 and b1)
  output.setBool(6, T5 and b1)

  if T4 then numberDisplayTicks = numberMaxTicks end   -- ③ 开一个显示窗口
  if numberDisplayTicks > 0 then numberDisplayTicks = numberDisplayTicks - 1 end
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
  return x > rectX and y > rectY and x < rectX + rectW and y < rectY + rectH
end
```

```lua
function onDraw()
  -- ④ 按下态：在原位叠一层半透明深色（不是换色，是加一层）
  if T2 and b1 then SC(2,2,2,55) DRF(57, 26.5, 5, 5) end
  if T3 and b1 then SC(2,2,2,55) DRF(51, 26.5, 5, 5) end
  if T1       then SC(2,2,2,55) DRF(1, 24.5, 7, 7) end
  if T4 and b1 then SC(2,2,2,255) DRF(44, 26.5, 5, 5) end

  -- ⑤ 松手后读数还留 100 tick：先夹到 0..4 再取整
  if numberDisplayTicks > 0 then
    SC(17,17,17)
    DTX(37, 5, tostring(math.floor(math.min(math.max(in7, 0), 4))))
  end

  if b2 then                                   -- 外部告警：红底 + 细边框
    SC(255,2,2,25) DRF(35, 26.5, 7, 5)
    SC(255,2,2,19) DR(35, 26, 6, 4)
  end
end

-- ⑥ 3x4 像素字模：整张字库压成一个十六进制长串，byte*3-95 直接定位
function txt(x, y, t)
  t = tostring(t)
  for i = 1, t:len() do
    local c = t:sub(i,i):upper():byte()*3 - 95
    if c > 193 then c = c - 78 end             -- 把小写 / 符号区折回大写区
    c = "0x" .. string.sub("0000D0808F6F5FAB6D5B7080690096525272120222010168F9F5F1BBD9DBE2FDDBFBB8BCFBFEAF0A01A025055505289C69D7A7FB6699F96FB9FA869BF2F9F921EF69F11FCFF8F696FA4F9EFA55BB8F8F1FE1EF3FD2DC3CBFDF9086109F4841118406F90F09F6642", c, c+2)
    for j = 0, 11 do                           -- 12 bit = 3 列 x 4 行
      if c & (1 << (11 - j)) > 0 then
        local b = x + j//4 + i*4 - 4
        DL(b, y + j%4, b, y + j%4)             -- 单像素线段当点用
      end
    end
  end
end
```

- 🔑 **按下后延时显示**：`numberDisplayTicks` 是一个纯倒计时——按下时置 `numberMaxTicks`，此后每 tick 递减，`onDraw` 里 `> 0` 就画。相比「按下即显、松手即隐」，它让手指松开后读数还留约 1.7 s，适合小屏上「按一下查一下」的交互。与 `05` §35 的开机自检动画是同一个「一个计数驱动多个视觉」的思路，本例是它的最小形态。
- 🔑 **复合命中**：`T4 = isPressed and b1 and isPointInRectangle(...)` 把外部使能直接并进命中表达式，比「先判区域再 `if 使能`」少一层嵌套、少一个变量。
- 🔑 **命中即广播**：`output.setBool(2, T1)` 让「按下高亮」和「对外输出」**共用同一个布尔**——不会出现「屏上亮了但没输出」或反之（同 `05` §39）。
- ⚠ **按下态的高亮矩形与命中区不是同一个矩形**：命中区 `(2, 25.5, 5, 5)`，高亮却是 `DRF(1, 24.5, 7, 7)`——高亮向外扩了 1 px 做视觉反馈。改命中区时若不同步改高亮，会出现「点了没反应」或「没点却亮」。
- 🔑 **读数先夹后取整**：`math.floor(math.min(math.max(in7, 0), 4))` 一行完成「限幅 + 取整」，比 `if` 链省字符，也杜绝了显示 `-1` 或 `7.3`。
- 🔑 **3 位十六进制紧凑字模**：把整张字库压成**一个超长十六进制串**，用 `byte*3 - 95` 直接算出字符的起始下标，再 `string.sub(FONT, c, c+2)` 取 3 位（12 bit = 3×4 像素）。相比「一张 `{0x123, 0x456, ...}` 数表」，省掉所有逗号与花括号，是**字符预算最紧时的方案**（对照 `05` §50 的 15 bit 单整数编码、`03` §18 的 16 进制 ROM 字体）。
- 🔑 **`if c > 193 then c = c - 78 end` 把小写 / 符号折回大写区**：一张表同时覆盖大小写，代价只是几个区段的字形复用。
- ⚠ 上面的 `c` 先被赋成 `"0x..." ` 字符串、紧接着又参与 `&` 位运算，靠的是 Lua 对十六进制字符串的隐式数值转换。能跑，但改写时建议显式写 `tonumber(c, 16)`，避免换解释器后行为不一致。
- ⚠ 单像素用 `drawLine(x, y, x, y)` 画——`screen` 没有 `drawPixel`，这是标准绕法（`03` §26 也用 `drawText(".")` 当像素，两者按场景选）。
- 关联：`05` §50（3×5 字模单整数编码）、`03` §18（16 进制 ROM 字体）、`01` §5（字模基础）、`05` §35（一个计数驱动多个视觉）、`05` §39（命中区即广播）

## §61 折线图的「好看刻度」（1 / 2 / 5 × 10^k 档）+ **稀疏表**存采样点 + 峰值标记

- 来源：steam id 3796142734 · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3796142734> · 载具（`_vehicle_2` 动力单元测功机 DISPLAY 2）
- 更新时间：未取到（Steam Web API 未返回该作品元数据）
- 用到：复合通道（数值 3/4/5 = 采样序号 / X 值 / Y 值，布尔 3/4/5 = 写入 / 复位 / 完成）、一块 96×64 屏
- 亮点：坐标轴上限不是「取最大值」而是**取一个好看的最大值**——步长只允许 1、2、5 × 10^k 三种，刻度线因此永远是整数；采样点用**两张平行稀疏表**按序号存放，允许中间空缺。

```lua
R, A = {}, {}          -- 两张平行表当稀疏数组：下标 = 采样序号，允许中间是 nil
phase, ready = 0, false

function onTick()
  phase = input.getNumber(8)
  if input.getBool(4) then R, A, ready = {}, {}, false end      -- 复位：整表重建
  if input.getBool(3) then                                      -- 写入一拍
    local i = math.floor(input.getNumber(3) + .5)               -- 序号是浮点，先落回整数
    R[i], A[i] = input.getNumber(4), input.getNumber(5)
  end
  if input.getBool(5) then ready = true end                     -- 测量完成才画曲线
end

-- 🔑 返回 >= v 的「好看」上限，同时给出步长：步长只有 1/2/5×10^k 三档
function niceMax(v, n)
  if v <= 0 then return 1 end
  local raw = v / n                       -- 期望步长 = 上限 / 期望分段数
  local p = 10 ^ math.floor(math.log(raw, 10))
  local q = raw / p                       -- 归一到 1..10
  local s = q <= 1 and 1 or q <= 2 and 2 or q <= 5 and 5 or 10
  local step = s * p
  return math.ceil(v / step) * step, step -- 上限 = 步长的整数倍（向上取整）
end

-- 有效数字随量级走：窄屏上 100 以上不显示小数，1 以下保留两位
function fmt(v)
  if v >= 100 then return string.format("%.0f", v) end
  if v >= 10  then return string.format("%.1f", v) end
  return string.format("%.2f", v)
end
```

```lua
function onDraw()
  local w, h = screen.getWidth(), screen.getHeight()
  screen.setColor(0, 0, 0) screen.drawClear()

  if not ready or #R < 2 then                     -- 没测完就只给状态文字
    screen.drawTextBox(0, h/2 - 4, w, 8, phase == 1 and "MEASURING" or "READY", 0, 0)
    return
  end

  local rmax, vmax, peak = 0, 0, 1
  for i = 1, #R do
    if R[i] and R[i] > rmax then rmax = R[i] end
    if A[i] and A[i] > vmax then vmax, peak = A[i], i end   -- 峰值下标顺手记下来
  end
  if vmax <= 0 or rmax <= 0 then return end

  local xmax, xstep = niceMax(rmax, 5)
  local ymax, ystep = niceMax(vmax, 4)

  local x0, x1, y0, y1 = 25, w - 3, h - 17, 11    -- 左边留 25 px 给 Y 标签，下面留 17 px 给 X
  local gw, gh = x1 - x0, y0 - y1

  for r = 0, xmax, xstep do                       -- ① 刻度循环直接用步长做增量
    local x = x0 + r / xmax * gw
    screen.drawLine(x, y0, x, y0 + 3)
    local t = fmt(r)
    screen.drawText(x - #t * 2.5, y0 + 5, t)      -- ② 按字宽手算居中（drawText 无对齐参数）
  end

  local px, py = nil, nil
  for i = 1, #R do                                -- ③ 稀疏表必须逐段判空
    if R[i] and A[i] then
      local x = x0 + R[i] / xmax * gw
      local y = y0 - A[i] / ymax * gh
      if px then screen.drawLine(px, py, x, y) end
      px, py = x, y
    end
  end

  screen.setColor(255, 180, 80)
  screen.drawCircleF(x0 + R[peak] / xmax * gw, y0 - A[peak] / ymax * gh, 2)
end
```

- 关联：`05` §55（走纸式折线图：定长 FIFO + 分道叠放，讲的是**时间序列**，本节是**X-Y 散点**）、`04` §9.1（对数域缩放）
- ⚠ **反面教材**：作者用 `#R` 当长度遍历一张**稀疏表**。Lua 里带空洞的表 `#` 是**未定义行为**，某个洞刚好落在末尾就会少画几段。这里因为序号连续所以够用；稳妥做法是另存一个 `n = n + 1` 的显式计数。

---


## §62 **半透明占位数字**（ghost）+ 手绘 ℃ 符号 + 按字宽手算右对齐 + 滑动窗口均值

- 来源：steam id 3796154868 · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3796154868> · 载具（`_vehicle_0` 恒温器小屏）
- 更新时间：未取到（Steam Web API 未返回该作品元数据）
- 用到：温度传感器（数值 7）、属性（默认温度、测量窗口秒数）、触控屏（数值 3/4 触点、布尔 1 按下）、布尔 7/8/9/10（外部升温 / 降温 / 开关 / 目标刷新）
- 亮点：**先用 25/255 的半透明黑把「满位数字」画一遍再画真值**——既给 LCD 底纹感，又天然把字宽撑住，位数变化时文字不会左右跳；℃ 符号用 3 个 `.` 加一竖手绘。

```lua
function celcius(x, y)                  -- 手绘 ℃：三个点 + 一竖，比找字体省事
  screen.drawText(x - 1, y - 4, ".")
  screen.drawText(x,     y - 2, ".")
  screen.drawText(x,     y,     ".")
  screen.drawLine(x, y + 2, x, y + 5)
end

function presentTemp(t, x, y)
  local T = math.floor(t * 10 + .5) / 10   -- 先量化到 0.1，避免 -0.0 这类显示抖动
  local I = math.floor(math.abs(T))
  local d = (math.abs(T) - I) * 10
  if t < 0 then I = -I end
  screen.drawText(x - 4 - (string.len(I) * 5), y, I)   -- 🔑 按位数右移 = 右对齐（字宽按 5 px 估）
  screen.drawText(x - 5, y, ".")
  screen.drawText(x - 2, y, string.format("%.0f", d))
end

function ghostNumbers(x, y)              -- 🔑 底纹：暗到几乎看不见，但把字宽撑住
  screen.setColor(0, 0, 0, 25)
  presentTemp(-88.8, x, y)               -- 满位样本：-88.8 是所有位数最宽的情况
end
```

```lua
function onTick()
  t    = input.getNumber(7)
  setT = input.getNumber(8)
  bUP, bDOWN = input.getBool(7), input.getBool(8)
  on, tUpdated = input.getBool(9), input.getBool(10)

  if tUpdated then T = setT end                 -- 外部改目标值：直接覆盖本地
  if bUP   and T <  50 then T = T + .5 end      -- 每 tick 半度，按住即连续调节
  if bDOWN and T > -50 then T = T - .5 end

  -- 滑动窗口均值：窗口长度 = 属性给的秒数 × 60 tick
  table.insert(tHist, t)
  if #tHist > tTime * 60 then table.remove(tHist, 1) end
  averageT = 0
  for i, v in ipairs(tHist) do averageT = averageT + v end
  if #tHist > 0 then averageT = averageT / #tHist end

  output.setNumber(1, averageT)
  output.setNumber(2, T)
  output.setBool(1, on and t < T)               -- 恒温：低于目标就加热
end
```

- 关联：`05` §60（按下后延时显示的倒计时变量）、`09` §15（油耗的固定窗口累计求平均，同一手法用在油量上）
- ⚠ **反面教材（原脚本）**：开头写成 `if not w and w > 0 then return end` 想判「屏没接上就返回」。
  这个条件是**恒假**：屏接上时 `not w` 为 false，直接短路跳过；屏没接上时 `w` 是 nil，`w > 0` 会**当场报错**。
  正确写法是 `if not w or w <= 0 then return end`（`or` + 反过来判）。


---

## §63 浮动标签的**出屏夹取** + 半透明底衬 + **空值占位**（战术地图 HUD）

- 来源：steam id 3796074511 · <https://steamcommunity.com/sharedfiles/filedetails/?id=3796074511> · **载具**（战术地图 / 雷达接触叠加）
- 更新时间：未取到（Steam Web API 对本批新 id 不返回元数据）
- 用到：触控屏、`map.screenToMap` / `map.mapToScreen`、雷达 8 槽（距离/方位/仰角）、罗盘（圈）
- 亮点：HUD 上「跟着光标/目标跑的文字」最容易在屏幕边缘跑丢。本例用**固定框宽的双向夹取**一行解决，
  并用**占位串 + 调暗**让「没有数据」和「数据为零」一眼可分。

```lua
-- ① 出屏夹取：先算理想位置，再对两个方向各夹一次
lx = math.max(1, math.min(w-37, mx+8))     -- 37 = 标签框宽 + 余量（不含文字实测宽度）
ly = math.max(1, math.min(h-8,  my-3))
screen.setColor(0,0,0,210)                 -- ② 半透明底衬，任何底色上都可读
screen.drawRectF(lx-1, ly-1, 38, 9)
screen.setColor(255,190,40)
screen.drawText(lx, ly, st)

-- ③ 单位自适应：与 06 §14 同口径
if sd >= 1000 then st = string.format("%.1fkm", sd/1000)
else              st = string.format("%.0fm",  sd) end

-- ④ 空值占位：无数据时照样输出一行，只是换成暗色 + 破折号
if sel then screen.setColor(255,190,40); screen.drawText(3,21, string.format("TGT %.1fkm", sd/1000))
else        screen.setColor(100,115,115); screen.drawText(3,21, "TGT --") end

if rv then screen.setColor(255,70,70); screen.drawText(3,30, string.format("AIR %.1fkm %+.0fm", rr/1000, rh))
else       screen.setColor(100,115,115); screen.drawText(3,30, "AIR NO TRACK") end
```

**要点**

- 🔑 **夹取用「屏宽 − 框宽」而不是「屏宽 − 字宽」**。`string.format("%.1fkm")` 的位数会随数值变（`"0.8km"` 4 字符、`"12.3km"` 6 字符），
  按内容实测宽度就要每帧多算一次；直接按**最坏情况**留固定 37 / 50 px，省字符且**永不越界**。
  代价是短文本右边留白略多——小屏 HUD 上完全可接受。
- **底衬 alpha 取 210~220 而不是 255**：既压住地图/海图的杂色，又保留底下地形轮廓，不显得是块补丁。
- 🔑 **空值占位 ≠ 空字符串**。`"TGT --"` / `"AIR NO TRACK"` 保证**行数和行高不变**，布局不跳；
  同时把颜色调暗（`setColor(100,115,115)`）——读者一眼分清「还没选定」和「数值真的是 0」。
  与 `05` §62 的 ghost 数字互补：**ghost 处理位数变化，本例处理有无数据**，两者可以叠加。
- **一次性 nan 门控**：`rv = lock and rr==rr and ra==ra and re==re and rr>10 and rr<100000`——
  `x == x` 为假即 nan（见 `04` §12），一次判完三路再统一决定「这个接触要不要画」。
  不这么做，`mapToScreen` 会拿到 nan 坐标，整块屏幕可能什么都不画。

**关联**：`05` §62（ghost 占位数字）/ `06` §14（点屏设航路点，同一个 `screenToMap`）/ `04` §12（NaN 三件套）/ `03` §20（雷达接触叠到地图）


---

## §64 手绘**折线红区** + `%0Nd` 定宽读数 + 阈值变色（紧凑车用仪表）

- 来源：steam id 3796005618 · <https://steamcommunity.com/sharedfiles/filedetails/?id=3796005618> · **载具**（摩托车仪表，2×1 屏）
- 更新时间：未取到（Steam Web API 对本批新 id 不返回元数据）
- 用到：RPS / 速度 / 挡位 / 温度四路数值输入、`screen.drawLine` 手绘指针与刻度、阈值变色
- 亮点：2×1 屏上没有空间放告警灯和装饰。本例**用一串 `drawLine` 手描出任意形状的红区**，
  用 `%02.0f` / `%03.0f` 的定宽格式让读数永不跳位，用**整块读数换色**代替告警图标。

```lua
m = 180                                     -- 主色亮度，一处改全局跟着变
function onDraw()
  -- ① 模拟指针：读数归一化到 [-2π/3, +2π/3]，再减 π/2 让 0 指向正上方
  minA, maxA = -math.pi*2/3, math.pi*2/3
  a = minA + math.min(math.max(RPS/15,0),1)*(maxA-minA) - math.pi/2
  screen.drawLine(13,13, 13+math.cos(a)*10, 13+math.sin(a)*10)

  -- ② 定宽读数：位数变化也不跳位
  screen.drawText(9, 6, string.format("%02.0f", RPS))     -- 补前导零
  screen.drawText(45,6, string.format("%03.0f", S))       -- 车速最多 3 位

  -- ③ 手绘红区：没有 drawArc，就用一串 drawLine 描出任意形状的危险段
  screen.setColor(153,0,0)
  screen.drawLine(22,19,22,20) screen.drawLine(23,17,23,19) screen.drawLine(24,14,24,17)
  screen.drawLine(25,13,25,14) screen.drawLine(24,12,24,13)

  -- ④ 阈值变色：越限整块读数换色，不另画告警框
  if RPS >= 12.5 then screen.setColor(153,0,0) else screen.setColor(m,m,m) end
  screen.drawText(9,6, string.format("%02.0f", RPS))

  if RPS <= 6 then screen.setColor(m,m,m) else screen.setColor(16,16,16) end
  screen.drawText(1,27,"IDLE")              -- ⑤ 状态字用「变暗」表达未激活
end
```

**要点**

- 🔑 **手绘红区 = 把表盘刻度当设计图纸抄**。每条 `drawLine` 一段折线，顶点直接从刻度上量。
  比 `drawArc` / 三角扇省 API、省字符，在 1×1 / 2×1 小屏上尤其划算；缺点是**改刻度要手改顶点**。
  对照 `09` §29 的「径向叠线造弧厚」：那个适合**规则圆弧**，本例适合**不规则形状**（转速红线常常一头宽一头窄）。
- 🔑 **`%02.0f` / `%03.0f` 是零成本的防跳位**：与 `05` §62 的 ghost（暗底先画满位）目的一样，
  但这里靠格式串实现，一个字符不多花。⚠ 前导零会占视觉宽度（`"07"` 而不是 `" 7"`）；
  想保留空白就写 `%2.0f` / `%3.0f`（空格补位），效果更接近 ghost，按审美选。
- **阈值变色用整块读数而不是加图标**：小屏没有地方放告警灯，换色是**最省面积**的表达方式。
  注意比较用**工程值**（`RPS >= 12.5`）而不是归一化后的比例，改量程时阈值含义不变。
- **状态字用「变暗」表达未激活**（`IDLE` 在怠速以上变暗）：既不占新位置，又传达了状态。
- ⚠ 本例把读数的 `drawText` 写了两遍（一次定宽、一次变色后重写）——**同一帧重复绘制同一位置**是可行的
  （后画的覆盖先画的），但要注意**先写底色块再写文字**，否则会盖掉文字。

**与既有章节的分工**：`04` §10 讲「归一化放 onTick、三角扇画弧」的**通用表盘骨架**；
`09` §4 讲**模拟指针仪表**的整盘布局。本例只取三处**小屏细节**（手绘红区 / 定宽读数 / 阈值变色），
是那两节在 2×1 屏上的落地补丁。


---

## §65 **点阵图用二进制字符串表** + **竖屏的 W/H 互换适配层** + 双帧动画

- 来源：steam id **3795830668** · <https://steamcommunity.com/sharedfiles/filedetails/?id=3795830668> · **载具**（屏上小游戏）
- 更新时间：未取到（Steam Web API 对本批新 id 不返回元数据）
- 用到：1×1~5×3 屏、`screen.drawRectF`、`string.sub`
- 亮点：字模/精灵图直接用**字符串数组**存，一行一个字符串、`"1"` 就画一个像素——比位掩码表可读一百倍，改图只改引号里的内容。另外整套绘制走一层**转置适配**，同一个 `R()` 在横屏竖屏都能用。

```lua
-- ① 一个字符 = 一个 3×5 点阵，每行一个字符串；键是字符本身
F = { A={"010","101","111","101","101"},
      B={"110","101","110","101","110"},
      ["0"]={"111","101","101","101","111"},
      ["<"]={"001","010","100","010","001"} }   -- 数字键要写 ["0"]，"0" 会被当数字下标

-- ② 🔑 W/H 互换：屏被竖着装时，把「宽」定义成 getHeight。全文件只认 W()/H()
function W() return screen.getHeight() end
function H() return screen.getWidth()  end

-- ③ 画一个像素块：注意 x/y 与 w/h 是交换着传的（旋转 90°）
function R(x,y,w,h) screen.drawRectF(y, screen.getHeight()-x-w, h, w) end

-- ④ 画一张点阵图：逐行逐字符判 "1"
function SP(s,x,y,z)
  for r=1,#s do
    local q = s[r]
    for c=1,#q do
      if q:sub(c,c)=="1" then R(x+(c-1)*z, y+(r-1)*z, z, z) end
    end
  end
end

-- ⑤ 字宽手算：n 个字符 ×(3+1) 格 − 1 个间隙
function TW(s,z) return #s*4*z - z end

-- ⑥ 双帧动画：同一角色两张表，按帧号交替
A1={"00011000","00111100","01111110","11011011","11111111","00100100","01011010","10100101"}
A2={"00011000","00111100","01111110","11011011","11111111","01011010","10100101","01000010"}
SP(A1, x, y, 2)      -- 奇数帧
SP(A2, x, y, 2)      -- 偶数帧（只改最后两行 -> 尾部摆动）
```

- 🔑 **② 这层适配是最值钱的部分**：只有 `W()` / `H()` 两个函数知道屏的真实方向，后面所有布局都按「W 是我要用的宽」写。屏从横装改成竖装时**只改这两行**，不动任何绘制代码。
- 🔑 **③ 的转置要连 Y 一起翻**：`drawRectF(y, getHeight()-x-w, h, w)` 里 `getHeight()-x-w` 是旋转后补的上下翻转，漏掉会上下颠倒。
- ⚠ **① 里的数字键必须写 `["0"]`**：写 `0=` 会被 Lua 当数组下标 0，而 Lua 数组从 1 开始，`F[0]` 反而是**另一个**槽位（能存能取，但 `#F` 数不到它）。
- ⚠ **字符串表比位掩码表费字符**（`"111"` 是 5 字节，位掩码 `7` 是 1 字节）。8192 预算紧张时改用 `05` §50 的「一个整数装 15 bit」编码；只在预算宽裕或需要人肉改图时用字符串表。
- 关联：`05` §50（3×5 字模单整数 15 bit 编码，省字版）/ `05` §56（屏上小游戏骨架）/ `05` §51（手绘矢量数字字形）/ `00_速查 §14`（字数压缩）


---

## §66 跨脚本方块画超长画面：**设计分辨率缩放** + **微型绘图 DSL** + **同色矩形 RLE**

- 来源：steam id 3795644548 · <https://steamcommunity.com/sharedfiles/filedetails/?id=3795644548> · **微控**（一台「新闻电视」，一个微控制器里 18 个 Lua 块，每块约 7.5 K 字符）
- 更新时间：未取到（Steam Web API 对本批新 id 不返回元数据）
- 用到：微控制器内的多个 Lua 脚本方块、`screen.drawRectF` / `drawLine` / `drawTriangleF` / `drawText`
- 亮点：一整幅 288×160 的手绘插画按字符算是装不进单个 8192 字符脚本块的。
  作者把它**切成 18 个块**，每块自成一「层」，共用同一套只有 5 个函数的微型绘图 DSL——
  **每个矩形从约 40 字符压到 11 字符**，这才是能塞进去的真正原因。

```lua
-- REPORTER / STATIC CHUNK 1 —— Video in: previous layer. Do not clear.
function onTick() end                       -- ① 纯静态层：逻辑留空，把 tick 预算让给别人
function onDraw()
  local W,H  = screen.getWidth(), screen.getHeight()
  local sx,sy = W/288, H/160                -- ② 设计分辨率 288×160，一次算好缩放
  local function C(r,g,b)      screen.setColor(r,g,b) end
  local function R(x,y,w,h)    screen.drawRectF(x*sx, y*sy, w*sx, h*sy) end
  local function L(x1,y1,x2,y2) screen.drawLine(x1*sx, y1*sy, x2*sx, y2*sy) end
  local function T(x1,y1,x2,y2,x3,y3)
    screen.drawTriangleF(x1*sx,y1*sy, x2*sx,y2*sy, x3*sx,y3*sy)
  end

  C(0,40,133)  R(84,81,1,1)
  C(0,55,164)  R(83,61,1,1)  R(85,61,1,1)                       -- ③ 换一次色，连续画完所有该色矩形
  C(1,20,41)   R(84,80,1,1)  R(72,82,1,1)
  C(7,7,7)     R(72,59,3,1)  R(83,59,3,1)  R(71,60,5,1)  R(82,60,6,1)
  C(209,204,204) R(72,62,1,1) R(75,62,1,1) R(82,62,2,1) R(85,62,2,1)
end
```

唯一有逻辑的那一层（`block#17`）用 **LCG 伪随机**每 30 秒换一条内容：

```lua
local t, story, seed = 0, 1, 37
function onTick()
  t = t + 1
  if t >= 1800 then                        -- 60 tick/s -> 每 30 s 换一条
    t = 0
    seed = (seed*73 + 41) % 997            -- 🔑 线性同余，模 997（质数）
    local n = 1 + seed % 4
    if n == story then n = n % 4 + 1 end   -- 一行防「连续抽到同一条」
    story = n
  end
end
-- onDraw 里按 story 选字幕与角色动作：
if story == 1 then X(57,147,"FERRY PARKED ON MAIN STREET")
else               X(48,147,"SEAGULLS STEAL EMERGENCY SIREN") end
```

**要点**

- 🔑 **设计分辨率 + 两个缩放系数**：所有坐标按 288×160 写死，`R/L/T` 内部统一乘 `sx/sy`。
  换屏幕不用改一个坐标；`sx ~= sy` 时也不会算错（两个方向独立缩放）。
  与 `05` §65 的「W/H 互换适配层」互补：**那个是把横屏设计转成竖屏布局，这个是同比例任意缩放**。
- 🔑 **把缩放包进函数，是比别名压缩更省的一环**。只做别名（`drf=screen.drawRectF`）的话，
  每个矩形仍要写 `drf(x*sx,y*sy,w*sx,h*sy)`（约 30 字符）；包一层 `R(x,y,w,h)` 后只剩 11 字符。
  18 块 × 数百个矩形，省下的是几万字符——**这是「装得下」和「装不下」的分界线**（见 `01` §2/§14 的字数账）。
- 🔑 **同色批处理 = 事实上的 RLE**：`C(色)` 后紧跟一串 `R(...)`，一行能塞十几个同色块。
  与 `05` §42「位图图标行段压缩表」目的一样，但**不需要解码表**——直接就是可执行代码，改一个像素只改一行。
  优先把画面按**颜色分层**而不是按**空间分块**，能显著减少换色次数。
- 🔑 **静态层把 `onTick` 留空**：只有需要动画/计时的那一个块写 `onTick`，其余 17 块 `function onTick() end`。
  微控制器里所有块共享同一 tick 预算，把纯绘制的块的逻辑开销归零很划算。
- 🔑 **用 LCG 而不是 `math.random`**：`math.random` 在多人下**各端不同步**（见 `00_速查` §15），
  `seed=(seed*73+41)%997` 是纯确定性整数运算，所有端算出同一个 `story`。模取 997（质数）周期够长。
  `if n==story then n=n%4+1 end` 一行解决「连续两次抽到同一条」——比 `repeat ... until` 省得多。
- ⚠ **多块共享一路视频时不要 `screen.clear()`**。作者注释 "Video in: previous layer. Do not clear."
  说明各层是**叠加**关系：先画的在下、后画的在上，任何一块清屏都会把前面的层擦掉。
  若各块接的是独立输出通道则互不影响——**接线前先确认是「串联叠加」还是「各自输出」**。
- ⚠ **拆块的代价**：常量（如配色、公共坐标）要在**每个块里各写一份**，改一次要改 18 处。
  真正需要共享的量请走 property 或复合输入，不要指望块之间能互相读变量。

**关联**：`01` §2/§14（字数压缩）/ `05` §42（位图行段压缩表）/ `05` §65（竖屏适配）/ `01` §11（微控内多脚本协同）/ `00_速查` §15（多人不同步）

## §67 按钮表的**有向互斥**：`tofalse` / `ifnot` 两张关系表 + **外部状态强制同步**

- 来源：steam id **3796902721** · 描述页 <https://steamcommunity.com/sharedfiles/filedetails/?id=3796902721> · **载具**（号灯 / 航行灯控制面板，64×32 屏）
- 更新时间：未取到（Steam Web API 连续多轮不返回新上架作品元数据，下轮 `fetch_meta.py` 补）
- 用到：触控屏（2×1）、8 路布尔输出（ANC / NUC / NAV / RAM / TUG / TOW / SOS / AUTO）、属性 `Automatic`
- 亮点：`05` §29 的按钮表用 `grp` 做**分组内互斥**，那是无向的（同组互清）。这里的关系是**有向**的——「点亮我时该关掉谁」和「谁亮着就不许点亮我」是两件不同的事，用两张关系表表达才够。
- 区别于 `05` §29（绘制 + 回调双闭包、每键冷却）：本节的表更薄（无闭包），代价是画法固定，换来的是**关系可读**。

```lua
B={
 {x=30,y=h-24,title="ANC",toggle=false,tofalse={"NUC","NAV","RAM","TUG","TOW"},ifnot={"SOS"},auto=true},
 {x=bm+bw+3,y=h-16,title="NAV",toggle=false,tofalse={"ANC"},ifnot={},auto=true},
 {x=w,y=h,title="SOS",toggle=false,tofalse={"RAM","TUG","TOW","NUC","ANC"},ifnot={}},
 {x=4,y=0,title="AUTO",toggle=property.getBool("Automatic")}
}

function press(i, v)
    if v.ifnot then                     -- 前置条件：名单里任一已亮 → 拒绝点亮
        for _,n in pairs(v.ifnot) do
            for _,v2 in pairs(B) do if v2.toggle and v2.title==n then return end end
        end
    end
    if v.tofalse then                   -- 有向互斥：清掉名单上的键（不对称！）
        for k,v2 in pairs(B) do
            for _,n in pairs(v.tofalse) do if v2.title==n then B[k].toggle=false end end
        end
    end
    B[i].toggle = true
end

for i,v in pairs(B) do
    -- 自动模式：外部输入与手动按钮共用同一条点亮路径
    pass = v.auto and B[8].toggle and v.state ~= v.toggle
    if (I.x>v.x and I.x<v.x+bw and I.y>v.y and I.y<v.y+bh) or pass then
        if I.push or pass then press(i, v) end
        pressing = I.press
    else
        pressing = false
    end
    B[i].push = pressing
    output.setBool(i, v.toggle)
end
```

- 🔑 **`tofalse` 是有向的**：SOS 亮起会清掉其它五个，但其它键的 `tofalse` 里没有 SOS——只有 `ifnot={"SOS"}` 能挡住它们。分组互斥（`grp`）表达不出这种单向压制。
- 🔑 **用 `title` 字符串当外键**：键数 < 10 时，三层 `pairs` 扫描比维护一张 `title -> index` 映射更省字符；规模上去了再换索引表。
- 🔑 **`pass` 让外部状态与手动按钮共用一条路径**：自动模式下 `v.state`（别的脚本算出的号灯状态）与本键状态不一致时直接触发点亮，按钮退化成「显示器」，不需要额外的同步分支。
- ⚠ **命中区间的开闭要和画的一致**：本例 `I.x>v.x and I.x<v.x+bw` 是**半开**区间，`05` §25 用的是闭区间，两者都能用，但必须和 `drawRectF(v.x,v.y,bw,bh)` 的边界观感一致，否则最外圈 1 px 点不到。
- 反面教材：原脚本 `conf=true; if conf then …` 是恒真嵌套，纯属冗余；按钮配色写成三层 `if/else` 嵌套，改成「状态 → 颜色」查表可省一半字符。
- 关联：`05` §29（数据驱动按钮表）、`05` §20（`click` 闩锁做单次触发）
