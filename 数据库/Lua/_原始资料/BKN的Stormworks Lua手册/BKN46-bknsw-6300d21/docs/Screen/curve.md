# ○ 扇面/圆弧/射线

绘制原理: 从中心出发，沿着圆弧的角度，绘制线段。  
通过控制线段的长度，可以控制是绘制扇面还是圆弧。  
控制起始和终点角度，可以限定出只绘制一条射线线段。

```lua
-- Curve(screen, centerX, centerY, radius, width, startAngle, endAngle)
function Curve(screen, cx, cy, radius, width, sa, ea)
	for i=sa,ea,1 do
		angle=math.rad(i-90)
		sx,sy=cx+math.cos(angle)*radius,cy+math.sin(angle)*radius
		ex,ey=sx-math.cos(angle)*width,sy-math.sin(angle)*width
		screen.drawLine(sx,sy,ex,ey)
	end
end
```

简化版:

```lua
function Curve(b,c,d,e,f,g,h)for i=g,h,1 do j=math.rad(i-90)l,m=c+math.cos(j)*e,d+math.sin(j)*e;n,o=l-math.cos(j)*f,m-math.sin(j)*f;b.drawLine(l,m,n,o)end end
```
