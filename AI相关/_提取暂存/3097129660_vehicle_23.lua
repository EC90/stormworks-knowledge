-- source: steam id 3097129660 / vehicle.xml block#23
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
w,h=96,96
t1,t2={},{}
vzo=0
I=input.getNumber
W=input.getBool
O=output.setNumber
Z=output.setBool
SF=string.format
M=math
P=2*M.pi
U=M.sin
V=M.cos
function Mf(x) return M.floor(x+0.5) end
Mr=M.sqrt
Mx=M.max
Mn=M.min
nm={'EO pod',2,3,4,'GPS BMB',6,'RKT','ARM','AShM','AAM',11,'GUN'}
S=screen
SC=S.setColor
DC=S.drawCircle
DT=S.drawText
J=S.drawTextBox
DR=S.drawRect
T=table
AG={0,0,-0.5}
function C(x)
if x==1 then SC(22,222,22) else SC(222,22,22) end end
function B(x,y,a,l)
S.drawLine(x,y,x+l*U(0.125*a*P),y-l*V(0.125*a*P))
end
function N(x,y,s)
x=Mf(x) y=Mf(y)
s=tostring(s) 
local l=string.len(s)
for i=1,l do
local n,w=s:sub(i,i),4
if n=="1"then B(x+2,y,4,5)
elseif n=="2"then B(x,y,2,2) B(x+2,y,4,2) B(x+2,y+2,6,2) B(x,y+2,4,2) B(x,y+4,2,3)
elseif n=="3"then B(x,y,2,2) B(x+2,y,4,5) B(x+1,y+2,6,1) B(x+1,y+4,6,2)
elseif n=="4"then B(x,y,4,2) B(x,y+2,2,2) B(x+2,y,4,5)
elseif n=="5"then B(x,y,2,3) B(x,y+1,4,2) B(x+1,y+2,2,2) B(x+2,y+3,4,2) B(x,y+4,2,2)
elseif n=="6"then DR(x,y+2,2,2)	B(x+1,y,2,2) B(x,y,4,2)
elseif n=="7"then B(x,y,2,3) B(x+2,y+1,4,4)
elseif n=="8"then DR(x,y,2,4) B(x+1,y+2,2,1)
elseif n=="9"then DR(x,y,2,2) B(x+2,y+3,4,2) B(x,y+4,2,2)
elseif n=="."then B(x,y+4,2,1) w=2
elseif n=='0'then DR(x,y,2,4)
elseif n=='T'then B(x,y,2,3) B(x+1,y+1,4,4)
elseif n=='H'then B(x+1,y+2,2,1) B(x,y,4,5) B(x+2,y,4,5)
elseif n==" "then w=3
else DT(x,y,n) w=5 end x=x+w end end
function Av(n,v,t)
T.insert(n,v)
local s=0
if #n>t then for i=1,#n-t do T.remove(n,1) end end
for i=1,#n do s=s+n[i] end return s/#n end
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{V(y)*V(z),V(x)*V(y)*U(z)+U(x)*U(y),U(x)*V(y)*U(z)-V(x)*U(y)},{-U(z),V(x)*V(z),U(x)*V(z)},{U(y)*V(z),V(x)*U(y)*U(z)-U(x)*V(y),U(x)*U(y)*U(z)+V(x)*V(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function L2G(l) return Mv(tM(E2R(E)),l) end
function L2AE(l) return M.atan(l[1],l[2]),M.atan(l[3],l[2]) end
F=1.1125
function onTick()
p,r,c=I(15),I(16),I(17)
X=h*0.5*I(21)/F
Y=h*(-1.38*I(22)-0.0439)/F
A=Mn(I(23),I(2))
O(1,-r*8)
O(2,p*8)
E={I(4),I(6),I(5)}
as=Mv(E2R(E),{I(10),I(12),I(11)})
vz=Av(t2,Mx(I(9),0),15)
Gg=L2G({as[3]*P*vz,(vzo-vz)*60,-as[1]*P*vz})
G=Av(t1,Mr(Gg[1]^2+Gg[2]^2+(Gg[3]+9.8)^2)/9.8,15)
thr=I(25)
vzo=vz
aP=vz>75 and A<80 and p<0.001
aL=vz<45 and A>50
aO=G>6
aG=((vz<75 and p<-0.005 and A<100 and W(1)) or (vz>100 and not W(1)))
Z(1,aP)
Z(2,aL)
Z(3,aO)
Z(4,aG)
if W(5) then
if W(4) then
mg='BVR 16km'
else
mg='SR 2.5km'
end
else
mg=''
end
if W(6) then mg=mg..' radio' end
w1=I(26) w2=I(27)
O(3,I(28))
O(4,I(29))
ml=I(30)
Z(5,W(7) or (ml>0 and w1==10))
Ax,Ay=0,0
if w1==7 or w1==12 then
if w1==7 then
lf=2400
dg=0.998
rP=10
v0=50
Ay=-0.08
else
lf=300
dg=0.975
rP=0
v0=2400
end
aim=I(31)
rp={I(1),I(3),I(2)}
rv=L2G({I(7),I(9)+v0,I(8)})
arm=false
td=I(2)/M.tan(-p*P)
if ir or (td<3000 and td>0) then arm=true end
if arm then
vadd=L2G({0,rP,0})
for i=1,lf do
for j=1,3 do
rp[j]=rp[j]+rv[j]/60
rv[j]=rv[j]*dg+AG[j]
if i<60 then
rv[j]=rv[j]+vadd[j]
end
end
if rp[3]<aim then Ax,Ay=L2AE(Mv(E2R(E),{rp[1]-I(1),rp[2]-I(3),rp[3]-I(2)})) break end
end
end
else
Ax,Ay=0,-0.1
end
O(21,Ax)
O(22,Ay)
end
function onDraw()
C(1)
x=w-16+X y=3+Y
N(x,y,'G'..SF('%.1f',G))
x=w-21+X y=h-13+Y
N(x,y,'R'..SF('%04.0f',A))
x=w-21+X y=h-7+Y
N(x,y,'THR'..SF('%02.0f',Mx(Mn(99,thr*100),0)))
x=1+X y=h-13+Y
N(x,y,nm[w1])
x=1+X y=h-7+Y
N(x,y,SF('%0.0f',w2)..'RND')
x=X y=13+Y
J(Mf(x),Mf(y),w,6,mg,0,0)
if w1==10 then
a=h*0.045*P/F
b=h*0.03*P/F
x=Mf(w/2+X) y=Mf(h/2+Y)
if ml>1 then C(2) else C(1) end
DR(x-b,y-b,2*b,2*b)
if ml>0 then C(2) else C(1) end
DR(x-a,y-a,2*a,2*a)
end
a=h*Ax/F
b=h*Ay/F
x=Mf(w/2+a+X) y=Mf(h/2-b+Y-0.5)
if w1==7 then
for i=1,4 do
a=(i+0.5)*P/4
S.drawLine(x+3*U(a),y+3*V(a),x+1*U(a),y+1*V(a))
end
end
if w1==12 then
DC(x,y,0.9)
end
C(2)
x=X y=h/2+Y+7
if aP then x=Mf(X) y=Mf(h/2+Y) J(x,y,w,6,'pull up',0,0) end
if aL then J(x,y,w,6,'Low SPD',0,0) end
if aO then J(x,y+6,w,6,'Over G',0,0) end
if aG then J(x,y+6,w,6,'Gear',0,0) end
end