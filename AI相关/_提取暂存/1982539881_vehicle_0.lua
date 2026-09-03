-- source: steam id 1982539881 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1982539881
ra=0sa=0sp=0R={}
s=screen
mc=math.cos
ms=math.sin
pi=math.pi
pi2=pi*2
ma=math.abs
mq=math.sqrt
drf=screen.drawRectF
dt=screen.drawText
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
df=pN("Detection Filter")
M={60500,266.5,500,517.3,703.6,1143.5,1151.5,1349,1364.7,1502.7,1795.7,1813.4,1869.6,1064.6,25,50,2500,}
function onTick()
	t2=iB(1)
	t1=iB(2)
	dark=iB(3)
	rT=iB(4)
	sT=iB(5)
	w=iN(1)cx=w/2
	h=iN(2)cy=h/2
	z=iN(5)
	l=iN(6)
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
	mm=iN(16)
	if mm==3 then
		mma=ba
		mmc=80
	else
		mma=0
		mmc=0
	end
	if rT then
		if rd>df then
			rla=ra*pi2-ba
			R[rla]={f=1,a=(-ra-.5)*pi2+ba,x=gX+rd*ms(rla),y=gY+rd*mc(rla),t=400,d=rd,m=0,h=rh,tg=false}
		end
	end
	if sT then
		sp=sp+0.005 if sp>=1 then sp=0 end
		sa=sa+0.003 if sa>=0.5 then sa=-0.5 end
		if sd>df then
			for i,v in pairs(M) do
				if math.abs(math.floor(sd*sss*10)/10-v)<=.1 then
					if i==1 then mdf="meg"
					elseif i<=13 then mdf="shrk"
					elseif i==14 then mdf="krak"
					elseif i==15 then mdf="npc"
					elseif i==16 then mdf="crte"
					elseif i==17 then mdf="whle"
					end
				end
			end
			sla=sa*pi2-ba
			R[sla]={f=2,a=(-sa-.5)*pi2+ba,x=gX+sd*ms(sla),y=gY+sd*mc(sla),t=400,d=sd,m=sd*sss,mdf=mdf,h=sh,tg=false}
			mdf=nil
		end
	end
	for i,v in pairs(R) do
		if mm==3 then
			x=cx+(v.d*h/(z*1000))*ms(v.a-ba)
			y=cy+(v.d*h/(z*1000))*mc(v.a-ba)
		else
			x,y=map.mapToScreen(gX,gY,z,w,h,v.x,v.y)
		end
		if t2 and tx>x-2 and tx<x+2 and ty>y-2 and ty<y+2 then R[i].tg=true return else R[i].tg=false end
		if v.f==1 then
			if v.t>0 then R[i].t=v.t-1 else R[i]=nil end
			if not rT then R[i]=nil end
		else
			if v.t>0 and (v.t<400 or math.abs((v.d*cy/(500*z))-(sr*cy/(500*z))*sp)<5) then R[i].t=v.t-1 else R[i]=nil end
			if not sT then R[i]=nil end
		end
	end
	oN(1,-1*sa)
end
function onDraw()
	for i,v in pairs(R) do
		if mm==3 then
			x=cx+(v.d*h/(z*1000))*ms(v.a-ba)
			y=cy+(v.d*h/(z*1000))*mc(v.a-ba)
		else
			x,y=map.mapToScreen(gX,gY,z,w,h,v.x,v.y)
		end
		if mq((x-cx)^2+(y-cy)^2)<cy then
			alpha=255*v.t/400
			if v.f==1 then sc(0,255,0,alpha) else sc(0,0,255,alpha) end
			if v.mdf then
				if v.mdf=="shrk" then sc(255,127,0,alpha) elseif v.mdf=="meg" or v.mdf=="krak" then sc(255,0,0,alpha) end
			end
			s.drawCircleF(x,y,1)
		end
	end
	for i,v in pairs(R) do
		if v.tg then
			if mm==3 then
				x=cx+(v.d*h/(z*1000))*ms(v.a-ba)
				y=cy+(v.d*h/(z*1000))*mc(v.a-ba)
			else
				x,y=map.mapToScreen(gX,gY,z,w,h,v.x,v.y)
			end
			strg=""
			if v.mdf then strg=strg.. "" .. v.mdf .. "\n" end
			if v.m>0 then strg=strg.."M=".. math.floor(v.m) .."\n" end
			if v.h~=0 then strg=strg.."A=".. math.floor(v.h) end
			sc(100,100,100)
			dt(x+2,y+2,strg)
		end
	end
	if sT then
		u=20
		for i=1,u do
			sc(0,50,150,(28+mmc)*(u-i)/u)
			f=(sr*cy/(500*z))*sp-i/3
			if f<0 then f=0 elseif f>cy then f=cy end
			s.drawCircle(cx,cy-1,f)
		end
	end
	if rT then
		u=45
		f=cy
		for i=1,u do
			rla1=(ra+.5-(i-1)/360)*pi2-ba+mma
			rx2=cx+f*ms(-rla1)
			ry2=cy+f*mc(-rla1)
			rla2=(ra+.5-i/360)*pi2-ba+mma
			rx3=cx+f*ms(-rla2)
			ry3=cy+f*mc(-rla2)
			sc(0,100,0,(85+mmc)*(u-i)/u)
			dtf(cx,cy,rx2,ry2,rx3,ry3)
		end
	end
end