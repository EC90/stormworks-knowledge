-- source: steam id 3097129660 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
z=12
mox,moy=0,0
mapofst,mapofsto=false,false
tchxo,tchyo=0,0
tchx,tchy=0,0
tched=false
aimg=false
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DT=S.drawText
msg={'spg','tank','ifv','aa','air','heli','msl','sct','logi','uav','at','ally','enem','unk'}
et=0
function SC(scc)
if scc==1 then sC(233,15,15) end
if scc==3 then sC(233,233,15) end
if scc==4 then sC(15,233,15,200) end
if scc==6 then sC(15,64,233) end
if scc==9 then sC(80,80,80) end
if scc==0 then sC(15,15,15) end
end
function DNATO(d,C,F,T)--x,y,faction,type
local a,b,c,e,f,g,A,B,D,E=d-3,d-2,d-1,d+1,d+2,d+3,C-2,C-1,C+1,C+2
if F==1 then--ally
SC(6) DRF(a,A-1,7,7) SC(0) DR(a,A-1,6,6) 
else 
SC(1) S.drawTriangleF(a,D,e,A-1,g+2,D) S.drawTriangleF(a,D,e,E+3,g+2,D) SC(0) DL(d,A-2,a-1,C) DL(a-1,C,d,E+2) DL(d,E+2,g+1,C) DL(g+1,C,d,A-2) 
end
if T==1 then DL(d,C,d,D) end 
if T==2 then DL(c,B,f,B) DL(c,D,f,D) DL(b,C,c,C) DL(f,C,e,C) end 
if T==3 then DL(b,A,g,E+1) DL(f,A,a,E+1) end 
if T==4 then DL(b,E,c,D) DL(f,E,e,D) DL(c,D,f,D) end 
if T==5 then DL(b,C,d,A) DL(c,D,f,A) DL(e,D,g,B) end 
if T==6 then DL(b,B,b,E) DL(c,C,f,C) DL(f,B,f,E) end 
if T==7 then DL(d,B,d,C) DL(c,E,c,B) DL(e,E,e,B) end 
if T==8 then DL(b,E,g,A-1) end 
if T==9 then DL(b,D,g,D) end 
if T==10 then DL(c,B,e,D) DL(e,B,c,D) end 
if T==11 then DL(b,E,e,B) DL(f,E,c,B) end 
end
function PB(bx,by,bw,bh)
if tch and tx>bx and tx<bx+bw and ty>by and ty<by+bh then
return true
else
return false
end
end
function TB(bx,by,bw,bh,stts)
if tch and tx>bx and tx<bx+bw and ty>by and ty<by+bh and (not tched) then
stts=not stts
else
end
return stts
end
function DB(bx,by,bw,bh,msg,stts)
if stts then
SC(4)
S.drawRectF(bx,by,bw,bh)
sC(0,0,0,128)
S.drawText(bx+1,by+1,msg)
else
sC(0,0,0,128)
S.drawRectF(bx,by,bw,bh)
SC(4)
S.drawText(bx+1,by+1,msg)
end
end
gxo=0
gyo=0
function onTick()
w=GN(1)
h=GN(2)
if w<64 or h<64 then ss=0 SS=true else ss=1 SS=false end
tx=GN(3)
ty=GN(4)
gx=GN(5)
gy=GN(6)
vx=(gx-gxo)*60*z*2
vy=(gy-gyo)*60*z*2
gxo=gx
gyo=gy
lock=GN(7)
tch=input.getBool(1)
zi,zo=false,false
oW,oE,oN,oS=false,false,false,false
if math.abs(mox)>0 or math.abs(moy)>0 then
mapofst=true
end
help=TB(w-16,h-8,15,7,help) and not SS
if help then--a
if PB(0,0,64,49) then et=math.floor(math.min(tx,64)/32)*6+math.floor((math.min(ty,49)-1)/8) end
else
aimg=TB(w/2-4+ss*(w/2-13),h-6-ss*(h-7),15+ss,6+ss,aimg)
ntmd=TB(ss,ss,8+ss*8,5+2*ss,ntmd)
share=TB(ss,h-6-2*ss,15+ss,7+ss,share)
SB(31,share)
if not SS then
--map offset
if PB(1,h/2-5,6,7) then mox=mox-z*5 oW=true end
if PB(w-7,h/2-5,6,7) then mox=mox+z*5 oE=true end
if PB(w/2-5,1,6,7) then moy=moy+z*5 oN=true end
if PB(w/2-5,h-7,6,7) then moy=moy-z*5 oS=true end
end
--zizo
if PB(w-4-2*ss,h/4-5,4+ss,6+ss) then zi=true z=math.max(z*0.97,0) end
if PB(w-4-2*ss,3*h/4-5,4+ss,6+ss) then zo=true z=math.min(z*1.03,50) end
if PB(ss,h-14-2*ss,15+ss,7+ss) then mapofst=false mox,moy=0,0 end
end--a
SN(1,et)
SB(1,ntmd)
SB(32,aimg)
if mapofst then
if not mapofsto then
mcx,mcy=gx+vx,gy+vy
else
mcx,mcy=mcx,mcy
end
else
mcx,mcy=gx+vx,gy+vy
end
mapofsto=mapofst
SN(30,mcx+mox)
SN(31,mcy+moy)
SN(32,z)
if PB(7*ss,6+ss,w-4-9*ss,h-12-3*ss) and not tched and not help then
tchx,tchy=map.screenToMap(mcx+mox,mcy+moy,z,w,h,tx,ty)
mox=tchx-mcx
moy=tchy-mcy
end
SN(21,tchx)
SN(22,tchy)
tchxo=tchx
tchyo=tchy
tched=tch
end
function onDraw()
if help then--a
SC(9)
S.drawClear()
for i=0,5 do
DNATO(4,8*(i)+4,2,i)
if i>0 then
DT(9,i*8+2,msg[i])
end
end
for i=6,11 do
DNATO(36,8*(i-6)+4,2,i)
DT(41,(i-6)*8+2,msg[i])
end
DR(math.floor(et/6)*32,(et%6)*8,30,8)
DT(1,h-7,"set type "..et)
else--a
if not SS then
DB(1,h/2-5,6,7,"W",oW)
DB(w-7,h/2-5,6,7,"E",oE)
DB(w/2-5,1,6,7,"N",oN)
DB(w/2-5,h-8,6,7,"S",oS)
end
DB(w/2-4+ss*(w/2-13),h-6-ss*(h-7),15+ss,6+ss,"AIM",aimg)
DB(ss,h-6-2*ss,15+ss,6+ss,"MRK",share)
DB(w-4-2*ss,h/4-5,4+ss,6+ss,"+",zi)
DB(w-4-2*ss,3*h/4-5,4+ss,6+ss,"-",zo)
if mapofst then
DB(ss,h-14-2*ss,15+ss,6+ss,"RST",not mapofst)
end
end--a
if not SS then
DB(w-16,h-8,15,7,'SET',help)
end
end