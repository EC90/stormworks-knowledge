-- source: steam id 2849434158 / vehicle.xml block#17
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2849434158
iB=input.getBool
iN=input.getNumber
oN=output.setNumber
oB=output.setBool
m=math
s=m.sin
c=m.cos
t=m.tan
as=m.asin
ac=m.acos
at=m.atan
pi=m.pi
pi2=2*pi
rads=pi/180
sc=screen
sC=sc.setColor
dT=sc.drawText
dL=sc.drawLine
dR=sc.drawRect
dL=sc.drawLine
dT=sc.drawText
fo=string.format

function quant(x,a)
	return m.floor(x/a)*a
end
function distV(V1,V2)
	_=0
	for i=1,3 do
		_=_+(V1[i]-V2[i])^2	
	end
	return _^0.5
end
function inPro(u,v)
	_=0
	for i=1,3 do
		_=_+u[i]*v[i]
	end
	return _
end
function outPro(u,v)
	w={}
	w[1]=u[2]*v[3]-u[3]*v[2]
	w[2]=u[3]*v[1]-u[1]*v[3]
	w[3]=u[1]*v[2]-u[2]*v[1]
	return w
end
function AngleToBasis(Q)
	ex={c(Q[1])*s(-Q[2]),c(Q[1])*c(-Q[2]),s(Q[1])}
	ey={c(Q[3])*s(-Q[4]),c(Q[3])*c(-Q[4]),s(Q[3])}
	ez=outPro(ex,ey)
	if m.abs(inPro(ex,ey))>0.1 then er=true else er=false end
	return {ex,ey,ez},er
end
function Mv(M,v)
	V={}
	for i=1,3 do
		_=0
		for j=1,3 do
			_=_+M[j][i]*v[j]
		end
		V[i]=_
	end
	return V
end
function inv(E)
	e1,e2,e3=E[1],E[2],E[3]
	a,b,C,d,e,f,g,h,i=e1[1],e2[1],e3[1],e1[2],e2[2],e3[2],e1[3],e2[3],e3[3]
	det=a*e*i+d*h*C+g*b*f-g*e*C-a*h*f-d*b*i
	E1={(e*i-f*h)/det,(f*g-d*i)/det,(d*h-e*g)/det}
	E2={(C*h-b*i)/det,(a*i-C*g)/det,(b*g-a*h)/det}
	E3={(b*f-C*e)/det,(C*d-a*f)/det,(a*e-b*d)/det}
	return {E1,E2,E3},det
end
function OrthToPol(VO)
	VP={}
	VP[1]=distV(VO,{0,0,0})
	VP[2]=at(VO[1],VO[2])
	VP[3]=as(VO[3]/VP[1])
	return VP
end
function dFrame(x,y,r,k)
	for i=-1,1,2 do
		for j=-1,1,2 do
			dL(x+i*r,y+j*r,x+k*i*r,y+j*r)
			dL(x+i*r,y+j*r,x+i*r,y+k*j*r)
		end
	end
end

TGT={}

function onTick()
	--Input
	PO={iN(4),iN(8),iN(12)}
	QO={iN(16)*pi2,iN(20)*pi2,iN(24)*pi2,iN(28)*pi2}
	fov=iN(32)
	BO,_=AngleToBasis(QO)
	bO,_=inv(BO)
	
	--Radar input
	for i=1,8 do
		if iB(i) then
			PTO={iN(i*4-3)-PO[1],iN(i*4-2)-PO[2],iN(i*4-1)-PO[3]}
			pTO=Mv(bO,PTO)
			TGT[i]=OrthToPol(pTO)
		else
			TGT[i]=nil
		end
	end
	
	--Calculate View Angle
	VA=2.2-fov*(2.2-0.025)
	
	--Closest target
	iClosest=0
	for i=1,8 do
		if TGT[i]~=nil then
			iAngDev2=TGT[i][2]^2+TGT[i][3]^2
			if i==1 or iAngDev2<MinAngDev then
				iClosest=i
				MinAngDev=iAngDev2
			end
		end
	end
	if iClosest~=0 then
		oN(1,iN(iClosest*4-3))
		oN(2,iN(iClosest*4-2))
		oN(3,iN(iClosest*4-1))
		oN(4,TGT[iClosest][1])
		oN(5,TGT[iClosest][2])
		oN(6,TGT[iClosest][3])
		oB(1,true)
	else
		oN(1,0)
		oN(2,0)
		oN(3,0)
		oN(4,0)
		oN(5,0)
		oN(6,0)
		oB(1,false)
	end
end

function onDraw()
	w=sc.getWidth()
	h=sc.getHeight()
	w2,h2=w/2,h/2
	
	--Show radar targets
	for i=1,8 do
		if TGT[i]~=nil then
			dtx,dty=w2+h2*t(TGT[i][2])/t(VA/2),h2-h2*t(TGT[i][3])/t(VA/2)
			--dtx,dty=w2+h2*t(TGT[i][2])/t(VA/2),h2-h2*t(TGT[i][3])/t(VA/2)
			fsize=m.max(m.min(h2*(10/2)/(TGT[i][1]*c(TGT[i][2])*t(VA/2)),10),3)
			if i==iClosest then
				--[[
				sC(255,255,0,195)
				dFrame(dtx,dty,fsize,0.5)
				fx,fy=quant(dtx,5),quant(dty,5)
				dT(w-30,h-5,"RD"..fo("%4.0f",TGT[i][1]))
				--]]
			else
				sC(255,255,255,195)
				dFrame(dtx,dty,fsize,0.5)
			end
		end
	end
end