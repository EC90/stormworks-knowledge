-- source: steam id 2807959992 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2807959992
function onTick()
	D = input.getNumber(1)*10
	x = input.getNumber(2)
	y = input.getNumber(3)
	R = input.getBool(4)
	S = input.getBool(5)
	L = input.getBool(6)
	RD = input.getBool(7)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	width = (w-w+11+x)
	height = (h-h+7.5+y)
	if R == true
	then
if D == 0
then
if S == true
then
screen.setColor(0, 255, 0)
screen.drawCircle(15, 15.5, 2.6)
screen.setColor(0,255,0)
screen.drawText(9, 26, "N/A")
screen.drawText(23, 2, "LR")
else
screen.setColor(0, 255, 0)
screen.drawCircle(15, 15.5, 2.6)
screen.setColor(0,255,0)
screen.drawText(9, 26, "N/A")
screen.drawText(23, 2, "MR")
end
else
if S == true
then
if L==true
then
screen.setColor(255, 0, 0)
screen.drawRect(width, height, 5, 7)
screen.setColor(0, 255, 0)
screen.drawText(1, 26, math.floor(D))
screen.drawText(25,26,"m")
screen.drawText(23, 2, "LR")
else
screen.setColor(0, 255, 0)
screen.drawRect(width, height, 5, 7)
screen.setColor(0, 255, 0)
screen.drawText(1, 26, math.floor(D))
screen.drawText(25,26,"m")
screen.drawText(23, 2, "LR")
end
else
if L == true
then
screen.setColor(255, 0, 0)
screen.drawRect(width, height, 5, 7)
screen.setColor(0, 255, 0)
screen.drawText(1, 26, math.floor(D))
screen.drawText(25,26,"m")
screen.drawText(23, 2, "MR")
else
screen.setColor(0, 255, 0)
screen.drawRect(width, height, 5, 7)
screen.setColor(0, 255, 0)
screen.drawText(1, 26, math.floor(D))
screen.drawText(25,26,"m")
screen.drawText(23, 2, "MR")
end
end
end
else
screen.setColor(0, 255, 0)
screen.drawCircle(15, 15.5, 2.6)
end

if RD ==true
then
screen.setColor(255,0,0)
screen.drawTextBox(h/8, 6,38,6 , "RADAR")
else
end
end