-- source: steam id 3788750037 / vehicle.xml block#26
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
trgts = {}
function clamp(x,m,M)
 return M<x and M or m>x and m or x
end
function onTick()
mdis =input.getNumber(31)
a =input.getNumber(32)
elv=input.getNumber(3)
ang=input.getNumber(2)
dis=input.getNumber(1)
target=input.getBool(1)
dis=clamp(dis,0,mdis)
dispix=(dis/mdis)*25
radoff=input.getBool(9)
head =input.getNumber(28)
xpos =input.getNumber(29)
ypos =input.getNumber(30)



angle=math.rad((ang*360) + head*-360)

xta=dis*math.sin(angle)
yta=dis*math.cos(angle)
	
output.setNumber(3, xta+xpos)
output.setNumber(4, yta+ypos)
output.setBool(2, reset)
output.setNumber(1, yl)



rdrA=(a*360)*math.pi/180
xl=26+25*math.cos(-1.58+rdrA)
yl=27+25*math.sin(-1.58+rdrA)

xt=26+dispix*math.cos(-1.58+rdrA)
yt=27+dispix*math.sin(-1.58+rdrA)
if xl>23 and yl<2.14 then
	reset = true
	else
	reset = false
	end

if target then
	trgts[xt] = yt
end

if xl>23 and yl<2.14 or radoff then

	for i in pairs(trgts) do
	trgts[i] = nil
	end
end
end

function onDraw()
	for i, v in pairs(trgts) do
		screen.setColor(200,0,0,10)
		screen.drawCircle(i,v,1)
	end
end
	