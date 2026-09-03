-- source: steam id 3275884864 / vehicle.xml block#29
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
GN=input.getNumber
GB=input.getBool
S=screen
SC=S.setColor
DL=S.drawLine
DC=S.drawCircle
DR=S.drawRect
DRF= S.drawRectF
DTF=S.drawTriangleF
DCF=S.drawCircleF
DT=S.drawText
sin,cos=math.sin,math.cos
pi=math.pi
dtr=pi/180
function DA(x,y,r,th1,th2,R,G,B)
	SC(R,G,B)
	for i=th1,th2-10,10 do
		DL(x-r*cos(dtr*i),y-r*sin(dtr*i),x-r*cos(dtr*(i+10)),y-r*sin(dtr*(i+10)))
	end
end
function DAF(x,y,r,th1,th2,R,G,B)
	SC(R,G,B)
	for j=1,r,0.5 do
		for i=th1,th2-10,10 do
			DL(x-j*cos(dtr*i),y-j*sin(dtr*i),x-j*cos(dtr*(i+10)),y-j*sin(dtr*(i+10)))
		end
	end
end
function DS(x,y,r,th1,th2,scale,R,G,B)
	SC(R,G,B)
	r1,r2,r3=r-1,r-2,r-3
	for i=th1,th2,30 do
		DL(x-r*cos(dtr*i),y-r*sin(dtr*i),x-r3*cos(dtr*i),y-r3*sin(dtr*i))
	end
	SC(R,G,B,150)
	if scale>1 then
		for i=th1,th2-30,30/scale do
			DL(x-r1*cos(dtr*i),y-r1*sin(dtr*i),x-r2*cos(dtr*i),y-r2*sin(dtr*i))
		end
	end
end
function DTemp(x,y)
	DL(x+1,y+1,x+3,y+1)
	DL(x+1,y,x+1,y+5)
	DL(x,y+3,x+3,y+3)
end
function DFuel(x,y)
	DR(x,y,2,3)
	DRF(x,y+2,3,3)
end
function DBat(x,y)
	DR(x,y+1,4,3)
	DL(x+1,y,x+1,y+1)
	DL(x+3,y,x+3,y+1)
end
function DPark(x,y)
	DT(x,y,"(")
	DT(x+3,y,"P")
	DT(x+5,y,")")
end
function DSPLT(x,y)
	DT(x+4,y,"D")
	DL(x,y,x+3,y)
	DL(x,y+2,x+3,y+2)
	DL(x,y+4,x+3,y+4)
end
function onTick()
bat=GN(8)
ent=GN(11)
fue=GN(22)
fum=GN(23)
park,ltsp=GB(6) and GB(7),GN(26)>0
aent=ent/120
afue=fue/fum
end
function onDraw()
w,h=S.getWidth(),S.getHeight()
wh,hh=w/2,h/2
SC(8,8,8,32)
S.drawClear()
SC(4,4,4)
DPark(1,2)
DBat(10,2)
DSPLT(16,2)
DFuel(wh-3,12)
DTemp(wh+1,12)
SC(200,25,15)
if park then DPark(1,1) end
if bat<0.25 then DBat(10,1) end
SC(22,233,55)
if ltsp then DSPLT(16,1) end
SC(4,4,4)
Ax,Ay,Bx,By,Cx,Cy=wh-20,20,wh,20,wh+20,20
DCF(Ax,Ay,10)
DCF(Cx,Cy,10)
DCF(Bx,By,10)
--bigblueshadow
DA(Ax,Ay,9.5,-45,135,5,30,15)
DA(Cx,Cy,9.5,0,135,5,30,15)
--bigredshadow
DA(Ax,Ay,9.5,135,180,36,6,12)
DA(Cx,Cy,9.5,135,225,36,6,12)
DA(Bx,By,9.5,0,180,5,30,15)
DA(Bx,By,7.5,-10,60,5,30,15)
DA(Bx,By,7.5,120,190,5,30,15)
DA(Bx,By,7.5,60,80,36,6,12)
DA(Bx,By,7.5,100,120,36,6,12)
--bigblue
DA(Ax,Ay,10,-45,135,10,180,20)
DA(Cx,Cy,10,0,135,10,180,20)
--bigred
DA(Ax,Ay,10,135,180,200,25,15)
DA(Cx,Cy,10,135,225,200,25,15)
DA(Bx,By,10,0,180,10,180,20)
DA(Bx,By,8,-10,60,10,180,20)
DA(Bx,By,8,120,190,10,180,20)
DA(Bx,By,8,60,80,200,25,15)
DA(Bx,By,8,100,120,200,25,15)
DS(Ax,Ay,10,-45,135,1,10,180,20)
DS(Ax,Ay,10,135,180,1,200,25,15)
DS(Cx,Cy,10,0,135,1,10,180,20)
DS(Cx,Cy,10,135,225,1,200,25,15)
SC(170*(1-afue)+10,160*afue+20,20)
DFuel(wh-3,20)
SC(170*aent+10,160*(1-aent)+20,20)
DTemp(wh+1,20)
end