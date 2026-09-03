# 计时

## 直接累加计时

利用INT全局变量控制触发周期，需要注意onTick时钟不稳定，只能大致为60hz。

```lua
CLK,INT=0,60

function onTick()
	if CLK == INT then
		CLK = 0
		-- do something
	else
		CLK = CLK + 1
	end
end
```

## 使用外部信号计时

使用一个外部组件（例如blinker）触发，用CLK作为计时脉冲

```lua
CLK=false

function onTick()
	clk=GB(1)
	if not clk then
		CLK=false
	elseif clk and not CLK then
		CLK=true
		-- blabla
	end
end
```
