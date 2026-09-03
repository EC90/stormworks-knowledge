-- source: steam id 2551954944 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2551954944
--
function onTick()
	w,h=input.getNumber(1),input.getNumber(2)
	inputX,inputY=input.getNumber(3),input.getNumber(4)
	isPressed1=input.getBool(1)
	gpsX=input.getNumber(11)
	gpsY=input.getNumber(12)
	gpsZ=input.getNumber(13)
	laserDistance=input.getNumber(14)

	sliderX,sliderY,sliderW,sliderH=w-9,0,9,h--slider fov position&dimension
	fov=sliderOut
	
	offsetW,offsetH=w/2,h/2--center of rotation camera sys

	--rotation camera
	if isPressed1 and inputX<sliderX and inputY>9 and inputY<h-9
		then
			if inputY<offsetH then commandPitch=inputY/offsetH-1 end
			if inputY>offsetH then commandPitch=inputY/offsetH-1 end

			if inputX<offsetW then commandYaw=inputX/offsetW-1 end
			if inputX>offsetW then commandYaw=inputX/offsetW-1 end
		else
			commandPitch=0
			commandYaw=0
	end

	--slider
	if isPressed1 and inputX>sliderX
		then
		sliderOut= (sliderH-inputY)/sliderH --slider out
		sliderSetline= -(sliderOut*sliderH)+sliderH --slider redline
		else
		sliderOut= sliderOut or 0.3 --slider out
		sliderSetline= sliderSetline or (h/3*2) --slider redline	
	end



	output.setNumber(1, commandPitch)
	output.setNumber(2, commandYaw)
	output.setNumber(3, fov)
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	
	--HUD Frame
	screen.setColor(20,20,20)
	screen.drawLine(w-9, 0, w-9, h)
	screen.drawLine(0, 9, w-9, 9)
	screen.drawLine(0, h-9, w-9, h-9)
	screen.drawLine(w/2-4, 0, w/2-4, 9)
	screen.drawLine(w/2-4, h-9, w/2-4, h)

	--crossaim/deadzone	
	screen.setColor(255,0,0)
	screen.drawRect(w/20*9, h/20*9, w/10, h/10)

	--fov slider
	screen.setColor(40,0,60,150)--bg color
	screen.drawRectF(sliderX+1, sliderY, sliderW, sliderH)--bg
	screen.setColor(235,255,235)--slider color
	screen.drawLine(sliderX+2, sliderY, sliderX+8, sliderY)--horizontal top
	screen.drawLine(sliderX+5, sliderY, sliderX+5, sliderH)--vertical
	screen.drawLine(sliderX+2, sliderH, sliderX+8, sliderH)--horizontal bottom
	screen.setColor(255,0,0)--lever color
	screen.drawLine(sliderX+1, sliderSetline, sliderX+9, sliderSetline)--lever slider

	--GPS Info
	infoX,infoY=1,11 --location
	screen.setColor(0,100,255)
	if w==96 
		then gX,gY,gZ,gL="X:","Y:","Z:","Dist.:"
		else
			if w>96
				then gX,gY,gZ,gL="X:","Y:","Z:","Distance:"
				else
					if w<96
						then gX,gY,gZ,gL="","","",""
					end
			end
	end

	if w>=96 then screen.setColor(0,100,255,255) else screen.setColor(0,100,255,0) end
	screen.drawTextBox(infoX, 11, w, 5, gX..string.sub(gpsX,0,6), -1, -1)
	screen.drawTextBox(infoX, 17, w, 5, gY..string.sub(gpsY,0,6), -1, -1)
	screen.drawTextBox(infoX, 23, w, 5, gZ..string.sub(gpsZ,0,6), -1, -1)
	
	if w<96 then screen.setColor(0,100,255,0) else screen.setColor(0,100,255,255) end
	screen.drawTextBox(infoX, h-15, w, 5, gL..string.sub(laserDistance,0,6), -1, -1)

end
--screen.drawTextBox(x, y, w, 5, ""..string.sub(xxx,0,6), -1, -1)