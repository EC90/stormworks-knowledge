# 🔲 按钮

原版比较复杂，就只给出Minify结果了。在onDraw里面调用drawButton，然后参数里面填上回调函数，就可以简单愉快的开始用按钮了，支持短按/长按两种操作。DBT代表长按识别时间(ticks)，可按需配置。

```lua
DBT,DBH,DBX,DBY=60,0,0,0
function onTick()
	GN=input.getNumber
	GB=input.getBool
	inputX=GN(3)inputY=GN(4)isPressed=GB(1)if isPressed then DBH=DBH+1;DBX=inputX;DBY=inputY end
end

function inRect(b,c,d,e,f,g)return b>d and c>e and b<d+f and c<e+g end

-- drawButton(x, y, w, h, content, screen, recall, holdRecall, param)
function drawButton(b,c,d,e,f,g,h,i,p)g.setColor(30,30,30)j=0;if isPressed and inRect(inputX,inputY,b-1,c,d,e)then j=1;g.setColor(100,100,100)if DBH>DBT then g.setColor(200,0,0)end else if DBH>DBT and not i==false and inRect(DBX,DBY,b-1,c,d,e)then i(p)DBH=0;DBX=0;DBY=0 elseif inRect(DBX,DBY,b-1,c,d,e)then h(p)DBH=0;DBX=0;DBY=0 end end;g.drawRectF(b,c,d,e)g.setColor(255,255,255)g.drawTextBox(b+1,c+1,d-1,e-1,f,0,0)return j end

function doNothing(a) return end
```
