-- source: steam id 3790163661 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3790163661
function onTick()
x = input.getNumber(3)
y = input.getNumber(4)
isp = input.getBool(1)

bt1 = isp and ispr(x, y, 0, h-22, 5, 5)
output.setBool(1, bt1)
	
bt2 = isp and ispr(x, y, 0, h-15, 5, 5)
output.setBool(2, bt2)

bt3 = isp and ispr(x, y, 0, h-7, 5, 7)
output.setBool(3, bt3)
end

function ispr(x, y, rX, rY, rW, rH)
return x > rX and y > rY and x < rX+rW and y < rY+rH
end

function onDraw()
w = screen.getWidth()
h = screen.getHeight()
screen.setColor(0, 0, 0, 80)
screen.drawRectF(0, 0, 5, h)

screen.setColor(255, 255, 255)
if not bt1 then
screen.drawText(1,h-22,"+")
end

if not bt2 then
screen.drawText(1,h-15,"-")
end

if not bt3 then
screen.drawText(1,h-7,"R")
end
end