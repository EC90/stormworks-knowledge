# 有限状态机

有的时候需要运作较为复杂机械的结构，使用微控连线的方式会非常难以开发，所以使用lua的形式读取所有的机械输入与输出

```lua
{% raw %}
-- 初始状态
STATE=0

-- 已用钻杆计数
ROD_COUNT=0

-- 计时器
TIMER,TIMER_HOLDER=0,false
BUTTON_1_HOLDER=false

-- 按钮
BUTTON_HOLDER=false

function onTick()
	-- 简化输入形式
	I,O=input,output
	GN,GB=I.getNumber,I.getBool
	SN,SB=O.setNumber,O.setBool

	-- 定义输入
	-- 1号bool输入直接接一个按钮，用于切换状态
	Button_1=GB(1)
	-- 1/2号数字输入是两个三格滑轨上的位置输入
	-- 注意滑轨本身位置输出有方向性正负，如果有方向和距离问题请在这里直接进行加减正负调整
	Rail_1_Dist,Rail_2_Dist=GN(1),GN(2)

	-- 定义默认输出
	-- 1/2/3/4 bool输出分别为两个滑轨的位置控制、以及钻杆夹持
	-- 1/2/3数字输出分别为两个旋转关节与钻杆输送速度
	Rail_1_Up,Rail_1_Down,Rail_2_Up,Rail_2_Down,Rod_Hold=false,false,false,false,false
	Rotate_1,Rotate_2,Rod_Slide=0,0,0

	-- 如果有按钮输入，转换为单次触发，将状态改为1
	if Button_1 and not BUTTON_HOLDER then
		STATE=1
		BUTTON_HOLDER=true
	elseif not Button_1 then
		BUTTON_HOLDER=false
	end

	-- 运行状态机
	STATE_MACHINE()

	-- 输出
	SN(1,Rotate_1)
	SN(2,Rotate_2)
	SN(3,Rod_Slide)
	SB(1,Rail_1_Up)
	SB(2,Rail_1_Down)s
	SB(3,Rail_2_Up)
	SB(4,Rail_2_Down)
	SB(5,Rod_Hold)
end

-- 状态机本身
-- 0 状态为idle，1/2滑轨运行至1位置，其他默认输出
-- 1 状态为1/2滑轨运行至钻杆所在位置、开启钻杆夹持，180ticks后切换到状态2
-- 2 状态为1/2滑轨运行至指定位置、开启钻杆夹持、钻杆进行滑动，300ticks后切换到状态3
-- 3 状态为关节1旋转、1/2滑轨运行至钻井处、开启钻杆夹持、钻杆进行滑动，600ticks后切换到状态4
-- 4 状态为关节1旋转、2滑轨到高处、关闭钻杆夹持，180ticks后切换到状态0
function STATE_MACHINE()
	if STATE=0 then
		Rail_1_Up,Rail_1_Down=RAIL_TO(Rail_1_Dist,1)
		Rail_2_Up,Rail_2_Down=RAIL_TO(Rail_2_Dist,1)
	elseif STATE==1 then
		Rail_1_Up,Rail_1_Down=RAIL_TO(Rail_1_Dist,1+0.5*ROD_COUNT)
		Rail_2_Up,Rail_2_Down=RAIL_TO(Rail_2_Dist,0)
		Rod_Hold=true
		NEXT_STATE_IN(180,2)
	elseif STATE==2 then
		Rail_1_Up,Rail_1_Down=RAIL_TO(Rail_1_Dist,0.5)
		Rail_2_Up,Rail_2_Down=RAIL_TO(Rail_2_Dist,0.5)
		Rod_Slide=1
		Rod_Hold=true
		NEXT_STATE_IN(300,3)
	elseif STATE==3 then
		Rail_1_Up,Rail_1_Down=RAIL_TO(Rail_1_Dist,0)
		Rail_2_Up,Rail_2_Down=RAIL_TO(Rail_2_Dist,0.25)
		Rod_Slide=-1
		Rotate_1=1
		Rod_Hold=true
		NEXT_STATE_IN(600,4)
	elseif STATE==4 then
		Rail_2_Up,Rail_2_Down=RAIL_TO(Rail_2_Dist,2)
		Rotate_1=1
		NEXT_STATE_IN(180,0)
	end
end

-- 定时切换到指定状态
function NEXT_STATE_IN(time, state)
	if TIMER==0 and not TIMER_HOLDER then
		TIMER,TIMER_HOLDER=time,true
	elseif TIMER==0 then
		STATE,TIMER_HOLDER=state,false
	else
		TIMER=TIMER-1
	end
end

-- 运行滑轨到指定位置
-- 输出两个bool值，对应滑轨的up和down
-- 由于速度不可调，位置给正负0.1的误差范围空间
function RAIL_TO(a,b)
	return a-b>0.1,a-b<-0.1
end
{% endraw %}
```

另一个简化版本，只需要填input和output的四个table，以及STATE_MACHINE函数主体就能用

```lua
{% raw %}
STATE=0
I_BOOL={false,}
I_NUM={0,0,0,0,0,0,0,}
O_BOOL={false,false,false,}
O_NUM={0,0,0,0,0,}

TIMER,TIMER_HOLDER=0,false

function onTick()
	I,O=input,output
	GN,GB=I.getNumber,I.getBool
	SN,SB=O.setNumber,O.setBool

	for i,v in ipairs(I_BOOL) do I_BOOL[i]=GB(i) end
	for i,v in ipairs(I_NUM) do I_NUM[i]=GN(i) end

	STATE_MACHINE()

	for i,v in ipairs(O_BOOL) do SB(i,v) end
	for i,v in ipairs(O_NUM) do SN(i,v) end
end

function STATE_MACHINE()
	if STATE==0 then
		O_BOOL[1]=false
	end
end

function NEXT_STATE_IN(time, state)
	if TIMER==0 and not TIMER_HOLDER then
		TIMER,TIMER_HOLDER=time,true
	elseif TIMER==0 then
		STATE,TIMER_HOLDER=state,false
	else
		TIMER=TIMER-1
	end
end

function RAIL_TO(a,b)
	return a-b>0.1,a-b<-0.1
end
{% endraw %}
```
