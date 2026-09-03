-- source: steam id 2790345070 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
S=screen
M=math

dTx=S.drawText
dCF=S.drawCircleF
dL=S.drawLine
sC=S.setColor

iN=input.getNumber

pN=property.getNumber
pB=property.getBool

e=1

function onTick()
	z=iN(9)
	e=iN(10)
	h=iN(13)*2*M.pi
	v=iN(14)
	id=iN(15)
	egg=pN("Velocity Vector Exaggeration Factor")
	
	x,y=map.mapToScreen(iN(7),iN(8),iN(9),iN(1),iN(2),iN(11),iN(12))
	if id<0 or id>0 then
		ID=string.format("%.2f",id)
	else
		ID=""
	end
end

function onDraw()
	sC(pN("Object Color R"),pN("Object Color G"),pN("Object Color B"))
	dCF(x,y,3)
	dTx(x+4,y+4,property.getText("Object Label")..ID)
	if pB("Show Velocity Vector") then
		if not pB("Don't Scale Velocity Vector With Map") then
			v=v*e
		end
		x1=x-M.sin(h)*v*egg
		y1=y-M.cos(h)*v*egg
		dL(x,y,x1,y1)
		dL(x1,y1,x1-M.sin(h+M.pi*-3/4)*4,y1-M.cos(h+M.pi*-3/4)*4)
		dL(x1,y1,x1-M.sin(h+M.pi*3/4)*4,y1-M.cos(h+M.pi*3/4)*4)
	end
end