-- source: steam id 3790163661 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3790163661
function onTick()
x = input.getNumber(3)
y = input.getNumber(4)
isp = input.getBool(1)
output.setBool(1, bt1)	

sw = isp and ispr(x, y, 0, h-31, 5, 7)
if sw and not lsw then bt1 = not bt1 end lsw = sw 
function ispr(x, y, rX, rY, rW, rH)
return x > rX and y > rY and x < rX+rW and y < rY+rH
end

function onDraw()
h = screen.getHeight()
if bt1 then
screen.setColor(255,255,255)
screen.drawText(1,h-30,"V")
else
screen.setColor(255,255,255,100)
screen.drawText(1,h-30,"V")
end
end
end
