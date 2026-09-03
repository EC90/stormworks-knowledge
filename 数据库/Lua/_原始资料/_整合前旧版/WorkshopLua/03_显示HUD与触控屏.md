# 03 · 显示 HUD 与触控屏

> screen / map API 清单见 `00_速查 §16`；触控输入约定同章。本文件只讲**手法组合**。
> 全部示例的代码块均为 ASCII，可直接粘进游戏内脚本方块。

---

### 1. 3×4 超小点阵字体（12 bit/字符，逐像素 `drawLine`）

- 来源：steam id 2900758088 · <https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088> · **载具**（Liechtes Ozelot）
- 更新时间：**2022-12-21**
- 用到：显示器、属性滑块（RGB / 透明度）、1x1 显示器检测开关
- 亮点：**每个字符只占 12 bit**（3 列 × 4 行），用一条 `drawLine(x,y,x,y+1)` 画一个「像素点」——比 `screen.drawText` 窄得多，1×1 屏也能塞下文字。

```lua
-- 68 entries, indices 1..68 ; each = 12 bits, 3 cols x 4 rows (MSB first)
font34={
0x0D0,0xC0C,0xFAF,0x2F4,0xB2D,0x6F5,0x0C0,0x690,0x096,0xAEA,0x4E4,0x560,0x444,0x010,0x168,0x79E,0x5F1,
0x9B5,0x9DA,0x6F2,0xDDA,0x6DA,0x9AC,0x3FC,0x4A7,0x050,0x1A0,0x44A,0xAAA,0xA44,0xA41,0x69D,0x7A7,0xFD6,
0x699,0xF96,0xFD9,0xFA8,0x69B,0xF2F,0x9F9,0x19E,0xF4B,0xF11,0xF4F,0xF6F,0x696,0xFA4,0x6B7,0xFA5,0x5BA,
0x8F8,0xE1E,0xC3C,0xF5F,0x969,0xC7C,0xBD9,0xF90,0x861,0x09F,0x484,0x111,0x084,0x2F9,0x0F0,0x9F4,0x462}

-- one "pixel" = a 1px vertical line (cheapest way to plot a point)
function dDot(x,y)
  screen.drawLine(x,y,x,y+1)
end

function dChar(x,y,char)
  c=string.byte(string.upper(char))-32            -- '!'->1 ... '_'->63
  if c>64 then c=c-26 end                         -- {|}~ folded into 65..68
  if c>0 and c<69 then
    for i=0,11 do
      if font34[c]&(1<<(11-i))>0 then             -- MSB first
        dDot(x+i//4, y+i%4)                       -- col = i//4 (0..2), row = i%4 (0..3)
      end
    end
  end
end

function dStr(x,y,str)
  for i=0,string.len(str)-1 do
    dChar(x+4*i,y,string.sub(str,i+1,i+1))        -- advance 4px (3 + 1 gap)
  end
end
```

调用（含 1×1 / 大屏自适应居中）：

```lua
function onDraw()
  w=screen.getWidth() h=screen.getHeight()
  screen.setColor(color[1],color[2],color[3],color[4])
  if mon ~= true then dStr(w/2+5,h/2+10,"LA")     -- 1x1 monitor: right-shifted
  else                dStr(w/2-15,h/2+10,"LA") end
end
```

**要点**
- `screen.drawLine(x,y,x,y+1)` 是 SW 里**画单个像素**的标准替代（`drawRectF(x,y,1,1)` 亦可，前者更省）。
- 字模用 **12 bit 打包成 3 位十六进制**（`0x0D0`），68 个字符仅约 400 字符源码——这是**在 8192 上限内塞下自定义字体**的关键。
- `string.upper()` 后仍保留 `c>64` 折叠分支，把 `{|}~` 也塞进表内；若你只做大写字母+数字，可把表砍到 36 项省一半空间。
- 字符横向步进是 `4 px`（3 宽 + 1 间隔），据此可用 `#str*4` 精确排版居中。

- 完整脚本：`AI相关/_提取暂存/2900758088_vehicle_1.lua`
- 关联：`00_速查 §13`（仅 ASCII 源码）、`§14`（8192 上限）、`§16`（screen API）

