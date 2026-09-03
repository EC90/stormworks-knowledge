-- source: steam id 2950778456 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2950778456
function onTick()
	GN = input.getNumber
	speed = GN(1)/0.514
	alt = GN(2)*3
	heading = GN(3)*360
	if heading <0 then
		heading = 360+heading
	end
	gforce = GN(4)
	AOA = GN(5)
	liftSpeed = GN(6)
	wprh=GN(7)
	wpt=GN(8)
	hudMode = GN(32)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	Color = screen.setColor
	Line = screen.drawLine
	Text = screen.drawText
	TextBox = screen.drawTextBox

	-- center w
	px = w/2
	py = h/2 - 4
	Color(0, 255, 0)
	Line(px,py,px-2,py+2)
	Line(px,py,px+2,py+2)
	Line(px-2,py+2,px-4,py)
	Line(px+2,py+2,px+4,py)
	
	-- speed
	px = 16
	pys = h*1/6
	pye = h*5/6
	pyc = (pys+pye)/2
	Line(px,pys,px,pye)
	Line(px+1,pyc,px+4,pyc-3)
	Line(px+1,pyc,px+4,pyc+3)
	for i=0,2500,10 do
		ry = pyc+(speed-i)/75*(pye-pys)/2
		if ry < pye and ry > pys then
			if i%50 == 0 then
				Color(0, 5, 0)
				TextBox(0,ry-2,15,5,math.floor(i),1,0)
				Color(0, 255, 0)
				Line(px,ry,px-4,ry)
			else
				Line(px,ry,px-2,ry)
			end
		end
	end
	Color(0, 100, 0)
	TextBox(0,pyc-2,15,5,math.floor(speed),1,0)
	Color(0, 255, 0)

	-- alt
	px = w-16
	Line(px,pys,px,pye)
	Line(px-1,pyc,px-4,pyc-3)
	Line(px-1,pyc,px-4,pyc+3)
	for i=0,10000,10 do
		ry = pyc+(alt-i)/75*(pye-pys)/2
		if ry < pye and ry > pys then
			if i%50 == 0 then
				Color(0, 5, 0)
				TextBox(px+2,ry-2,15,5,math.floor(i),-1,0)
				Color(0, 255, 0)
				Line(px,ry,px+4,ry)
			else
				Line(px,ry,px+2,ry)
			end
		end
	end
	Color(0, 100, 0)
	TextBox(px+2,pyc-2,15,5,math.floor(alt),-1,0)
	TextBox(w-26,10,25,5,string.format("%.1f",liftSpeed),1,0)
	Color(0, 255, 0)

	-- AOA
	if hudMode == 0 then
		px = 26
		pys = h*1/2
		pye = h*4/5
		pyc = (pys+pye)/2
		for i = 1,10 do
			tmp = pys+(10-i)*(pye-pys)/9
			Line(px,tmp,px-2,tmp)
			if (i-1)%2 == 0 then
				Color(0, 10, 0)
				TextBox(px-10,tmp-1,10,5,math.floor((i-1)*5),1,0)
			end
			Color(0, 255, 0)
		end
		Line(px,pys,px,pye)
		if AOA <= 40 and AOA >= 0 then
			pygc = (1-AOA/40)*(pye-pys)+pys
			Line(px+1,pygc,px+4,pygc-3)
			Line(px+1,pygc,px+4,pygc+3)
		end
	end
	
	-- heading
	py = h*1/3-10
	pxs = 1/4*w
	pxe = 3/4*w
	pxc = (pxs+pxe)/2
	Line(pxs,py,pxe,py)
	Line(pxc,py+1,pxc-3,py+4)
	Line(pxc,py+1,pxc+3,py+4)
	for i=0,355,5 do
		fov = 15
		rx = pxc+(heading-i)/fov*(pxe-pxs)/2
		if math.abs(heading-i) > 180 then
			rx = pxc+(360-i+heading)/fov*(pxe-pxs)/2
		end
		if rx < pxe and rx > pxs then
			if i%45 == 0 then
				Color(0, 20, 0)
				TextBox(rx-7,py-6,15,5,math.floor(i),0,0)
				Color(0, 255, 0)
				Line(rx,py,rx,py-3)
			else
				Line(rx,py,rx,py-2)
			end
		end
	end
	TextBox(pxc-7,py-6,15,5,math.floor(heading),0,0)
	-- target indicator
	if hudMode == 0 then
		rx = pxc+(wprh)/fov*(pxe-pxs)/2
		if math.abs(wprh) > 180 then
			rx = pxc+(wprh)/fov*(pxe-pxs)/2
		end
		if rx > pxe then rx=pxe end
		if rx < pxs then rx=pxs end
		Line(rx,py,rx,py+6)
	end
	
	-- gforce number
	TextBox(2,h-12,25,5,string.format("%.2f",gforce),1,0)
	-- mode
	if hudMode == 0 then
		TextBox(w-30,h-12,25,5,"NAV",1,0)
		if wpt > 99 then
		TextBox(w-40,h-6,35,5,string.format("- MIN"),1,0)
		else
		TextBox(w-40,h-6,35,5,string.format("%.1fMIN",wpt),1,0)
		end
	elseif hudMode == 1 then
		TextBox(w-30,h-12,25,5,"GUN",1,0)
	elseif hudMode == 2 then
		TextBox(w-30,h-12,25,5,"MSL",1,0)
	elseif hudMode == 3 then
		TextBox(w-30,h-12,25,5,"BMB",1,0)
	end
end