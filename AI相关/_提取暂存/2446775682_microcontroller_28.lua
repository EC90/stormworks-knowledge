-- source: steam id 2446775682 / microcontroller.xml block#28
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()

	iX = input.getNumber(3)
	iY = input.getNumber(4)
	ips = input.getBool(1)
	osb = input.getNumber(32)
	boot = input.getNumber(29)
	stby = input.getBool(4)
end


function ipr(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end



function onDraw()
if boot<11 then
		screen.setColor(0,0,0)
		screen.drawRectF(0, 0, 70, 70)
		screen.setColor(0,255,0)
		end
if boot<3 and boot>1 then

		screen.setColor(255, 255, 255)
		screen.drawLine(0, 0, 65, 65)
		screen.drawLine(0, 65, 65, 0)
		screen.drawLine(0, 32, 65, 32)
		screen.drawLine(32, 0, 32, 65)
		end

if boot<11 and boot>3.5 then
		screen.setColor(255, 255, 255)
		screen.drawTextBox(0, 54, 64, 6, "V.1.2.4", 0, 0)
		screen.drawTextBox(5, 0, 6, 64, "falkner", 0, 0)
		if stby==true and boot<9 then
		screen.drawTextBox(0, 10, 64, 8, "stby", 0, 0)
		end
		if boot>9 then screen.drawTextBox(0, 10, 64, 8, "ready", 0, 0) end
		if boot>3.9 and boot<10.7 then
		screen.drawRectF(50, 10, 4, 4)
		screen.setColor(200, 200, 200)
		screen.drawRectF(50, 14, 4, 4)
		screen.setColor(160, 160, 160)
		screen.drawRectF(50, 18, 4, 4)
		screen.setColor(120, 120, 120)
		screen.drawRectF(50, 22, 4, 4)
		screen.setColor(80, 80, 80)
		screen.drawRectF(50, 26, 4, 4)
		screen.setColor(60, 60, 60)
		screen.drawRectF(50, 30, 4, 4)
		screen.setColor(40, 40, 40)
		screen.drawRectF(50, 34, 4, 4)
		screen.setColor(20, 20, 20)
		screen.drawRectF(50, 38, 4, 4)
		screen.setColor(10, 10, 10)
		screen.drawRectF(50, 42, 4, 4)
		end
		if boot>4.2 then
		screen.setColor(0,255,0)
		screen.drawTriangleF(32, 20, 32, 32, 22, 41)
		screen.setColor(255,0,0)
		screen.drawTriangleF(32, 20, 32, 32, 42, 41)
		screen.setColor(0,0,255)
		screen.drawTriangleF(22, 41, 32, 32, 42, 41)
		end
end

	screen.setColor(10, 5, 5)
	screen.drawRectF(0, 0, 3, 64)
	screen.drawRectF(0, 0, 64, 3)
	screen.drawRectF(64, 64, -64, -3)
	screen.drawRectF(64, 64, -3, -64)
	screen.setColor(20, 10, 10)
	screen.drawLine(2, 2, 62, 2)
	screen.drawLine(2, 2, 2, 62)
	screen.drawLine(61, 61, 61, 2)
	screen.drawLine(61, 61, 2, 61)
	screen.setColor(35, 35, 35)
	
	screen.drawRectF(0, 10, 4, 4)
	screen.drawRectF(0, 20, 4, 4)
	screen.drawRectF(0, 30, 4, 4)
	screen.drawRectF(0, 40, 4, 4)
	screen.drawRectF(0, 50, 4, 4)
	
	screen.drawRectF(10, 60, 4, 4)
	screen.drawRectF(20, 60, 4, 4)
	screen.drawRectF(30, 60, 4, 4)
	screen.drawRectF(40, 60, 4, 4)
	screen.drawRectF(50, 60, 4, 4)
	
	screen.drawRectF(60, 50, 4, 4)
	screen.drawRectF(60, 40, 4, 4)
	screen.drawRectF(60, 30, 4, 4)
	screen.drawRectF(60, 20, 4, 4)
	screen.drawRectF(60, 10, 4, 4)
	
	screen.drawRectF(50, 0, 4, 4)
	screen.drawRectF(40, 0, 4, 4)
	screen.drawRectF(30, 0, 4, 4)
	screen.drawRectF(20, 0, 4, 4)
	screen.drawRectF(10, 0, 4, 4)
	screen.setColor(5, 5, 5)
	if osb==1 then
	screen.drawRectF(0, 10, 4, 4)
	end
	if osb==2 then
	screen.drawRectF(0, 20, 4, 4)
	end
	if osb==3 then
	screen.drawRectF(0, 30, 4, 4)
	end
	if osb==4 then
	screen.drawRectF(0, 40, 4, 4)
	end
	if osb==5 then
	screen.drawRectF(0, 50, 4, 4)
	end
	if osb==6 then
	screen.drawRectF(10, 60, 4, 4)
	end
	if osb==7 then
	screen.drawRectF(20, 60, 4, 4)
	end
	if osb==8 then
	screen.drawRectF(30, 60, 4, 4)
	end
	if osb==9 then
	screen.drawRectF(40, 60, 4, 4)
	end
	if osb==10 then
	screen.drawRectF(50, 60, 4, 4)
	end
	if osb==11 then
	screen.drawRectF(60, 50, 4, 4)
	end
	if osb==12 then
	screen.drawRectF(60, 40, 4, 4)
	end
	if osb==13 then
	screen.drawRectF(60, 30, 4, 4)
	end
	if osb==14 then
	screen.drawRectF(60, 20, 4, 4)
	end
	if osb==15 then
	screen.drawRectF(60, 10, 4, 4)
	end
	if osb==16 then
	screen.drawRectF(50, 0, 4, 4)
	end
	if osb==17 then
	screen.drawRectF(40, 0, 4, 4)
	end
	if osb==18 then
	screen.drawRectF(30, 0, 4, 4)
	end
	if osb==19 then
	screen.drawRectF(20, 0, 4, 4)
	end
	if osb==20 then
	screen.drawRectF(10, 0, 4, 4)
	end
end