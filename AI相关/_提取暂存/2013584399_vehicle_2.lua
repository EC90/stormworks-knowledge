-- source: steam id 2013584399 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2013584399
function onTick()
	speed = PrecisonAdj(input.getNumber(1),10)%1000
	if (speed<0) then speedText = "-"..string.gsub(math.abs(speed),"%.0","") else speedText = " "..string.gsub(math.abs(speed),"%.0","") end
	mSpeed = math.abs(PrecisonAdj(property.getNumber("Max Value"),10)%1000)
	if property.getBool("Shift range") then s = 1 else s = 0 end
end
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0,0,0,0)
	screen.drawClear()
	DrawTextBoxColored((w/2)-11,(h/2)-3,23,7,speedText,1,0,50,150,50,255,0,0,0,255)
	screen.setColor(0,0,0,0)
	screen.drawRectF((w/2)-11,(h/2)-3, 1, 7)
	screen.drawRectF((w/2)+11,(h/2)-3, 1, 7)
	screen.setColor( 0,255,0,255)
	if (((speed/mSpeed)>=((0+s)/38))) then
		screen.drawLine( 1,29, 4,26)
	end
	if ((speed/mSpeed)>=((1+s)/38)) then
		screen.drawLine( 1,26, 4,24)
	end
	if ((speed/mSpeed)>=((2+s)/38)) then
		screen.drawLine( 1,23, 4,23)
	end
	if ((speed/mSpeed)>=((3+s)/38)) then
		screen.drawLine( 1,21, 4,21)
	end
	if ((speed/mSpeed)>=((4+s)/38)) then
		screen.drawLine( 1,19, 4,19)
	end
	if ((speed/mSpeed)>=((5+s)/38)) then
		screen.drawLine( 1,17, 4,17)
	end
	if ((speed/mSpeed)>=((6+s)/38)) then
		screen.drawLine( 1,15, 4,15)
	end
	if ((speed/mSpeed)>=((7+s)/38)) then
		screen.drawLine( 1,13, 4,13)
	end
	if ((speed/mSpeed)>=((8+s)/38)) then
		screen.drawLine( 1,11, 4,11)
	end
	if ((speed/mSpeed)>=((9+s)/38)) then
		screen.drawLine( 1, 9, 4, 9)
	end
	if ((speed/mSpeed)>=((10+s)/38)) then
		screen.drawLine( 1, 7, 4, 7)
	end
	if ((speed/mSpeed)>=((11+s)/38)) then
		screen.drawLine( 1, 4, 4, 6)
	end
	if ((speed/mSpeed)>=((12+s)/38)) then
		screen.drawLine( 1, 1, 4, 4)
	end
	if ((speed/mSpeed)>=((13+s)/38)) then
		screen.drawLine( 4, 1, 6, 4)
	end
	if ((speed/mSpeed)>=((14+s)/38)) then
		screen.drawLine( 7, 1, 7, 4)
	end
	if ((speed/mSpeed)>=((15+s)/38)) then
		screen.drawLine( 9, 1, 9, 4)
	end
	if ((speed/mSpeed)>=((16+s)/38)) then
		screen.drawLine(11, 1,11, 4)
	end
	if ((speed/mSpeed)>=((17+s)/38)) then
		screen.drawLine(13, 1,13, 4)
	end
	if ((speed/mSpeed)>=((18+s)/38)) then
		screen.drawLine(15, 1,15, 4)
	end
	if ((speed/mSpeed)>=((19+s)/38)) then
		screen.drawLine(17, 1,17, 4)
	end
	if ((speed/mSpeed)>=((20+s)/38)) then
		screen.drawLine(19, 1,19, 4)
	end
	if ((speed/mSpeed)>=((21+s)/38)) then
		screen.drawLine(21, 1,21, 4)
	end
	if ((speed/mSpeed)>=((22+s)/38)) then
		screen.drawLine(23, 1,23, 4)
	end
	if ((speed/mSpeed)>=((23+s)/38)) then
		screen.drawLine(25, 1,25, 4)
	end
	if ((speed/mSpeed)>=((24+s)/38)) then
		screen.drawLine(28, 1,26, 4)
	end
	if ((speed/mSpeed)>=((25+s)/38)) then
		screen.drawLine(31, 1,28, 4)
	end
	if ((speed/mSpeed)>=((26+s)/38)) then
		screen.drawLine(31, 4,28, 6)
	end
	if ((speed/mSpeed)>=((27+s)/38)) then
		screen.drawLine(31, 7,28, 7)
	end
	if ((speed/mSpeed)>=((28+s)/38)) then
		screen.drawLine(31, 9,28, 9)
	end
	if ((speed/mSpeed)>=((29+s)/38)) then
		screen.drawLine(31,11,28,11)
	end
	if ((speed/mSpeed)>=((30+s)/38)) then
		screen.drawLine(31,13,28,13)
	end
	if ((speed/mSpeed)>=((31+s)/38)) then
		screen.drawLine(31,15,28,15)
	end
	if ((speed/mSpeed)>=((32+s)/38)) then
		screen.drawLine(31,17,28,17)
	end
	if ((speed/mSpeed)>=((33+s)/38)) then
		screen.drawLine(31,19,28,19)
	end
	if ((speed/mSpeed)>=((34+s)/38)) then
		screen.drawLine(31,21,28,21)
	end
	if ((speed/mSpeed)>=((35+s)/38)) then
		screen.drawLine(31,23,28,23)
	end
	if ((speed/mSpeed)>=((36+s)/38)) then
		screen.drawLine(31,26,28,24)
	end
	if ((speed/mSpeed)>=((37+s)/38)) then
		screen.setColor(255,0,0,255)
		screen.drawLine(31,29,28,26)
	end
end
	
function DrawTextBoxColored(x,y,w,h,text,xa,ya,r,g,b,a,ctr,ctg,ctb,cta)
	screen.setColor(r,g,b,a)
	screen.drawRectF(x,y,w,h)
	screen.setColor(ctr,ctg,ctb,cta)
	screen.drawTextBox(x+1,y+1,w-2,h-2,text,xa,ya)
end
	
function PrecisonAdj(a,p)
	return (((p*a)-(p*a)%10)/p)
end