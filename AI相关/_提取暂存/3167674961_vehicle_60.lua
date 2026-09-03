-- source: steam id 3167674961 / vehicle.xml block#60
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1679 (2039 with comment) chars

M=true
O=input
m=math
V=output
l=V.setNumber
D=V.setBool
e=m.pi
U=m.abs
T=O.getBool
k=m.atan
j=m.sin
u=m.cos
f=O.getNumber
w=property.getNumber
x=m.sqrt
function h(a,b,c)return{a=a or 0,b=b or 0,c=c or 0}end
function af(_,d)return h(_.a+d.a,_.b+d.b,_.c+d.c)end
function ax(_,F)return h(_.a*F,_.b*F,_.c*F)end
function an(_)return ax(_,-1)end
function aE(_,d)return af(_,an(d))end
function aC(_)return x(_.a*_.a+_.b*_.b+_.c*_.c)end
function ar(_,d)return h(_.b*d.c-_.c*d.b,_.c*d.a-_.a*d.c,_.a*d.b-_.b*d.a)end
A=0
Y=w("Distance To Dive")al=w("Cruise Altitude")ay=-w("Cruise Sensitivity")aA=-w("Terminal Sensitivity")Q=w("Fire Delay (Ticks)")aj=w("Vertical Trim On Launch")B,aD,r=h(),h(),h()function onTick()i=h(f(1),f(3),f(2))R,N,S=f(4),f(5),f(6)p,t,q=u(R),u(N),u(S)v,s,o=j(R),j(N),j(S)ao=h(t*q,-s,t*o)az=h(v*o+p*s*q,p*t,-v*q+p*s*o)aF=ar(ao,az)ag=t*q
L=-p*o+v*s*q
aB=v*o+p*s*q
aw=t*o
au=p*q+v*s*o
av=-v*q+p*s*o
ab=-s
W=v*t
ak=p*t
am=k(aw,x(ag^2+ab^2))z=k(au,x(L^2+W^2))at=k(av,x(aB^2+ak^2))n=-k(j(am),-j(at))H=k(i.a-B.a,i.b-B.b)aq=k(L,W)r=h(f(7),f(8),f(9))K=T(1)ai=U(r.a)>1 or U(r.b)>1
y=x((r.a-i.a)^2+(r.b-i.b)^2)ah=k(r.a-i.a,r.b-i.b)X=(e+H-ah)%(e*2)-e
ae=z+k(i.c-r.c,y)Z=(i.c-B.c)*60
aa=C((al-i.c)*1,-100,100)ac=(Z-aa)*.02
B=i
if y<Y and K and A>Q then
D(1,M)G=ae
g=aA
else
D(1,false)G=ac
g=ay
end
E=(u(n)*g*X)+(j(-n)*g*G)I=(j(n)*g*X)+(u(n)*g*G)if K then
A=C(A+1,0,600)if A>Q then
l(1,E)l(2,I)if not ai then
D(1,M)g=g/2
E=(u(n)*g*((e+H-P)%(e*2)-e))+(j(-n)*g*(z+J))I=(j(n)*g*((e+H-P)%(e*2)-e))+(u(n)*g*(z+J))l(1,E)l(2,I)y=0
end
if T(2)and y<Y then
l(1,f(10))l(2,f(11))end
else
l(1,0)l(2,aj)end
else
P=aq
J=C(-z,e/6,e/2)end
end
function C(ad,ap,as)return m.min(m.max(ad,ap),as)end
