-- source: steam id 2902453331 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2902453331
-- Author: TAK4129
-- GitHub: https://github.com/yukimaru73
-- Workshop: https://steamcommunity.com/profiles/76561198174258594/myworkshopfiles/?appid=573090
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1103 (1501 with comment) chars

z=input
n=math
o=output.setNumber
v=n.pi
s=z.getNumber
A=n.sin
q=n.cos
t=t or{}t.E=function(I,f,K)f=f or{}for C,h in pairs(I)do
f[C]=not K and f[C]or h
end
return f
end;
m={y=function(D,a,c,b)return t.E(D,{a=a or 0,c=c or 0,b=b or 0})end;
H=function(D,p,l,r)return m:y(p*q(r)*q(l),p*A(r),p*q(r)*A(l))end;
L=function(M)local e=M
return n.sqrt(e.a*e.a+e.c*e.c+e.b*e.b)end;
sub=function(j,g)return m:y(j.a-g.a,j.c-g.c,j.b-g.b)end;
G=function(j,g)return j:sub(g):L()end}J=property.getNumber("Maximum Distance")F=5
_={}function onTick()_={}P=false
local x,i,w,B
local a,c,b=0,0,0
for d=1,8 do
x=z.getBool(d)if x then
i=s(4*d-3)w=s(4*d-2)*2*v
B=s(4*d-1)*2*v
if i>15 and i<J
then
_[#_+1]={m:H(i,w,B),{},i}end
end
end
if#_~=0 then
if#_>1 then
for d=1,#_ do
for k=#_,d+1,-1 do
local O=F*_[d][3]*.01
if m.G(_[d][1],_[k][1])<O then
_[d][2][#_[d][2]+1]=k
_[k][2][#_[k][2]+1]=d
end
end
end
table.sort(_,function(l,N)return#l[2]>#N[2]end)end
a,c,b=_[1][1].a,_[1][1].c,_[1][1].b
for d,h in ipairs(_[1][2])do
a=a+_[h][1].a
c=c+_[h][1].c
b=b+_[h][1].b
end
local u=#_[1][2]+1
a=a/u
c=c/u
b=b/u
end
o(1,a)o(2,c)o(3,b)end
