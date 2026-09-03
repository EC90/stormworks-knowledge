-- source: steam id 2379508495 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2379508495
gb = input.getBool
gn = input.getNumber
sb = output.setBool
sn = output.setNumber
pgb = property.getBool
pgn = property.getNumber

ON = false
L = false
DV = 0
DH = 0
PV = 0
PH = 0
BLINK = false
P = 0
RG = 1000
BR = false
BL = false

_R = pgn('Display R')
_G = pgn('Display G')
_B = pgn('Display B')

function onTick()
	ON = gb(3)
	L = gb(4)
	DV = gn(5)
	DH = gn(6)
	PV = gn(7)
	PH = gn(8)
	P = gn(29)
	RG = gn(28)
	BLINK = gb(32)
	BR = gb(1)
	BL = gb(2)
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	if ON then
		w = screen.getWidth()
		h = screen.getHeight()
		
		if L then
			screen.setColor(_R*0.5,_G*0.5,_B*0.5,255)
			screen.drawTriangle(-1,-1,w/2,h,w+1,-1)
			screen.setColor(_R*0.5,_G*0.5,_B*0.5,15)
			screen.drawTriangleF(-1,-1,w/2,h,w+1,-1)
		
			d = 0
			c = 0
			
			if DV > 1 then
				d = d + DV
				c = c + 1
			end
			if DH > 1 then
				d = d + DH
				c = c + 1
			end
			
			if c > 0 then
				x = w*(0.5-PV*4)
				y = h-h*(d/c)/RG -- avg distance
				screen.setColor(_R*0.33,_G*0.33,_B*0.33,255)
				screen.drawLine(w/2,h,x,y)
				
				screen.setColor(_R,_G,_B,255)
				if (DV > 1 and DH > 1) or BLINK then
					screen.drawRect(x-3,y-3,6,6)
				end
			end
		else
			-- draw scan
			screen.setColor(_R,_G,_B,255)
			x = w*(0.5+P)
			screen.drawLine(x,0,x,h)
		end
		
		-- buttons
		if BR then
			screen.setColor(_R*0.25,_G*0.25,_B*0.25,255)
		else
			screen.setColor(63,63,63,255)
		end
		screen.drawRectF(1, 24, 6, 7)
		
		if BL then
			screen.setColor(_R*0.25,_G*0.25,_B*0.25,255)
		else
			screen.setColor(63,63,63,255)
		end
		screen.drawRectF(8, 24, 6, 7)
		
		screen.setColor(191,191,191,255)
		screen.drawText(2, 25,'R')
		screen.drawText(9, 25,'T')
		r = RG
		m = 'm'
		if r >= 1000 then
			r = r / 1000
			m = 'km'
		end
		screen.drawText(1, 1,'R:' .. string.format('%d', r//1) .. m)
	else
		screen.drawText(1,1,'MC OFF')
	end
end