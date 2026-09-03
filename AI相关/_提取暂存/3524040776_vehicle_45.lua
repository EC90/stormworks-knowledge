-- source: steam id 3524040776 / vehicle.xml block#45
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--Engine order telegraph
list={
	{g=-6,v=-1.2,t='[EMGC]'},
	{g=-5,v=-1.0,t='[FULL]'},
	{g=-4,v=-0.75,t='[HIGH]'},
	{g=-3,v=-0.5,t='[HALF]'},
	{g=-2,v=-0.25,t='[SLOW]'},
	{g=-1,v=-0.1,t='[D SL]'},
	{g=0,v=0	,t='[STOP]'},
	{g=1,v=0.1	,t='[D SL]'},
	{g=2,v=0.25	,t='[SLOW]'},
	{g=3,v=0.5	,t='[HALF]'},
	{g=4,v=0.75	,t='[HIGH]'},
	{g=5,v=1.0	,t='[FULL]'},
	{g=6,v=1.2	,t='[EMGC]'},
}
vtarget=0
gearBlend=0
function onTick()
	sys=input.getBool(1)
	gear=input.getNumber(1)
	for i=1,#list do
		if list[i].g==gear then
			vtarget=list[i].v*property.getNumber('Max Speed')
		end
	end
	output.setNumber(1,vtarget)
	if math.abs(gearBlend-gear)>0.1 then
		if gearBlend>gear then
			gearBlend=gearBlend-0.1
		elseif gearBlend<gear then
			gearBlend=gearBlend+0.1
		end
	else
		gearBlend=gear
	end
end
function onDraw()
	w,h=screen.getWidth(),screen.getHeight()
	if sys then
		screen.setColor(16,16,16)
	else
		screen.setColor(8,8,8)
	end
	screen.drawClear()
	for i=1,#list do
		_=h/2-3+8*7-(i-gearBlend)*8
		if sys then
			if list[i].g==gear then
				if list[i].g>0 then
					screen.setColor(44,111,222)
				elseif list[i].g<0 then
					screen.setColor(222,66,55)
				else
					screen.setColor(222,166,55)
				end
			else
				if list[i].g>0 then
					screen.setColor(16,32,99)
				elseif list[i].g<0 then
					screen.setColor(99,24,16)
				else
					screen.setColor(99,66,24)
				end
			end
		else
			screen.setColor(4,4,4)
		end
		screen.drawTextBox(0,_,w,8,list[i].t,0,0)
		if sys then
			screen.setColor(99,99,99)
		else
			screen.setColor(4,4,4)
		end
		screen.drawLine(0,_-1,w,_-1)
		for j=1,8 do
			screen.setColor(0,0,0,math.abs(j-4)*8)
			screen.drawLine(0,_+j-2,w,_+j-2)
		end
	end
	screen.setColor(0,0,0,200)
	screen.drawRect(1,1,w-3,h)
	screen.drawLine(0,h/2+1,5,h/2+1)
	screen.drawLine(w,h/2+1,w-5,h/2+1)
	if sys then
		screen.setColor(128,128,128)
	else
		screen.setColor(16,16,16)
	end
	screen.drawRect(0,0,w-1,h-1)
	screen.drawLine(0,h/2,5,h/2)
	screen.drawLine(w,h/2,w-5,h/2)
	for i=1,h do
		screen.setColor(0,0,0,math.abs(i-h/2)/(h/2)*64)
		screen.drawLine(0,i-1,w,i-1)
	end
end