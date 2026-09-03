-- source: steam id 2551954944 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2551954944
igN=input.getNumber
igB=input.getBool
sdL=screen.drawLine
ssC=screen.setColor
sin=math.sin
cos=math.cos

w,h=0,0
pi2=2*math.pi
pi=math.pi


function onTick()
	Markings=igB(5)
	CS=igN(10)
	NCR=igN(24)
	NCG=igN(25)
	NCB=igN(26)
	MACR=igN(27)
	MACG=igN(28)
	MACB=igN(29)
end


function onDraw()
	w=screen.getWidth()				  
	h=screen.getHeight()
	if Markings then
		OS=h/18
	else
		OS=0
	end
	
	if w<h then
		r=w/2-1-OS
	else
		r=h/2-1-OS
	end
	
	if Markings then
		for i=1,31 do
			ssC(MACR,MACG,MACB)
			if i%8==0 then
				j=1
			elseif i%4==0 and i%8~=0 then
				j=0.80
			else
				j=0.30
			end
			tempN=i*pi/16
			sdL(w/2-1+(r+OS*j)*sin(tempN),h/2-(r+OS*j)*cos(tempN),w/2-1+(r-1)*sin(tempN),h/2-(r-1)*cos(tempN))
		end
		ssC(NCR,NCG,NCB)
		sdL(w/2-1+(r+OS)*sin(CS*pi2),h/2-(r+OS)*cos(CS*pi2),w/2-1+(r-1)*sin(CS*pi2),h/2-(r-1)*cos(CS*pi2))
	end
end
