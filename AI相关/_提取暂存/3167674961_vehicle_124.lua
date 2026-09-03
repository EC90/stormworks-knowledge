-- source: steam id 3167674961 / vehicle.xml block#124
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1640 (2000 with comment) chars

L=true
M=input
p=math
U=output
v=U.setNumber
B=U.setBool
e=p.pi
P=p.abs
q=p.atan
i=p.sin
s=p.cos
j=M.getNumber
w=property.getNumber
x=p.sqrt
function g(a,b,c)return{a=a or 0,b=b or 0,c=c or 0}end
function al(_,d)return g(_.a+d.a,_.b+d.b,_.c+d.c)end
function as(_,C)return g(_.a*C,_.b*C,_.c*C)end
function aA(_)return as(_,-1)end
function aG(_,d)return al(_,aA(d))end
function aE(_)return x(_.a*_.a+_.b*_.b+_.c*_.c)end
function ah(_,d)return g(_.b*d.c-_.c*d.b,_.c*d.a-_.a*d.c,_.a*d.b-_.b*d.a)end
y=0
aB=w("Distance To Dive")au=w("Cruise Altitude")at=-w("Cruise Sensitivity")az=-w("Terminal Sensitivity")K=w("Fire Delay (Ticks)")an=w("Vertical Trim On Launch")A,aq,r=g(),g(),g()function onTick()h=g(j(1),j(3),j(2))T,Q,S=j(4),j(5),j(6)l,t,n=s(T),s(Q),s(S)u,k,m=i(T),i(Q),i(S)Z=g(t*n,-k,t*m)ai=g(u*m+l*k*n,l*t,-u*n+l*k*m)aC=ah(Z,ai)ay=t*n
W=-l*m+u*k*n
ak=u*m+l*k*n
ax=t*m
aa=l*n+u*k*m
ad=-u*n+l*k*m
av=-k
N=u*t
X=l*t
ar=q(ax,x(ay^2+av^2))z=q(aa,x(W^2+N^2))ab=q(ad,x(ak^2+X^2))o=-q(i(ar),-i(ab))I=q(h.a-A.a,h.b-A.b)ap=q(W,N)r=g(j(7),j(8),j(9))D=M.getBool(1)ao=P(r.a)>1 or P(r.b)>1
J=x((r.a-h.a)^2+(r.b-h.b)^2)am=q(r.a-h.a,r.b-h.b)R=(e+I-am)%(e*2)-e
aw=z+q(h.c-r.c,J)Y=(h.c-A.c)*60
ac=E((au-h.c)*1,-100,100)af=(Y-ac)*.02
A=h
if J<aB and D and y>K then
B(1,L)H=aw
f=az
else
B(1,false)H=af
f=at
end
G=(s(o)*f*R)+(i(-o)*f*H)F=(i(o)*f*R)+(s(o)*f*H)if D then
y=E(y+1,0,600)if y>K then
v(1,G)v(2,F)if not ao then
B(1,L)f=f/2
G=(s(o)*f*((e+I-O)%(e*2)-e))+(i(-o)*f*(z+V))F=(i(o)*f*((e+I-O)%(e*2)-e))+(s(o)*f*(z+V))v(1,G)v(2,F)J=0
end
else
v(1,0)v(2,an)end
else
O=ap
V=E(-z,e/6,e/2)end
aD=D
aq=aF
end
function E(ae,aj,ag)return p.min(p.max(ae,aj),ag)end
