-- source: steam id 2793934450 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793934450

m=255
aK=string
W=math
aG=property
aD=input
B=screen
aE=B.drawText
K=B.setColor
aA=aD.getBool
aJ=aG.getText
A=aG.getNumber
S=aD.getNumber
ag=W.cos
ao=W.sin
function R(a,g,r,t)a=a or{}a[1]=g or 0
a[2]=r or 0
a[3]=t or 0
return a
end
function bf(C,O,a)for _=1,#C do
a[_]=C[_]+O[_]end
return a
end
function aI(bb,aS,a)a=a or{}for _=1,aS do
a[_]=a[_]or{}for w=1,bb do
a[_][w]=0
end
end
return a
end
function bl(C,O,a)a=a or{}for _=1,#O do
a[_]=a[_]or{}for w=1,#C[1]do
a[_][w]=0
for aQ=1,#C do
a[_][w]=a[_][w]+C[aQ][w]*O[_][aQ]end
end
end
return a
end
function be(aw,ax,a)for _=1,3 do
a[_]=aw[1][_]*ax[1]+aw[2][_]*ax[2]+aw[3][_]*ax[3]end
return a
end
function bg(az,aH,ay,a)a=a or aI(3,3,a)local d,c,i,I,Q,E=ao(az),ao(aH),ao(ay),ag(az),ag(aH),ag(ay)a[1][1]=Q*E
a[1][2]=Q*i
a[1][3]=-c
a[2][1]=-I*i+d*c*E
a[2][2]=I*E+d*c*i
a[2][3]=d*Q
a[3][1]=d*i+I*c*E
a[3][2]=-d*E+I*c*i
a[3][3]=I*Q
return a
end
function bd(g,M,aF)return g<M and M or g>aF and aF or g
end
function ah(g,r,t)return S(g),S(r),S(t)end
local aL,aM=A("w"),A("h")local ae,aq=aL/2,aM/2
local aP,aO=ae+A("pxOffsetX"),aq+A("pxOffsetY")local au,N=A("near")+.47,A("far")local bn=au*N
local aZ=au-N
local b={}local bi=function(b,u)for _=1,#u.g do
local h,k,j,e=u.g[_],u.r[_],u.t[_],1
h,k,j,e=b[1]*h+b[5]*k+b[9]*j+b[13],b[2]*h+b[6]*k+b[10]*j+b[14],b[3]*h+b[7]*k+b[11]*j+b[15],b[4]*h+b[8]*k+b[12]*j+b[16]u.y[_]=0<=j and j<=e
and-e<=h and h<=e
and-e<=k and k<=e
if u.y[_]then
e=1/e
u.d[_]=h*e*ae+aP
u.c[_]=k*e*aq+aO
u.i[_]=j*e
end
end
end
local bj=function(b,f,x,aT)local bc,bm,aR,d,c,i,aY,aa,J,T=f.g,f.r,f.t,f.d,f.c,f.i,f.H,f.y,f.aV,{}for _=1,#x do
local D=x[_]for w=1,3 do
local s=D[w]if aY[s]~=aT then
local h,k,j,e=bc[s],bm[s],aR[s],1
h,k,j,e=b[1]*h+b[5]*k+b[9]*j+b[13],b[2]*h+b[6]*k+b[10]*j+b[14],b[3]*h+b[7]*k+b[11]*j+b[15],b[4]*h+b[8]*k+b[12]*j+b[16]J[s]=0<=j and j<=e
if J[s]then
aa[s]=-e<=h and h<=e
and-e<=k and k<=e
e=1/e
d[s]=h*e*ae+aP
c[s]=k*e*aq+aO
i[s]=j*e
end
end
end
local n,o,p=D[1],D[2],D[3]if
J[n]and J[o]and J[p]and(aa[n]or aa[o]or aa[p])and(d[n]*c[o]-d[o]*c[n]+d[o]*c[p]-d[p]*c[o]+d[p]*c[n]-d[n]*c[p]>0)then
D[4]=i[n]+i[o]+i[p]T[#T+1]=D
end
end
table.sort(T,function(aU,b_)return aU[4]>b_[4]end)return T
end
local aX=aJ("b64")local function ba(V)local ad=0
for _=1,6 do
ad=ad|(aX:find(V:sub(_,_))-1<<((6-_)*6))end
return(aK.unpack("f",aK.pack("I",ad)))end
local af=function(bh,aW)local X,ac,L,F={},0,1,1
repeat
ac=ac+1
local V=aJ(bh..ac)for M in V:gmatch("......")do
X[L]=X[L]or{}X[L][F]=ba(M)F=F+1
if F>aW then
L,F=L+1,1
end
end
until V==""
return X
end
local an,U,al=af("v",3),af("t",3),af("c",3)local f,aB,x={g={},r={},t={},d={},c={},i={},H={},aV={},y={}},{},{}local aC,Z,bk,l={},{},A("Laser_amount"),{g={},r={},t={},d={},c={},i={},y={}}local av,q,H=aI(3,3),R(),0
for _=1,#U do
aB[_]={U[_][1],U[_][2],U[_][3],0,al[_][1],al[_][2],al[_][3]}end
function onTick()aN=aA(1)if aA(2)then
l.g={}l.r={}l.t={}end
if aN then
for _=1,16 do
b[_]=S(_)end
R(aC,ah(17,18,19))R(Z,ah(20,21,22))for _=1,bk do
local as=(_-1)*3
R(q,ah(23+as,24+as,25+as))if q[1]~=0 and q[2]~=0 then
local ai=#l.g+1
l.g[ai]=q[1]l.r[ai]=q[2]l.t[ai]=q[3]end
end
end
end
local am,at,aj
am={0,0,m,m,m}at={m,0,0,m,m}aj={0,m,0,0,m}function onDraw()if aN then
H=H+1
bi(b,l)local y,d,c,i,ar=l.y,l.d,l.c,l.i,0
local ap,ab,ak,v,G,Y,P
for _=1,#l.g do
if y[_]then
ar=ar+1
ap=au/(N+i[_]*aZ)ab=ap*N
ak=ap*4
v=W.floor(ak)G=ak-v
Y=1-G
v=v+1
P=v+1
K(am[v]*Y+am[P]*G,at[v]*Y+at[P]*G,aj[v]*Y+aj[P]*G,bd(300-ab,100,240))B.drawCircleF(d[_],c[_],W.max(25/ab,1))end
end
K(0,0,0,150)B.drawRectF(0,0,aL,aM)bg(Z[1],Z[2],Z[3],av)bl(av,an,f)for _=1,#an do
bf(be(av,an[_],q),aC,q)f.g[_]=q[1]f.r[_]=q[2]f.t[_]=q[3]end
x=bj(b,f,aB,H)d,c=f.d,f.c
for _=1,#x do
local z=x[_]local n,o,p=z[1],z[2],z[3]if z then
K(z[5],z[6],z[7],225)B.drawTriangleF(d[n],c[n],d[o],c[o],d[p],c[p])K(m,m,m,100)B.drawTriangle(d[n],c[n],d[o],c[o],d[p],c[p])end
end
K(m,m,0,100)aE(0,7,"L:"..ar)aE(0,14,"T:"..#x)end
end
