-- source: steam id 2933258043 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2933258043
function touch(inputX, inputY, rectX, rectY, rectW, rectH)
	return inputX > rectX and inputY > rectY and inputX < rectX+rectW and  inputY < rectY+rectH
	end
function onTick()
CTRL = input.getBool(1)
nv = input.getBool(4)
FOV = input.getNumber(4)
loaded = input.getBool(5)
RC = input.getNumber(6)
LX = input.getNumber(9)
LY = input.getNumber(10)
LX = math.min(math.max(LX,-0.048),0.048)
LY = math.min(math.max(LY,-0.048),0.048)
FOV = math.floor(FOV/0.036)
FOV = math.min(math.max(FOV,1),20)
	
	function onDraw()
	w = screen.getWidth()				 
	h = screen.getHeight()	
	
	if loaded then
	screen.setColor(0, 255, 0,220)
	screen.drawCircle(w/2, h/2, 1)
	
else
screen.setColor(255, 0, 0,220)
	screen.drawCircle(w/2, h/2, 1)

end
	
					
	
	
	if CTRL then
	screen.setColor(255, 255, 255,200)	
	screen.drawLine(w/2, h/2-5, w/2+LX*400, h/2-5-LY*400)
else
screen.setColor(255, 0, 0,255)	
	screen.drawText(w/2-10, h/2-20, "CTRL OUT")
	end

BX= 20
BY= h-30
	RC = math.fmod(RC,1)*2*math.pi
    screen.setColor(0, 255, 0,255)
    screen.drawRect(BX-6, BY-6, 13, 13)
    
    screen.setColor(0, 255, 0,255)
    screen.drawLine(BX-6, BY-6, BX, BY-12)

    screen.setColor(0, 255, 0,255)
    screen.drawLine(BX, BY-12, BX+7, BY-6)
    
    screen.setColor(0, 255, 0,255)
    screen.drawLine(BX, BY, BX+15*math.sin(RC), BY-15*math.cos(RC))
 	

 screen.setColor(0, 255, 0,255)
    screen.drawText(w/2+10, 15,(FOV))

if loaded then
screen.setColor(0, 255, 0,255)
screen.drawText(w-80, 15, "LOADED")
else
screen.setColor(255, 0, 0,255)
screen.drawText(w/2-10, h/2-10, "LOADING")
end
if nv then
screen.setColor(0, 255, 0,255)
screen.drawText(w-15, 15, "NV")
end

end


end


