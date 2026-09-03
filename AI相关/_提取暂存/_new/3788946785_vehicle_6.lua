-- source: steam id 3788946785 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785
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
	w=iN(1)cx=w/2-.5
	h=iN(2)cy=h/2
	gX=iN(5)
	gY=iN(6)
	z=iN(8)
	l=iN(9)
	m_mode=iN(10)
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
	else
	--s.setColor(17,25,15)
	s.setColor(4,5,4)
	s.drawRectF(0,0,w,h)
	end
end