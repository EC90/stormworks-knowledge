-- source: steam id 3097129660 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GN=input.getNumber
function onTick()
	gpsx=GN(1)
	gpsy=GN(2)
	mapx=GN(30)
	mapy=GN(31)
	z=GN(32)
	nightmode=not input.getBool(1)
end
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	screen.drawMap(mapx,mapy,z)
	if nightmode then
	screen.setMapColorOcean(20,25,35)
	screen.setMapColorShallows(30,35,45)
	screen.setMapColorLand(50,50,60)
	screen.setMapColorGrass(30,35,35)
	screen.setMapColorSand(50,45,40)
	screen.setMapColorSnow(60,60,70)
	screen.setMapColorRock(25,21,20)
	screen.setMapColorGravel(30,25,20)
	else
	screen.setMapColorOcean(9,24,40)
	screen.setMapColorShallows(10,36,50)
	screen.setMapColorLand(51,54,55)
	screen.setMapColorGrass(24,50,24)
	screen.setMapColorSand(86,71,20)
	screen.setMapColorSnow(80,88,112)
	screen.setMapColorRock(44,33,22)
	screen.setMapColorGravel(55,44,33)
	end
	selfx,selfy=map.mapToScreen(mapx,mapy,z,w,h,gpsx,gpsy)
	selfx,selfy=math.floor(selfx+0.5),math.floor(selfy+0.5)
	akm1,akm2=map.mapToScreen(mapx,mapy,z,w,h,gpsx+20000,gpsy-2000)
	akm5,akm10=map.mapToScreen(mapx,mapy,z,w,h,gpsx+5000,gpsy-10000)
	km1,km2,km5,km10=akm1-selfx,akm2-selfy,akm5-selfx,akm10-selfy
	screen.setColor(15,15,15,32)
	--2
	screen.drawText(selfx,selfy+km2,"2km")
	screen.drawText(selfx,selfy-km2,"2km")
	screen.drawText(selfx+km2,selfy,"2km")
	screen.drawText(selfx-km2,selfy,"2km")
	screen.drawCircle(selfx,selfy,km2)
	if w>63 and h>63 then
	--1
	screen.drawCircle(selfx,selfy,km1)
	screen.drawText(selfx,selfy+km1,"20km")
	screen.drawText(selfx,selfy-km1,"20km")
	screen.drawText(selfx+km1,selfy,"20km")
	screen.drawText(selfx-km1,selfy,"20km")
	--5
	screen.drawText(selfx,selfy+km5,"5km")
	screen.drawText(selfx,selfy-km5,"5km")
	screen.drawText(selfx+km5,selfy,"5km")
	screen.drawText(selfx-km5,selfy,"5km")
	screen.drawCircle(selfx,selfy,km5)
	end
	--10
	screen.drawText(selfx,selfy+km10,"10km")
	screen.drawText(selfx,selfy-km10,"10km")
	screen.drawText(selfx+km10,selfy,"10km")
	screen.drawText(selfx-km10,selfy,"10km")
	screen.drawCircle(selfx,selfy,km10)
end