-- source: steam id 3261800786 / vehicle.xml block#32
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3261800786
--Damage Monitor
S=screen
SC=S.setColor

DC=S.drawCircle
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
DR=S.drawRect
DRF=S.drawRectF
D3F=S.drawTriangleF

M=math
Mf=M.floor
Mc=M.sin
Ms=M.cos
pi=M.pi
pi2=pi*2

GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
w=64 h=64
hW,hH=w-17,h-8
dx,dy=Mf(hW/2),8+Mf(hH/2)
P={}
for i=1,38 do P[i]={} end
function PB(bx,by,bw,bh)
	if tc and tx>bx and tx<bx+bw and ty>by and ty<by+bh then return true
	else return false end
end
function TB(bx,by,bw,bh,st)
	if tc and tx>bx and tx<bx+bw and ty>by and ty<by+bh and (not tcd) then st=not st
	else end return st end
function DB(bx,by,bw,bh,msg,st,oc)
	if st then C(oc) DRF(bx,by,bw,bh) C(0) DTB(bx,by,bw,bh,msg,0,0)
	else C(43) DRF(bx,by,bw,bh) C(45) DTB(bx,by,bw,bh,msg,0,0) end end
function RP(x,y,a)--rotatePixel
	xf,yf=x*Mc(a)-y*Ms(a),x*Ms(a)+y*Mc(a)
	return xf,yf
end
function Av(n,v,t)--average
t=M.max(Mf(t),1)
table.insert(n,v)
local s=0
if #n>t then for i=1,#n-t do table.remove(n,1) end end
for i=1,#n do s=s+n[i] end
return s/#n end
R={}
for i=1,16 do
	R[i]={}
	R[i].t={}
end
function onTick()
tc=GB(1)
ca=(GN(17)-GN(18)+0.25)*pi2
sum=0
for i=1,16 do
	R[i].v=Av(R[i].t,1-GN(i)/i,60)
	sum=sum+R[i].v
end
if sum>0 then SN(1,0) else SN(1,1) end
P[1].x,P[1].y=RP(-10,-13,ca)
P[2].x,P[2].y=RP(-4,-13,ca)
P[3].x,P[3].y=RP(4,-13,ca)
P[4].x,P[4].y=RP(10,-13,ca)
P[5].x,P[5].y=RP(-10,-8,ca)
P[6].x,P[6].y=RP(-4,-8,ca)
P[7].x,P[7].y=RP(4,-8,ca)
P[8].x,P[8].y=RP(10,-8,ca)
P[9].x,P[9].y=RP(-10,4,ca)
P[10].x,P[10].y=RP(-4,4,ca)
P[11].x,P[11].y=RP(4,4,ca)
P[12].x,P[12].y=RP(10,4,ca)
P[13].x,P[13].y=RP(-10,16,ca)
P[14].x,P[14].y=RP(-5,16,ca)
P[15].x,P[15].y=RP(0,16,ca)
P[16].x,P[16].y=RP(5,16,ca)
P[17].x,P[17].y=RP(10,16,ca)
P[18].x,P[18].y=RP(-10,20,ca)
P[19].x,P[19].y=RP(0,20,ca)
P[20].x,P[20].y=RP(10,20,ca)
P[21].x,P[21].y=RP(-5,14,ca)
P[22].x,P[22].y=RP(5,14,ca)
P[23].x,P[23].y=RP(5,18,ca)
P[24].x,P[24].y=RP(-5,18,ca)
P[25].x,P[25].y=-2,-8
P[26].x,P[26].y=-7,-6
P[27].x,P[27].y=-7,-2
P[28].x,P[28].y=-7,11
P[29].x,P[29].y=7,11
P[30].x,P[30].y=7,-2
P[31].x,P[31].y=7,-6
P[32].x,P[32].y=2,-8
P[33].x,P[33].y=-2,-4
P[34].x,P[34].y=-2,7
P[35].x,P[35].y=2,7
P[36].x,P[36].y=2,-4
P[37].x,P[37].y=-2,11
P[38].x,P[38].y=2,11
end
function DRR(a,b,c,d)
	D3F(dx+P[a].x,dy+P[a].y,dx+P[b].x,dy+P[b].y,dx+P[c].x,dy+P[c].y)
	D3F(dx+P[b].x,dy+P[b].y,dx+P[c].x,dy+P[c].y,dx+P[d].x,dy+P[d].y)
end
function onDraw()
SC(5,5,5) S.drawClear()
SC(R[1].v*95+5,R[1].v*10+5,R[1].v*2.5+5)
DRR(1,2,5,6)
SC(R[2].v*95+5,R[2].v*10+5,R[2].v*2.5+5)
DRR(2,3,6,7)
SC(R[3].v*95+5,R[3].v*10+5,R[3].v*2.5+5)
DRR(3,4,7,8)
SC(R[4].v*95+5,R[4].v*10+5,R[4].v*2.5+5)
DRR(5,6,9,10)
SC(R[5].v*95+5,R[5].v*10+5,R[5].v*2.5+5)
DRR(7,8,11,12)
SC(R[6].v*95+5,R[6].v*10+5,R[6].v*2.5+5)
DRR(9,10,13,14)
SC(R[7].v*95+5,R[7].v*10+5,R[7].v*2.5+5)
DRR(11,12,16,17)
SC(R[9].v*95+5,R[9].v*10+5,R[9].v*2.5+5)
DRR(13,15,18,19)
SC(R[10].v*95+5,R[10].v*10+5,R[10].v*2.5+5)
DRR(15,17,19,20)
SC(R[8].v*95+5,R[8].v*10+5,R[8].v*2.5+5)
DRR(21,22,24,23)
SC(R[11].v*95+5,R[11].v*10+5,R[11].v*2.5+5)
DRR(26,25,27,33)
SC(R[12].v*95+5,R[12].v*10+5,R[12].v*2.5+5)
DRR(25,32,33,36)
SC(R[13].v*95+5,R[13].v*10+5,R[13].v*2.5+5)
DRR(31,32,30,36)
SC(R[14].v*95+5,R[14].v*10+5,R[14].v*2.5+5)
DRR(27,33,28,37)
SC(R[15].v*95+5,R[15].v*10+5,R[15].v*2.5+5)
DRR(30,36,29,38)
SC(R[16].v*95+5,R[16].v*10+5,R[16].v*2.5+5)
DRR(34,35,37,38)
end