-- source: steam id 3446969574 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3446969574
bD="%d"

q=360
ar=false
aW=property
aT=output
aK=input
M=math
C=screen
as=C.drawRect
ab=C.drawRectF
v=M.floor
O=string.format
H=C.drawText
F=C.drawLine
ba=M.tan
aV=M.sqrt
c=M.sin
b=M.cos
ay=M.atan
bc=C.setColor
A=M.pi
r=aK.getNumber
bB=aK.getBool
b_=aT.setNumber
bz=aT.setBool
bC=aW.getNumber
y=aW.getBool
E=A*2
bv=(73/q)*E
bh=(58/q)*E
function W()bc(0,255,0)end
function ae()bc(0,0,0)end
function am(d,p)if d>=0 then
aA=ay(p/d)elseif p>=0 then
aA=ay(p/d)+A
else
aA=ay(p/d)-A
end
return aA
end
function bs(d,min,max)if d>=max then
d=max
elseif d<=min then
d=min
end
return d
end
function L(i,h,j,au,az,aC,f,g,e)i,h,j=i-au,h-aC,j-az
Q=b(e)*b(g)U=b(e)*c(g)*c(f)-c(e)*b(f)Z=b(e)*c(g)*b(f)+c(e)*c(f)V=i
Y=c(e)*b(g)X=c(e)*c(g)*c(f)+b(e)*b(f)T=c(e)*c(g)*b(f)-b(e)*c(f)R=j
av=-c(g)aF=b(g)*c(f)aD=b(g)*b(f)aB=h
ap=((Q*X-U*Y)*aD+(Z*Y-Q*T)*aF+(U*T-Z*X)*av)aP,aM,aL=0,0,0
if ap~=0 then
aP=((U*T-Z*X)*aB+(V*X-U*R)*aD+(Z*R-V*T)*aF)/ap
aM=-((Q*T-Z*Y)*aB+(V*Y-Q*R)*aD+(Z*R-V*T)*av)/ap
aL=((Q*X-U*Y)*aB+(V*Y-Q*R)*aF+(U*R-V*X)*av)/ap
end
return aP,aL,aM
end
function at(o,k,n,au,az,aC,f,g,e)bk=b(e)*b(g)*o+(b(e)*c(g)*c(f)-c(e)*b(f))*n+(b(e)*c(g)*b(f)+c(e)*c(f))*k
bj=c(e)*b(g)*o+(c(e)*c(g)*c(f)+b(e)*b(f))*n+(c(e)*c(g)*b(f)-b(e)*c(f))*k
bo=-c(g)*o+b(g)*c(f)*n+b(g)*b(f)*k
return bk+au,bo+aC,bj+az
end
function bd(d,p,G,ag)local m,l
m=am(aV(d^2+p^2),G)l=am(p,d)z=aV(d^2+p^2+G^2)if ag then
return m,l,z
else
return m/(A*2),l/(A*2),z
end
end
function aZ(m,l,z,ag)local d,p,G
if not ag then
m=m*A*2
l=l*A*2
end
d=z*b(m)*c(l)p=z*b(m)*b(l)G=z*c(m)return d,p,G
end
function bq(m,l,z,ag)local d,p,G
if not ag then
m=m*A*2
l=l*A*2
end
d=z*c(l)p=z*b(l)*b(m)G=z*b(l)*c(m)return d,p,G
end
function aE(o,k,n)local u,x,w
u=J/2+(o/k)*(J/2)/ba(bv/2)x=P/2-(n/k)*(P/2)/ba(bh/2)w=k>0
return u,x,w
end
function aU(i,h,j,f,g,e)local o,k,n,u,x,w
o,k,n=L(i,h,j,0,0,0,f,g,e)o,k,n=L(o,k,n,0,0,0,-an,aq,0)u,x,w=aE(o,k,n)return u,x,w
end
function bb(m,l,f,g,e)local i,h,j,u,x,w
i,h,j=aZ(m,l,1,ar)i,h,j=L(i,h,j,0,0,0,f,g,e)u,x,w=aU(i,h,j,ai,aj,ah)return u,x,w
end
function al(m,l,f,g,e)local i,h,j,u,x,w
i,h,j=bq(m,l,1,ar)i,h,j=L(i,h,j,0,0,0,f,g,e)u,x,w=aU(i,h,j,ai,aj,ah)return u,x,w
end
function bt(_,a,B,D)local ac,ao,af
ac=bs((a-D)/(_-B),-1000,1000)ao=a-ac*_
af=2*b(am(B-_,D-a))for d=_,B-af,af*2 do
if S(d,ac*d+ao)then
F(d,ac*d+ao,d+af,ac*(d+af)+ao)end
end
end
function S(d,p)return d>=0 and d<=J and p>=0 and p<=P
end
function onTick()ai=r(4)aj=r(5)ah=r(6)aH=r(13)*r(20)be=r(2)*r(21)aY=r(22)*r(20)bf=r(23)*r(21)I=r(17)*E
aq=r(18)*E
an=r(19)*E
aO=y("air speed")aQ=y("ground speed")aa=y("main speed")bu=y("air altitude")bm=y("ground altitude")bw=y("magnetic heading")bl=y("attitude bars")bx=y("horizon line")bi=y("center marker")bg=y("laser direction")if bg then
o,k,n=L(0,0,-1,0,0,0,ai,aj,ah)o,k,n=L(o,k,n,0,0,0,E/4,0,0)br,bn,bA=bd(o,k,n,ar)b_(1,bn*8)b_(2,br*8)end
end
function onDraw()J=C.getWidth()P=C.getHeight()W()if bi then
o,k,n=L(0,1,0,0,0,0,-an,aq,0)_,a,K=aE(o,k,n)if K then
C.drawCircle(_,a,4)F(_+4,a,_+10,a)F(_-4,a,_-10,a)F(_,a-4,_,a-8)end
end
if bx then
for s=5,180,45 do
for t=-1,1,2 do
_,a,K=bb(0,t*s/q,0,I,0)B,D,ax=bb(0,t*(s+45)/q,0,I,0)if K and ax then
F(_,a,B,D)end
end
end
end
if bl then
for s=5,175,5 do
for t=-1,1,2 do
for N=-1,1,2 do
_,a,K=al(N*s/q,t*12/q,0,I,0)B,D,ax=al(N*s/q,t*5/q,0,I,0)aI,aS,bp=al(N*(s-1)/q,t*12/q,0,I,0)aR,aG,by=al(N*s/q,t*16/q,0,I,0)if K and ax and bp and by then
if S(_,a)or S(B,D)then
if N==1 then
F(_,a,B,D)else
bt(B,D,_,a)end
end
if S(_,a)or S(aI,aS)then
F(_,a,aI,aS)end
if S(aR,aG)then
H(aR-2.5*#tostring(N*s),aG-3,N*s)end
end
end
end
end
end
if bw then
i,h,j=at(0,1,0,0,0,0,-an,aq,0)i,h,j=at(i,h,j,0,0,0,ai,aj,ah)aw=am(h,i)/E
i,h,j=at(0,0,1,0,0,0,-an,aq,0)i,h,j=at(i,h,j,0,0,0,ai,aj,ah)if j>0 then
t=1
else
t=-1
end
for s=0,t*355,t*5 do
o,k,n=aZ(19.5/q,s/q-t*aw,1,ar)_,a,K=aE(o,k,n)if K then
F(_,a+2,_,a-2)if s%10==0 then
H(_-4,a-7,O("%02d",t*s/10))end
end
end
_=v(J/2)aw=O("%03.0f",q*((-I/E)%1))ae()ab(_-10,9,20,11)W()as(_-9,10,17,8)C.drawTextBox(_-8,11,16,7,aw,0,0)end
if aa then
aX=aH
aN=aY
aJ="AS"
else
aX=aY
aN=aH
aJ="GS"
end
if(aa and aQ)or(not aa and aO)then
_,a=v(J/5),v(P/3)ad=O(bD,v(aX+.5))ae()ab(_-10,a,20,11)W()as(_-9,a+1,17,8)H(_+8-5*#ad,a+3,ad)end
if(aa and aO)or(not aa and aQ)then
ad=O(bD,v(aN+.5))ae()ab(_-20,a+10,28,7)W()H(_-19,a+11,aJ)H(_+8-5*#ad,a+11,ad)end
if bu then
_,a=v(4*J/5),v(P/3)ak=O(bD,v(be+.5))ae()ab(_-10,a,30,11)W()as(_-9,a+1,27,8)H(_+18-5*#ak,a+3,ak)end
if bm then
_,a=v(4*J/5),v(2*P/3)ak=O(bD,v(bf+.5))ae()ab(_-17,a,40,11)W()H(_-16,a+3,"AG")as(_-6,a+1,27,8)H(_+21-5*#ak,a+3,ak)end
end
