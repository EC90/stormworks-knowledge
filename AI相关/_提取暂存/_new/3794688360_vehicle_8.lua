-- source: steam id 3794688360 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794688360
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 632 (982 with comment) chars

i=true
a=false
r=input
l=output
d=l.setBool
n=r.getNumber
k=r.getBool
_=1
p=a
q=a
m=a
j=a
b={}c=0
v=a
e=0
for g=1,15 do
b[g]=a
end
function onTick()t=property.getNumber("Number of Hardpoints")s=k(20)f=n(20)h=n(21)u=k(21)e=k(22)o=a
if not s then
q=a
m=a
j=a
elseif not p then
if f>29 and h>24 and e then
_=_-1
q=i
c=0
elseif f>29 and h>16 and e then
_=_+1
m=i
c=0
elseif f<17 and h>24 and e then
o=i
j=i
b[_]=a
elseif f>17 and f<29 and h>24 and c>7 and u and e then
b[_]=not b[_]end
end
if c<8 then c=c+1 end
if _<1 then _=t
elseif _>t then _=1 end
p=s
l.setNumber(1,_)for g=1,15 do
d(g,a)d(g+15,b[g])end
d(_,o)d(31,b[_])d(32,j)end
