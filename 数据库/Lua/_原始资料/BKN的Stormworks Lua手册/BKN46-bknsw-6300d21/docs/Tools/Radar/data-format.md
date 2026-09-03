# 雷达数据格式转换

适用于1.2.30版本新雷达混合信号。转换完之后直接调用TARGET[1].dist就能获取第一个目标的探测距离，简化写代码过程。

```lua
function onTick()
	I,O=input,output
	GN,GB=I.getNumber,I.getBool
	SN,SB=O.setNumber,O.setBool
	TARGET={}
	for i=1,8 do
		table.insert(TARGET, {i=GB(i),dist=GN(i*4-3),ang=GN(i*4-2),tilt=GN(i*4-1),time=GN(i*4)})
	end
end
```
