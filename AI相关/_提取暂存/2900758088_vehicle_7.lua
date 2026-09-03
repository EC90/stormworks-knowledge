-- source: steam id 2900758088 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088
function onTick()
	spd1 = tostring(math.ceil(input.getNumber(3) * 3.6))
	az = input.getNumber(1)			 
	x = -az
	
	   mode = input.getBool(1)
	reverse = input.getBool(2)
		low = input.getBool(3)
end

function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()
	
	screen.setColor(0,0,0,255)
	screen.drawRect(0,0,w-1,h-1)
	screen.drawRect(1,1,w-3,h-3)
	for i = 0, 3, 1 do
		vis = 200 - (i*50)
		screen.setColor(0,0,0,vis)
		screen.drawRect(2+i,2+i,w-5-(2*i),h-5-(2*i))
	end		
	
	screen.setColor(0, 200, 0, 255)	
	screen.drawLine(w/2, 0, w/2, 3)
	
	screen.setColor(0, 150, 0, 200)			
	
	xd8 = ((0.55-x)%1) pd8 = math.ceil(xd8*(w))
	xd7 = ((0.60-x)%1) pd7 = math.ceil(xd7*(w))
	xd6 = ((0.65-x)%1) pd6 = math.ceil(xd6*(w))
	xd5 = ((0.70-x)%1) pd5 = math.ceil(xd5*(w))
	
	xW  = ((0.75-x)%1) pW  = math.ceil(xW *(w))
	
	xd4 = ((0.80-x)%1) pd4 = math.ceil(xd4*(w))
	xd3 = ((0.85-x)%1) pd3 = math.ceil(xd3*(w))
	xd2 = ((0.90-x)%1) pd2 = math.ceil(xd2*(w))
	xd1 = ((0.95-x)%1) pd1 = math.ceil(xd1*(w))
	
	xN  = ((1.00-x)%1) pN  = math.ceil(xN *(w))
	
	xu1 = ((1.05-x)%1) pu1 = math.ceil(xu1*(w))
	xu2 = ((1.10-x)%1) pu2 = math.ceil(xu2*(w))
	xu3 = ((1.15-x)%1) pu3 = math.ceil(xu3*(w))
	xu4 = ((1.20-x)%1) pu4 = math.ceil(xu4*(w))
	
	xE  = ((1.25-x)%1) pE  = math.ceil(xE *(w))
	
	xu5 = ((1.30-x)%1) pu5 = math.ceil(xu5*(w))
	xu6 = ((1.35-x)%1) pu6 = math.ceil(xu6*(w))
	xu7 = ((1.40-x)%1) pu7 = math.ceil(xu7*(w))
	xu8 = ((1.45-x)%1) pu8 = math.ceil(xu8*(w))
	
	xS  = ((1.50-x)%1) pS  = math.ceil(xS *(w))
	
	-------------------------------------------

	screen.drawLine(pd8, 0, pd8, 1)
	screen.drawLine(pd7, 0, pd7, 1)
	screen.drawLine(pd6, 0, pd6, 1)
	screen.drawLine(pd5, 0, pd5, 1)
	
	screen.drawLine(pW , 0, pW , 2)
	
	screen.drawLine(pd4, 0, pd4, 1)
	screen.drawLine(pd3, 0, pd3, 1)
	screen.drawLine(pd2, 0, pd2, 1)
	screen.drawLine(pd1, 0, pd1, 1)
	
	screen.drawLine(pN , 0, pN , 2)
	
	screen.drawLine(pu1, 0, pu1, 1)
	screen.drawLine(pu2, 0, pu2, 1)
	screen.drawLine(pu3, 0, pu3, 1)
	screen.drawLine(pu4, 0, pu4, 1)
	
	screen.drawLine(pE , 0, pE , 2)

	screen.drawLine(pu5, 0, pu5, 1)
	screen.drawLine(pu6, 0, pu6, 1)
	screen.drawLine(pu7, 0, pu7, 1)
	screen.drawLine(pu8, 0, pu8, 1)
	
	screen.drawLine(pS , 0, pS , 2)
	
	if not mode then
		screen.setColor(0, 150, 0, 255)
		screen.drawText(w-2-(spd1:len()*5), h-8, spd1)
		
		if not low and not reverse then
				screen.drawText(3, h-8, "D")
		else if low and not reverse then
				screen.drawText(3, h-8, "DL")
		else if not low and reverse then	
			screen.drawText(3, h-8, "R")
		else 
			screen.drawText(3, h-8, "RL")
		end
	end
	end
	else
		screen.setColor(150, 0, 0, 200)	
		screen.drawText(3, h-8, "SA")
		
		screen.setColor(0,200,0,150)
		screen.drawRect(w/3,h/3,w/3,h/3)
		
		screen.drawLine(w/2,h/4,w/2,(h/2)-2)
		screen.drawLine(w/2,(h/2)+3,w/2,h-(h/4))
		
		screen.drawLine(w/4,h/2,(w/2)-2,h/2)
		screen.drawLine((w/2)+3,h/2,w-(w/4),h/2)
	end
end