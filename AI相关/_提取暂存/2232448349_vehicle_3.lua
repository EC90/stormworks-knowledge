-- source: steam id 2232448349 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
FD_0 = false
FD_1 = false
FD = false
FD_CH = 1

CH2 = false
CH3 = false -- 1+2
CHG_0 = false
CHG_1 = false

function onDraw()
	w = 32
	h = 32

	screen.setColor(200,100,0,255)
	screen.drawTriangleF(w/2-3*w/32, h/2+3*h/32, w/2, h/2+3*h/32, w/2, h/2)
	screen.drawTriangleF(w/2+3*w/32, h/2+3*h/32, w/2, h/2+3*h/32, w/2, h/2)
	screen.drawLine(w/2-10*w/32, h/2-1, w/2-6*w/32, h/2-1)
	screen.drawLine(w/2+6*w/32, h/2-1, w/2+10*w/32, h/2-1)
	
	screen.setColor(128,128,128,255)
	screen.drawLine(0, h/2-1, 3*w/32, h/2-1)
	screen.drawLine(w-3*w/32, h/2-1, w, h/2-1)
	screen.drawTriangleF(w/2-4*w/32, 0, w/2, 0, w/2, 4*h/32)
	screen.drawTriangleF(w/2+4*w/32, 0, w/2, 0, w/2, 4*h/32)
	
	rMark(math.pi*1/3, 3)
	rMark(math.pi*-1/3, 3)
	rMark(math.pi*1/6, 3)
	rMark(math.pi*-1/6, 3)
	rMark(math.pi*1/16, 3)
	rMark(math.pi*-1/16, 3)
	
	
	if ResetBTN then
		screen.drawRectF(TW/2-2*(TW/32), TH-5*(TH/32), 4*(TW/32), 4*(TH/32))
	end
	
	
end
	

function rMark(deg, length)
	if deg > 0 then offset_w = -1 else offset_w = 0 end
	screen.drawLine(w/2 + offset_w - w * math.sin(deg),
	 h/2 -1 - h * math.cos(deg),
	 w/2 + offset_w - (w/2 - length) * math.sin(deg),
	 h/2 -1 - (h/2 - length) * math.cos(deg))
end

function isInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end