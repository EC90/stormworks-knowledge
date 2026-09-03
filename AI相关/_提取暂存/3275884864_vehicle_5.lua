-- source: steam id 3275884864 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864

a5=input
a7=output
a8=pi
a9=table
aa=min
ab=max
am=property
an=math
--yyy--
al=a5.getBool
m=a5.getNumber
a6=a7.setNumber
A=a7.setBool
B=am.getNumber
e=an
s=e.abs
function R(i)
return e.floor(i+0.5)
end
ao=e.floor
S=e.sqrt
g=e.cos
h=e.sin
a8=e.pi
n=a8*2
C=a9
t=C.insert
T={0,0,0}
function ap(i,aa,ab)
return e.max(aa,e.min(i,ab))
end

function U(q,D,j)
j=e.max(R(j),1)
t(q,D)
local E=0
if#q>j then
for b=1,#q-j do
a9.remove(q,1)
break 
end
end
for b=1,#q do
E=E+q[b]end
return E/#q 
end

function V(ac,ad)
return e.atan(ad,ac)/n 
end

function W(o)
local i,k,l=o[1],o[2],o[3]return{{g(k)*g(l),g(i)*g(k)*h(l)+h(i)*h(k),h(i)*g(k)*h(l)-g(i)*h(k)},{-h(l),g(i)*g(l),h(i)*g(l)},{h(k)*g(l),g(i)*h(k)*h(l)-h(i)*g(k),h(i)*h(k)*h(l)+g(i)*g(k)}}
end

function ae(e)
local j={{},{},{}}
for b=1,3 do
for c=1,3 do
j[b][c]=e[c][b]end
end
return j 
end

function X(e,D)
local j={}
for b=1,3 do
f=0
for c=1,3 do
f=f+e[c][b]*D[c]end
j[b]=f 
end
return j 
end

function af(d)
local j=X(ae(W(Y)),{d[1]*g(d[3]*n)*h(d[2]*n),d[1]*g(d[3]*n)*g(d[2]*n),d[1]*h(d[3]*n)})return{j[1]+r[1],j[2]+r[2],j[3]+r[3]}
end

function ag(F)
return X(W(Y),{F[1]-r[1],F[2]-r[2],F[3]-r[3]})
end

function ah(G)
local i,k,l=G[1],G[2],G[3]return e.atan(i,k),e.atan(l,k)
end

function aq(Z,_)
return s(Z.r[2])+s(Z.r[3])<s(_.r[2])+s(_.r[3])
end

function ai(H,I)
return S((H[1]-I[1])^2+(H[2]-I[2])^2+(H[3]-I[3])^2)
end
a={}
J=1
K=B('md')
ar=0
as=0
v=0
at=-1
function onTick()
L=B('at')
a0=B('vt')
r={m(4),m(8),m(12)}
Y={m(16),m(20),m(24)}if#a>0 then
for b=1,#a do
if a[b].l>10 then
C.remove(a,b)
break 
end
end
end
for b=1,8 do
if m(4*b-3)>25 then
w=0
d={}
d.r={m(4*b-3),m(4*b-2),m(4*b-1)}
d.p=af(d.r)if#a>0 then
for c=1,#a do
x={}
for p=1,3 do
x[p]=s(a[c].r[p]-d.r[p])
end
if x[2]<0.002+V(a[c].r[1],K+a[c].va)and x[3]<0.002+V(a[c].r[1],K+a[c].va)and x[1]<0.02*a[c].r[1]+K+a[c].va then
t(a[c].pb,d.p)a[c].l=0
w=0
break else w=1
end
end
else w=1
end
if w>0 then
d.pb={d.p}
d.g=d.p
d.b={}
d.v=T
d.va=0
d.vb={{0},{0},{0}}
d.l=0
d.s=1
d.id=J
d.d=0
d.db={}
J=J+1
t(a,d)
end
end
end
M=false
N=0
if#a>0 then
for b=1,#a do
if a[b].l==0 then
f=#a[b].pb
if f>1 then
O,P,Q=0,0,0
for c=1,f do
O=O+a[b].pb[c][1]P=P+a[b].pb[c][2]Q=Q+a[b].pb[c][3]end
t(a[b].b,{O/f,P/f,Q/f})else t(a[b].b,a[b].pb[1])
end
aj=a[b].r[1]u=a[b].b[#a[b].b]y,ak=ah(ag(u))
a1=ai(u,r)a[b].r={a1,y/n,ak/n}a[b].d=U(a[b].db,a1-aj,a0)a[b].pb={}
f=#a[b].b
if f>L then
for p=1,f-L do
C.remove(a[b].b,1)
end
end
f=#a[b].b
o=e.max(e.min(f-1,R(a[b].r[1]/2000*L)),1)a[b].s=o
if f>2 then
z=T
for c=f,f-o+1,-1 do
for p=1,3 do
z[p]=z[p]+a[b].b[c][p]end
end
a2={}a[b].g={}
for c=1,3 do
a2[c]=a[b].p[c]y=z[c]/o
a[b].p[c]=y
u=U(a[b].vb[c],z[c]/o-a2[c],a0)a[b].v[c]=u
a[b].g[c]=y+u*(a[b].s+5)*0.5 
end
a[b].va=S(a[b].v[1]^2+a[b].v[2]^2+a[b].v[3]^2)
if a[b].va>1 and a[b].va<10 and-a[b].d/a[b].va>0.9 then
M=true
N=a[b].r[2]end
else a[b].p=a[b].b[f]a[b].g=a[b].p 
end
end
a[b].l=a[b].l+1 
end
end
if M then
v=(v+1)%60
if v==10 then
if N>0 then
a3=true
else a4=true
end
else a3,a4=false,false 
end
else v=0
end
a6(32,N)
A(30,M)
A(31,a3)
A(32,a4)end