-- source: steam id 2902453331 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2902453331

aZ=false
aQ=tonumber
aL=nil
b_=table
ar=pairs
C=math
aU=property
aH=input
aP=output
R=aP.setNumber
ba=aH.getBool
d=aH.getNumber
bh=aU.getText
aS=C.atan
m=C.pi
P=C.cos
aC=C.sqrt
af=C.sin
D=D or{}D.L=function(bt,K,bq)K=K or{}for s,n in ar(bt)do
K[s]=not bq and K[s]or n
end
return K
end;
aT={ac=function(f,h,j,i,g)return D.L(f,{h=h or 0,j=j or 0,i=i or 0,g=g or 0})end;
aW=function(_)return _:ac(-_.h,-_.j,-_.i,_.g)end;
Z=function(_,e)return _:ac(e.h*_.g-e.j*_.i+e.i*_.j+e.g*_.h,e.h*_.i+e.j*_.g-e.i*_.h+e.g*_.j,-e.h*_.j+e.j*_.h+e.i*_.g+e.g*_.i,-e.h*_.h-e.j*_.j-e.i*_.i+e.g*_.g)end;
ao=function(f,Y,c)Y=Y/2
local aA,bl=af(Y),aC(c[1]^2+c[2]^2+c[3]^2)for a=1,3 do
c[a]=c[a]/bl
end
local x=f:ac(c[1],c[2],c[3],0)x.h=aA*x.h
x.j=aA*x.j
x.i=aA*x.i
x.g=P(Y)return x
end;
ab=function(_,c)local T={}local l=_:Z(_:ac(c[1],c[2],c[3],0):Z(_:aW()))T[1]=l.h
T[2]=l.j
T[3]=l.i
return T
end;
aX=function(f,t,r,p)local n,l={1,0,0},f:ao(p,{0,-1,0})n=l:ab({0,0,1})l=f:ao(t,n):Z(l)n=l:ab({-1,0,0})l=f:ao(r,n):Z(l)return l
end}aD={q=function(f,t,r,p)return D.L(f,{t=t or 0,r=r or 0,p=p or 0,aw=aT:aX(t or 0,r or 0,p or 0),aK=0,aE=0,aY=0})end;
z=function(_,k,ag,V,U)U=U or .25
V=((V+1.75)%1-.5)*2*m
k=2*m*k
ag=C.asin(af(2*m*ag)/P(k))if U<0 then
if k>0 then
k=m-k
elseif k<0 then
k=-m-k
elseif U==0 then
k=m/2
end
end
_.aK=k-_.t
_.aE=ag-_.r
_.aY=(V-_.p+3*m)%(2*m)-m
_.t=k
_.r=ag
_.p=V
_.aw=aT:aX(_.t,_.r,_.p)end;
al=function(_,c)return _.aw:ab(c)end;
bg=function(_,c)return _.aw:aW():ab(c)end;
aJ=function(_,an)return aD:q(_.t+_.aK*an,_.r+_.aE*an,_.p+_.aY*an)end}bn={q=function(f,au,M,aj,w)return D.L(f,{au=au,M=M,aj=aj,w=w,W=0,Q=0,H=0,aG=1/60})end;
z=function(_,o,e)local b=_
b.W=b.Q
b.Q=o-e
b.H=b.H+(b.Q+b.W)/2*b.aG
local bo,a,J=b.au*b.Q,b.M*b.H,b.aj*(b.Q-b.W)/b.aG
if a>b.w then
b.H=b.w/b.M
a=b.w
elseif a<-b.w then
b.H=-b.w/b.M
a=-b.w
end
return bo+a+J
end;
be=function(_)_.W=0
_.H=0
end}bm={q=function(f,as,ap)local b={}for a=1,ap do
b[a]=0
end
return D.L(f,{as=as,G={},y=b})end;
z=function(_,o)b_.insert(_.G,o)if#_.G>_.as then
b_.remove(_.G,1)end
_.y={}for a=1,#_.G do
for s,n in ar(_.G[a])do
if _.y[s]==aL then
_.y[s]=0
end
_.y[s]=_.y[s]+n
end
end
for s,n in ar(_.y)do
_.y[s]=n/#_.G
end
end;
ai=function(_)return _.y
end;
bu=function(_)_.G={}end}bv={q=function(f,A,ap)local aM={A=A,ah=0,E={}}for a=1,ap do
aM.E[a]=0
end
return D.L(f,aM)end;
z=function(_,bf,A)A=A or _.A
_.ah=_.ah+1
for a=1,#bf do
_.E[a]=A*_.E[a]+(1-A)*bf[a]end
end;
be=function(_)_.ah=0
for a=1,#_.E do
_.E[a]=0
end
end}function aI(bp)local ak={}for g in string.gmatch(bp,"[-0-9.]+")do
local aV=aQ(g)if aV~=aL then
ak[#ak+1]=aQ(aV)end
end
return ak
end
function aN(o,max,min)if o<min then
o=min
elseif o>max then
o=max
end
return o
end
function bc(c)return aS(c[3],c[1]),aS(c[2],aC(c[1]^2+c[3]^2))end
at=3
S=6
bj=aI(bh("GPS Position Diff"))bk=aI(bh("Altitude Position Diff"))N=aD:q(0,0,0)bd=aD:q(0,0,0)F={0,0,0}aB={0,0,0}I=bm:q(at+1,3)O=bv:q(.965,3)X={0,0,0}bs={0,0,0}aO={0,0,0}aa=aZ
v=0
u=0
bi=bn:q(7,.007,.2,.05)ae=aU.getNumber("Rotate Sensitivity")*.0001
function onTick()F={d(1),d(2),d(3)}local ad,ax,aR,az,av={0,0,0},{0,0,0},{0,0,0},aC(F[1]^2+F[2]^2+F[3]^2),d(17)if(av~=4000)and(C.abs(az-av+2)<10*az/100)then
local b,ay=bc(F)local J=(az+av)/2
F={J*P(ay)*P(b),J*af(ay),J*P(ay)*af(b)}end
N:z(d(4),d(5),d(6))bd:z(d(7),d(8),d(9),d(10))local bb,br,B=N:al(bj),N:al(bk),{d(11),d(12),d(13)}local am={B[1]-bb[1],B[2]-br[2],B[3]-bb[3]}bs={B[1]-X[1],B[2]-X[2],B[3]-X[3]}if ba(1)and ba(2)then
ad=bd:al(F)I:z(ad)local aF,aq=I:ai(),{0,0,0}if aa then
for a=1,3 do
aR[a]=(ad[a]+am[a])-(aB[a]+aO[a])end
O:z(aR)for a=1,3 do
if
O.ah>20 then
ax[a]=aF[a]+O.E[a]*(S+at)else
ax[a]=aF[a]end
end
aq=N:aJ(S):bg(ax)else
aq=N:aJ(S):bg(I:ai())end
u,v=bc(aq)u,v=u/m/2,2*v/m
aB=ad
aa=true
else
aB={0,0,0}I:bu()O:be()if d(15)==-1 then
u=u+ae
elseif d(15)==1 then
u=u-ae
end
if d(16)==1 then
v=aN(v+ae,1,-1)elseif d(16)==-1 then
v=aN(v-ae,1,-1)end
aa=aZ
end
X=B
aO=am
for a=1,3 do
R(a+3,am[a]+I:ai()[a])R(a+9,O.E[a])end
R(20,at+S)aP.setBool(1,aa)R(31,v)R(32,bi:z((u-d(14)+1.5)%1-.5,0))end
