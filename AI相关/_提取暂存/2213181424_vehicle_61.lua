-- source: steam id 2213181424 / vehicle.xml block#61
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
function onTick()
	
dist =input.getNumber(5)
zoom = math.floor(43-(input.getNumber(6)*20)+0.5)
lHDG = input.getNumber(3)
tHDG = input.getNumber(4)*57.2958
STAB = input.getBool(1)
TRK = input.getBool(2)
IR = input.getBool(3)
SL = input.getBool(4)
--cam = input.getNumber(10)

hx = math.floor(math.sin(lHDG)*5+7+0.5)
hy = math.floor(6-math.cos(lHDG)*5+0.5)

output.setBool(1,STAB)
output.setBool(2,TRK)
output.setBool(3,IR)
output.setBool(4,SL)

end

function onDraw()

screen.setColor(0,0,0)
screen.drawRectF(0,0,64,7)
screen.drawRectF(0,7,14,6)
screen.drawRectF(54,7,10,6)
screen.drawRectF(61,20,3,25)
--screen.drawRectF(0,49,16,7)
screen.drawRectF(54,49,10,7)
screen.setColor(25,25,25)
screen.drawLine(14,0,14,7)
screen.drawLine(31,0,31,7)
screen.drawLine(53,0,53,7)
screen.drawLine(61,22,61,43)


screen.setColor(100,100,100)
screen.drawCircle(7,6,5)
if hx >0 then
screen.drawLine(7,6,hx,hy)
end
screen.drawTextBox(16,1,17,5,string.format("%03.0f",tHDG))

if (TRK or SL) and dist <1000 then
screen.drawTextBox(33,1,22,5,string.format("%03.0fm",dist))
else
screen.drawTextBox(33,1,22,5,"---m")
end
-- target track 
if TRK then
screen.setColor(100,100,100)
else
screen.setColor(25,25,25)
end
screen.drawLine(58,1,58,6)
screen.drawLine(56,3,61,3)

-- heading lock
if STAB then
screen.setColor(100,100,100)
else
screen.setColor(25,25,25)
end
screen.drawTextBox(55,7,11,5,">")
screen.drawTextBox(59,7,11,5,"<")

screen.setColor(100,100,100)
-- zoom
tx=62
ty=zoom
screen.drawTriangleF(tx,ty,tx+2,ty-2,tx+2,ty+2)

-- cntrl
--if cam == 1 then
--screen.drawTextBox(1,50,17,5,"CPL")
--elseif cam == 2 then
--screen.drawTextBox(1,50,17,5,"PLT")
--elseif cam == 3 then
--screen.drawTextBox(1,50,17,5,"REM")
--elseif cam == 0 then
--screen.drawTextBox(1,50,17,5,"CON")
--end

-- searchlight
if SL then
screen.setColor(255,255,255)
else
screen.setColor(25,25,25)
end
screen.drawCircleF(60,52,2.5)
screen.drawLine(55,50,57,50)
screen.drawLine(55,52,57,52)
screen.drawLine(55,54,57,54)

-- cross hairs
screen.setColor(100,0,0)
screen.drawLine(20,32,24,32) -- cross hairs
screen.drawLine(44,32,40,32)
screen.drawLine(32,44,32,40)
screen.drawLine(32,20,32,24)	
end