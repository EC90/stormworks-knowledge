-- source: steam id 3167674961 / vehicle.xml block#161
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 227 (585 with comment) chars

c=input
b=c.getNumber
_=output.setNumber
d=property.getNumber("Sensitivity")function onTick()_(1,0)_(2,0)_(3,0)for a=8,1,-1 do
if c.getBool(a)then
_(1,b(2+((a-1)*4))*d)_(2,b(3+((a-1)*4))*d)_(3,b(1+((a-1)*4)))break
end
end
end
