# → 箭头

```lua
-- Arrow(screen, x1, y1, x2, y2, length)
function Arrow(S,x1,y1,x2,y2,l)
	S.drawLine(x1,y1,x2,y2)
	ang=math.atan(x2-x1,y2-y1)
	S.drawLine(x2,y2,x2-math.sin(ang-math.pi/4)*l,y2-math.cos(ang-math.pi/4)*l)
	S.drawLine(x2,y2,x2-math.sin(ang+math.pi/4)*l,y2-math.cos(ang+math.pi/4)*l)
end
```

简化版：

```lua
function Arrow(b,c,d,e,f,g)b.drawLine(c,d,e,f)h=math.atan(e-c,f-d)b.drawLine(e,f,e-math.sin(h-math.pi/4)*g,f-math.cos(h-math.pi/4)*g)b.drawLine(e,f,e-math.sin(h+math.pi/4)*g,f-math.cos(h+math.pi/4)*g)end
```
