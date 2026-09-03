-- source: steam id 2892569502 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2892569502
igN = input.getNumber
igB = input.getBool
ssC = screen.setColor
sdL = screen.drawLine
sdC = screen.drawCircle
sdR = screen.drawRect
sdRF= screen.drawRectF
sdTF = screen.drawTriangleF
sdCF = screen.drawCircleF
sdT = screen.drawText
stf = string.format
sts = string.sub
sin,cos = math.sin,math.cos
pi = 3.141592
dtr=pi/180
function sdA(x,y,r,th1,th2,R,G,B)
	ssC(R,G,B)
	for i=th1,th2-10,10 do
		sdL(x-r*cos(dtr*i),y-r*sin(dtr*i),x-r*cos(dtr*(i+10)),y-r*sin(dtr*(i+10)))
	end
end
function sdAF(x,y,r,th1,th2,R,G,B)
	ssC(R,G,B)
	for j=1,r,0.5 do
		for i=th1,th2-10,10 do
			sdL(x-j*cos(dtr*i),y-j*sin(dtr*i),x-j*cos(dtr*(i+10)),y-j*sin(dtr*(i+10)))
		end
	end
end
function sdS(x,y,r,th1,th2,scale,R,G,B)
	ssC(R,G,B)
	r1,r2,r3=r-1,r-2,r-3
	for i=th1,th2,30 do
		sdL(x-r*cos(dtr*i),y-r*sin(dtr*i),x-r3*cos(dtr*i),y-r3*sin(dtr*i))
	end
	ssC(R,G,B,150)
	if scale>1 then
		for i=th1,th2-30,30/scale do
			sdL(x-r1*cos(dtr*i),y-r1*sin(dtr*i),x-r2*cos(dtr*i),y-r2*sin(dtr*i))
		end
	end
end
function drawTemp(x,y)
	sdL(x+1,y+1,x+3,y+1)
	sdL(x+1,y,x+1,y+5)
	sdL(x,y+3,x+3,y+3)
end
function drawFuel(x,y)
	sdR(x,y,2,3)
	sdRF(x,y+2,3,3)
end
function drawBat(x,y)
	sdR(x,y+1,4,3)
	sdL(x+1,y,x+1,y+1)
	sdL(x+3,y,x+3,y+1)
end
function drawPark(x,y)
	sdT(x,y,"(")
	sdT(x+3,y,"P")
	sdT(x+5,y,")")
end
function drawEmer(x,y)
	sdT(x,y,"(")
	sdT(x+3,y,"!")
	sdT(x+5,y,")")
end
function drawFGLT(x,y)
	sdT(x+4,y,"D")
	sdL(x+1,y,x+1,y+5)
	sdL(x,y+1,x+3,y+1)
	sdL(x,y+3,x+3,y+3)
end
function drawSPLT(x,y)
	sdT(x+4,y,"D")
	sdL(x,y,x+3,y)
	sdL(x,y+2,x+3,y+2)
	sdL(x,y+4,x+3,y+4)
end
function drawDoor(x,y)
	sdR(x+2,y,3,4)
	sdL(x+3,y,x-1,y+4)
	sdL(x+4,y,x+8,y+4)
	sdL(x+3,y+1,x+5,y+1)
	sdL(x+3,y+4,x+5,y+4)
end
function dLTR(x,y)
	sdRF(x,y+1,4,3)
	sdL(x+2,y+2,x+5,y+2)
	sdL(x+2,y,x+2,y+5)
end
function dLTL(x,y)
	sdRF(x,y+1,4,3)
	sdL(x+1,y+2,x-2,y+2)
	sdL(x+1,y,x+1,y+5)
end
function onTick()
	fue,bat,ent,gea,fum=igN(23),igN(24),igN(21),igN(19),igN(20)
	park,ltdr,ltL,ltR,ltsp,ltem,ltfg= igB(15),igB(16),igB(17),igB(18),igB(19),igB(25),igB(20)
	drS,drF,drB=igB(26),igB(27),igB(28)
aent=ent/120
afue=fue/fum
ltdr = drS or drF or drB
end
function onDraw()
w,h,wh,hh=96,32,48,16
ssC(8,8,8,32)
--screen.drawClear()
sdRF(0,0,w,h)
ssC(4,4,4)
drawPark(w-11,17)
drawEmer(w-9,24)
drawBat(12,3)
drawDoor(7,10)
drawSPLT(4,17)
drawFGLT(2,24)
dLTL(21,1)
dLTR(w-25,1)
drawFuel(wh-3,12)
drawTemp(wh+1,12)
sdCF(wh-17,21,10)
sdCF(wh+17,21,10)
sdCF(wh,13,10)
--bigblueshadow
sdA(wh-17,21,9.5,-45,135,0,24,36)
sdA(wh+17,21,9.5,0,135,0,24,36)
--bigredshadow
sdA(wh-17,21,9.5,135,180,36,6,12)
sdA(wh+17,21,9.5,135,225,36,6,12)
sdA(wh,13,9.5,0,180,0,24,36)
sdA(wh,13,7.5,-10,60,0,24,36)
sdA(wh,13,7.5,120,190,0,24,36)
sdA(wh,13,7.5,60,80,36,6,12)
sdA(wh,13,7.5,100,120,36,6,12)
--bigblue
sdA(wh-17,21,10,-45,135,0,75,225)
sdA(wh+17,21,10,0,135,0,75,225)
--bigred
sdA(wh-17,21,10,135,180,233,22,33)
sdA(wh+17,21,10,135,225,233,22,33)
sdA(wh,13,10,0,180,0,75,225)
sdA(wh,13,8,-10,60,0,75,225)
sdA(wh,13,8,120,190,0,75,225)
sdA(wh,13,8,60,80,233,22,33)
sdA(wh,13,8,100,120,233,22,33)
sdS(wh-17,21,10,-45,135,1,0,75,225)
sdS(wh-17,21,10,135,180,1,233,22,33)
sdS(wh+17,21,10,0,135,1,0,75,225)
sdS(wh+17,21,10,135,225,1,233,22,33)
ssC(200*(1-afue)+22,218*afue+15,22+33*afue)
drawFuel(wh-3,11)
ssC(200*aent+22,218*(1-aent)+15,22+33*(1-aent))
drawTemp(wh+1,11)
ssC(222,15,22)
if park then drawPark(w-11,16) end
if ltem then drawEmer(w-9,23) end
if ltdr then drawDoor(7,9) end
if bat<0.25 then drawBat(12,2) end
ssC(22,233,55)
if ltfg then drawFGLT(2,23) end
if ltsp then drawSPLT(4,16) end
ssC(233,122,33)
if ltL then dLTL(21,0) end
if ltR then dLTR(w-25,0) end
end