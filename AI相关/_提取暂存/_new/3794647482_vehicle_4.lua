-- source: steam id 3794647482 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
chaff=0

function onTick()
	
	chaff=input.getNumber(1)
	SR=input.getBool(1)
	FCR=input.getBool(2)
	MIS=input.getBool(3)
	AC=input.getBool(4)
	chaffdc=input.getBool(5)
	
end


function onDraw()
	
	screen.setColor(0,50,0)
	screen.drawText(0,0,string.format("%.0f",chaff))
	
	if SR then
		screen.setColor(70,30,0)
		screen.drawText(1,18,"*SR*")
	end
	if FCR then
		screen.setColor(70,30,0)
		screen.drawText(1,12,"*FCR*")
	end
	if MIS then
		screen.setColor(70,0,0)
		screen.drawText(1,6,"*MIS!*")
	end
	if AC then
		screen.setColor(50,20,0)
		screen.drawText(13,0,"AUTO")
	end
	if chaffdc then
		screen.setColor(70,0,0)
		screen.drawText(1,26,"*C/M*")
	end
	
end