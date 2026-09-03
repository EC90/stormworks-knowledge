-- source: steam id 3167674961 / vehicle.xml block#44
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 422 (772 with comment) chars

i=tonumber
c=tostring
h=property
d=string
e=output.setNumber
f=math.floor
g=d.format
_=h.getNumber
a=1
b=1
p={}function onTick()j=h.getText("Name")type=_("Type")o=_("Subtype")l={_("Radar FOV Launch Horizontal"),_("Radar FOV Launch Vertical"),_("Minimum Range (m)"),_("Maximum Range (m)")}a=(a%j:len())+1
n=g("%03d",d.byte(d.sub(j,a,a)))k=g("%02d",c(a))m=c(f(type))..c(f(o))e(32,i(m..n..k))b=(b%4)+1
e(31,i(b..l[b])+0)end
