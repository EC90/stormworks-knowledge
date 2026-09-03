# ⛤ 五角星

```lua
-- Star(screen, centerX, centerY, radius)
function Star(b,c,d,e)for i=0,360,72 do j=math.rad(i-90)l,m=c+math.cos(j)*e,d+math.sin(j)*e;n,o=l-math.cos(j)*e,m-math.sin(j)*e;b.drawLine(l,m,n,o)end end
```
