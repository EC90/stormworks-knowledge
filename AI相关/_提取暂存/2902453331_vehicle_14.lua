-- source: steam id 2902453331 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2902453331

x=.7
ah=true
y=false
t=math
aE=input
aC=output
L=aC.setNumber
j=aE.getNumber
aP=t.atan
aJ=t.cos
aG=t.sin
al=t.pi
aO=property.getNumber
N=t.abs
au=t.sqrt
af=af or{}af.bf=function(aV,K,bx)K=K or{}for b,ar in pairs(aV)do
K[b]=not bx and K[b]or ar
end
return K
end;
k={l=function(bi,g,i)local at={}for _=1,g do
at[_]={}for e=1,i do
at[_][e]=0
end
end
return af.bf(bi,{g=g,i=i,s=at})end;
a=function(c,g,i)return c.s[g][i]end;
d=function(c,g,i,by)c.s[g][i]=by
end;
aH=function(c)for _=1,c.g do
c:d(_,_,1)end
return c
end;
ad=function(c)local f=k:l(c.g,c.i)for _=1,c.g do
for e=1,c.i do
f:d(_,e,c:a(_,e))end
end
return f
end;
av=function(c,s,J)J=J or 1
local aL=k:l(c.g,c.i)for A=1,c.g do
for C=1,c.i do
aL:d(A,C,c:a(A,C)+s:a(A,C)*J)end
end
return aL
end;
az=function(c,J)local f=c:ad()for _=1,f.g do
for e=1,f.i do
f:d(_,e,f:a(_,e)*J)end
end
return f
end;
ax=function(c,s)local ap=k:l(c.g,s.i)for A=1,c.g do
for C=1,s.i do
for aS=1,c.i do
ap:d(A,C,ap:a(A,C)+c:a(A,aS)*s:a(aS,C))end
end
end
return ap
end;
aF=function(c)local aQ=k:l(c.i,c.g)for _=1,c.g do
for e=1,c.i do
aQ:d(e,_,c:a(_,e))end
end
return aQ
end;
be=function(c)local f=c.g
local r,am,w=c:ad(),k:l(f,f):aH(),k:l(1,f)for b=1,f-1 do
local D=0
for _=b,f do
D=D+r:a(_,b)*r:a(_,b)end
D=au(D)if D~=0 then
w:d(1,b,r:a(b,b)+(r:a(b,b)<0 and-1 or 1)*D)local ag=w:a(1,b)*w:a(1,b)for _=b+1,f do
w:d(1,_,r:a(_,b))ag=ag+w:a(1,_)*w:a(1,_)end
local V,aX=k:l(f,f):aH(),1/ag
for _=b,f do
for e=b,f do
V:d(_,e,V:a(_,e)-2*w:a(1,_)*w:a(1,e)*aX)end
end
r=V:ax(r)am=am:ax(V)end
end
return am,r
end;
bw=function(c,bu)local h=c:ad()local F,n={0,0},h.g
for _=1,n do
F[_-1]=_-1
end
for b=1,n-1 do
local E,aT=b-1,N(h:a(b,b))for _=b+1,n do
if N(h:a(_,b))>aT then
E=_-1
aT=N(h:a(b,b))end
end
if E+1~=b then
for _=1,n do
local aA=h:a(b,_)h:d(b,_,h:a(E+1,_))h:d(E+1,_,aA)aA=F[b-1]F[b-1]=F[E]F[E]=aA
end
end
for _=b+1,n do
h:d(_,b,h:a(_,b)/h:a(b,b))for e=b+1,n do
h:d(_,e,h:a(_,e)-h:a(_,b)*h:a(b,e))end
end
end
local p=k:l(n,1)for _=1,n do
p:d(_,1,bu:a(F[_-1]+1,1))end
for _=2,n do
for e=1,_-1 do
p:d(_,1,p:a(_,1)-h:a(_,e)*p:a(e,1))end
end
for _=n,1,-1 do
for e=_+1,n do
p:d(_,1,(p:a(_,1)-h:a(_,e)*p:a(e,1)))end
p:d(_,1,p:a(_,1)/h:a(_,_))end
return p
end};
bp={{1000,.02,x,300},{1000,.01,x,300},{900,.005,x,600},{800,.002,x,3600},{700,.001,x,3600},{600,.0005,x,3600},{1600,.025,x,120}}bA=aO("Additional Data Lag")M=bp[aO("Gun Type")]m=M[1]/60
bb=M[2]aK=1-M[2]bl=1/t.log(aK)bs=30/(60^2)W=bs/bb
bB=al/2
function aZ(bk,bg,br,T,aa,X,H,I,G,ay,v,aB,aM,U,q)local ae,P,R,B,O,S=v+ay,aG(aB),aG(aM),aJ(aB),aJ(aM),aK^v
local u=(S-1)*bl
U:d(1,1,bg+I*ae-(aa+m*P+W)*u+W*v)U:d(2,1,bk+H*ae-(T+m*O*B)*u)U:d(3,1,br+G*ae-(X+m*R*B)*u)q:d(1,1,I-S*(aa+m*P+W)+W)q:d(1,2,-m*B*u)q:d(1,3,0)q:d(2,1,H-S*(T+m*O*B))q:d(2,2,m*P*O*u)q:d(2,3,m*R*B*u)q:d(3,1,G-S*(X+m*R*B))q:d(3,2,m*R*P*u)q:d(3,3,-m*O*B*u)return U,q
end
function bj(aW,bh,b_,ba,bc,bv,T,aa,X,H,I,G,ay,aD,bd,bo,ar,bm)local Z,o,aj=k:l(3,1),k:l(3,1),y
local Y,ab,Q=ba-aW,bc-bh,bv-b_
if bm then
o=ar
else
local v=au(Y*Y+ab*ab+Q*Q)/m
local as,bq,ak=Y+H*v,ab+I*v,Q+G*v
o:d(1,1,v)o:d(2,1,aP(bq,au(as*as+ak*ak)))o:d(3,1,(aP(ak,as)+al*2)%(al*2))end
local ac,aw,aN=k:l(3,1),k:l(3,3),0
for _=1,bd do
ac,aw=aZ(Y,ab,Q,T,aa,X,H,I,G,ay,o:a(1,1),o:a(2,1),o:a(3,1),ac,aw)local aq=0
for e=1,3 do
aq=t.max(aq,N(ac:a(e,1)))end
if aq<bo and o:a(1,1)>0 then
aj=ah
aN=_
break
end
local bn,bz=aw:aF():be()local aY=Z:az(-2):av(bz:aF():bw(ac),-1)local bt=bn:ax(Z)o,Z=o:av(bt:az(aD)),Z:av(aY:az(aD))end
if aj then
debug.log("$$: "..aN)end
return o,aj
end
z,aR,aI,aU,ao,ai=k:l(3,1),0,0,0,y,y
an=y
function onTick()an,ai=y,y
if not aE.getBool(1)then
ao=y
else
z,ao=bj(j(1),j(2),j(3),j(4),j(5),j(6),j(7),j(8),j(9),j(10),j(11),j(12),j(20)+5+bA,M[3],20,.25,z,ai)end
if z:a(1,1)>0 and z:a(1,1)<M[4]and ao then
aR,aI,aU=z:a(1,1),z:a(2,1),z:a(3,1)an,ai=ah,ah
end
L(1,aR)L(2,aI)L(3,aU)L(4,j(17))aC.setBool(1,an)for _=1,4 do
L(_+12,j(_+12))end
end
