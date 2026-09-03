# 雷达角度转笛卡尔坐标

将雷达的高度、角度、距离三个参数转换为笛卡尔坐标。坐标系中心为雷达，x轴正方向为雷达正对方向。  
方便导入矩阵计算

```lua
function simpleXYZ(dist, angle, pitch)
	xy=dist*math.cos(pitch)
	return {
		xy*math.cos(angle),
		xy*math.sin(angle),
		dist*math.sin(pitch),
	}
end
```

简化版:

```lua
function simpleXYZ(b,c,d)f=math;e=b*f.cos(d)return{e*f.cos(c),e*f.sin(c),b*f.sin(d)}end
```
