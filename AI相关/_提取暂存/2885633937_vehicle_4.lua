-- source: steam id 2885633937 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2885633937
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PI=math.pi
function onTick()
fov=GN(1)
roll=-GN(2)
pitch=GN(3)
fa=GN(11)
fe=GN(12)-pitch
fovr=2.2-(2.2-0.025)*fov
fovt=fovr/(PI*2)
rollr=roll*PI*2
if fa~=0 and fe~=0 then
faf=fa*math.cos(rollr)-fe*math.sin(rollr)
fef=fa*math.sin(rollr)+fe*math.cos(rollr)
else
faf,fef=0,0
end
end
function onDraw()
w,h=screen.getWidth(),screen.getHeight()
se=math.min(w/2,h/2)
screen.setColor(15,233,15,160)
if faf~=0 and fef~=0 then
	x=se+se*(-faf/(0.5*fovt))
	y=se-se*(fef/(0.5*fovt))
	screen.drawLine(x-4,y-4,x+4,y+4)
	screen.drawLine(x-4,y+4,x+4,y-4)
end
end