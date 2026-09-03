-- source: steam id 3792899963 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792899963
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 736 (1086 with comment) chars
o="maxRange"
n="fovX"
m="fovY"
l="radarRange"
k="minRange"

h=tostring
j=tonumber
a=output.setNumber
e=input.getNumber
i=string.sub
_={}_[n]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}_[m]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}_[k]={}_[o]={}_[l]={}function onTick()for b=1,14 do
g=j(i(h(e(b)),1,1))f=j(i(h(e(b)),2,h(e(b)):len()))if g==1 then
_[n][b]=f
elseif g==2 then
_[m][b]=f
elseif g==3 then
_[k][b]=f
elseif g==4 then
_[o][b]=f
end
if _[n][b]*_[m][b]>0 then
_[l][b]=8/(_[n][b]*_[m][b])else
_[l][b]=0
end
end
d=e(31)c=e(32)if d<1 then
a(1,0)a(2,0)a(3,0)a(4,0)a(5,0)else
a(1,_[n][d])a(2,_[m][d])a(3,_[k][d])a(4,_[o][d])a(5,_[l][d])end
if c<1 then
a(6,0)a(7,0)a(8,0)a(9,0)a(10,0)else
a(6,_[n][c])a(7,_[m][c])a(8,_[k][c])a(9,_[o][c])a(10,_[l][c])end
end
