-- source: steam id 2013584399 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2013584399
scSC=screen.setColor
scDT=screen.drawText
scDCF=screen.drawCircleF
scDL=screen.drawLine

function onTick()
	
	radarAct=input.getBool(10)	
	
	if radarAct then
		if not initialized then
			ranges={}
			rangesStr=property.getText("Ranges")
			rangeID=0
			for r in (rangesStr..","):gmatch("([^,]*),") do
				ranges[rangeID]= tonumber(r)
				rangeID= rangeID+1
			end
			rangeID= 5
			range=ranges[5]			
						
			radius= 1000
			initialized= true
		end
		
		rangeChange=false

		if input.getBool(1) then
			rangeChange=true
			rangeID=rangeID-1
			if rangeID == -1 then rangeID=0 end
			range=ranges[rangeID]
		end	
		
		if input.getBool(7) then
			rangeChange=true
			rangeID=rangeID+1
			if ranges[rangeID] == nil then rangeID=rangeID-1 end
			range=ranges[rangeID]
		end		
		
		hMode=input.getBool(2)
		frontSweepMode=input.getBool(11)
		heading=((1-input.getNumber(4))%1)*math.pi*2
		if hMode then brg=heading else brg=0 end
		if input.getBool(3) then direction=1 else direction= -1 end
		rot=input.getNumber(1)*math.pi*2
		if input.getBool(4) then rot=rot+heading end	
		rot=rot*direction+input.getNumber(3)/180*math.pi
		distance=input.getNumber(2)/range*radius	
		pausedSweep=input.getBool(12)
			
		output.setNumber(1,range)
		output.setBool(2,rangeChange)
	end
end

function onDraw()
	w=screen.getWidth()				  
	h=screen.getHeight()	
	
	scSC(0,100,0,5)
	screen.drawRectF(-1,-1,w+2,h+2)
	
	if radarAct then	
		
	pivot=math.min(w,h)/2-1
	radius=pivot
	if radius>20 then radius=radius-3 end
	
	scSC(4,4,4)
	screen.drawClear()
	scSC(0,0,0)
	scDCF(pivot,pivot,radius)  	

	if not pausedSweep then
		ray= brg+rot
		alpha=100
		for i=0,20,1 do
			scSC(0,255,0,alpha)
			screen.drawLine(pivot,pivot,polar2cart(ray,radius))
			ray=ray-.02*direction
			alpha=alpha*.7
		end	
	end
	
	scSC(0, 255, 0, 5)
	pxN,pyN=polar2cart(brg,radius)
	pxE,pyE=polar2cart(brg+math.pi/2,radius)
	pxS,pyS=polar2cart(brg+math.pi,radius)
	pxW,pyW=polar2cart(brg+math.pi*3/2,radius)
	scDL(pxN,pyN,pxS,pyS)
	scDL(pxE,pyE,pxW,pyW)
	if w>40 then
		for i=0, 36, 1 do
			angle=brg+i/18*math.pi
			px0,py0=polar2cart(angle,radius)
			len=4
			if i/9==math.floor(i/9) then
				scSC(0,255,0) 
			else 
				scSC(0,40,0)
				if i/3~=math.floor(i/3) then
					len=2
				end
			end
			px1,py1=polar2cart(angle,radius+len)
			scDL(px0,py0,px1,py1)
		end
	end
	
	if hMode then
		scSC(0,255,0,100)
		(pivot,pivot,pxN,pyN)
	end	
	
	xi0=pivot yi0=pivot-radius/2
	xo0=pivot yo0=pivot-radius
	for i=1, 30, 1 do
		angle=i/15*math.pi
		xi1,yi1=polar2cart(angle,radius/2)
		scSC(0,255,0,5)
		scDL(xi0,yi0,xi1,yi1)
		xi0=xi1 yi0=yi1
		xo1,yo1= polar2cart(angle,radius)
		scSC(0,120,0)
		scDL(xo0,yo0,xo1,yo1)
		xo0=xo1 yo0=yo1
	end


	if radius>40 then
		x=w-45
		if hMode then modeStr="north" else modeStr="heading" end
		scDT(x,3,modeStr)
		if range<1000 then
			scDT(x,10,string.format("rng %3.0fm ",range))
		else
			scDT(x,10,string.format("rng %3.1fkm",range/1000))
		end
		scDT(x,17,string.format("hdg %3.0f  ",heading*180/math.pi))
		screen.drawCircle(x+36,18,1)
	elseif radius>20 then
		scSC(4,4,4)
		screen.drawRectF(w-18,h-7,15,6)
		scSC(0,255,0)
		--if hMode then 
		--	scDT(4,h-6,"N")
		--else
		--	scDT(4,h-6,"H")
		--end
		if range<1000 then
			scDT(w-20,h-6,string.format("%3.0fm",range))
		else
			scDT(w-28,h-6,string.format("%3.0fkm",range/1000))
		end
	end
	
	else
		scSC(0,100,0,100)
		if w>32 then
			screen.drawRect(w/6,2*(h/6),w-(2*w/6),(h/6)*2)
		end
		screen.drawTextBox(1,2*(h/6),w-1,(h/6)*2," RADAR\nOFF",0,0)
	
	end
end
	
function polar2cart(angle,length)
	return pivot+math.sin(angle)*length, pivot-math.cos(angle)*length
end
	
function tableLen(T)
	local c=0
	if T~=nill then		
		for _ in pairs(T) do c=c+1 end
	end	
	return c
end