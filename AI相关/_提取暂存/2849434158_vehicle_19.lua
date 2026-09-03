-- source: steam id 2849434158 / vehicle.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2849434158
FrSize=10

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
sc=screen
sC=sc.setColor
dT=sc.drawText
dL=sc.drawLine
dR=sc.drawRect
dRF=sc.drawRectF
dL=sc.drawLine
dT=sc.drawText
fo=string.format

function quant(x,a)
	return m.floor(x/a)*a
end
function dFrame(x,y,r,k)
	for i=-1,1,2 do
		for j=-1,1,2 do
			dL(x+i*r,y+j*r,x+k*i*r,y+j*r)
			dL(x+i*r,y+j*r,x+i*r,y+k*j*r)
		end
	end
end
function TGTScreenPos(T)
	if m.abs(T[2])<pi/2 and m.abs(T[3])<pi/2 then
		x,y=w2+h2*t(T[2])/t(VA/2),h2-h2*t(T[3])/t(VA/2)
		size=m.max(m.min(h2*(FrSize/2)/(T[1]*c(T[2])*t(VA/2)),10),3)
	else
		x,y,size=nil,nil,nil
	end
	return x,y,size
end
function dTGT(T)
	x,y,size=TGTScreenPos(T)
	if size~=nil then
		dFrame(x,y,size,0.5)
		dT(quant(x,4)-12,quant(y,4)+size+1,fo("%4.0f",T[1]))
	end
end

SelN=4
KEYp,LASp,RADp={0,0,0},{0,0,0},{0,0,0}

function onTick()
	for i=1,3 do
		KEYp[i]=iN(8+i)
		LASp[i]=iN(11+i)
		RADp[i]=iN(14+i)
	end
	SelN=iN(18)
	VA=iN(19)
	
	KDet=iB(1)
	LDet=iB(2)
	RDet=iB(3)
	
	
end

function onDraw()
	w=sc.getWidth()
	h=sc.getHeight()
	w2,h2=w/2,h/2
	if KDet then
		if SelN==1 then
			sC(255,255,0,255)
		else
			sC(255,255,255,195)
		end
		dTGT(KEYp)
	end
	
	if LDet then
		if SelN==2 then
			sC(255,255,0,255)
		else
			sC(255,255,255,195)
		end
		dTGT(LASp)
	end
	
	if RDet then
		if SelN==3 then
			sC(255,255,0,255)
		else
			sC(255,255,255,195)
		end
		dTGT(RADp)
	end
end