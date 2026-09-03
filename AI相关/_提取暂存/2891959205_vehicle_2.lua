-- source: steam id 2891959205 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891959205
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PI=math.pi
function onTick()
fov=GN(13)
roll=-GN(11)
pitch=GN(12)
fa=GN(23)
fe=GN(24)-pitch
fea=GN(25)
fee=GN(26)-pitch
fovr=2.2-(2.2-0.025)*fov
fovt=fovr/(PI*2)
rollr=roll*PI*2
if fa~=0 and fe~=0 then
faf=fa*math.cos(rollr)-fe*math.sin(rollr)
fef=fa*math.sin(rollr)+fe*math.cos(rollr)
else
faf,fef=0,0
end
if fea~=0 and fee~=0 then
feaf=fea*math.cos(rollr)-fee*math.sin(rollr)
feef=fea*math.sin(rollr)+fee*math.cos(rollr)
else
feaf,feef=0,0
end
end
function onDraw()
w,h=screen.getWidth(),screen.getHeight()
se=math.min(w/2,h/2)
screen.setColor(15,233,15,160)
if faf~=0 and fef~=0 then
	x=w/2+se*(-faf/(0.5*fovt))
	y=h/2-se*(fef/(0.5*fovt))
	screen.drawLine(x-4,y-4,x+4,y+4)
	screen.drawLine(x-4,y+4,x+4,y-4)
end
screen.setColor(222,15,15,160)
if feaf~=0 and feef~=0 then
	x=w/2+se*(-feaf/(0.5*fovt))
	y=h/2-se*(feef/(0.5*fovt))
	screen.drawLine(x-4,y-4,x+4,y+4)
	screen.drawLine(x-4,y+4,x+4,y-4)
end
end