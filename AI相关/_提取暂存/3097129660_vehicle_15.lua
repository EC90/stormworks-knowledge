-- source: steam id 3097129660 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GN=input.getNumber
GB=input.getBool
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DT=S.drawText
mF=math.floor
R={}
msg={'spg','tank','ifv','aa','air','heli','msl','sct','logi','uav','at','ally','enem','unk'}
function SC(c)
if c==1 then sC(233,15,15) end
if c==3 then sC(233,233,15) end
if c==6 then sC(15,64,233) end
if c==9 then sC(233,233,233) end
if c==0 then sC(15,15,15) end
end
function DNATO(d,C,F,T,ss)--x,y,faction,type,smallscreen
d,C=mF(d),mF(C)
local a,b,c,e,f,g,A,B,D,E=d-3,d-2,d-1,d+1,d+2,d+3,C-2,C-1,C+1,C+2
if F==1 then--ally
SC(6) DRF(b,A,5,5) SC(0) DR(a,A-ss,6,4+2*ss) 
elseif F==2 then--enemy
SC(1) S.drawTriangleF(a,D,e,A-1,g+2,D) S.drawTriangleF(a,D,e,E+3,g+2,D) SC(0) DL(d,A-2,a-1,C) DL(a-1,C,d,E+2) DL(d,E+2,g+1,C) DL(g+1,C,d,A-2) 
else--unknown
SC(3) DRF(c,B,3,3) SC(0) DL(c,A,f,A) DL(f,B,f,E) DL(e,E,b,E) DL(b,D,b,A) 
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
function dsN(x,y,s)
x,y=mF(x),mF(y)
s=tostring(s)
l=string.len(s)
for i=1,l do
n=s:sub(i,i)
if n=="1"then DL(x+2,y,x+2,y+5)
elseif n=="2"then DL(x,y,x+3,y) DL(x,y+2,x+3,y+2) DL(x,y+4,x+3,y+4) DL(x+2,y,x+2,y+2) DL(x,y+2,x,y+4)
elseif n=="3"then DL(x,y,x+3,y)	DL(x,y+2,x+3,y+2) DL(x,y+4,x+3,y+4)	DL(x+2,y,x+2,y+4)
elseif n=="4"then DL(x,y+2,x+3,y+2)	DL(x+2,y,x+2,y+5) DL(x,y,x,y+2)
elseif n=="5"then DL(x,y,x+3,y)	DL(x,y+2,x+3,y+2) DL(x,y+4,x+3,y+4) DL(x,y,x,y+2) DL(x+2,y+2,x+2,y+4)
elseif n=="6"then DR(x,y+2,2,2)	DL(x,y,x+3,y) DL(x,y,x,y+2)
elseif n=="7"then DL(x,y,x+3,y) DL(x+2,y,x+2,y+5)
elseif n=="8"then DR(x,y,2,4) DL(x,y+2,x+3,y+2)
elseif n=="9"then DR(x,y,2,2) DL(x+2,y,x+2,y+5) DL(x,y+4,x+3,y+4)
elseif n==","then DL(x,y+4,x+2,y+2)
elseif n=="-"then DL(x,y+2,x+3,y+2)
else DR(x,y,2,4) end
x=x+4
end
end
function onTick()
arad=GB(30)
sID=GN(21)
lock=GN(22)
Mx=GN(23)
My=GN(24)
zm=GN(25)
cps=GN(26)
Tx=GN(27)
Ty=GN(28)
Tz=GN(29)
Gx=GN(30)
Gy=GN(31)
Gz=GN(32)
rx,ry=GN(18),GN(19)
if GN(5)~=0 or GN(2)~=0 then
	j=#R+1
	if #R>0 then
		for i=1,#R do
			if GN(1)==R[i].id then
				j=i
				break
			end
		end
	end
	R[j]={id=GN(1),x=GN(2),y=GN(3),z=GN(4),t=0,tx=GN(5),ty=GN(6),tz=GN(7),ts=GN(8),te=GN(9)}
end
if #R>0 then
	for i=1,#R do
		R[i].t=R[i].t+1
		if R[i].t>600 then
			table.remove(R,i)
			break
		end
	end
end
tempx,tempy=map.mapToScreen(Mx,My,zm,w,h,Tx,Ty)
end
function onDraw()
w=S.getWidth()
h=S.getHeight()
if w>63 and h>63 then ss=1 else ss=0 end
if arad then
sC(0,0,0,128)
DRF(ss,ss,24,5)
sC(222,22,22,200)
DT(ss,ss,"RADIO")
else
sC(0,0,0,128)
DRF(ss,ss,8+8*ss,5)
sC(15,233,15,200)
if ss==1 then
DL(2,1,2,6)
DL(4,1,4,6)
DL(4,1,6,1)
DL(4,5,6,5)
DL(6,2,6,5)
end
dsN(1+8*ss,ss,mF(sID))
end
SC(0)
if Tx~=0 and lock==0 then
	DT(tempx-2,tempy-2,"+")
	if w>63 and h>63 then
	dsN(tempx-20,tempy-8,mF(Tx)..','..mF(Ty))
	end
end
if rx~=0 then
	rdx,rdy=map.mapToScreen(Mx,My,zm,w,h,rx,ry)
	SC(1) S.drawCircleF(mF(rdx+0.5),mF(rdy+0.5),1.4)
	SC(0) S.drawCircle(mF(rdx+0.5),mF(rdy+0.5),1.4)
end
if #R>0 then
for i=1,#R do
Px,Py=map.mapToScreen(Mx,My,zm,w,h,R[i].x,R[i].y)
DNATO(Px,Py,1,R[i].ts,ss)
dsN(Px-3,Py+4+ss,mF(R[i].id))
if R[i].tx~=0 then
tmx,tmy=map.mapToScreen(Mx,My,zm,w,h,R[i].tx,R[i].ty)
DNATO(tmx,tmy,2,R[i].te,ss)
dsN(tmx-3,tmy+4+ss,mF(R[i].id))
if i==lock then
DR(mF(tmx)-4,mF(tmy)-4,8,8)
end
end
end
end
end