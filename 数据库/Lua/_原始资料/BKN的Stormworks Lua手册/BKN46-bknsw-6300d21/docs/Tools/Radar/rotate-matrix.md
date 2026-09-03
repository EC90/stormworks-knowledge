# 雷达坐标系转换

转换笛卡尔坐标系，用于非常方便的修正雷达的姿态，来获取雷达目标的绝对位置。

## 欧拉角旋转矩阵

![rotate-matrix](https://bkn46.github.io/bknsw/pics/rotate-matrix.png)

```lua
-- roll, pitch, yaw (x,y,z)
function rotateMatrix(a,b,c)
	cos,sin=math.cos,math.sin
	return {
		{cos(c)*cos(b), -sin(c)*cos(a)+cos(c)*sin(b)*sin(a), sin(c)*sin(a)+cos(c)*sin(b)*cos(a)},
		{sin(c)*cos(b), cos(c)*cos(a)+sin(c)*sin(b)*sin(a), -cos(c)*sin(a)+sin(c)*sin(b)*cos(a)},
		{-sin(b), cos(b)*sin(a), cos(b)*cos(a)},
	}
end
```

简化版:

```lua
-- roll, pitch, yaw (x,y,z)
{% raw %}
function rotateMatrix(b,c,d)e,f=math.cos,math.sin;return{{e(d)*e(c),-f(d)*e(b)+e(d)*f(c)*f(b),f(d)*f(b)+e(d)*f(c)*e(b)},{f(d)*e(c),e(d)*e(b)+f(d)*f(c)*f(b),-e(d)*f(b)+f(d)*f(c)*e(b)},{-f(c),e(c)*f(b),e(c)*e(b)}}end
{% endraw %}
```

## 对角矩阵转换、转出

```lua
{% raw %}
function matXYZ(x,y,z) return{{x,x,x},{y,y,y},{z,z,z}} end

function dematXYZ(mat) return{x=mat[1][1],y=mat[2][2],z=mat[3][3]} end
{% endraw %}
```

## 合在一起

```lua
res=matMul(matXYZ(x,y,z),rotateMatrix(roll,pitch,yaw))
res=dematXYZ(res)
```
