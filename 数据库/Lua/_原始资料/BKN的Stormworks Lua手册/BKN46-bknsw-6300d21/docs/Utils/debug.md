# 屏幕快速DEBUG

有了这个就可以利用屏幕快速进行lua运行时的数据观察，可以自动把table展开。想要监控的数据放在DEBUG变量里就好。

```lua
function onDraw()
S=screen
Text,TextBox,Color,Line,RectF,Rect,Circle,CircleF,Triangle,TriangleF=S.drawText,S.drawTextBox,S.setColor,S.drawLine,S.drawRectF,S.drawRect,S.drawCircle,S.drawCircleF,S.drawTriangle,S.drawTriangleF
w,h=S.getWidth(),S.getHeight()
DEBUG={}
TextBox(0,0,w,s,dump(DEBUG))
end
function dump(b)if type(b)=='table'then local d='{ 'for e,f in pairs(b)do if type(e)~='number'then e='"'..e..'"'end;d=d..'['..e..'] = '..dump(f)..',\n'end;return d..'} 'else return tostring(b)end end
```