---

### 2. 3×5 点阵字体 + 字模存进属性文本 + 地图配色主题与自动对比色

- 来源：steam id 2774712393 · <https://steamcommunity.com/sharedfiles/filedetails/?id=2774712393> · **微控制器**（Zizo Transponder Locator）
- 更新时间：**2023-11-26**
- 用到：显示器、属性文本（FONT1/FONT2/MapColor1/2）、属性滑块
- 亮点：**把字模表放进 `property.getText`，完全不占脚本字符数**——绕开 8192 上限的最强手法；同时演示 `setMapColor*` 全套地图配色与**按平均 HSL 反色求自动对比色**。

```lua
-- 字模存在属性文本里：FONT1/FONT2 各存若干 4 位十六进制，每字符 15 bit (3x5)
FONT=property.getText("FONT1")..property.getText("FONT2")
FONT_D={} FONT_S=0
for n in FONT:gmatch("....") do
  FONT_D[FONT_S+1]=tonumber(n,16) FONT_S=FONT_S+1
end

-- dst(x, y, text, scale, rotation, monospaced)
--   rotation 1=normal 2=vertical 3/4=mirrored variants
function dst(x,y,t,s,r,m)
  s=s or 1 r=r or 1
  if r>2 then t=t:reverse() end
  t=t:upper()
  for c in t:gmatch(".") do
    ci=c:byte()-31
    if 0<ci and ci<=FONT_S then
      for i=1,15 do
        p = (r>2) and 2^i or 2^(16-i)             -- 镜像时位序反转
        if FONT_D[ci]&p==p then
          xx,yy=((i-1)%3)*s, ((i-1)//3)*s         -- 3 cols x 5 rows
          if r%2==1 then screen.drawRectF(x+xx, y+yy, s,s)
          else           screen.drawRectF(x+5-yy, y+xx, s,s) end
        end
      end
      i = (FONT_D[ci]&1==1 and not m) and 2*s or 4*s   -- 末位为 1 => 窄字符
      if r%2==1 then x=x+i else y=y+i end
    end
  end
end
```

地图配色主题（**动态属性索引**：用数字属性选择要读哪个文本属性）：

```lua
-- 每个通道编码为 3 位十进制并 +111，避免前导零被吞；"111"->0  "366"->255
cc1=property.getText(pN("MapColor1"))             -- pN -> 索引号，getText 按标签读取
for num in cc1:gmatch("%d%d%d") do M1[#M1+1]=num-111 end

function onDraw()
  s.setMapColorOcean   (M[1],M[2],M[3])
  s.setMapColorShallows(M[4],M[5],M[6])
  s.setMapColorLand    (M[7],M[8],M[9])
  s.setMapColorGrass   (M[10],M[11],M[12])
  s.setMapColorSand    (M[13],M[14],M[15])
  s.setMapColorSnow    (M[16],M[17],M[18])
  s.setMapColorRock    (M[19],M[20],M[21])
  s.setMapColorGravel  (M[22],M[23],M[24])
  screen.drawMap(mx,my,mz)
  px,py=map.mapToScreen(mx,my,mz,w,h,gps_x,gps_y)
end
```

自动对比色（HSL 反亮度）与平滑跟随：

```lua
function findBestContrastColor(C)                  -- C = {r,g,b, r,g,b, ...}
  totalH,totalL=0,0
  for i=1,#C,3 do
    H,S,L=RGBToHSL(C[i],C[i+1],C[i+2])
    totalH=totalH+H totalL=totalL+L
  end
  return {HSLToRGB(totalH/#C*3, 1, 1-totalL/(#C/3))}   -- 同色相反亮度 = 高对比
end

-- 平滑跟随：每 tick 最多移动固定量，避免瞬移/抖动
mz=mz-clamp(mz-z,-.5,.5)
mx=mx-clamp(mx-mcx,-100,100)
my=my-clamp(my-mcy,-100,100)
function clamp(x,min,max) return math.max(math.min(x,max),min) end
```

