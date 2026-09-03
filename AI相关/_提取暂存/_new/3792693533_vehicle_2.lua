-- source: steam id 3792693533 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792693533
gridON=property.getBool("Map Grid") or true
function drawGridLines(mapX, mapY, zoom, w, h, s)

	local tlX, tlY = map.screenToMap(mapX, mapY, zoom, w, h, 0, 0)
	local brX, brY = map.screenToMap(mapX, mapY, zoom, w, h, w, h) 
	
	local vl0 = math.ceil(tlX/s)*s
	local hl0 = math.ceil(tlY/s)*s
	
	
	for i=vl0,brX,s do
		local pxVLX, pxVLY = map.mapToScreen(mapX, mapY, zoom, w, h, i, tlY)
		screen.drawLine(pxVLX, 0, pxVLX, h)
	end
	
	for i=hl0,brY,-s do

		local pxHLX, pxHLY = map.mapToScreen(mapX, mapY, zoom, w, h, tlX, i)
		screen.drawLine(0, pxHLY, w, pxHLY)
	end

end

firstTic=true
function onTick()	
	--data import
	mapX=input.getNumber(13)
	mapY=input.getNumber(14)
	zoom=input.getNumber(15)
	mapZoom=zoom*0.001
	
end
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()					

	screen.setColor(255, 255, 150)
	screen.drawRect(0,0, w-1, h-1)
	if gridON then
		screen.setColor(0,0,0,25)
		if true then
			drawGridLines(mapX,mapY,mapZoom,w,h,4000)
		end
		if mapZoom*500 <= 10000 then
			drawGridLines(mapX,mapY,mapZoom,w,h,2000)
		end
		if mapZoom*500 <= 5000 then
			drawGridLines(mapX,mapY,mapZoom,w,h,1000)
		end
		if mapZoom*500 <= 2000 then
			drawGridLines(mapX,mapY,mapZoom,w,h,500)
		end
		if mapZoom*500 <= 500 then
			drawGridLines(mapX,mapY,mapZoom,w,h,250)
		end
	end
end