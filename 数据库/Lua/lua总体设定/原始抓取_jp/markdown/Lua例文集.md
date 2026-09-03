---
wiki: sbarjp
page: Lua例文集
source_url: https://wikiwiki.jp/sbarjp/Lua%E4%BE%8B%E6%96%87%E9%9B%86
last_modified: 2026-07-11
retrieved_at: 2026-08-31T01:13:11+0800
---

# Lua例文集

|  |
| --- |
| - [はじめに](#g872c94e) - [Logic再現系](#n03f5f6a)    - [pulse](#t51ae83a)   - [toggle](#bae8307a)   - [timer](#h89ac1fe)   - [clamp](#p59523f9)   - [PID](#k6a78c47) - [文字数削減系](#w81895ec)    - [スペース消し](#q9c03079)   - [入出力系の短縮](#p4fec930)   - [mathの短縮](#we45c3d2)   - [クラス短縮系](#bcd13b0b)   - [三項演算子もどき](#j0aa1d8a)   - [変数名の短縮](#t981a795)   - [for文](#td92a9d3) - [行列演算](#kba958ad)    - [和](#r9040185)   - [積](#l1fbaf1a)   - [転置](#h19c5238)   - [逆行列](#h7d42913)   - [スカラー倍](#s565966b)   - [要素積](#tc36bb3c)   - [べき乗](#u32b3df3) - [その他便利系](#kba958ad)    - [フィジックスセンサーのオイラー角から自機の府仰角、方位角、回転角を求める方法](#w1a3f346)   - [Switch](#k6a78c47) |

## はじめに

やりたいことがあるけどこれってどうすればいいの？という人向けの例文集。  
**1%のひらめきをあなたに**  
追加募集中！

## Logic再現系

Logicブロックの機能をLuaで再現するコード

### pulse

1tick前の入力Bool値と比較することで入力値の変化した1tickだけtrueを返す。

```
 prev_tick = false
 function onTick()
    value = input.getBool(1)
    pulse = not (value == prev_tick)
    output.setBool(1, pulse)
    prev_tick=value
 end
```

### toggle

一つ上のpulseを利用し、保存値を反転させる。  
**※Lua内部の変数はマルチで同期されないため、マルチでは非同期バグが発生する可能性が非常に高いので要注意**

```
 prev_tick = false
 function onTick()
    value = input.getBool(1)
    pulse = not (value == prev_tick)
    output.setBool(1, pulse)
    prev_tick = value
 if pulse then
    toggle = not toggle
 end
 end
```

### timer

用途によって色々な方法がある。しかし例によって**非同期バグ**の可能性があるため注意。  
tickごとに増加する数値を用いて一定値以上でON/OFFを出力する

```
 time = 0
 tick = 120
 function onTick()
    time = time + 1
    TON = time > tick
    TOFF = time < tick
 end
```

### clamp

数値に制限を掛けたいときに使用

```
 value = math.max(math.min(value,MAX),MIN)
```

MIN < value < MAXとなる

### PID

修正大歓迎  
ゲイン調整などは[こちら](/sbarjp/PID%E3%83%90%E3%83%A9%E3%83%B3%E3%82%B9%E5%88%B6%E5%BE%A1 "PIDバランス制御")へ

```
local PID = {
   new = function(kp, ki, kd, dt)
       local self = {
           kp = kp,
           ki = ki,
           kd = kd,
           dt = dt,
           prev_error = 0,
           prev_cur = 0,
           integral = 0,
           output = 0,
           maxInt = 10,
           start = false
       }
       function self:update(target, current)
           local error = target - current
           local derivative = self.start and -(current - self.prev_cur)/dt or 0
           self.integral = math.min(self.maxInt, math.max(-self.maxInt, self.integral + error * self.dt))
           self.output = self.kp * error + self.ki * self.integral + self.kd * derivative
           self.prev_error = error
           self.prev_cur = current
           return self.output
       end
       function self:reset()
           self.integral = 0
           self.prev_error = 0
       end
       function self:setGain(kp,ki,kd)
           self.kp = kp
           self.ki = ki
           self.kd = kd
       end
       return self
   end
}
-- Example
local Gain_P = 1
local Gain_I = 0
local Gain_D = 1
local Gain_dt = 1
local SetPoint = 0  --目標値
local ProcessVariable = 1  --現在値
local PID_Control = PID.new(Gain_P,Gain_I,Gain_D,Gain_dt)
local Output = PID_Control:update(SetPoint,ProcessVariable)
```

## 文字数削減系

### スペース消し

余計なスペースを消すだけだが必要なスペースは残すこと。  
左下のボタンで構文チェックができるので活用しよう。

### 入出力系の短縮

クラス名を短縮できる。入出力系は非常に文字数がかさむので短縮の効果がかなり高い。ついでにコードの打ち込みの時間も短縮できる。  
大体3回以上使うならば圧縮した方が得である。

```
 i,o=input,output
 gn,gb,sn,sb=i.getNumber,i.getBool,o.setNumber,o.setBool
 function onTick()
    A=gn(1)
    B=input.getNumber(1)
 end
```

実行するとA=Bとなる。

### mathの短縮

同上。

```
 m=math
 sin,cos,abs,pi=m.sin,m.cos,m.abs,m.pi
 function onTick()
    A=sin(pi)
    B=math.sin(math.pi)
 end
```

実行するとA=Bとなる。

### クラス短縮系

同様に、property、screen、string、mapなども短縮できる。~~てかできないことある？~~

### 三項演算子もどき

Bool値のTrue/Falseで数値を切り替えたいとき、if文よりも短く書ける。

```
 A=true
 num1=100
 num2=200
 B=A and num1 or num2
```

A=trueのときB=num1、falseのときB=num2となる

### 変数名の短縮

様々な観点からあまりよろしくはないが文字数を節約できる。  
可読性を無視するなら変数を出現頻度順に並び変えて頻度順にa,b,c,d,...,aa,ab,ac,...と置き換えておけばよい。Luaブロックのレイテンシの為に1つに収めたいなどよっぽどのことがない限りやめた方がいい。

- ある程度可読性を維持するために  
  どこかに変数名と機能(中身)をコメントアウトしておく

  ```
   a=1--エンジン用PIDのPゲイン
   b=0.1--Iゲイン
   c=2--Dゲイン
  ```

  機能(中身)の頭文字を使う

  ```
   ER=input.getNumber(1)--Engine RPS
   FT=AT*0.5 --Fuel manuhold Throttle
  ```

  番号を付ける

  ```
   ER1=input.getNumber(1)--1st Engine RPS
   ER2=input.getNumber(2)--2nd Engine RPS
  ```

### for文

同じ動作を複数行う場合に有効。Tableと組み合わせるとさらに強力。

```
 Table.Bool = {}
 Table.Number = {}
 function onTick()
    for i=1,32 do
       Table.Bool[i]=input.getBool(i)
       Table.Number[i]=input.getNumber(i)
    end
    --何らかの処理
    for i=1,32 do
       output.setBool(i,Table.Bool[i])
       output.setNumber(i,Table.Number[i])
    end
 end
```

これで入出力が完結する。上と組み合わせるとさらに文字数を圧縮できる

## 行列演算

StormWorks Luaには行列(テーブル)の演算が実装されていないため、自力で実装する必要がある。~~おのメタ~~  
※作成中

### 和

### 積

行列の乗算 (A \* B)  
A: m x n, B: n x p  
戻り値: m x p の行列

```
 function multiply(A, B)
   local m = #A
   local n = #A[1]
   local p = #B[1]
   -- Bの列数がAの行数と一致するか (n == #B)
   if n ~= #B then
       -- なんらかのエラー処理
   end
   local C = {}
   for i = 1, m do
       C[i] = {}
       for j = 1, p do
           local sum = 0
           for k = 1, n do
               sum = sum + A[i][k] * B[k][j]
           end
           C[i][j] = sum
       end
   end
   return C
 end
```

### 転置

行列の転置 (A^T)  
A: m x n の行列 (テーブルのテーブル)  
戻り値: n x m の行列

```
local function transpose(A)
   local m = #A
   local n = #A[1]
   local At = {}
   for j = 1, n do
       At[j] = {}
       for i = 1, m do
           At[j][i] = A[i][j]
       end
   end
   return At
end
```

### 逆行列

2x2行列の逆行列  
M: {{a, b}, {c, d}}  
戻り値: M^-1

```
 local function invert2x2(M)
   local a = M[1][1]
   local b = M[1][2]
   local c = M[2][1]
   local d = M[2][2]
   -- 行列式 (Determinant)
   local det = a * d - b * c
   if math.abs(det) < 1e-10 then
       -- 行列式がほぼ0の場合、逆行列は存在しない（または不安定）
       -- なんらかのエラー処理
   end
   local invDet = 1.0 / det
   local M_inv = {
       { invDet * d,  invDet * -b },
       { invDet * -c, invDet * a  }
   }
   return M_inv
 end
```

### スカラー倍

### 要素積

### べき乗

## その他便利系

### フィジックスセンサーのオイラー角から自機の府仰角、方位角、回転角を求める方法

回転行列を作り、計算する

```
 -- フィジックスセンサーからオイラー角を取得
 local euler_x = input.getNumber(4)
 local euler_y = input.getNumber(5)
 local euler_z = input.getNumber(6)
 -- 各軸周りの回転に対するsinとcosを計算
 local cos_x = math.cos(euler_x)
 local sin_x = math.sin(euler_x)
 local cos_y = math.cos(euler_y)
 local sin_y = math.sin(euler_y)
 local cos_z = math.cos(euler_z)
 local sin_z = math.sin(euler_z)
 -- 回転行列 (Rotation Matrix) を計算
 local RotationMatrix = {
     {
         cos_y * cos_z,
         sin_x * sin_y * cos_z - cos_x * sin_z,
         cos_x * sin_y * cos_z + sin_x * sin_z
     },
     {
         cos_y * sin_z,
         sin_x * sin_y * sin_z + cos_x * cos_z,
         cos_x * sin_y * sin_z - sin_x * cos_z
     },
     {
         -sin_y,
         sin_x * cos_y,
         cos_x * cos_y
     }
 }
 -- 回転行列から各角度を抽出
 -- 仰角
 local Elevation = math.asin(RotationMatrix[2][3])
 -- 方位角
 local Azimuth = math.atan(RotationMatrix[1][3], RotationMatrix[3][3])
 -- 回転角
 local Roll = math.atan(RotationMatrix[1][2], RotationMatrix[2][2])
```

### Switch

C++におけるswitch-case、Pythonでいうところのmatch-caseです。階層的な処理をifよりも比較的きれいに書けます。

```
local function switch(value)
   return function(cases)
       local case = cases[value] or cases.default
       if case then
           return case(value)
       else
           error(string.format("Invalid case (%s)", value), 2)
       end
   end
end
--例
switch(Mode) {
   [1] = function()
       --Modeが1の場合の処理
   end,
   [2] = function()
       --Modeが2の場合の処理
   end,
   [3] = function()
       --Modeが3の場合の処理
   end,
   ["A"] = function()
       --Modeが"A"の場合の処理
   end,
   ["B"] = function()
       --Modeが"B"の場合の処理
   end,
   ["C"] = function()
       --Modeが"C"の場合の処理
   end,
   default = function()
       --Modeが上記のどれにも当てはまらない場合の処理
   end
}
switch(1) --1の処理が実行される
switch("A") --"A"の処理が実行される
```