**要点**
- 🔥 **字模 / 大表放进 `property.getText`** 是本例最有价值的手法：脚本源码只留解析循环，**8192 字符上限几乎不再是约束**。字体、配色表、航点列表都适用。
- 配色用 `数字+111` 再三位切分，是因为 `gmatch("%d%d%d")` 需要**定长**；`+111` 保证 0 也写成三位数，不会被截断。
- `property.getText(pN("..."))` 实现**运行时动态选择属性**：数字属性给出索引，文本属性按标签名（"1"~"N"）读取。
- `clamp(target-current, -step, step)` 的减法写法 = 限速跟随，比直接插值更可控，**做镜头/缩放平滑时通用**。
- `setMapColor*` 共 8 组 24 通道，**必须在 `screen.drawMap` 之前调用**。

- 完整脚本：`AI相关/_提取暂存/2774712393_microcontroller_1.lua`
- 关联：`00_速查 §14`（8192 上限）、`§16`（screen/map/property）

---

### 3. 滚动罗盘带（可复用独立微控，hex 属性配色）

- 来源：steam id 1815902922 · <https://steamcommunity.com/sharedfiles/filedetails/?id=1815902922> · **微控制器**（Customizable Compass Module）
- 更新时间：**2019-07-27**
- 用到：指南针、显示器、属性文本（Hex 色值）、属性滑块（透明度/偏移）、属性开关（垂直翻转/显示航向）
- 亮点：**用「像素偏移 + while 循环」画无限滚动刻度带**，只画可见部分；`hex` 字符串属性让用户直接填网页色值。

> 🕒 同功能新作：steam id **2623064051**（[DLC] T-80U，更新于 **2023-02-13**）在坦克炮手观瞄 HUD 中沿用了同一套滚动带，并叠加了准星与弹药显示。
> **独立微控请抄本例（可直接拖进自己的作品）；要做综合 HUD 请抄 2623064051。**

```lua
function hex2rgb(hex)
  hex = hex:gsub("#","")
  return {r=tonumber("0x"..hex:sub(1,2)),
          g=tonumber("0x"..hex:sub(3,4)),
          b=tonumber("0x"..hex:sub(5,6))}
end

function onTick()
  H=(((1-input.getNumber(1))%1)*360)      -- compass sensor is in TURNS; 1-x flips to screen dir
  C =hex2rgb(property.getText("Bars Color (Hex)"))
  C2=hex2rgb(property.getText("Heading Color (Hex)"))
  T =property.getNumber("Bars Transparency")
  OF=property.getNumber("Height Offset")
  FLP=property.getBool("Flip Vertically")
  Show=property.getBool("Show Heading")
end

function onDraw()
  w=screen.getWidth() h=screen.getHeight()
  sp=H-math.floor(H/5)*5                  -- 航向在 5px 格内的亚像素偏移
  l =math.ceil((w/2-sp)/5)
  x =w/2-sp-l*5                           -- 起始像素（屏幕外对齐）
  v =math.floor(H-w/2+x)%360              -- 该像素对应的角度

  screen.setColor(C["r"],C["g"],C["b"],T)
  while (x<w) do
    if (v/15==math.floor(v/15)) then      -- 每 15° 画长刻度
      screen.drawLine(x, OF, x, 2+OF)
      -- N/NE/E/SE/S/SW/W/NW 标注（略）
    else                                  -- 其余画短刻度
      screen.drawLine(x, P1+OF, x, P2+OF)
    end
    x=x+5 v=(v+5)%360                     -- 5px = 5°
  end
  if Show then
    screen.setColor(C2["r"],C2["g"],C2["b"])
    screen.drawLine(w/2, OF, w/2, 2+OF)                       -- 中央航向指针
    screen.drawText((w-#(string.format("%.0f",H))*5)/2+1, PL+OF,
                    string.format("%.0f",H))
  end
end
```

