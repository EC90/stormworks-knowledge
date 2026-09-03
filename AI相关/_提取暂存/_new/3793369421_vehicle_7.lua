-- source: steam id 3793369421 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793369421
bg=244
bf=true
be=false
bd=nil
bc=input
bb=screen
Z=table.insert
Y=bb.drawText
X=bb.drawRect
W=bb.drawRectF
V=bb.drawClear
U=bb.setColor
T=bc.getNumber
b={{0,1,0,1,0,1,0,1},{1,0,1,0,1,0,1,0},{0,1,0,1,0,1,0,1},{0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0},{3,0,3,0,3,0,3,0},{0,3,0,3,0,3,0,3},{3,0,3,0,3,0,3,0}}c={}d=bd
e=be
f=be
function onTick()g=bc.getBool(1)h=T(3)i=T(4)if d==bd then
d=j(b)end
if g then
k=k+1
if k==30 then
f=bf
end
else
k=0
end
if g and not l then
if not f then
for m=1,8 do
for n=1,8 do
if o(n*8-7,m*8-7,8,8)then
if p then
q={n,m}local r=s(e)local t=u(p[2],p[1])if r then
t=u(p[2],p[1],bf)end
for v=1,#t do
if(t[v][1]==q[2] and t[v][2]==q[1])then
w(p[1],p[2],q[1],q[2])x=j(d)d[q[2]][q[1]]=d[p[2]][p[1]]
d[p[2]][p[1]]=0
if r then
local y=u(q[2],q[1],bf)if #y==0 then
e=not e
else
break
end
else
e=not e
end
z(m,n)q=bd
p=bd
y=bd
break
end
end
end
if d[m][n] ~=0 then
if e and(d[m][n]==1 or d[m][n]==2)then
p={n,m}elseif not e and(d[m][n]==3 or d[m][n]==4)then
p={n,m}end
end
end
end
end
else
if o(13,14,38,9)then
d=j(b)e=be
f=be
elseif o(13,26,38,9)then
f=be
end
end
end
l=g
end
function onDraw()U(37,10,7)V()if not f then
U(135,70,47)for n=0,56,16 do
W(n,0,8,8)W(n+8,8,8,8)W(n,16,8,8)W(n+8,24,8,8)W(n,32,8,8)W(n+8,40,8,8)W(n,48,8,8)W(n+8,56,8,8)end
for n=1,8 do
for m=1,8 do
local A=d[m][n]
if A>0 then
B=n*8-7
C=m*8-7
D(B,C,A)end
if p then
local r=s(e)local t=u(p[2],p[1])if r then
t=r
end
if t then
for v=1,#t,1 do
U(bg,90,10)X(t[v][2]*8-6,t[v][1]*8-6,3,3)end
end
end
end
end
else
U(135,70,47)V()U(37,10,7)X(13,14,37,8)X(13,26,37,8)Y(15,16,"Restart")Y(17,28,"Resume")end
end
function j(E)local F={}for G,H in pairs(E)do
if type(H)=="table" then
H=j(H)end
F[G]=H
end
return F
end
function D(n,m,A)U(0,0,0)if p then
if p[1]*8-7==n and p[2]*8-7==m then
U(bg,90,10)end
else
U(0,0,0)end
W(0+n,1+m,6,4)W(1+n,0+m,4,6)if A>=3 then
U(19,39,7)else
U(111,8,8)end
W(1+n,2+m,4,2)W(2+n,1+m,2,4)if A==2 or A==4 then
U(bg,90,10)W(2+n,2+m,2,2)end
end
function w(I,J,K,L)local M=0
local N=0
if I-K==-2 then
M=I+1
elseif I-K==2 then
M=I-1
end
if J-L==-2 then
N=J+1
elseif J-L==2 then
N=J-1
end
if M>0 then
d[N][M]=0
end
end
function z(n,m)local O=d[n][m]
if O==1 and n==8 then
d[n][m]=2
elseif O==3 and n==1 then
d[n][m]=4
end
end
function s(P)local r={}for n=1,8 do
for m=1,8 do
local O=d[m][n]
local t=u(m,n)if t then
for v=1,#t,1 do
if t[v][3] then
if P and(O==1 or O==2)then
Z(r,{t[v][1],t[v][2]})elseif not P and(O==3 or O==4)then
Z(r,{t[v][1],t[v][2]})end
end
end
end
end
end
if #r>0 then
return r
end
end
function u(n,m,Q)local t={}local r={}local O=d[n][m]
if O==1 or O==2 or O==4 then
if n<8 and m<8 then
if d[n+1][m+1]==0 then
Z(t,{n+1,m+1})elseif d[n+1][m+1]==3 or d[n+1][m+1]==4 or(O==2 and(d[n+1][m+1]==3 or d[n+1][m+1]==4))or(O==4 and(d[n+1][m+1]==1 or d[n+1][m+1]==2))then
if n<7 and m<7 then
if d[n+2][m+2]==0 and not(O==4 and(d[n+1][m+1]==3 or d[n+1][m+1]==4))then
Z(t,{n+2,m+2,bf})end
end
end
end
if n<8 and m>1 then
if d[n+1][m-1]==0 then
Z(t,{n+1,m-1})elseif d[n+1][m-1]==3 or d[n+1][m-1]==4 or(O==2 and(d[n+1][m-1]==3 or d[n+1][m-1]==4))or(O==4 and(d[n+1][m-1]==1 or d[n+1][m-1]==2))then
if n<7 and m>2 then
if d[n+2][m-2]==0 and not(O==4 and(d[n+1][m-1]==3 or d[n+1][m-1]==4))then
Z(t,{n+2,m-2,bf})end
end
end
end
end
if O==3 or O==2 or O==4 then
if n>1 and m<8 then
if d[n-1][m+1]==0 then
Z(t,{n-1,m+1})elseif d[n-1][m+1]==1 or d[n-1][m+1]==2 or(O==2 and(d[n-1][m+1]==3 or d[n-1][m+1]==4))or(O==4 and(d[n-1][m+1]==1 or d[n-1][m+1]==2))then
if n>2 and m<7 then
if d[n-2][m+2]==0 and not(O==2 and(d[n-1][m+1]==1 or d[n-1][m+1]==2))then
Z(t,{n-2,m+2,bf})end
end
end
end
if n>1 and m>1 then
if d[n-1][m-1]==0 then
Z(t,{n-1,m-1})elseif d[n-1][m-1]==1 or d[n-1][m-1]==2 or(O==2 and(d[n-1][m-1]==3 or d[n-1][m-1]==4))or(O==4 and(d[n-1][m-1]==1 or d[n-1][m-1]==2))then
if n>2 and m>2 then
if d[n-2][m-2]==0 and not(O==2 and(d[n-1][m-1]==1 or d[n-1][m-1]==2))then
Z(t,{n-2,m-2,bf})end
end
end
end
end
for v=1,#t do
if t[v][3] then
Z(r,{t[v][1],t[v][2],bf})end
end
if #r>0 or Q then
return r
else
return t
end
end
function o(n,m,R,S)return h>=n and h<=n+R and i>=m and i<=m+S
end
