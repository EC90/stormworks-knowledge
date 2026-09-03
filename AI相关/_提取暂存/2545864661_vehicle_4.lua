-- source: steam id 2545864661 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2545864661

function tuth(x,y,xx,yy,w,h,tut)
ret = x>=xx and x<=xx+w and y >= yy and y <= yy+h and tut 
return ret
end

ipn = input.getNumber
ipb = input.getBool

function onTick()
w = ipn(1)
h = ipn(2)
x = ipn(3)
y = ipn(4)
clik = ipb(1) 
end

s = screen
SC = screen.setColor

function dr(x,y,tex,tik)
local w=6
local h=7
if tik then
SC(100, 100, 100)
else
SC(0, 0, 0)
end
s.drawRectF(x, y, w, h)
if tik then
SC(0, 0, 0)
else
SC(100, 100, 100)
end
s.drawTextBox(x, y, w, h, tex, 0, 0)
end

function onDraw()
w = s.getWidth()				  
h = s.getHeight()
if w>60 then	
--[[dr(3,h-22,"+",tuth(x,y,3,h-22,8,8,clik))
dr(25,h-22,"-",tuth(x,y,25,h-22,8,8,clik))	
dr(3,h-11,"<",tuth(x,y,3,h-11,8,8,clik))
dr(25,h-11,">",tuth(x,y,25,h-11,8,8,clik))	
dr(14,h-22,"^",tuth(x,y,14,h-22,8,8,clik))	
dr(14,h-11,"v",tuth(x,y,14,h-11,8,8,clik))
]]
dr(w-8,h-22,"R",tuth(x,y,w-11,h-22,8,8,clik))
dr(w-8,h-11,"C",tuth(x,y,w-11,h-11,8,8,clik))
dr(w-8,h-33,"b",tuth(x,y,w-11,h-33,8,8,clik))
end
end
