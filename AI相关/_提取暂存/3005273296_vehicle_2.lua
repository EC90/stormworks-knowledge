-- source: steam id 3005273296 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3005273296
local ign=input.getNumber
local osn=output.setNumber
local step=1/90

function onTick()
	deg=ign(3)
	com=ign(4)
	deg=deg-com
	
	if deg<0 then deg=360+deg end
	if deg>=360 then deg=360-deg end
	if deg<=90 then
		osn(1,deg*step)
		osn(2,0)
	end
	if deg>90 and deg<=180 then
		osn(1,1)
		osn(2,(deg-90)*step)
	end
	if deg>181 and deg<=270 then
		osn(1,-1)
		osn(2,-1+((deg-180)*step))
	end
	if deg>270 then
		osn(1,((360-deg)*step)*-1)
		osn(2,0)
	end
end