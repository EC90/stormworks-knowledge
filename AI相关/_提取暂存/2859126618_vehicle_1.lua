-- source: steam id 2859126618 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2859126618
W=64
H=32
Zoom = 0.5
ZS = 0.004
function onTick()
X=input.getNumber(1)
Y=input.getNumber(2)
--Toutch
Toutch1Press = input.getBool(1)
Toutch1X = input.getNumber(3)
Toutch1Y = input.getNumber(4)

ZoomIN = Toutch1Press and isPointInRectangle(Toutch1X, Toutch1Y, 0, 0, W, H/2)
ZoomOUT = Toutch1Press and isPointInRectangle(Toutch1X, Toutch1Y, 0, H/2, W, H/2)

if ZoomIN then
	Zoom = Zoom-ZS
elseif ZoomOUT then
	Zoom = Zoom+ZS
end

if Zoom > 50 then
	Zoom = 50
elseif Zoom < 0.1 then
	Zoom = 0.1
end
end

-- Returns true if the point (x, y) is inside the rectangle at (rectX, rectY) with width rectW and height rectH
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	screen.drawMap(X, Y, Zoom)
	screen.setColor(255, 0, 0)
	screen.drawLine(W/2-2, H/2, W/2+3, H/2)
	screen.drawLine(W/2, H/2-2, W/2, H/2+3)
end