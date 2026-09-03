-- source: steam id 2891959205 / vehicle.xml block#22
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891959205
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
mA=math.abs
mT=math.atan
PI=math.pi
sID=math.random(99)
T=1
R,Rs={},{}
lock=0
Txo,Tyo=0,0
--compare dict contents
function cmpr(a,b)
return a.id<b.id
end
function cmpra(a,b)
return a.c<b.c
end
function cmprb(a,b)
return a.tc<b.tc
end
function onTick()
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
sd=input.getBool(31)
pw=input.getBool(32)
--update data
if GN(1)==sID then
sID=math.random(99)
end
if GN(1)~=0 then
	j=#R+1
	if #R>0 then
		for i=1,#R do
			if GN(1)==R[i].id then
				j=i
				break
			end
		end
	end
	R[j]={id=GN(1),x=GN(2),y=GN(3),z=GN(4),t=0,tx=GN(5),ty=GN(6),tz=GN(7),tp=GN(8)}
end
if #R>0 then
	for i=1,#R do
		R[i].t=R[i].t+1
		if R[i].t>300 then
			table.remove(R,i)
			break
		end
	end
end
if #R>0 then
for i=1,#R do
R[i].a=-mT(R[i].x-Gx,R[i].y-Gy)/(2*PI)-cps
R[i].e=mT((R[i].z-Gz),math.sqrt((R[i].x-Gx)^2+(R[i].y-Gy)^2))/(2*PI)
R[i].c=mA(R[i].a)+mA(R[i].e)
R[i].ta=-mT(R[i].tx-Gx,R[i].ty-Gy)/(2*PI)-cps
R[i].te=mT((R[i].tz-Gz),math.sqrt((R[i].tx-Gx)^2+(R[i].ty-Gy)^2))/(2*PI)
R[i].tc=mA(R[i].ta)+mA(R[i].te)
end
Rs=R
table.sort(Rs,cmpra)
SN(23,Rs[1].a)
SN(24,Rs[1].e)
table.sort(Rs,cmprb)
SN(25,Rs[1].ta)
SN(26,Rs[1].te)
else
SN(23,0)
SN(24,0)
SN(25,0)
SN(26,0)
end
--send timing
if T==0 then
send=true
T=28+math.random(5)
else
send=false
T=T-1
end
SN(1,sID)
SB(31,send and pw)
if mA(Tx-Txo)>10*zm or mA(Ty-Tyo)>10*zm then
if #R>0 then
lock=0
for i=1,#R do
dx=mA(R[i].tx-Tx)
dy=mA(R[i].ty-Ty)
if dx+dy<zm*80 then lock=i break end
end
else lock=0
end
end
if lock~=0 then
SN(27,R[lock].tx)
SN(28,R[lock].ty)
SN(29,R[lock].tz)
else
SN(27,Tx)
SN(28,Ty)
SN(29,Tz)
end
Txo,Tyo=Tx,Ty
SN(30,lock)
SN(31,math.floor(sID/10))
SN(32,math.floor(sID%10))
SB(32,#R>0)
if sd then
SN(5,Tx)
SN(6,Ty)
SN(7,Tz)
else
SN(5,0)
SN(6,0)
SN(7,0)
end
end