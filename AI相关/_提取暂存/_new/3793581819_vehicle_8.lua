-- source: steam id 3793581819 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
bZ="1"
bY="3"
bX="2"
bW="5"

y=false
bd=input
r=math
aL=output
ab=aL.setBool
n=aL.setNumber
aT=r.fmod
_=bd.getNumber
aB=property.getNumber
s=r.pi
bp=r.max
Y=r.min
x=r.abs
aa=r.sin
ae=r.cos
function b(bw,bs,bC)return{g=bw or 0,f=bs or 0,c=bC or 0}end
function bu(V,R,as)return{aM=V,ad=R,H=as}end
function q(h,j)return b(h.g+j.g,h.f+j.f,h.c+j.c)end
function v(h,F)return b(h.g*F,h.f*F,h.c*F)end
function N(h,j)return q(h,v(j,-1))end
function P(a)return r.sqrt(a.g*a.g+a.f*a.f+a.c*a.c)end
function bN(a,F)return v(a,1/F)end
function S(h,j)return h.g*j.g+h.f*j.f+h.c*j.c
end
function bV(h,j)return b(h.f*j.c-h.c*j.f,h.c*j.g-h.g*j.c,h.g*j.f-h.f*j.g)end
function ay(a,w)return b(S(w.aM,a),S(w.ad,a),S(w.H,a))end
function ak(a)return P(a),r.atan(a.g,a.f),r.asin(a.c/P(a))end
function aI(bz,bP,bL)bi,bm,aW=bz,bP,bL
at,ap,ac=ae(bi),ae(bm),ae(aW)b_,av,aj=aa(bi),aa(bm),aa(aW)V=b(ap*ac,-av,ap*aj)R=b(b_*aj+at*av*ac,at*ap,-b_*ac+at*av*aj)as=bV(V,R)return bu(V,R,as)end
function bv(bJ,af,w)a=b()a=q(a,v(w.aM,af.g))a=q(a,v(w.ad,af.f))a=q(a,v(w.H,af.c))return q(bJ,a)end
function aY(ar,aD,aG,A)l=ar
a=b()for B=1,A do
l=q(l,aD)l=v(l,1-aG)a=q(a,l)end
return a
end
function ax(ar,aD,aG,A)l=ar
aA=0
for B=1,A do
l=l+aD
l=l*(1-aG)aA=aA+l
end
return aA
end
function K(a,k)if not i then
i={}i[k]={t=b(),L=b()}elseif not i[k]then
i[k]={t=b(),L=b()}end
az=1e-6
if x(i[k].t.g)<az and x(i[k].t.f)<az and x(i[k].t.c)<az then
i[k].L=b()else
i[k].L=N(a,i[k].t)end
i[k].t.g=a.g
i[k].t.f=a.f
i[k].t.c=a.c
return i[k].L
end
function ai(k)if i and i[k]then
i[k]={t=b(),L=b()}end
end
function bl(a,A,e,bq,bI)l=bb(K(a,bZ..e),bq,bZ..e)by=bb(K(l,bX..e),bI,bX..e)return q(a,q(v(l,A),v(by,.5*A^2)))end
function aS(e)ai(bZ..e)ai(bX..e)aZ(bZ..e)aZ(bX..e)end
function bb(bU,aw,e)if aw==0 then
return b()else
if not m then
m={}end
if not m[e]then
m[e]={D={},I=0}end
for B=aw,2,-1 do
m[e].D[B]=m[e].D[B-1]end
m[e].D[1]=bU
m[e].I=Y(m[e].I+1,aw)aq=b()for B=1,m[e].I do
aq=q(aq,m[e].D[B])end
return bN(aq,m[e].I)end
end
function aZ(e)if m and m[e]then
m[e]={D={},I=0}end
end
function G(an,bK,bx)return bp(bK,Y(bx,an))end
function bk(an,bc)return bp(-bc,Y(bc,an))end
bo=30/3600
E=s/180
Z=s*2
bF={{800/60,.023,300,.01},{1000/60,.0189,300,.01},{1000/60,.00975,300,.015},{900/60,.00493,600,.007},{800/60,.00198,3600,.002},{700/60,.00098,3600,.0011},{600/60,.00048,3600,.001}}aK=true
am=10
C=0
aP=aB("Weapon Type")p=bF[aP]bf=p[1]d=1
Q=y
aR=b()o=b()aV=aB("Yaw piviot type")bh=aB("Pitch piviot type")function au()aS(bX)ai(bY)aS(bW)C=0
z=_(16)>0
if z then d=p[3]else d=1 end
end
function onTick()if am>0 then am=am-1 else
if aK then
bE=b(-_(13),-_(14),-_(15))bB=_(17)aC=_(18)*E
ah=_(19)*E
bQ=_(20)*E
bR=_(21)*E
aE=_(22)*aV
bO=_(23)*bh
aJ=_(25)*E
bS=_(28)br=_(26)aK=y
end
if _(16)>0~=z then
au()end
O=aI(_(7),_(8),_(9))W=aI(_(10),_(11),_(12))bg,aF,bA=ak(ay(O.ad,W))bD=aa(O.H.c)*bS
M=8*aV
J=8*bh
if P(K(b(_(1),_(2),_(3)),bZ))>10 then
au()end
aR=bl(b(_(1),_(2),_(3)),bB,bX,30,0)u=bv(b(_(4),_(6),_(5)),bE,W)aX=N(aR,u)ag=bd.getBool(1)if ag then
if z then
aN=0
else
aN=_(27)end
d=G(d,1,p[3])ao=K(aX,bY)bj=K(u,"4")bM=aY(bj,b(),p[4],d)bG=aY(bj,b(),0,d)o=N(aX,N(bM,bG))bf=ax(p[1],0,p[2],d)/d
bt=P(b((o.g+ao.g*d),(o.f+ao.f*d),(o.c+ao.c*d)+ax(0,bo,p[2],d)))bn=bt-bf*d
if z then
d=G(d-bn*.01,1,p[3])else
d=G(d+bn*.01,1,p[3])end
o=bl(o,d,bW,br,aN)o.c=o.c+ax(0,bo,p[2],d)end
bg,U,aO=ak(ay(o,W))bg,bT,bH=ak(ay(o,O))Q=x(bT)<aJ and x(bH)<aJ
if ag then
C=Y(1,C+.006)else
C=0
end
aH=_(29)if aH~=9 then
U=aH
M=M/2
Q=y
else
M=M*C
end
al=_(30)if al~=9 then
aO=al
J=J/2
Q=y
else
J=J*C
end
X=aT((aF-G(U,-aC,ah))+s*3,Z)-s
aU=aT((bA-G(aO,-bR,bQ))+s*3,Z)-s
ba=S(O.H,W.H)if ba<.001 then
T=0
be=ba
else
if(U>0 and aF<0)and X>0 and(aC<s or ah<s)then
T=-aE
elseif(U<0 and aF>0)and X<0 and(ah<s or aC<s)then
T=aE
else
T=((X/Z)*M)+_(31)end
be=-((aU/Z)*J)+_(32)+bD
end
n(31,bk(T,aE))n(32,bk(be,bO))aQ=_(24)>0
if aQ==y then
au()end
n(1,o.g+u.g)n(2,o.f+u.f)n(3,o.c+u.c)n(4,u.g)n(5,u.f)n(6,u.c)n(7,_(7))n(8,_(8))n(9,_(9))n(10,d)n(11,aP)ab(1,((z and(d==1 or d==p[3]))or(z==y and d==p[3]))==y and ag)ab(2,Q)ab(3,(x(X)<.001 and aH~=9)or(x(aU)<.001 and al~=9))ab(4,aQ)end
end