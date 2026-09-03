-- source: steam id 2849434158 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2849434158
iN=input.getNumber
iB=input.getBool
m=math
pi=m.pi
pi2=2*pi
s=m.sin
c=m.cos
t=m.tan
min=m.min
max=m.max
at=m.atan
sc=screen
sC=sc.setColor
dT=sc.drawText
dL=sc.drawLine
dR=sc.drawRect
fo=string.format
tI=table.insert
tR=table.remove

function dL2(x,y,l,d)
	if d=="v" then
		dL(x,y,x,y+l)
	elseif d=="h" then
		dL(x,y,x+l,y)
	end
end
function dAng(q1,q2)
	return at(s(q1-q2),c(q1-q2))
end
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
VUnit=3.6
x1fov=0.5
x1VA=2.2-x1fov*(2.2-0.025)
setfov=false
	
function onTick()
	absV=iN(4)*VUnit
	compB=iN(8)
	compT=iN(12)
	fov=iN(20)
	if not setfov and fov~=0 then
		x1fov=fov
		x1VA=2.2-x1fov*(2.2-0.025)
		setfov=true
	end
	compR=-dAng(compT*pi2,compB*pi2)
	compT=-compT*360 if compT<0 then compT=compT+360 end
	
	--fov
	VA=2.2-fov*(2.2-0.025)
	mag=t(x1VA/2)/t(VA/2)

end

function onDraw()
	w=sc.getWidth()
	h=sc.getHeight()
	tX,tY=w-8,h-12
	tSc=3
	cSc=30
	sC(0,127,0)
--compass
	dL2(w/2,9,4,"v")
	dT(w/2-6,2,fo("%3.0f",compT))
	dR(w/2-8,0,17,8)
	for i=0,35 do
		if compT<180 and i*10>180 then
			xi=w/2+(i*10-compT-360)*(w/cSc)
		elseif compT>180 and i*10<180 then
			xi=w/2+(i*10-compT+360)*(w/cSc)
		else
			xi=w/2+(i*10-compT)*(w/cSc)
		end
		if xi>-10 and xi<w+10 then
			dL2(xi,8,6,"v")
			if xi<w/2-8-3 or xi>w/2+8+3 then
				dT(xi-3,2,i)
			end
		end
	end
--Speed
	dT(w-15,h/2-8,fo("%3.0f",absV))
	dT(w-15,h/2,"KPH")
--Magnification
	dT(1,h/2-8,"mag")
	if w>64 then
		MagFormat="%4.1f"
	else
		MagFormat="%2.0f"
	end
	dT(1,h/2,"X"..fo(MagFormat,mag))
--Reticle
	dL(w/2,h/2+4,w/2,h/2+6)
	dL(w/2+4,h/2,w/2+6,h/2)
	dL(w/2,h/2-4,w/2,h/2-6)
	dL(w/2-4,h/2,w/2-6,h/2)
--Turret
	dL2(tX+tSc,tY-tSc,2*tSc,"v")
	dL2(tX-tSc,tY+tSc,2*tSc,"h")
	dL2(tX-tSc,tY-tSc,2*tSc,"v")
	dL(tX-tSc,tY-tSc,tX,tY-tSc*2)
	dL(tX,tY-tSc*2,tX+tSc,tY-tSc)
	dL(tX,tY-tSc,tX+2*tSc*c(-compR+pi/2),tY-tSc-2*tSc*s(-compR+pi/2))
end