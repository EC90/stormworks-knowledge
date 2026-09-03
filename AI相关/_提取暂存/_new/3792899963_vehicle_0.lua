-- source: steam id 3792899963 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792899963
cc="%02.0f"
cb=":"
ca="%d"
c_="WP"
T=.5
v=360
aT=tostring
az=false
bg=property
aS=output
bk=input
aa=math
Q=screen
aB=Q.drawRect
R=Q.drawRectF
C=string.format
x=Q.drawText
bt=Q.drawCircle
h=aa.floor
P=Q.drawLine
bj=aa.tan
aY=aa.sqrt
c=aa.sin
b=aa.cos
aH=aa.atan
br=Q.setColor
N=aa.pi
q=bk.getNumber
bY=bk.getBool
bc=aS.setNumber
bX=aS.setBool
aA=bg.getNumber
w=bg.getBool
S=N*2
bH=(73/v)*S
bx=(58/v)*S
pAs,pAh,pAj = 0,0,0
tAs,tAh,tAj = 0,0,0
tS=1000

function J()br(0,255,0)end

function U()br(0,0,0)end

function ay(d,p)if d>=0 then
aI=aH(p/d)elseif p>=0 then
aI=aH(p/d)+N
else
aI=aH(p/d)-N
end
return aI
end

function ba(d,min,max)if d>=max then
d=max
elseif d<=min then
d=min
end
return d
end

function O(l,k,m,as,ah,aj,e,g,f)local y,A,ab,ac,Z,W,X,u,t,o,z,aC,d,B,p,at
l=l-as
k=k-aj
m=m-ah
y=b(f)*b(g)A=b(f)*c(g)*c(e)-c(f)*b(e)ab=b(f)*c(g)*b(e)+c(f)*c(e)ac=l
Z=c(f)*b(g)W=c(f)*c(g)*c(e)+b(f)*b(e)X=c(f)*c(g)*b(e)-b(f)*c(e)u=m
t=-c(g)o=b(g)*c(e)z=b(g)*b(e)aC=k
at=((y*W-A*Z)*z+(ab*Z-y*X)*o+(A*X-ab*W)*t)d=0
p=0
B=0
if at~=0 then
d=((A*X-ab*W)*aC+(ac*W-A*u)*z+(ab*u-ac*X)*o)/at
p=-((y*X-ab*Z)*aC+(ac*Z-y*u)*z+(ab*u-ac*X)*t)/at
B=((y*W-A*Z)*aC+(ac*Z-y*u)*o+(A*u-ac*W)*t)/at
end
return d,B,p
end

function ax(n,i,j,as,ah,aj,e,g,f)local bn,bq,aZ
bn=b(f)*b(g)*n+(b(f)*c(g)*c(e)-c(f)*b(e))*j+(b(f)*c(g)*b(e)+c(f)*c(e))*i
bq=c(f)*b(g)*n+(c(f)*c(g)*c(e)+b(f)*b(e))*j+(c(f)*c(g)*b(e)-b(f)*c(e))*i
aZ=-c(g)*n+b(g)*c(e)*j+b(g)*b(e)*i
return bn+as,aZ+aj,bq+ah
end

function bB(d,p,B,ap)local r,s
r=ay(aY(d^2+p^2),B)s=ay(p,d)I=aY(d^2+p^2+B^2)if ap then
return r,s,I
else
return r/(N*2),s/(N*2),I
end
end

function bh(r,s,I,ap)local d,p,B
if not ap then
r=r*N*2
s=s*N*2
end
d=I*b(r)*c(s)p=I*b(r)*b(s)B=I*c(r)return d,p,B
end

function bQ(r,s,I,ap)local d,p,B
if not ap then
r=r*N*2
s=s*N*2
end
d=I*c(s)p=I*b(s)*b(r)B=I*b(s)*c(r)return d,p,B
end

function aw(n,i,j)local G,E,D --function is called by the waypoint marker
G=K/2+(n/i)*(K/2)/bj(bH/2)E=u/2-(j/i)*(u/2)/bj(bx/2)D=i>0
return G,E,D
end

function be(l,k,m,e,g,f)local n,i,j,G,E,D
n,i,j=O(l,k,m,0,0,0,e,g,f)n,i,j=O(n,i,j,0,0,0,-ar,am,0)G,E,D=aw(n,i,j)return G,E,D
end

