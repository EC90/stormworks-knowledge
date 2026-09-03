-- source: steam id 3792235232 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792235232

m=math
s,tau=screen,m.pi*2
IN,IB,ON,PN=input.getNumber,input.getBool,output.setNumber,property.getNumber
function mat_mult(a,b)
local c={}
for d=1,#a do
c[d]={}
for e=1,#b[1]do
c[d][e]=0
for f=1,#b do
c[d][e]=c[d][e]+a[d][f]*b[f][e]end
end
end
return c 
end

function mat_trans(a)
local c={}
for d=1,#a[1]do
c[d]={}
for e=1,#a do
c[d][e]=a[e][d]end
end
return c 
end

function mat_op(a,b,g)
local c={}
for d=1,#a do
c[d]={}
for e=1,#a[1]do
if g==0 then
c[d][e]=a[d][e]+b[d][e]elseif g==1 then
if#b[d]==1 then
c[d][e]=a[d][e]-b[d][1]else c[d][e]=a[d][e]-b[d][e]end
else c[d][e]=a[d][e]*b 
end
end
end
return c 
end

function mat_inv(m)
local h=m[2][2]*m[3][3]-m[3][2]*m[2][3]local i=m[2][3]*m[3][1]-m[2][1]*m[3][3]local j=m[2][1]*m[3][2]-m[3][1]*m[2][2]local k=m[1][1]*h+m[1][2]*i+m[1][3]*j
local l=1/k
return{{h*l,(m[1][3]*m[3][2]-m[1][2]*m[3][3])*l,(m[1][2]*m[2][3]-m[1][3]*m[2][2])*l},{i*l,(m[1][1]*m[3][3]-m[1][3]*m[3][1])*l,(m[2][1]*m[1][3]-m[1][1]*m[2][3])*l},{j*l,(m[3][1]*m[1][2]-m[1][1]*m[3][2])*l,(m[1][1]*m[2][2]-m[2][1]*m[1][2])*l}},k 
end
timeout=PN("Timeout (seconds)"
)
tick_delay=PN("Delay Compensation (ticks)"
)
initial_var=PN("Intital Covariance"
)
process=PN("Process Noise"
)
store=PN("On Target Loss"
)==0
swap=PN("Swap Y&Z"
)==1
function dst_update(n)
local o={}
local p=n/60
for d=1,9 do
o[d]={}
local q=(d-1)//3
for e=1,9 do
local r=(e-1)//3
o[d][e]=(d-1)%3==(e-1)%3 and p^(4-q-r)/2^(m.max(1-q,0)+m.max(1-r,0))or 0 
end
end
local t=2*(n+1)*(n+2)
local u=(tau*0.002)^2/t
return mat_op(o,process),t,{{1,0,0},{0,u,0},{0,0,u}}
end
Q,den,R=dst_update(1)
I={}
H={}
for d=1,9 do
I[d]={}H[d]=d<4 and{}
or nil
for e=1,9 do
I[d][e]=d==e and 1 or 0 
end
end
F=mat_op(I,1)
for d=4,9 do
F[d-3][d]=1/60
F[d-3][d+3]=.5*(1/60)^2 
end
N=9
num_points=2*N+1
kappa=3-N
Nkappa=N+kappa
W={{}}
Wd={}
for d=1,num_points do
W[1][d]=1/(2*Nkappa)Wd[d]={}
for e=1,num_points do
Wd[d][e]=d==e and W[1][d]or 0 
end
end
W[1][1]=kappa/Nkappa
Wd[1][1]=kappa/Nkappa
tick=0
htsd=0
function onTick()
rx,ry,rz=IN(4),IN(5),IN(6)cx,cy,cz=m.cos(rx),m.cos(ry),m.cos(rz)sx,sy,sz=m.sin(rx),m.sin(ry),m.sin(rz)
O={{cy*cz,cy*sz,-sy},{-cx*sz+sx*sy*cz,cx*cz+sx*sy*sz,sx*cy},{sx*sz+cx*sy*cz,-sx*cz+cx*sy*sz,cx*cy}}
mpos={{IN(1)},{IN(2)},{IN(3)}}
auto=IB(2)
data={}
tsd=IN(32)
if tsd>htsd then
htsd=tsd
Q,den,R=dst_update(tsd+1)
end
for d=1,8 do
data[d]={IN(d*3+4),IN(d*3+5)*tau,IN(d*3+6)*tau}
end
if X~=nil then
L=mat_op(Pp,0)
for d=1,#L do
for e=1,d do
local v=0
for f=1,e-1 do
v=v+L[d][f]*L[e][f]end
if d==e then
L[d][e]=m.sqrt(m.abs(Pp[d][d]*Nkappa-v))else L[d][e]=(Pp[d][e]*Nkappa-v)/L[e][e]end
end
end
V=mat_op(X,1)
for d=1,N do
for e=1,N do
V[e][d+1]=X[e][1]+L[e][d]V[e][N+d+1]=X[e][1]-L[e][d]end
end
V=mat_mult(F,V)
X=mat_mult(V,mat_trans(W))
D=mat_op(V,X,1)
Pp=mat_mult(mat_mult(D,Wd),mat_trans(D))
end
if tsd~=0 and radar~=nil then
for d=1,8 do
for e=1,3 do
radar[d][e]={m.min(data[d][e],radar[d][e][1]),m.max(data[d][e],radar[d][e][2])}
end
end
else 
if not auto or tick>60*timeout/(htsd+1)then
tick=0
radar=nil
X=nil
end
if IB(1)and radar~=nil then
tick=0
Z={}
for d=1,8 do
Z[d]={}
for e=1,3 do
Z[d][e]={(radar[d][e][1]+radar[d][e][2])/2}
end
end
world={}
for d=1,8 do
local w=Z[d]if w[1][1]>0 then
world[d]=mat_op(mat_mult(mat_trans(O_tsd),{{w[1][1]*m.cos(w[3][1])*m.sin(w[2][1])},{m.sin(w[3][1])*w[1][1]},{w[1][1]*m.cos(w[3][1])*m.cos(w[2][1])}}),mpos_tsd,0)else world[d]=nil 
end
end
if X~=nil then
Pp=mat_op(Pp,Q,0)
nearest={0,0}
for f,w in ipairs(world)do
local x=m.sqrt((w[1][1]-X[1][1])^2+(w[2][1]-X[2][1])^2+(w[3][1]-X[3][1])^2)
if x<nearest[2]or nearest[2]==0 then
nearest={f,x}
end
end
for e=1,num_points do
local y=mat_mult(O_tsd,mat_op({{V[1][e]},{V[2][e]},{V[3][e]}},mpos_tsd,1))
local z=y[1][1]^2+y[3][1]^2
H[1][e]=m.sqrt(z+y[2][1]^2)H[2][e]=m.atan(y[1][1],y[3][1])H[3][e]=m.atan(y[2][1],m.sqrt(z))
end
H_=mat_mult(H,mat_trans(W))
H=mat_op(H,H_,1)R[1][1]=(H_[1][1]*0.02)^2/den
pp=mat_op(mat_mult(mat_mult(H,Wd),mat_trans(H)),R,0)pp_i,pp_d=mat_inv(pp)
K=mat_mult(mat_mult(D,Wd),mat_trans(H))
K=mat_mult(K,pp_i)
if nearest[1]~=0 then
X=mat_op(X,mat_mult(K,mat_op(Z[nearest[1]],H_,1)),0)
Pp=mat_op(Pp,mat_mult(mat_mult(K,pp),mat_trans(K)),1)
end
end
if X==nil and world[1]~=nil and auto then
nearest={0,0}
for d=1,8 do
local x=m.sqrt(Z[d][2][1]^2+Z[d][3][1]^2)
if Z[d][1][1]>0 and x<nearest[2]or nearest[2]==0 then
nearest={d,x}
end
end
Pp=mat_op(I,initial_var)
X=world[nearest[1]]for d=4,9 do
X[d]={0}
end
end
end
if X~=nil and not IB(1)then
tick=tick+1 
end
O_tsd={O[1],O[2],O[3]}
mpos_tsd={mpos[1],mpos[2],mpos[3]}
radar={}
for d=1,8 do
radar[d]={}
for e=1,3 do
radar[d][e]={data[d][e],data[d][e]}
end
end
end
if store then
ON(2,-100)
end
if X~=nil then
for d=1,9 do
local e=d
if swap then
if(d-1)%3==1 then
e=d+1 
elseif(d-1)%3==2 then
e=d-1 
end
end
if tick_delay~=0 and d<4 then
output.setNumber(d,X[e][1]+X[e+3][1]*tick_delay/60)else output.setNumber(d,X[e][1])
end
end
end
end