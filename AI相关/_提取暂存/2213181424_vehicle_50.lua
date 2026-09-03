-- source: steam id 2213181424 / vehicle.xml block#50
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
function onTick()
act =input.getBool(32)

if act then
c = input.getNumber(5)
tm = input.getNumber(6)
tr = input.getNumber(7)
rm = input.getNumber(8)
rr = input.getNumber(9)
	
	
end
end

function onDraw()
if act then

w=screen.getWidth()
h=screen.getHeight()

-- range
screen.setColor(25,50,100)
screen.drawLine(0,h/2,w,h/2)

screen.drawLine(9,5,4,14)
screen.drawLine(8,3,12,7)
screen.drawLine(8,6,12,2)


screen.drawTextBox(16,1,w,7,"MAIN:",-1,0)
screen.drawTextBox(16,1,47,7,string.format("%.0fkm",rm),1,0)
screen.drawTextBox(16,8,w,7,"RSRV:",-1,0)
screen.drawTextBox(16,8,47,7,string.format("%.0fkm",rr),1,0)

-- endurance
screen.drawLine(0,16,w,16)

screen.drawCircle(7,24,6)
screen.drawLine(7,24,12,21)

screen.drawTextBox(16,17,w,7,"MAIN:",-1,0)
screen.drawTextBox(16,17,47,7,string.format("%.0fm",tm),1,0)
screen.drawTextBox(16,24,w,7,"RSRV:",-1,0)
screen.drawTextBox(16,24,47,7,string.format("%.0fm",tr),1,0)

end
end