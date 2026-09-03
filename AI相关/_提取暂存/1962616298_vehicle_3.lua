-- source: steam id 1962616298 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
Compass = 0
HDG = 0
TrueWindSpd = 0
pi = math.pi


function onTick()
	Compass = input.getNumber(32) * -1
	HDG = math.floor(((360 + Compass) % 1)*360)
	WindSpd = input.getNumber(30)
	WindDir = input.getNumber(31)
	IAS = WindSpd * math.cos(WindDir * pi * 2)
	CWS = WindSpd * math.sin(WindDir * pi * 2)
	FLS = input.getNumber(26)
	F_Tilt = input.getNumber(27)
	LLS = input.getNumber(28)
	L_Tilt = input.getNumber(29)
	
	FGS = FLS * math.cos(F_Tilt * pi * 2)
	LGS = LLS * math.cos(L_Tilt * pi * 2)

	FWS = FGS - IAS * math.cos(F_Tilt * pi * 2)
	LWS = LGS - CWS * math.cos(L_Tilt * pi * 2)
	
	if (FLS^2 + LLS^2)^(1/2) < 5 then
		TrueWindSpd = WindSpd
		TrueWindDir = WindDir * pi * -2 - pi
	else
		TrueWindSpd = (FWS^2 + LWS^2)^(1/2)
		TrueWindDir = math.atan(LWS, FWS)
	end

end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 0, 0, 255)
	screen.drawClear()
	
	if TrueWindSpd > 1 then
		screen.setColor(255, 100, 0, 200)
		rMark(TrueWindDir + pi, 5)
		for i = 1, TrueWindSpd, 1 do
			wMark(TrueWindDir + pi, TrueWindDir + pi * (1 + i/180), 5)
			wMark(TrueWindDir + pi, TrueWindDir + pi * (1 - i/180), 5)
			
		end
	end
	
	screen.setColor(200, 200, 200, 255)
	
	--mini airplane
	screen.drawLine(w/2,h/2-10,w/2,h/2+10)
	AHand(0,9,5)
	screen.drawLine(w/2 -3,h/2+7,w/2 +4,h/2+7)
	screen.drawLine(w/2 -10,h/2,w/2 +10,h/2)
	

	rMark(pi*2*Compass+0.05, 6)
	rMark(pi*2*Compass-0.05, 6)
	rMark(pi*2*Compass, 6) --north
	
	rMark(pi*2*(Compass+0.75), 5) --east
	rMark(pi*2*(Compass+0.5), 5) --south
	rMark(pi*2*(Compass+0.25), 5) --west
	
	rMark(pi*2*(Compass+0.25*1/3), 2) --330
	rMark(pi*2*(Compass+0.25*2/3), 2) --300
	
	rMark(pi*2*(Compass+0.25+0.25*1/3), 2) --240
	rMark(pi*2*(Compass+0.25+0.25*2/3), 2) --210
	
	rMark(pi*2*(Compass+0.5+0.25*1/3), 2) --150
	rMark(pi*2*(Compass+0.5+0.25*2/3), 2) --120
	
	rMark(pi*2*(Compass+0.75+0.25*1/3), 2) --60
	rMark(pi*2*(Compass+0.75+0.25*2/3), 2) --30

	screen.drawRectF(w/2 -9, h/2 -4, 18, 9)
	screen.setColor(0, 0, 0, 255)
	screen.drawRectF(w/2 -8, h/2 -3, 16, 7)
	screen.setColor(200, 200, 200, 255)
	screen.drawTextBox(w/2 -8, h/2 -2, 16, 5, string.format("%03.0f", HDG), 0, -1)
	
	

	--screen.drawTextBox(w/2 -8, h/2 -12, 16, 5, string.format("%03.0f", TrueWindDir), 0, -1)
	

end
	
function rMark(deg, length)
	screen.drawLine(w/2 - w/2 * math.sin(deg), h/2 - h/2 * math.cos(deg), w/2 - (w/2 - length) * math.sin(deg), h/2 - (h/2 - length) * math.cos(deg))
end

function wMark(degA, degB, length)
	screen.drawLine(w/2 - w/2 * math.sin(degB), h/2 - h/2 * math.cos(degB), w/2 - (w/2 - length) * math.sin(degA), h/2 - (h/2 - length) * math.cos(degA))
end

function AHand(ALT,length,width)
	local deg = pi * ALT /5
	width = width/2
	screen.drawTriangleF(w/2 + length * math.sin(deg),
		h/2 - length * math.cos(deg),
		w/2 - width * math.cos(deg),
		h/2 - width * math.sin(deg),
		w/2 + width * math.cos(deg),
		h/2 + width * math.sin(deg))
end