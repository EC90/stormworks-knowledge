-- source: steam id 3228447235 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228447235
--Config--
Ai,Ad=0,0--I,D gain(Azim)
Aimax=0--Max int.
Ei,Ed=0,0--I,D gain(Elev)
Eimax=0--Max int.
M=60
ag={}
ah={}
--[[
EminT[1]={-91,-10}
EminT[2]={-90,-10}
EminT[3]={-30,-3}
EminT[4]={30,-3}
EminT[5]={90,-10}
EminT[6]={91,-10}
--]]
o=pi
an=min
a_=input
b0=output
bF=math
bH=property
aZ=a_.getBool
e=a_.getNumber
ai=b0.setBool
w=b0.setNumber
j=bF
o=j.pi
m=2*o
k=o/180
q=j.sin
n=j.cos
bG=j.tan
b1=j.asin
b2=j.acos
N=j.atan
V=bH.getNumber
b3={V("GPS X horizontal offset (m)"
),V("GPS Y directional offset (m)"
),V("Altimeter vertical offset (m)"
)}
function aj(b4,b5)
b=0
for a=1,3 do
b=b+(b4[a]-b5[a])^2 
end
return b^0.5 
end

function ak(B,f,i)
g={B*q(f)*n(i),B*n(f)*n(i),B*q(i)}
return g 
end

function O(g)
B=aj(g,{0,0,0})
f=N(g[1],g[2])
i=b1(g[3]/B)
return B,f,i 
end

function P(b6,g)
C={}
for a=1,3 do
b=0
for al=1,3 do
b=b+b6[al][a]*g[al]end
C[a]=b 
end
return C 
end

function b7(W)X,Y,Z=W[1],W[2],W[3]f,u,D,x,i,h,E,F,a=X[1],Y[1],Z[1],X[2],Y[2],Z[2],X[3],Y[3],Z[3]r=f*i*a+x*F*D+E*u*h-E*i*D-f*F*h-x*u*a
b8={(i*a-h*F)/r,(h*E-x*a)/r,(x*F-i*E)/r}
b9={(D*F-u*a)/r,(f*a-D*E)/r,(u*E-f*F)/r}
ba={(u*h-D*i)/r,(D*x-f*h)/r,(f*i-u*x)/r}return{b8,b9,ba},r 
end

function bb(s,g)
b=0
for a=1,3 do
b=b+s[a]*g[a]end
return b 
end

function bc(s,g)
Q={}Q[1]=s[2]*g[3]-s[3]*g[2]Q[2]=s[3]*g[1]-s[1]*g[3]Q[3]=s[1]*g[2]-s[2]*g[1]return Q 
end

function bd(t)
_={n(t[1])*q(-t[2]),n(t[1])*n(-t[2]),q(t[1])}
a0={n(t[3])*q(-t[4]),n(t[3])*n(-t[4]),q(t[3])}
be=bc(_,a0)
if j.abs(bb(_,a0))>0.1 then
am=true
else am=false
end
return{_,a0,be},am 
end

function R(v,an,ao)
if v<an or v>ao then
ap=true
else ap=false
end
return j.min(ao,j.max(an,v)),ap 
end

