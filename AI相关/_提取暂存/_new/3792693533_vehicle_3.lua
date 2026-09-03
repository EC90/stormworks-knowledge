-- source: steam id 3792693533 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792693533
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onTick()	
	--disp
	w=input.getNumber(1)
	h=input.getNumber(2)
	iX = input.getNumber(3)
	iY = input.getNumber(4)
	iP = input.getBool(1)
	x0=w/2
	y0=h/2	
				
	bH=8
	bWf=.25
	
	output.setBool(1,iP and isPointInRectangle(iX,iY,0			 ,y0-(h*bWf/2)	,bH		,h*bWf	))  -- pLEFT
	output.setBool(2,iP and isPointInRectangle(iX,iY,w-bH 		 ,y0-(h*bWf/2)	,bH		,h*bWf	)) -- pRIGHT
	output.setBool(3,iP and isPointInRectangle(iX,iY,x0-(w*bWf/2)  ,0		  	 ,w*bWf	 ,bH		)) -- pUP
	output.setBool(4,iP and isPointInRectangle(iX,iY,x0-(w*bWf/2)  ,h-bH			,w*bWf	 ,bH		)) -- pDOWN
end


function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	x0=w/2
	y0=h/2					

	tD=6
	tW=3
	
	screen.setColor(0,0,0,50)
	screen.drawTriangleF(x0-tW, tD, x0, 1, x0+tW, tD) -- Up
	screen.drawTriangleF(x0-tW, h-tD, x0, h-1, x0+tW, h-tD) -- Down
	
	screen.drawTriangleF(tD, y0-tW, 1, y0, tD, y0+tW) -- Left
	screen.drawTriangleF(w-tD, y0-tW, w-1, y0, w-tD, y0+tW) -- Right
end