**要点**
- `sp = H - floor(H/5)*5`（即 `H % 5`）算出**亚像素偏移**，使刻度带随航向连续滚动而不是跳格。
- `while (x<w)` 只画屏幕内的刻度，**不建数组、不缓存**，是滚动带最省内存的写法。
- `hex2rgb` 用 `tonumber("0x"..s)` 解析十六进制字符串——SW 的 Lua 支持 `0x` 前缀字面量转换。
- 垂直翻转（`FLP`）通过切换 `PL/P1/P2` 三个偏移量实现，**不重复写一遍绘制代码**（值得抄的组织方式）。
- 全部外观参数走 `property.*`，用户无需改代码即可定制——**工坊微控的标配做法**。

- 完整脚本：`AI相关/_提取暂存/1815902922_microcontroller_0.lua`
- 关联：`00_速查 §16`（property / screen）

---

### 4. 触控翻页菜单（点内三角命中 + 脉冲/长按双态）

- 来源：steam id 2551954944 · <https://steamcommunity.com/sharedfiles/filedetails/?id=2551954944> · **载具**（A-10 Warthog）
- 更新时间：**2021-10-07**
- 用到：触控屏（复合通道 1-6）、属性文本（pageNtext）、属性开关（enableButtons/Line/Rectangle）
- 亮点：**同一套触控输入拆成「脉冲沿」和「按住」两种语义**——脉冲用于触发翻页，按住用于绘制按下反馈；命中判定用**手写点内三角**函数（比矩形省 API）。

```lua
page = 0
function onTick()
  inputX=input.getNumber(3) inputY=input.getNumber(4)
  isPressedPulse=input.getBool(3)        -- 外部电路产生的「按下沿」脉冲
  isPressedHold =input.getBool(1)        -- 触控原始按住状态
  numberOfPages=property.getNumber("numberOfPages")
  transparency =property.getNumber("transparency")

  isPressingTriangle1 = isPressedPulse and isPointInTriangle1()
  isPressingTriangle2 = isPressedPulse and isPointInTriangle2()

  -- 只有一个「无输入」分支，避免两个 if 互相覆盖
  if (enableButtons and isPressingTriangle1) or nextPage then b=1
  elseif not1(isPressingTriangle1,isPressingTriangle2,nextPage,previousPage) then b=0 end
  if (enableButtons and isPressingTriangle2) or previousPage then b=-1
  elseif not1(isPressingTriangle1,isPressingTriangle2,nextPage,previousPage) then b=0 end

  page = page + b
  if page > numberOfPages-1 then page = 0 end          -- 环形翻页
  if page < 0 then page = numberOfPages-1 end
  output.setNumber(3,page)
end

function not1(x,y,z,w) return not (x or y or z or w) end

-- 手写的「点是否落在三角形内」：按行枚举像素区间，比通用算法省字符
function isPointInTriangle1()
  return ((inputX==58 or inputX==59) and (inputY<=63 and inputY>=59)) or
         ((inputX==60 or inputX==61) and (inputY<=62 and inputY>=60)) or
          (inputX==62 and inputY==61)
end
```

绘制（按住态反馈 + 半透明叠层）：

```lua
function onDraw()
  screen.setColor(property.getNumber("rectangleR"),
                  property.getNumber("rectangleG"),
                  property.getNumber("rectangleB"), transparency)   -- 第 4 参 = alpha
  if enableRectangle then screen.drawRectF(0,57,64,7) end
  if enableButtons then
    screen.drawTriangle(61.5,60, 57,58, 57,62)      -- 空心：常态
    screen.drawTriangle(55,62, 55,58, 50.5,60)
  end
  if enableButtons and (isPressingTriangle1Hold or nextPageHold) then
    screen.drawTriangleF(61.5,61, 57,59, 57,63)     -- 实心：按下反馈
  end
  screen.drawTextBox(5,58,59,5,text,-1,-1)
end
```

**要点**
- **脉冲 vs 按住**：触控原始信号是「按住」，直接当触发器会在一次触摸里翻很多页。作者用外部逻辑电路造出**一个 tick 的脉冲**再送进脚本——**这是 SW 触控做「按钮」的标准解法**。
- `not1(...)` 把「四个输入全为假」收成一个布尔，保证两段 `if/elseif` 不会互相把 `b` 清零覆盖。
- 命中判定用**按行枚举像素区间**的硬编码写法，虽然不通用，但在 64×64 小屏上比点到三角形重心坐标算法省一半字符。
- 环形翻页用 `>` 与 `<` 两次判定，比 `%` 更直观且对负数安全。
- `screen.setColor(r,g,b,a)` 的 alpha 让 HUD 半透明叠加在视野上（本例 `transparency` 直接来自属性滑块）。

