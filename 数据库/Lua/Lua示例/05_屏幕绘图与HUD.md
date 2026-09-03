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