function aq(v,h)if#h==1 then
f,u=0,h[1][2]G=1
else 
if v<h[1][1]then
G,S=1,2 
elseif v>h[#h][1]then
G,S=#h-1,#h else 
for a=1,#h-1 do
if v>=h[a][1]and v<h[a+1][1]then
G,S=a,a+1
break 
end
end
end
a1,a2,ar,as=h[G][1],h[S][1],h[G][2],h[S][2]f,u=(ar-as)/(a1-a2),(a1*as-a2*ar)/(a1-a2)
end
return f*v+u,G 
end

function H(f,i)
a3=bf
if#ag~=0 then
b=aq(f/k,ag)*k
a3=j.max(a3,b)
end
a4=bg
if#ah~=0 then
b=aq(f/k,ah)*k
a4=j.min(a4,b)
end
if f>o then
f=f-m 
elseif f<-o then
f=f+m 
end
f,bh=R(f,bi,bj)i,bk=R(i,a3,a4)
return f,i,bh,bk 
end

function A(a5,a6)
g=ak(1,a5,a6)
C=P(y,g)b,a7,a8=O(C)
return a7,a8 
end

function at(a7,a8)
C=ak(1,a7,a8)
g=P(bl,C)b,a5,a6=O(g)
return a5,a6 
end

function au(i,bm,a,x,av,z,bn,bo,bp)
z=z+i
if j.abs(z)>av then
z=av*z/j.abs(z)
end
bq=i-bn
aw=bm*i+a*z+x*bq
br=aw-bo
s=bp+br
return s,z,aw 
end
ax,a9,ay={},{},{}c,d=0,0
aa=0.5
az=2.2-aa*(2.2-0.025)
I=1
aA,aB,aC,aD=0,0,0,0
aE,aF,aG,aH=0,0,0,0
function onTick()
bs,bt=e(5),e(6)
bu=e(11)
bv=e(12)
ab=e(13)/60*k
bi=e(14)*k
bj=e(15)*k
ac=e(16)/60*k
bf=e(17)*k
bg=e(18)*k
bw=e(19)*k
bx=e(20)*k
aI=e(21)
by={e(28)*m,e(29)*m,e(30)*m,e(31)*m}y,aJ=bd(by)bl,b=b7(y)
bz=P(y,b3)
for a=1,3 do
ax[a]=e(a+24)a9[a]=e(a+21)ay[a]=a9[a]-ax[a]-bz[a]end
if aj(a9,{0,0,0})==0 then
aK=false
else aK=true
end
bA=aZ(30)T,U=e(bu),e(bv)
if j.abs(T)>0.01 then
aL=true
else aL=false
end
if j.abs(U)>0.01 then
ad=true
else ad=false
end
aM=e(32)
if I==M then
aa=aM
az=2.2-aa*(2.2-0.025)c,d=0,0
ae=P(y,{0,1,0})b,p,l=O(ae)
end
bB=2.2-aM*(2.2-0.025)
J=bB/az
aN,aO=e(7)*m,e(8)*m
if aK then
ae=ay
b,p,l=O(ae)c,d=at(p,l)c,d,K,L=H(c,d)p,l=A(c,d)
elseif bA then
c,d=e(9)*m+bw,e(10)*m+bx
c,d,K,L=H(c,d)p,l=A(c,d)else 
if aI==2 and not aJ and I>M then
if aL then
p,b=A(c,d)
end
if ad then
b,l=A(c,d)
end
p,l,b=p+T*ab*J,R(l+U*ac*J,-o/2,o/2)c,d=at(p,l)c,d,K,L=H(c,d)
elseif aI==1 and not aJ and I>M then
if ad then
b,l=A(c,d)
end
c=c+T*ab*J
c,b,K,b=H(c,d)l,b=R(l+U*ac*J,-o/2,o/2)
b={}
for a=1,3 do
b[a]=y[1][a]*q(c)+y[2][a]*n(c)
end
af=b2(q(-l)/(b[3]^2+y[3][3]^2)^0.5)
if af==af then
bC=N(b[3],y[3][3])
d=af-bC-o/2
b,d,b,L=H(c,d)p,b=A(c,d)
end
else c,d=c+T*ab*J,d+U*ac*J
c,d,K,L=H(c,d)p,l=A(c,d)
end
end
aP=N(q(c-aN),n(c-aN))/m
aQ,aA,bD=au(aP,bs,Ai,Ad,Aimax,aA,aB,aC,aD)
aR=N(q(d-aO),n(d-aO))/m
aS,aE,bE=au(aR,bt,Ei,Ed,Eimax,aE,aF,aG,aH)aB,aC,aD=aP,bD,aQ
aF,aG,aH=aR,bE,aS
w(1,c*2/o)
w(2,d*2/o)
w(3,aQ)
w(4,aS)
w(29,p/k)
w(30,l/k)
w(31,c/k)
w(32,d/k)
ai(1,K)
ai(2,L)
if I<=M then
I=I+1 
end
end