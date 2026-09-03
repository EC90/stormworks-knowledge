-- source: steam id 3167674961 / vehicle.xml block#157
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1670 (2030 with comment) chars

U=true
P=input
q=math
O=output
w=O.setNumber
H=O.setBool
e=q.pi
X=q.abs
r=q.atan
i=q.sin
t=q.cos
j=P.getNumber
v=property.getNumber
x=q.sqrt
function h(a,b,c)return{a=a or 0,b=b or 0,c=c or 0}end
function al(_,d)return h(_.a+d.a,_.b+d.b,_.c+d.c)end
function aA(_,J)return h(_.a*J,_.b*J,_.c*J)end
function an(_)return aA(_,-1)end
function aF(_,d)return al(_,an(d))end
function aE(_)return x(_.a*_.a+_.b*_.b+_.c*_.c)end
function az(_,d)return h(_.b*d.c-_.c*d.b,_.c*d.a-_.a*d.c,_.a*d.b-_.b*d.a)end
z=0
ap=v("Distance To Dive")am=v("Cruise Altitude")Z=-v("Cruise Sensitivity")at=-v("Terminal Sensitivity")S=v("Fire Delay (Ticks)")aw=v("Vertical Trim On Launch")A,T,p=h(),h(),h()function onTick()g=h(j(1),j(3),j(2))R,M,K=j(4),j(5),j(6)m,u,l=t(R),t(M),t(K)s,k,o=i(R),i(M),i(K)av=h(u*l,-k,u*o)ak=h(s*o+m*k*l,m*u,-s*l+m*k*o)aG=az(av,ak)aj=u*l
W=-m*o+s*k*l
as=s*o+m*k*l
ar=u*o
ai=m*l+s*k*o
ao=-s*l+m*k*o
ay=-k
Q=s*u
ad=m*u
Y=r(ar,x(aj^2+ay^2))y=r(ai,x(W^2+Q^2))aq=r(ao,x(as^2+ad^2))n=-r(i(Y),-i(aq))E=r(g.a-A.a,g.b-A.b)au=r(W,Q)aD=h(j(7),j(8),j(9))B=P.getBool(1)if B and not aB then
p=T
end
ab=X(p.a)>1 or X(p.b)>1
C=x((p.a-g.a)^2+(p.b-g.b)^2)aC=r(p.a-g.a,p.b-g.b)N=(e+E-aC)%(e*2)-e
ae=y+r(g.c-p.c,C)af=(g.c-A.c)*60
ah=I((am-g.c)*1,-100,100)ax=(af-ah)*.02
A=g
if C<ap and B and z>S then
H(1,U)F=ae
f=at
else
H(1,false)F=ax
f=Z
end
D=(t(n)*f*N)+(i(-n)*f*F)G=(i(n)*f*N)+(t(n)*f*F)if B then
z=I(z+1,0,600)if z>S then
w(1,D)w(2,G)if not ab then
H(1,U)f=f/2
D=(t(n)*f*((e+E-V)%(e*2)-e))+(i(-n)*f*(y+L))G=(i(n)*f*((e+E-V)%(e*2)-e))+(t(n)*f*(y+L))w(1,D)w(2,G)C=0
end
else
w(1,0)w(2,aw)end
else
V=au
L=I(-y,e/6,e/2)end
aB=B
T=aD
end
function I(ac,ag,aa)return q.min(q.max(ac,ag),aa)end
