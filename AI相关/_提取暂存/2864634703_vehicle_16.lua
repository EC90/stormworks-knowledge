-- source: steam id 2864634703 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2864634703
ScaleLen=0.8

iN=input.getNumber
iB=input.getBool
oB=output.setBool
oN=output.setNumber
pN=property.getNumber
pB=property.getBool
m=math
pi=m.pi
pi2=2*pi
rads=pi/180
s=m.sin
c=m.cos
t=m.tan
at=m.atan
sc=screen
sC=sc.setColor
dL=sc.drawLine
dT=sc.drawText
fo=string.format

SigS=pB("Zoom Control Signal Source")
VAx1=pN("Default view angle (deg) (1.5~126.0)")*rads
ZS=pN("Zoom Sensitivity (Mag/s)")/60
ColS1="Display color "
ColS2=" (0~255)"
Col={}
for i,v in ipairs({"R","G","B"}) do
	Col[i]=pN(ColS1..v..ColS2)
end
MagSc=pB("Show Magnification Scale")

function Clamp(x,min,max)
	return m.max(min,m.min(max,x))
end
function VAtoFOV(va)
	return (2.2-va)/(2.2-0.025)
end
function VAtoMAG(va)
	return t(VAx1/2)/t(va/2)
end
function MAGtoFOV(mag)
	return (1.1-at(t(VAx1/2)/mag))/1.0875
end
function DrScaleLine(mag)
	pxY=ScA*m.log(mag)+ScC
	dL(ScX-2,pxY,ScX+2,pxY)
end
MagMIN,MagMAX=m.floor(VAtoMAG(2.2)/ZS)*ZS,m.ceil(VAtoMAG(0.025)/ZS)*ZS
Mag=1

function onTick()
	if SigS then
		c1=m.max(m.log(MagMAX),-m.log(MagMIN))
		Mag=m.exp(c1*iN(1))
	else
		ZI=iB(1)
		ZO=iB(2)
		if ZI then
			Mag=Clamp(Mag+ZS*Mag,MagMIN,MagMAX)
		end
		if ZO then
			Mag=Clamp(Mag-ZS*Mag,MagMIN,MagMAX)
		end
	end
	FOV=MAGtoFOV(Mag)
	
	oN(1,FOV)
	oN(2,Mag)
end
	
function onDraw()
	w=sc.getWidth()
	h=sc.getHeight()
	w2,h2=w/2,h/2
	
	--Magnification Label
	xl,yl=2,h2
	if MagSc then
		xl=xl+5
	end
	sC(Col[1],Col[2],Col[3],255)
	dT(xl,yl,"X"..fo("%4.1f",Mag))
	
	--Magnification Scale
	if MagSc then
		ScX,ScY=2,h2
		ScYMIN,ScYMAX=ScY+h*ScaleLen/2,ScY-h*ScaleLen/2
	
		ScA=(ScYMIN-ScYMAX)/(m.log(MagMIN)-m.log(MagMAX))
		ScC=ScYMIN-ScA*m.log(MagMIN)
	
		sC(Col[1],Col[2],Col[3],127)
		dL(ScX,ScYMIN,ScX,ScYMAX)
		sC(Col[1]/8,Col[2]/8,Col[3]/8,255)
		DrScaleLine(1)
		DrScaleLine(MagMIN)
		DrScaleLine(MagMAX)
		sC(Col[1],Col[2],Col[3],255)
		DrScaleLine(Mag)
	end
end