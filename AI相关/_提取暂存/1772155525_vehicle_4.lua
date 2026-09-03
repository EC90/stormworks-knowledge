-- source: steam id 1772155525 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1772155525
rays={250,500,1000,1500,2000} -- Zoom Values, you can add, change or remove values
ray=3 -- Default Value to select in rays
rAl=.15 -- Alarm Trigger Range (Default 0.15)

-- DO NOT MODIFY LINES BELOW (Until you know what you are doing.)

t={}
clock=true
c=0
init=false

function onTick()
	gN,sN,gB,sB=input.getNumber,output.setNumber,input.getBool,output.setBool
	sB(2,On)
	sB(20,gN(16)>0)
	if gN(10) == nil then return end
	rot=gN(10)%1
	if not gB(15) then
		c=0
		On=false
		return false
	end
	if gB(15) and not On and not chk then
		c=c+1
		if not chkRot then chkRot=rot
		else
			a=chkRot-rot
			if a>0 then a=a+1
			elseif a<0 then a=a-1 end
			if c<10 then chkRot=rot
			else
				clock=a>0
				chk=true
				On=true
			end
		end
		if not On then return end
	end
	On=gB(15)
	if not init then init,fxd,alrm,mR=true,gB(10),gN(14),gN(15) end
	sB(21,not clock)
	sN(3,gN(10))
	sN(4,gN(11))
	sN(5,gN(12))
	tK,zB=gB(1),gB(11)
	uiR=gB(12)
	if gB(13) and not zI then zmI=true end
	zI=gB(13)
	if gB(14) and not zO then zmO=true end
	zO=gB(14)
	w,h,tX,tY=gN(1),gN(2),gN(3),gN(4)
	mw,mh=w/2,h/2
	dis,vC,alti,tilt=gN(11),gN(12),gN(13),gN(17)
	r=(h/2)*.95
	len=r*.95
	if fxd then d,v=rot,vC else d,v=rot-vC,0 end
	ang=math.pi*((d+.25)%1)*2
	vang=math.pi*((v+0.25)%1)*2
	if alrm>2000 then alrm=2000 end
	if rays[ray]>2000 then rays[ray]=2000 end
	if dis<rays[ray] and dis>mR then table.insert(t,{rot,dis/rays[ray],rot%1,0}) end
	if alrm>0 and math.abs(vang-ang)<rAl and dis<alrm and dis>mR then sB(1,true)
	else sB(1,false) end
	if tK and not ltK then clkd=true end
	ltK=tK
	sN(1,((1/90)*(math.atan((alti+0.5)/rays[ray])*(180/math.pi)))+(tilt*4))
	sN(2,rays[ray])
end

function onDraw()
	if not On then return end
	sC,dT,dL,dRF,cos,sin=screen.setColor,screen.drawText,screen.drawLine,screen.drawRectF,math.cos,math.sin
	sC(0,0,0)
	screen.drawClear()
	sC(0,30,0)
	screen.drawCircle(w/2, h/2, r)
	sC(0,140,0)
	lx=mw+cos(ang)*len
	ly=mh-sin(ang)*len
	dL(mw, mh, lx, ly)
	for n,v in ipairs(t) do
		v[4]=v[4]+((v[3]-rot%1)%1)
		t[n][3]=rot%1
		t[n][4]=v[4]
		if fxd then d=v[1] else d=v[1]-vC end
		nAng=math.pi*((d+.25)%1)*2
		x1=mw+cos(nAng)*len*v[2]
		y1=mh-sin(nAng)*len*v[2]
		x2=mw+cos(nAng)*len
		y2=mh-sin(nAng)*len
		b=1-((v[1]-rot)%1)-.2
		if v[4]<1.1 then
			if v[4]<1 then
				if b<0 then b=0 end
				sC(0, 10, 0, 130*b)
				dL(x1, y1, x2, y2)
			end
			sC(0, 255, 0, 255*(1-v[4]/1.1))
			dL(x1, y1, x1+1, y1)
		else table.remove(t,n) end
	end
	if alrm>0 then
		sC(50,0,0,40)
		l=(alrm/rays[ray])
		if l>1 then l=1 end
		l=l*r
		ax=mw+cos(vang-rAl)*l
		ay=mh-sin(vang-rAl)*l
		bx=mw+cos(vang+rAl)*l
		by=mh-sin(vang+rAl)*l
		screen.drawTriangleF(mw, mh, ax, ay, bx, by)
	end
	sC(190,0,0,60)
	lx=mw+cos(vang)*len
	ly=mh-sin(vang)*len
	dL(mw, mh, lx, ly)
	sC(0, 140, 0)
	v=math.floor((1-vC%1)*360)
	if v<10 then v="00"..v
	elseif v<100 then v="0"..v end
	if w>h then
		s=rays[ray].."m"
		a={3,3}
		b={3,11,9,9}
		bT={12,20}
		bS={6,13}
		c={3,22,9,9}
		cT={12,31}
		cS={6,24}
		ciR=(w/2)-r
		dX=ciR-20
		dY=h/2-4
		dL(ciR,h/2,ciR-3,h/2)
		screen.drawRect(dX,dY,17,8)
		dT(dX+2,dY+2,v)
	else
		s=rays[ray]
		if zB then sL=string.len(s)*5;a={w-sL-1,1}
		else a={2,1} end
		b={1,2,5,5}
		bT={6,7}
		bS={2,2}
		c={1,8,5,5}
		cT={6,13}
		cS={2,8}
		dT(2,h-7,v)
	end
	if (zB and scrP(clkd,b[1],b[2],bT[1],bT[2])) or zmI then
		zmI=false
		clkd=false
		ray=ray-1
		t={}
		if ray<1 then ray=#rays end
	end
	if (zB and scrP(clkd,c[1],c[2],cT[1],cT[2])) or zmO then
		zmO=false
		clkd=false
		ray=ray+1
		t={}
		if ray>#rays then ray=1 end
	end
	if scrP(clkd,0,0,w,h) and not (zB and scrP(clkd,b[1],c[2],bT[1],cT[2])) then
		fxd = not fxd
		clkd=false
	end
	sC(70, 0, 0)
	if uiR then dT(a[1],a[2],s) end
	if zB then
		dRF(b[1],b[2],b[3],b[4])
		dRF(c[1],c[2],c[3],c[4])
		sC(0,0,0)
		dT(bS[1],bS[2],"+")
		dT(cS[1],cS[2],"-")
	end
end

function scrP(k,x,y,x2,y2)
	return tX>=x and tX<=x2 and tY>=y and tY<=y2 and k
end