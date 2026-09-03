-- source: steam id 2902453331 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2902453331
-- Author: TAK4129
-- GitHub: https://github.com/yukimaru73
-- Workshop: https://steamcommunity.com/profiles/76561198174258594/myworkshopfiles/?appid=573090
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 969 (1365 with comment) chars

x=false
w=input
v=output
A=v.setBool
f=v.setNumber
g=w.getNumber
p=p or{}p.C=function(H,e,G)e=e or{}for z,E in pairs(H)do
e[z]=not G and e[z]or E
end
return e
end;
h={s=function(D,c,d,b)return p.C(D,{c=c or 0,d=d or 0,b=b or 0})end;
sub=function(m,q)return h:s(m.c-q.c,m.d-q.d,m.b-q.b)end}_={}r=.25
j=x
function onTick()local y,B,u=0,0,0
j=x
for a=1,9 do
local c,d,b=g(3*a),g(3*a+1),g(3*a+2)_[a]=h:s(c,d,b)end
for a=1,3 do
for I=1,3 do
if _[a].c~=0 and _[a].d~=0 and _[a].b~=0 then
local F=h:s(r,(I-2)*r,(a-2)*r)_[a]=h.sub(_[a],F)j=true
end
end
end
if#_>0 then
local n,k,o,t,i,l=_[1].c,_[1].c,_[1].d,_[1].d,_[1].b,_[1].b
for a=1,#_ do
if _[a].c~=0 and _[a].d~=0 and _[a].b~=0 then
if _[a].c>n then n=_[a].c end
if _[a].c<k then k=_[a].c end
if _[a].d>o then o=_[a].d end
if _[a].d<t then t=_[a].d end
if _[a].b>i then i=_[a].b end
if _[a].b<l then l=_[a].b end
end
end
y,B,u=(n+k)/2,(o+t)/2,(i+l)/2
end
f(1,y)f(2,B)f(3,u)A(1,j)A(2,w.getBool(1))f(15,g(1))f(16,g(2))end
