# ⛛ 正多边形

```lua
-- Polygon(screen, centerX, centerY, radius, edges, rotation)
function Polygon(screen, cx, cy, radius, edges, rotation)
	for i=0,360,360/edges do
		angle=math.rad(i-90+rotation)
		sx,sy=cx+math.cos(angle)*radius,cy+math.sin(angle)*radius
		if i~=0 then screen.drawLine(sx,sy,ex,ey) end
		ex,ey=sx,sy
	end
end
```

简化版：

```lua
-- Polygon(screen, centerX, centerY, radius, edges, rotation)
function Polygon(b,c,d,e,f,g)for h=0,360,360/f do i=math.rad(h-90+g)k,l=c+math.cos(i)*e,d+math.sin(i)*e;if h~=0 then b.drawLine(k,l,m,n)end;m,n=k,l end end

```
