-- source: steam id 2864634703 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2864634703
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber

fo=string.format

function onTick()
	XO,YO,ZO=iN(1),iN(2),iN(3)
	XT,YT,ZT=iN(4),iN(5),iN(6)
	zoom=iN(7)
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	screen.drawMap(XT,ZT,zoom)
	pxO,pyO=map.mapToScreen(XT,ZT,zoom,w,h,XT,ZT)
	
	screen.setColor(0,0,255)
	screen.drawCircleF(pxO,pyO,1)
	
	screen.setColor(255,0,0)
	screen.drawCircleF(w/2,h/2,2)
	
	screen.setColor(255,255,255)
	screen.drawText(0,1,"Hit Position")
	screen.drawText(0,7,"X "..fo("%5.0f",XT))
	screen.drawText(0,13,"Y "..fo("%5.0f",YT))
	screen.drawText(0,19,"Z "..fo("%5.0f",ZT))
end