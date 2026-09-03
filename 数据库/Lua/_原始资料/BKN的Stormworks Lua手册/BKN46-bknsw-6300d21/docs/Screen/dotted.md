# 虚线

```lua
-- DottedLine(screen, start_pos_x, start_pos_y, end_pos_x, end_pos_y, line_length, space_length)
function DottedLine(screen, x1, y1, x2, y2, w1, w2)
	len=math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
	for i=1,math.floor(len/(w1+w2)),1 do
		r1=i*(w1+w2)/len
		r2=r1+w1/len
		sx,sy=x1+r1*(x2-x1),y1+r1*(y2-y1)
		ex,ey=x1+r2*(x2-x1),y1+r2*(y2-y1)
		screen.drawLine(sx,sy,ex,ey)
	end
end
```