function aD(r,s,aG,aO,aM)local l,k,m,G,E,D
l,k,m=bh(r,s,1,az)l,k,m=O(l,k,m,0,0,0,aG,aO,aM)G,E,D=be(l,k,m,e,g,f)return G,E,D
end

function av(r,s,aG,aO,aM)local l,k,m,G,E,D
l,k,m=bQ(r,s,1,az)l,k,m=O(l,k,m,0,0,0,aG,aO,aM)G,E,D=be(l,k,m,e,g,f)return G,E,D
end

function bE(_,a,F,L)local y,A,au
y=ba((a-L)/(_-F),-1000,1000)A=a-y*_
au=2*b(ay(F-_,L-a))for d=_,F-au,au*2 do
if ad(d,y*d+A)then
P(d,y*d+A,d+au,y*(d+au)+A)end
end
end

function ad(d,p)return d>=0 and d<=K and p>=0 and p<=u
end

function aJ(bT,bV)return#aT(h(bT*bV+T))end

function onTick()aF=aA("Speed Units")aE=aA("Altitude Units")bd=aA("Distance Units")Y=aJ(500,aF)ag=aJ(30000,aE)ai=ba(aJ(150000,bd),3,100)as=q(1)ah=q(2)aj=q(3)e=q(4)g=q(5)f=q(6)bI=q(21)*aE
bw=q(2)*aE
bo=q(13)*aF
bf=q(20)*aF
M=q(17)*S
am=q(9)*S
ar=q(10)*S
bW=q(22)bJ=q(23)bO=q(24)aL=q(25)*bd
af=q(26)bz=q(27)==1
bF=q(28)==1
aX=w("air speed")aR=w("ground speed")an=w("main speed")bU=w("air altitude")by=w("ground altitude")bA=w("magnetic heading")aW=w("attitude bars")bR=w("horizon line")b_=w("center marker")bL=w("laser direction")bD=w("waypoint marker")bP=w("waypoint marker label")bv=w("waypoint marker distance")bM=w("waypoint distance")bS=w("waypoint arrival time")bp=h(aA("Minimum angle for attitude bars"))if bL then
n,i,j=O(0,0,-1,0,0,0,e,g,f)n,i,j=O(n,i,j,0,0,0,S/4,0,0)bK,bG,bZ=bB(n,i,j,az)bc(1,bG*8)bc(2,bK*8)end
dAs=as-pAs
dAh=ah-pAh
dAj=aj-pAj
tAs=as+dAs*tS
tAh=ah+dAh*tS
tAj=aj+dAj*tS
pAs,pAh,pAj=as,ah,aj
end

function onDraw()K=Q.getWidth()u=Q.getHeight()J()

if b_ then
n,i,j=O(0,1,0,0,0,0,-ar,am,0)_,a,H=aw(n,i,j)if H then
--bt(_,a,3)
--P(_+3,a,_+10,a)
--P(_-3,a,_-10,a)
--P(_,a-3,_,a-8)
P(_+6,a,_+10,a)
P(_+3,a+3,_+6,a)
P(_+0,a,_+3,a+3)
P(_-0,a,_-3,a+3)
P(_-3,a+3,_-6,a)
P(_-6,a,_-10,a)
end
n,i,j=O(tAs,tAj,tAh,as,ah,aj,e,g,f)
n,i,j=O(n,i,j,0,0,0,-ar,am,0)
_,a,H=aw(n,i,j)if H and (bo/aF)>5 then
_=h(_) a=h(a)
bt(_,a,3)
P(_+3,a,_+10,a)
P(_-3,a,_-10,a)
P(_,a-3,_,a-8)
end
end

