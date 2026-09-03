-- source: steam id 2900758088 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088
function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	CENT = input.getNumber(6)
	DEZ = input.getNumber(7)
	UN = input.getNumber(8)	
	Q = input.getNumber(5)
	R1 = input.getNumber(9)
	R2 = input.getNumber(10)
	R3 = input.getNumber(11)
	R4 = input.getNumber(12)
	
	isPressed = input.getBool(1)
		
	cu = isPressed and isPointInRectangle(inputX, inputY, 15, 8, 4, 4)
	cd = isPressed and isPointInRectangle(inputX, inputY, 15, 18, 4, 4)
	du = isPressed and isPointInRectangle(inputX, inputY, 20, 8, 4, 4)
	dd = isPressed and isPointInRectangle(inputX, inputY, 20, 18, 4, 4)
	uu = isPressed and isPointInRectangle(inputX, inputY, 25, 8, 4, 4)
	ud = isPressed and isPointInRectangle(inputX, inputY, 25, 18, 4, 4)
	
	output.setBool(1, cu)
	output.setBool(2, cd)
	output.setBool(3, du)
	output.setBool(4, dd)
	output.setBool(5, uu)
	output.setBool(6, ud)
end


function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()					
	screen.setColor(10, 10, 10)	
	screen.drawClear()	 
	
	screen.setColor(5, 5, 5)	
	screen.drawLine(0, 8, 32, 8)
	
	screen.setColor(100, 100, 100)
	screen.drawTextBox(-7, 0, w, h, "CH.", 0, 0)
	screen.drawTextBox(0, -12, w, h, "COMMS", 0, 0)
	screen.drawTextBox(2, 0, w, h, string.format("%.0f", CENT), 0, 0)
	screen.drawTextBox(7, 0, w, h, string.format("%.0f", DEZ), 0, 0)
	screen.drawTextBox(12, 0, w, h, string.format("%.0f", UN), 0, 0)
		
	screen.setColor(2, 2, 2)
	screen.drawTriangleF(18, 11, 20, 13, 17, 13)
	screen.drawTriangleF(23, 11, 25, 13, 22, 13)
	screen.drawTriangleF(28, 11, 30, 13, 27, 13)
	screen.drawTriangleF(18, 23, 20, 20, 16, 20)
	screen.drawTriangleF(23, 23, 25, 20, 21, 20)
	screen.drawTriangleF(28, 23, 30, 20, 26, 20)
	
	screen.setColor(100, 100, 100)
	screen.drawTriangleF(17, 10, 19, 12, 16, 12)
	screen.drawTriangleF(22, 10, 24, 12, 21, 12)
	screen.drawTriangleF(27, 10, 29, 12, 26, 12)
	screen.drawTriangleF(17, 22, 19, 19, 15, 19)
	screen.drawTriangleF(22, 22, 24, 19, 20, 19)
	screen.drawTriangleF(27, 22, 29, 19, 25, 19)
	
	
	
	screen.setColor(5, 5, 5)
	screen.drawRect(0+Q, 23, 31, 8)
	screen.drawTextBox(1, 23, w, 10, "STATUS", 0, 0)
	screen.setColor(5, 5, 5)
	screen.drawRect(0, 23, 31, 8)
	
	screen.setColor(0, 40, 0)
	screen.drawRectF(1+Q, 24, 30, 7)	
	screen.setColor(100, 100, 100)
	screen.drawTextBox(1+Q, 23, w, 10, "TRnSMT", 0, 0)
	screen.setColor(100, 100, 100)
	screen.setColor(5, 5, 5)
	screen.drawRect(0+Q, 23, 31, 8)
	
	--VERMELHO
	screen.setColor(50, 0, 0)
	screen.drawRectF(1+R1, 24, 30, 7)
	screen.setColor(100, 100, 100)
	screen.drawTextBox(1+R1, 23, w, 10, "RCVNG", 0, 0)
	--LARANJA
	screen.setColor(255, 40, 5)
	screen.drawRectF(1+R2, 24, 30, 7)
	screen.setColor(100, 100, 100)
	screen.drawTextBox(1+R2, 23, w, 10, "RCVNG", 0, 0)
	
	--AMARELO
	screen.setColor(255, 140, 0)
	screen.drawRectF(1+R3, 24, 30, 7)
	screen.setColor(5, 5, 5)
	screen.drawTextBox(1+R3, 23, w, 10, "RCVNG", 0, 0)
	
	--VERDE
	screen.setColor(0, 40, 0)
	screen.drawRectF(1+R4, 24, 30, 7)	
	screen.setColor(100, 100, 100)
	screen.drawTextBox(1+R4, 23, w, 10, "RCVNG", 0, 0)

		screen.setColor(0, 40, 0)
	screen.drawRectF(1+Q, 24, 30, 7)	
	screen.setColor(100, 100, 100)
	screen.drawTextBox(1+Q, 23, w, 10, "TRnSMT", 0, 0)
	screen.setColor(100, 100, 100)
	screen.setColor(5, 5, 5)
	screen.drawRect(0+Q, 23, 31, 8)
	
	


end