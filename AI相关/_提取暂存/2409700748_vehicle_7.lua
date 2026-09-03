-- source: steam id 2409700748 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2409700748
-- Tick function that will be executed every logic tick
function onTick()
	hdg = input.getNumber(8)
	coordX = input.getNumber(1)
	coordY = input.getNumber(2)
	output.setNumber(8, HDG)
	Heading = math.floor((1-input.getNumber(8)%1)*360)
	
	
	HDG = ((1-hdg)%1)*360	--definitely not stolen :)

	if round(HDG) == 00 then Tleft = "340" end	
	if round(HDG) == 00 then Tup = "360" end	--N
	if round(HDG) == 00 then Tright = "020" end
	
	if round(HDG) == 23 then Tleft = "360" end	
	if round(HDG) == 23 then Tup = "020" end	--NNE
	if round(HDG) == 23 then Tright = "045" end
	
	if round(HDG) == 45 then Tleft = "020" end	
	if round(HDG) == 45 then Tup = "045" end	--NE
	if round(HDG) == 45 then Tright = "070" end
	
	if round(HDG) == 68 then Tleft = "045" end
	if round(HDG) == 68 then Tup = "070" end	--ENE
	if round(HDG) == 68 then Tright = "090" end	
	
	if round(HDG) == 90 then Tleft = "070" end	
	if round(HDG) == 90 then Tup = "090" end	--E
	if round(HDG) == 90 then Tright = "110" end
	
	if round(HDG) == 112 then Tleft = "090" end	
	if round(HDG) == 112 then Tup = "110" end	--ESE
	if round(HDG) == 112 then Tright = "135" end
	
	if round(HDG) == 135 then Tleft = "110" end	
	if round(HDG) == 135 then Tup = "135" end	--SE
	if round(HDG) == 135 then Tright = "160" end
	
	if round(HDG) == 157 then Tleft = "135" end	
	if round(HDG) == 157 then Tup = "160" end	--SSE
	if round(HDG) == 157 then Tright = "180" end
	
	if round(HDG) == 180 then Tleft = "160" end	
	if round(HDG) == 180 then Tup = "180" end	--S
	if round(HDG) == 180 then Tright = "200" end
	
	if round(HDG) == 203 then Tleft = "180" end	
	if round(HDG) == 203 then Tup = "200" end	--SSW
	if round(HDG) == 203 then Tright = "225" end
	
	if round(HDG) == 225 then Tleft = "200" end	
	if round(HDG) == 225 then Tup = "225" end	--SW
	if round(HDG) == 225 then Tright = "250" end
	
	if round(HDG) == 248 then Tleft = "225" end	
	if round(HDG) == 248 then Tup = "250" end	--WSW
	if round(HDG) == 248 then Tright = "270" end
	
	if round(HDG) == 270 then Tleft = "250" end	
	if round(HDG) == 270 then Tup = "270" end	--W
	if round(HDG) == 270 then Tright = "290" end
	
	if round(HDG) == 292 then Tleft = "270" end	
	if round(HDG) == 292 then Tup = "290" end	--WNW
	if round(HDG) == 292 then Tright = "315" end
	
	if round(HDG) == 315 then Tleft = "290" end	
	if round(HDG) == 315 then Tup = "315" end	--NW
	if round(HDG) == 315 then Tright = "340" end
	
	if round(HDG) == 337 then Tleft = "315" end	
	if round(HDG) == 337 then Tup = "340" end	--NNW
	if round(HDG) == 337 then Tright = "360" end
	
	if round(HDG) == 359 then Tleft = "340" end
	if round(HDG) == 359 then Tup = "360" end	--N
	if round(HDG) == 359 then Tright = "020" end	
end

function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()
	
	MapOL(150)
	
	screen.setColor(0, 255, 0)
	
	screen.drawText(26, 37, Tup)
	screen.drawText(1, 49, Tleft)
	screen.drawText(50, 49, Tright)
	
	screen.drawText(26, 55, Heading)
	
	screen.drawCircle(32, 64, 20)
	
	--Vector()
		
end


	
	
--function Vector()
--	screen.setColor(255, 0, 255)
	
--	screen.drawLine(32, 52, Xn, Yn)
--end
	
function MapOL(a)
	screen.setColor(255, 255, 255)
	
	screen.setMapColorOcean(0, 0, 255, a)
	screen.setMapColorShallows(128, 128, 0, a)
	screen.setMapColorLand(128, 128, 128, a)
	screen.setMapColorGrass(128, 128, 128, a)
	screen.setMapColorSand(128, 128, 128, a)
	screen.setMapColorSnow(128, 128, 128, a)
	
	screen.drawMap(coordX, coordY, 0.5)
end
	
function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end