if bR then
local aP=5
if not b_ then
aP=0
end
for t=aP,180,45 do
for o=-1,1,2 do
_,a,H=aD(0,o*t/v,0,M,0)F,L,ak=aD(0,o*(t+45)/v,0,M,0)if H and ak then
P(_,a,F,L)end
end
end
elseif aW then
for o=-1,1,2 do
_,a,H=aD(0,o*5/v,0,M,0)F,L,ak=aD(0,o*15/v,0,M,0)if H and ak then
P(_,a,F,L)end
end
end
if aW then
for t=bp,175,bp do
for o=-1,1,2 do
for z=-1,1,2 do
_,a,H=av(z*t/v,o*12/v,0,M,0)F,L,ak=av(z*t/v,o*5/v,0,M,0)bi,aU,bN=av(z*(t-1)/v,o*12/v,0,M,0)bs,bl,bu=av(z*t/v,o*16/v,0,M,0)if H and ak and bN and bu then
if ad(_,a)or ad(F,L)then
if z==1 then
P(_,a,F,L)else
bE(F,L,_,a)end
end
if ad(_,a)or ad(bi,aU)then
P(_,a,bi,aU)end
if ad(bs,bl)then
x(bs-2.5*#aT(z*t),bl-3,z*t)end
end
end
end
end
end
if bA then
l,k,m=ax(0,1,0,0,0,0,-ar,am,0)l,k,m=ax(l,k,m,0,0,0,e,g,f)aN=ay(k,l)/S
l,k,m=ax(0,0,1,0,0,0,-ar,am,0)l,k,m=ax(l,k,m,0,0,0,e,g,f)if m>0 then
o=1
else
o=-1
end
--heading angle bars
--for t=0,o*355,o*5 do
--n,i,j=bh(19.5/v,t/v-o*aN,1,az)_,a,H=aw(n,i,j)if H then
--P(_,a+2,_,a-2)if t%10==0 then
--x(_-4,a-7,C("%02d",o*t/10))end
--end
--end
_=h(K/2)aN=C("%03.0f",v*((-M/S)%1))U()R(_-10,9,20,11)J()aB(_-9,10,17,8)Q.drawTextBox(_-8,11,16,7,aN,0,0)end
if bz then
n,i,j=O(bW,bJ,bO,as,ah,aj,e,g,f)n,i,j=O(n,i,j,0,0,0,-ar,am,0)if aL>=10 then
ao=C("%.0f",h(aL+T))else
ao=C("%.1f",h(aL*10+T)/10)end
if bD then --waypoint marker
	_,a,H=aw(n,i,j)_=h(_)a=h(a)
	if H then
		J()bt(_,a,5)
		if bP then
			x(_-4,a-11,c_)end
		if bv then
			x(_+1-2.5*#ao,a+7,ao)end
		end
	end
if bM then
_,a=h(K/5),h(3*u/5)U()R(_-5-5*ai,a,13+5*ai,7)J()x(_-4-5*ai,a+1,c_)x(_+8-5*#ao,a+1,ao)end
if bS then
_,a=h(K/5),h(3*u/5)bC=C(ca,h(af/3600))aQ=C(cc,h(af%60+T))if af<3600 then
aK=C(ca,h((af/60)%60))ae=aK..cb..aQ
elseif af>=36000 then
ae="-:--:--"
else
aK=C(cc,h((af/60)%60))ae=bC..cb..aK..cb..aQ
end
U()R(_+7-5*#ae,a+7,5*#ae+1,7)J()x(_+8-5*#ae,a+8,ae)end
end
if bF then
_,a=h(K/5),h(3*u/5)U()R(_-5-5*ai,a-7,11,7)J()x(_-4-5*ai,a-6,"AP")end
if an then
bm=bo
bb=bf
aV="AS"
else
bm=bf
bb=bo
aV="GS"
end
if(an and aR)or(not an and aX)then
_,a=h(K/5),h(u/3)al=C(ca,h(bm+T))U()R(_+5-5*Y,a,5*Y+5,11)J()aB(_+6-5*Y,a+1,5*Y+2,8)x(_+8-5*#al,a+3,al)end
if(an and aX)or(not an and aR)then
al=C(ca,h(bb+T))U()R(_-5-5*Y,a+10,5*Y+13,7)J()x(_-4-5*Y,a+11,aV)x(_+8-5*#al,a+11,al)end
if bU then
_,a=h(4*K/5),h(u/3)aq=C(ca,h(bw+T))V=2*ag
U()R(_-V,a,5+5*ag,11)J()aB(_+1-V,a+1,2+5*ag,8)x(_+3+1.5*V-5*#aq,a+3,aq)end
if by then
_,a=h(4*K/5),h(2*u/3)aq=C(ca,h(bI+T))V=2*ag
U()R(_-5-V,a,15+5*ag,11)J()x(_-4-V,a+3,"AG")aB(_+6-V,a+1,2+5*ag,8)x(_+8+1.5*V-5*#aq,a+3,aq)end
end
