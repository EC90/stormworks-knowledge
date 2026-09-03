-- source: steam id 2913735149 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2913735149
function onTick()
	GN = input.getNumber
	vvv = GN(1)
	vvh = GN(2)
	pitch = -GN(3)*360
	-- roll = GN(4)*math.pi*2
	rollFix = math.pi*2*90/(90-math.abs(pitch))
	roll = GN(4)*rollFix
	hudMode = GN(32)
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()
	margin = 2
	fov = 10

	Color = screen.setColor
	Circle = screen.drawCircle
	Line = screen.drawLine
	TextBox = screen.drawTextBox
	
	-- velocity vertical
	cx = w/2+vvh*(w/2-6)/45
	cy = w/2-vvv*(h/2-6)/30
	Color(0, 160, 0)
	Circle(cx, cy, 2)
	Line(cx-2,cy,cx-4,cy)
	Line(cx+2,cy,cx+4,cy)
	Line(cx,cy-2,cx,cy-4)
	if hudMode == 0 then
		Line(w/2,cy-4,w/2,cy+4)
	end
	
	-- pitch ladder
	if hudMode == 0 then
	tvvx = cx
	tvvy = cy
	for i = -180,180,5 do
		l = (i-pitch)/fov*(w/2-margin)
		if roll < -0.5*rollFix or roll > 0.5*rollFix then
			cosr = -math.cos(roll)
			sinr = -math.sin(roll)
		else
			cosr = math.cos(roll)
			sinr = math.sin(roll)
		end
		ax = tvvx-sinr*l
		ay = tvvy+cosr*l

		Line(ax-cosr*2,ay-sinr*2,ax-cosr*15,ay-sinr*15)
		Line(ax+cosr*2,ay+sinr*2,ax+cosr*15,ay+sinr*15)
		if i == 0 then
			Line(ax-cosr*20,ay-sinr*20,ax+cosr*20,ay+sinr*20)
		elseif i < 0 then
			Line(ax-cosr*15,ay-sinr*15,ax-cosr*15-sinr*2,ay-sinr*15+cosr*2)
			Line(ax+cosr*15,ay+sinr*15,ax+cosr*15-sinr*2,ay+sinr*15+cosr*2)
		elseif i > 0 then
			Line(ax-cosr*15,ay-sinr*15,ax-cosr*15+sinr*2,ay-sinr*15-cosr*2)
			Line(ax+cosr*15,ay+sinr*15,ax+cosr*15+sinr*2,ay+sinr*15-cosr*2)
		end
		if i == 0 then
		else
			Color(0, 20, 0)
			TextBox(ax-cosr*25,ay-sinr*25+cosr*2,20,5,-i,0,0)
			TextBox(ax+cosr*5,ay+sinr*5+cosr*2,20,5,-i,0,0)
			Color(0, 160, 0)
		end
    end
    end
end