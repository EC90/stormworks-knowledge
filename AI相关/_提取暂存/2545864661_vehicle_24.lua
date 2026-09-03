-- source: steam id 2545864661 / vehicle.xml block#24
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2545864661
pi2=math.pi*2
pi=math.pi
atan=math.atan
sin=math.sin
cos=math.cos
dis=0
Olosh=0
Olosv=0
Od1losh=0
Od1losv=0
Odis=0
strgz=0
pcc=0
pco=false
trgx=0
trgy=0
trgz=0
t=0
nodata=0
function pid(p,i,d)
	return{p=p,i=i,d=d,E=0,D=0,I=0,
		run=function(s,sp,pv)
			local E,D,A
			E = sp-pv
			D = E-s.E
			A = math.abs(D-s.D)
			s.E = E
			s.D = D
			s.I = A<E and s.I +E*s.i or s.I*0.5
			return E*s.p +(A<E and s.I or 0) +D*s.d
		end
	}
end
pidPitch=pid(0.05, 0, 7.5)
function cl(x,mi,ma)
 return ma<x and ma or mi>x and mi or x
end
function atan2(y,x)
	if x>0 then
		a=atan(y/x)
	elseif x<0 and y>=0 then
		a=atan(y/x)+pi
	elseif x<0 and y<0 then
		a=atan(y/x)-pi
	elseif x==0 and y>0 then
		a=pi/2
	elseif x==0 and y<0 then
		a=-pi/2
	elseif x==0 and y==0 then
		a=0
	else
		a=0
	end
	return(a)	
end
depthOffset = math.abs(property.getNumber("Depth Offset"))
function onTick()
	launch=input.getBool(1)
	if launch then
		t=t+1
	end
	gpx=input.getNumber(4)
	gpy=input.getNumber(5)
	gpz=input.getNumber(6)
	setmass=input.getNumber(7)
	hdg=input.getNumber(8)
	mass=input.getNumber(9)
	np=property.getNumber("N pitch")
	ny=property.getNumber("N yaw")
	if setmass==0 and mass==0 and t>30 and nodata==0 then
		trgx=gpx+cos(-(hdg-0.25)*pi2)*3000
		trgy=gpy+sin(-(hdg-0.25)*pi2)*3000
		trgz=-1.5
		nodata=1
	elseif t>31 and nodata==0 then
		trgx=input.getNumber(1)
		trgy=input.getNumber(2)
		trgz=input.getNumber(3) - depthOffset
	end
	if mass~=0 then 
		nodata=0
	end
	trgz=cl(trgz,-999,-1)
	xdif=trgx-gpx
	ydif=trgy-gpy
	zdif=trgz-gpz
	dis=math.sqrt(xdif^2+ydif^2)
	losh=atan2(xdif,ydif)/pi2

	d1losh=losh-Olosh
	d2losh=d1losh-Od1losh
	ddis=dis-Odis
	eta=dis/ddis

	if dis<500 then
		ny=ny/4
		np=np/8
		yaw=cl(ny*d1losh,-0.3,0.3)
	else
		yaw=ny*d1losh
	end
	if launch then
		pitch=-pidPitch:run(trgz,gpz)
	else
		pitch = 0
	end
	Olosh=losh
	Od1losh=d1losh
	Odis=dis
	
	output.setNumber(1,yaw)
	output.setNumber(2,pitch)
	output.setNumber(3,dis)
	output.setNumber(4,math.abs(eta/60))
	output.setNumber(6,trgx)
	output.setNumber(7,trgy)
	output.setNumber(8,trgz)
	output.setBool(1,dis < 10 and dis > 0.1 and property.getBool("Damage type"))
end
