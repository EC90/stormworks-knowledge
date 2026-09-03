-- source: steam id 1982539881 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1982539881
M1={}
M2={}
s=screen
iN=input.getNumber
iB=input.getBool
pN=property.getNumber
cc1=property.getText(pN("MapColor1"))
for num in cc1:gmatch("%d%d%d") do
	M1[#M1+1]=num-111
end
cc2=property.getText(pN("MapColor2"))
for num in cc2:gmatch("%d%d%d") do
	M2[#M2+1]=num-111
end
function onTick()
	w=iN(1)cx=w/2
	h=iN(2)cy=h/2
	z=iN(5)
	l=iN(6)
	gX=iN(7)
	gY=iN(8)
	m_mode=iN(16)
	if m_mode==2 then M=M1 else M=M2 end
	if M[1]+M[2]+M[3]<15*3 then dark=true else dark=false end
	output.setBool(1,dark)
end
function onDraw()
	if m_mode<3 then
	s.setMapColorOcean(M[1],M[2],M[3])
	s.setMapColorShallows(M[4],M[5],M[6])
	s.setMapColorLand(M[7],M[8],M[9])
	s.setMapColorGrass(M[10],M[11],M[12])
	s.setMapColorSand(M[13],M[14],M[15])
	s.setMapColorSnow(M[16],M[17],M[18])
	s.drawMap(gX,gY,z)
	end
	
	r=h/2
	r2=r*10/z
	
	if m_mode<3 then
	s.setColor(10,10,10,50)
	else
	s.setColor(10,10,10,100)
	end
	for i=1,5 do
	s.drawCircle(cx,cy-1,i*l*h/z)
	end
	for i=1,8 do
		x1=cx+(l*h/z)*math.cos(0.125*i*math.pi*2)
		y1=cy-1+(l*h/z)*math.sin(0.125*i*math.pi*2)
		x2=cx+r*math.cos(0.125*i*math.pi*2)
		y2=cy-1+r*math.sin(0.125*i*math.pi*2)
		s.drawLine(x1,y1,x2,y2)
	end
	
	s.setColor(10,10,10)
	for i=1,h do
		x=cx+r*math.cos((i/h)*2*math.pi)
		y=cy+r*math.sin((i/h)*2*math.pi)
		x1=cx+r*math.cos((i/h-1/h)*2*math.pi)
		y1=cy+r*math.sin((i/h-1/h)*2*math.pi)
		if x>cx then x2=w else x2=0 end
		if y>cy then y2=h else y2=0 end
		s.drawTriangleF(x,y,x1,y1,x2,y2)
	end
	s.drawTriangleF(0,0,w,0,cx,(h-2*r)/2)
	s.drawTriangleF(w,0,w,h,w-(w-2*r)/2-1,cy)
	s.drawTriangleF(w,h,0,h,cx,h-(h-2*r)/2-1)
	s.drawTriangleF(0,h,0,0,(w-2*r)/2,cy)
end