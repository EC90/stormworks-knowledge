-- source: steam id 3792899963 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792899963
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 535 (885 with comment) chars

h=tonumber
j=screen
c=j.drawLine
a=j.drawRectF
d=j.setColor
k=string.sub
function onTick()l=not input.getBool(31)_={{},{},{},{},{}}for f=1,5 do
i=property.getText("Color Code "..tostring(math.floor(f)))_[f].g,_[f].b,_[f].e=h(k(i,1,3)),h(k(i,5,7)),h(k(i,9,11))end
end
function onDraw()d(_[5].g,_[5].b,_[5].e)a(29,0,3,32)d(_[4].g,_[4].b,_[4].e)if l then a(29,0,3,8)else
a(29,9,3,7)end
d(_[4].g,_[4].b,_[4].e)a(30,18,1,5)a(30,26,1,5)a(29,29,3,1)a(29,19,3,1)d(_[3].g,_[3].b,_[3].e)c(28,0,28,32)c(28,24,32,24)c(28,16,32,16)c(28,8,32,8)end
