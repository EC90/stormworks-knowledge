# 坐标距离计算

二维距离：

```lua
function dist(x,y) return math.sqrt(x*x+y*y) end
```

三维距离(需要先导入二维距离函数)：

```lua
function dist3(x,y,z) return dist(x,dist(y,z)) end
```
