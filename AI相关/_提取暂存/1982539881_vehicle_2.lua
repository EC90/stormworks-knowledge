-- source: steam id 1982539881 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1982539881
l=1R={}
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
dtb=screen.drawTextBox
dt=screen.drawText
dtf=screen.drawTriangleF
sc=screen.setColor
iN=input.getNumber
iB=input.getBool
pB=property.getBool
pN=property.getNumber
oN=output.setNumber
oB=output.setBool
h=math.floor(pN("Display")) cy=h/2
w=(pN("Display")-h)*1000 cx=w/2
rr=pN("Radar Range")
z=rr*2/1000
sr=pN("Sonar Type")
df=pN("Detection Filter")
mm=pN("Default Map Mode")
son=pB("Sonar")
B={{title="V",x=1,y=h-8,w=12,h=7,p=false,t=not pB("Buzzer")},{title="R",x=1,y=1,w=6,h=7,p=false,t=pB("Radar at spawn")},{title="+",x=w-12,y=h-8,w=5,h=7,p=false,t=false},{title="-",x=w-6,y=h-8,w=5,h=7,p=false,t=false},{title="M",x=14,y=h-8,w=6,h=7,p=false,t=false}}
if son then table.insert(B,{title="S",x=8,y=1,w=6,h=7,p=false,t=pB("Sonar at spawn")})end
function onTick()
	t2=iB(1)
	t1=iB(2)
	rT=iB(3)
	dark=iB(3)
	tx=iN(3)
	ty=iN(4)
	gX=iN(7)
	gY=iN(8)
	ba=iN(9)
	rd=iN(10)
	ra=iN(11)
	sd=iN(12)
	sss=iN(13)
	sh=iN(14)
	rh=iN(15)
	for i,v in pairs(B) do
		if t2 then
			if tx>v.x and tx<v.x+v.w and ty>v.y and ty<v.y+v.h then
				B[i].p=true
				if t1 then
					B[i].t=not v.t
					B[3].t=false
					B[4].t=false
					B[5].t=false
					end
				end
			else
				B[i].p=false
			end
		end
		rT=B[2].t dw=B[3].p up=B[4].p
		if son then sT=B[6].t end
	zs=z/170
	if z>1 and dw then z=z-zs elseif z<rr*2/1000 and z<50 and up then z=z+zs end
	if l*h/z>h/3 then l=l/2 elseif l*h/z<h/6 then l=l*2 end
	if B[5].p and t1 then
		mm=mm+1
		if mm>3 then mm=1 end
	end
	oB(1,B[1].t and (rT or sT) and (rd>df or sd>df))
	oB(2,rT)
	if son then oB(3,sT) end
	oN(1,z)oN(2,l)oN(3,mm)
end
function onDraw()
	if mm==3 then
		ba=0
	end
	x1=cx-3*ms(ba)
	y1=cy-3*mc(ba)
	x2=cx-4*ms(ba-10)
	y2=cy-4*mc(ba-10)
	x3=cx-4*ms(ba+10)
	y3=cy-4*mc(ba+10)
	if dark then sc(100,100,100) else sc(10,10,10) end
	dtf(x1,y1,x2,y2,x3,y3)
	for i,v in pairs(B) do
		if v.title=="V" then
			sc(100,100,100)
			drf(v.x,v.y,v.w,v.h)
			sc(10,10,10)
			dtf(v.x+1,v.y+4,v.x+6,v.y+1,v.x+6,v.y+7)
			if v.t then dt(v.x+7,v.y+1,"<") else dt(v.x+7,v.y+1,"X") end
		else
			sc(100,100,100)
			if v.p then sc(10,10,10) end
			if v.title=="" and v.t then sc(100,50,0) end
			drf(v.x,v.y,v.w,v.h)
			sc(10,10,10)
			if v.t then sc(100,50,0) end
			j=1
			if v.x>20 and (w<65 or w>97) then
				j=2
			end
			dt(v.x+j,v.y+1,v.title)
		end
	end
	if w>32 then
		sc(100,100,100)
		drf(w-1,1,-l*h/z,1)
		if l<1 then lt=math.floor(l*1000) .. "M"
		else lt=math.floor(l) .. "KM" end
		dt(w-5*#lt,3,lt)
	end
end