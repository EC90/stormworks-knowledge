-- source: steam id 3788946785 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785
FONT=property.getText("FONT1")..property.getText("FONT2") FONT_D={} FONT_S=0 for n in FONT:gmatch("....")do FONT_D[FONT_S+1]=tonumber(n,16)FONT_S=FONT_S+1 end function dt(x,y,t,s,r,m)s=s or 1 r=r or 1 if r>2then t=t:reverse()end t=t:upper()for c in t:gmatch(".")do ci=c:byte()-31if 0<ci and ci<=FONT_S then for i=1,15 do if r>2 then p=2^i else p=2^(16-i)end if FONT_D[ci]&p==p then xx,yy=((i-1)%3)*s,((i-1)//3)*s if r%2==1then screen.drawRectF(x+xx,y+yy,s,s)else screen.drawRectF(x+5-yy,y+xx,s,s)end end end if FONT_D[ci]&1==1 and not m then i=2*s else i=4*s end if r%2==1then x=x+i else y=y+i end end end end

l=1
s=screen
mc=math.cos
ms=math.sin
pi=math.pi
pi2=pi*2
ma=math.abs
mq=math.sqrt
mstm=map.screenToMap
drf=screen.drawRectF
dr=screen.drawRect
dtf=screen.drawTriangleF
sc=screen.setColor
iN=input.getNumber
iB=input.getBool
pB=property.getBool
pN=property.getNumber
oN=output.setNumber
oB=output.setBool
rr=pN("Radar Range")
sr=pN("Sonar Type")
z=math.min(math.max(rr,sr)*2/1000,50)
son=(sr>0)
mm=pN("Default Map Mode")
dm=pB("Display")
B={{title={"R","R"},x=-6,y=1,w=5,h=7,t=0,p=0},{title={"+","+"},x=-6,y=16,w=5,h=7,t=0,p=0},{title={"-","-"},x=-6,y=24,w=5,h=7,t=0,p=0},{title={"1","2","3"},x=1,y=1,w=5,h=7,t=mm,p=0}}if son then table.insert(B,{title={"S","P","A"},x=-12,y=1,w=5,h=7,t=0,p=0})end
function onTick()
	t=iB(1) or iB(2)
	dark=iB(3)
	w=iN(1)cx=w/2-.5
	h=iN(2)cy=h/2
	tx=iN(3)
	ty=iN(4)
	gx=iN(5)
	gy=iN(6)
	ba=iN(7)*pi2
	for i,v in pairs(B) do
		if v.x<0 then v.x=w+v.x end
		if v.y<0 then v.y=h+v.y end
		if v.w<0 then v.w=w+v.w end
		if v.h<0 then v.h=h+v.h end
		if t then
			if tx>v.x and tx<v.x+v.w and ty>v.y and ty<v.y+v.h then
				v.p=1
				if t and not last_t then
					if i<2 then v.t=(v.t+1)%2 end
					if i>=4 then
						v.t=(v.t+1)%3
					end
				end
			end
		else
			v.p=0
		end
	end
	if z>1 and B[2].p>0 then z=z-z/170 elseif z<math.max(rr,sr)*2/1000 and z<50 and B[3].p>0 then z=z+z/170 end
	if l*w/z>h/4 then l=l/2 elseif l*w/z<h/8 then l=l*2 end
	last_t=t
	oB(2,B[1].t>0)
	oN(1,z)oN(2,l)oN(3,B[4].t+1)
	if son then
		oN(4,B[5].t) 
		oB(3,B[5].t==2)
		oB(4,B[5].t==1)
	end
end
function onDraw()
	r=cy+1
	r2=r*10/z
	if B[4].t<2 then
	sc(50,50,50,50)
	else
	sc(50,50,50,50)
	end
	for i=1,5 do
	s.drawCircle(cx,cy,i*l*w/z)
	end
	for i=1,8 do
		x1=cx+(l*w/z)*mc(0.125*i*pi2)
		y1=cy+(l*w/z)*ms(0.125*i*pi2)
		x2=cx+(r+w)*mc(0.125*i*pi2)
		y2=cy+(r+w)*ms(0.125*i*pi2)
		s.drawLine(x1,y1,x2,y2)
	end
	if dm then
	sc(7,7,7)
	for i=1,h do
		x=cx+r*mc((i/h)*pi2)
		y=cy+r*ms((i/h)*pi2)
		x1=cx+r*mc((i/h-1/h)*pi2)
		y1=cy+r*ms((i/h-1/h)*pi2)
		if x>cx then x2=w else x2=0 end
		if y>cy then y2=h else y2=0 end
		dtf(x,y,x1,y1,x2,y2)
	end
	dtf(0,0,w,0,cx,(h-2*r)/2)
	dtf(w,0,w,h,w-(w-2*r)/2-1,cy)
	dtf(w,h,0,h,cx,h-(h-2*r)/2-1)
	dtf(0,h,0,0,(w-2*r)/2,cy)
	end
	
	if B[4].t==2 then
		ba=0
	end
	x1=cx-4*ms(ba)
	y1=cy-4*mc(ba)
	x2=cx+4*ms(ba-.65)
	y2=cy+4*mc(ba-.65)
	x3=cx+4*ms(ba+.65)
	y3=cy+4*mc(ba+.65)
	if dark then sc(100,100,100) else sc(10,10,10) end
	dtf(x1,y1,x2,y2,x3,y3)
	for i,v in pairs(B) do
		sc(100,100,100)
		if v.p>0 then sc(30,30,30) end
		--if v.title=="" and v.t>0 then sc(100,50,0) end
		drf(v.x,v.y,v.w,v.h)
		sc(10,10,10)
		if v.t>0 then sc(100,50,0) end
		j=1
		if v.x>20 and (w<65 or w>97) then
			j=1
		end
		dt(v.x+j,v.y+1,v.title[v.t+1])
	end
		if w>32 then
		sc(100,100,100)
		drf(1,h-2,l*h/z,1)
		if l<1 then lt=math.floor(l*1000) .. "M"
		else lt=math.floor(l) .. "KM" end
		dt(1,h-8,lt)
	end
end