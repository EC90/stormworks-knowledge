-- source: steam id 3794583580 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794583580
vvSiz=2
pi=math.pi
pi2=2*pi
inN=input.getNumber
inB=input.getBool
s=math.sin
c=math.cos
t=math.tan
at=math.atan
abs=math.abs
min=math.min
drawT=screen.drawText
drawL=screen.drawLine
drawR=screen.drawRect
setC=screen.setColor
form=string.format
function sgn(x)
	if x==0 then return 0
	else return x/abs(x)
	end
end
function devAng(q,q0,qt,cw)
	return -cw*(q-q0+(1-qt))%1-(1-qt)
end
function rotV2Z(x,y,qz)
	qz=qz*pi2
	return x*c(qz)-y*s(qz),x*s(qz)+y*c(qz)
end
function drawLineP(x,y,lenO,lenI,angP,angR,angL,label)
	capL=3
	hP=r*t(angP*pi2)
	if angL<0 then spaceN=3 else spaceN=0 end
	for i=0,spaceN do
		int=(lenO-lenI)/(4*spaceN+2)
		xl1,yl1=rotV2Z(-lenO/2+int*2*i,-hP,-angR)
		xl2,yl2=rotV2Z(-lenO/2+int*(2*i+1),-hP,-angR)
		xr1,yr1=rotV2Z(lenO/2-int*2*i,-hP,-angR)
		xr2,yr2=rotV2Z(lenO/2-int*(2*i+1),-hP,-angR)
		drawL(x+xl1,y+yl1,x+xl2,y+yl2)
		drawL(x+xr1,y+yr1,x+xr2,y+yr2)
		if i==0 then
			xcl,ycl=rotV2Z(-lenO/2,-hP+sgn(angL)*capL,-angR)
			xcr,ycr=rotV2Z(lenO/2,-hP+sgn(angL)*capL,-angR)
			drawL(x+xl1,y+yl1,x+xcl,y+ycl)
			drawL(x+xr1,y+yr1,x+xcr,y+ycr)
		end
		if label then
			xang,yang=rotV2Z(sgn(vtilt)*(lenO/2+3),-hP-sgn(vtilt)*2,angR)
			drawT(x-xang-11,y+yang,form("%3.0f",angL*360))
		end
	end
end

function onTick()
	altunit=inN(11)
	alt=inN(1)*altunit
	Vunit=inN(12)
	dirV=inN(2)*Vunit
	horV=inN(3)*Vunit
	verV=inN(4)*Vunit
	rol0=inN(5)
	pit0=inN(6)
	vtilt=inN(7)
	rol=rol0-min(0,sgn(vtilt))*(sgn(rol0)*0.5-2*rol0)
	pit=math.asin(s(pit0*pi2)/c(rol*pi2))/pi2
	comp=devAng(inN(8),0,1,1)

	r=inN(13)
	ladSc=inN(14)
	cOpt=inN(15)
	pitInt=math.max(inN(17),1)
	dNumP=math.floor(360/pitInt)
	ss=inB(3)
	sl=inB(4)
	as=inB(5)
	al=inB(6)
	cs=inB(7)
	cl=inB(8)
	vv=inB(9)
	ll=inB(10)
	absV=(dirV^2+horV^2+verV^2)^0.5
	vP0=(50/3.6)*Vunit	--vv display switch velocity
	vH0=(1/3.6)*Vunit	--vv circle position velocity
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()	

--pitch ladder
	if cOpt == 0 or cOpt == 1 then setC(0, 255, 0) elseif cOpt == 2 then setC(255, 255, 255) end
	for i=1,dNumP do
		angDisp=devAng((i-1)/dNumP,0,0.5,-1)
		angi=devAng(angDisp-pit,0,0.5,-1)
		if cs then lRangeB=-at((h/2-17)/r)/pi2 elseif cl then lRangeB=-at((h/2-9)/r)/pi2 else lRangeB=-at((h*3/4)/r)/pi2 end
		lRangeU=at((h/2)/r)/pi2
		if angi>lRangeB and angi<lRangeU then
			drawLineP(w/2,h/2,w*ladSc,w*ladSc/2,angi,rol,angDisp,ll)
		end
	end
	
--velocity vector
	if vv then
		if abs(dirV)>vP0 then
			vvx=w/2+r*horV/dirV
			vvy=h/2-r*verV/dirV
			screen.drawCircle(vvx,vvy,vvSiz)
			drawL(vvx+vvSiz,vvy,vvx+vvSiz*3,vvy)
			drawL(vvx-vvSiz,vvy,vvx-vvSiz*3,vvy)
			drawL(vvx,vvy-vvSiz,vvx,vvy-vvSiz*2)
		else
			vvx=w/2--+r*horV/v0
			vvy=h/2---r*verV/v0
			screen.drawCircleF(vvx,vvy,vvSiz)
			screen.drawCircle(vvx,vvy,vvSiz*2)
			fpmRad=(dirV^2+horV^2)^0.5/vH0*2*vvSiz
			fpmAng=at(dirV/horV)/pi2
			fpmx=vvx+horV/vH0
			fpmy=vvy-dirV/vH0
			drawL(vvx,vvy,fpmx,fpmy)
		end
	end
end