- 完整脚本：`AI相关/_提取暂存/2551954944_vehicle_2.lua`
- 关联：`00_速查 §16`（触控屏输入约定）、`§10`（复合信号 BUS 时序）

---

### 5. 状态栏 HUD（信号强度阶梯条 + 时间格式转换）

- 来源：steam id 2751468095 · <https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095> · **载具**（[LEGACY] NordahlLunden M2A1 Rook MBT）
- 更新时间：**2025-07-11**
- 用到：显示器 1x1、无线电、属性滑块（背景 RGB）、复合输入（背光亮度）
- 亮点：**用负高度 `drawRectF` 画向上增长的条形图**（1×1 屏上唯一够用的画法）；阶梯条**先画暗底再按阈值覆盖亮色**，实现「灰底 + 点亮」效果。

```lua
function onTick()
  rs  = input.getNumber(20)               -- 无线电信号强度 0..1
  t   = input.getNumber(21)               -- 任务时间（分.秒）
  f   = input.getNumber(22)               -- 频率
  com = input.getBool(1)
  BR,BG,BB = property.getNumber("BackroundR"),
             property.getNumber("BackroundG"),
             property.getNumber("BackroundB")
  BRT = input.getNumber(23)               -- 背光亮度由复合输入实时控制
  time = math.floor(t) + 0.60*(t-math.floor(t))   -- 分.百分秒（0.60 而非 1.0）
end

function onDraw()
  w=screen.getWidth() h=screen.getHeight()
  screen.setColor(5,5,5)
  screen.drawRectF(0,0,w,h)                        -- 外框底色
  screen.setColor(BR,BG,BB)
  screen.drawRectF(2,2,w-4,h-11)                   -- 内容区

  -- 信号阶梯条：负高度 = 向上生长
  screen.setColor(BR,BG,BB,BRT-30)                 -- 暗底（未点亮）
  screen.drawRectF(22,h-10,1,-1)
  screen.drawRectF(24,h-10,1,-2)
  screen.drawRectF(26,h-10,1,-3)
  screen.drawRectF(28,h-10,1,-4)

  screen.setColor(0,0,0,BRT)                       -- 亮色（点亮）
  if rs > 0   then screen.drawRectF(22,h-10,1,-1) end
  if rs > 0.4 then screen.drawRectF(24,h-10,1,-2) end
  if rs > 0.6 then screen.drawRectF(26,h-10,1,-3) end
  if rs > 0.8 then screen.drawRectF(28,h-10,1,-4) end

  screen.drawTextBox(4,3,25,7,string.format("%.2f",time),-1,-1)
  screen.drawTextBox(3,11,w-6,7,string.format("%.0f",f),1,-1)
  if com then screen.drawRectF(3,17,16,5) end      -- COM 指示灯
end
```

**要点**
- 🔑 **`screen.drawRectF(x,y,w,负数)`**：高度为负时矩形向**上**延伸，这是 SW 屏幕（Y 向下）画柱状图的关键技巧，第四格 `-4` 就是 4 px 高的柱子。
- 「暗底 + 按阈值覆盖」比「每格独立判断前景/背景色」少一半代码，且天然形成灰度层次。
- `BRT-30` 让暗底比亮色暗 30，亮度整体由复合输入 `BRT` 联动，实现**一处调节全屏背光**。
- `math.floor(t) + 0.60*(t-math.floor(t))` 把小数分钟写成「分.百分秒」——注意系数是 `0.60` 而非 `1`，因为秒→分是 60 进制（`0.5` 分 = 30 秒，显示成 `.30`）。

- 完整脚本：`AI相关/_提取暂存/2751468095_vehicle_16.lua`
- 关联：`00_速查 §16`（screen 绘图 API）
