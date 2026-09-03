-- source: steam id 2774712393 / microcontroller.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2774712393
FONT=property.getText("FONT1")..property.getText("FONT2") FONT_D={} FONT_S=0 for n in FONT:gmatch("....")do FONT_D[FONT_S+1]=tonumber(n,16)FONT_S=FONT_S+1 end function dst(x,y,t,s,r,m)s=s or 1 r=r or 1 if r>2then t=t:reverse()end t=t:upper()for c in t:gmatch(".")do ci=c:byte()-31if 0<ci and ci<=FONT_S then for i=1,15 do if r>2 then p=2^i else p=2^(16-i)end if FONT_D[ci]&p==p then xx,yy=((i-1)%3)*s,((i-1)//3)*s if r%2==1then screen.drawRectF(x+xx,y+yy,s,s)else screen.drawRectF(x+5-yy,y+xx,s,s)end end end if FONT_D[ci]&1==1 and not m then i=2*s else i=4*s end if r%2==1then x=x+i else y=y+i end end end end
s=screen
dL=s.drawLine
sC=s.setColor
iN=input.getNumber
iB=input.getBool
pN=property.getNumber
mc=math.cos
ms=math.sin
M={}
M1={}
M2={}
cc1=property.getText(pN("MapColor1"))
for num in cc1:gmatch("%d%d%d") do
	M1[#M1+1]=num-111
end
cc2=property.getText(pN("MapColor2"))
for num in cc2:gmatch("%d%d%d") do
	M2[#M2+1]=num-111
end
mz=1
mx=0
my=0
z=1
function onTick()
	w=iN(1)
	h=iN(2)
	if w==0 then w=32 h=32 end cy=h/2 cx=w/2
	mode=iN(3)
	gps_x=iN(4)
	gps_y=iN(5)
	ba=-iN(6)*math.pi*2
	bc_x=iN(7)
	bc_y=iN(8)
	dist=iN(9)
	z_in=iB(3)
	z_out=iB(4)
	m_mode=iB(6)
	if m_mode then M=M1 else M=M2 end
	k_color=findBestContrastColor(M)
	if M[1]+M[2]+M[3]<15*3 then dark=true else dark=false end
	if bc_x~=0 and mode==1 then
		z=clamp(dist*0.00225,1,50)
		mcx=(gps_x+bc_x)/2
		mcy=(gps_y+bc_y)/2-((mz*1000/h)*3.5)
	else
		if mode==2 and bc_x~=0 then
			mcx=bc_x
			mcy=bc_y-((mz*1000/h)*3.5)
		else
			mcx=gps_x
			mcy=gps_y-((mz*1000/h)*3.5)
		end
		if z_in then z=clamp(z-z/150,.1,50) end
		if z_out then z=clamp(z+z/150,.1,50) end
	end
	mz=mz-clamp(mz-z,-.5,.5)
	mx=mx-clamp(mx-mcx,-100,100)
	my=my-clamp(my-mcy,-100,100)
	output.setNumber(1,mx)
	output.setNumber(2,my)
	output.setNumber(3,mz)
	output.setBool(1,dark)
end
function onDraw()
	s.setMapColorOcean(M[1],M[2],M[3])
	s.setMapColorShallows(M[4],M[5],M[6])
	s.setMapColorLand(M[7],M[8],M[9])
	s.setMapColorGrass(M[10],M[11],M[12])
	s.setMapColorSand(M[13],M[14],M[15])
	s.setMapColorSnow(M[16],M[17],M[18])
	s.setMapColorRock(M[19],M[20],M[21])
	s.setMapColorGravel(M[22],M[23],M[24])
	screen.drawMap(mx,my,mz)
	px,py=map.mapToScreen(mx,my,mz,w,h,gps_x,gps_y)
	px1=px+(4)*ms(ba)
	py1=py-(4)*mc(ba)
	sC(50,2,2)
	s.drawLine(px1,py1,px,py)
	sC(k_color[1],k_color[2],k_color[3])
	s.drawCircleF(px,py,1.5)
end
function clamp(x,min,max)
	return math.max(math.min(x,max),min)
end
function RGBToHSL(R,G,B)
    R,G,B=R/255,G/255,B/255
    max,min=math.max(R,G,B),math.min(R,G,B)
    L=(max+min)/2
    if max==min then
        H,S=0,0 -- achromatic
    else
        d=max-min
        S=L>.5 and d/(2-max-min) or d/(max+min)
        if max==R then
            H=(G-B)/d+(G<B and 6 or 0)
        elseif max==G then
            H=(B-R)/d+2
        else
            H=(R-G)/d+4
        end
        H=H/6
    end
    return H,S,L
end
function HSLToRGB(H,S,L)
    if S==0 then
        R,G,B=L,L,L -- achromatic
    else
        function hue2rgb(p, q, t)
            if t<0 then t=t+1 end
            if t>1 then t=t-1 end
            if t<1/6 then return p+(q-p)*6*t end
            if t<1/2 then return q end
            if t<2/3 then return p+(q-p)*(2/3-t)*6 end
            return p
        end
        Q=L<.5 and L*(1+S) or L+S-L*S
        P=2*L-Q
        R,G,B=hue2rgb(P,Q,H+1/3),hue2rgb(P,Q,H),hue2rgb(P,Q,H-1/3)
    end
    return R*255,G*255,B*255
end
function findBestContrastColor(C)
    hslColors={}
    for i=1,#C,3 do
        R,G,B=C[i],C[i+1],C[i+2]
        H,S,L=RGBToHSL(R,G,B)
        table.insert(hslColors,{H=H,S=S,L=L})
    end
    totalH,totalL=0,0
    for _,hslColor in ipairs(hslColors) do
        totalH=totalH+hslColor.H
        totalL=totalL+hslColor.L
    end
    avgH=totalH/#hslColors
    avgL=totalL/#hslColors
    contrastL=1-avgL
    R,G,B=HSLToRGB(avgH,1,contrastL)
    return {R,G,B}
end