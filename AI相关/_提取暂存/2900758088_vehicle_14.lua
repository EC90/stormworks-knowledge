-- source: steam id 2900758088 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088
--NNTC Missile Guidance System V5
--Updated 6/26/2022

--Made by thatcoolcat1#1574 for NNTC.
--Not available for reuse or reupload.

--Note: ZEM formulas WIP

------------------------------------

--zeroing values
oldLOSX = 0
oldLOSY = 0
oldAccX = 0
oldAccY = 0
oldJerkX = 0
oldJerkY = 0
oldsrrDist = 0
oldsrrX = 0
oldsrrY = 0
oldlrrX = 0
oldlrrY = 0
oldEPNX = 0
oldEPNY = 0
commandX = 0
commandY = 0
oldtgo = 3
oldcommandX = 0
oldx1 = 0
oldy1 = 0

--aliases
igN = input.getNumber
pgN = property.getNumber
pgB = property.getBool
osN = output.setNumber

function clamp(x,y,z)
	return math.min(math.max(y,x),z)
end

--run
function onTick()	
--load sensors
LOSX = igN(1)
LOSY = igN(2)
srrDist = igN(3)
srrX = igN(4)
srrY = igN(5)
srrActive = igN(6)
lrrDist = igN(7)
lrrX = igN(8)
lrrY = igN(9)
lrrActive = igN(10)
guidlaw = igN(11)
--load tune
srgain = pgN("Gain")
lrgain = pgN("Long Range Gain")
trim = pgN("Pitch Trim")
nc = pgN("Nav Constant")
lrnX = pgN("LRNX")
lrnY = pgN("LRNY")
rsens = pgN("Roll Sensitivity")
varnav = pgB("Variable Nav Constant")
dseek = pgB("Dual Stage Guidance")
ras = pgB("Rolling Airframe System")
rSens = pgN("Roll Sensitivity")
sSpin = pgN("Seeking Spin Speed")
--LOS rate acceleration, jerk, and snap
accX     = LOSX-oldLOSX
oldLOSX  = LOSX
accY     = LOSY-oldLOSY
oldLOSY  = LOSY
jerkX    = accX-oldAccX
oldAccX  = accX
jerkY    = accY-oldAccY
oldAccY  = accY
snapX    = jerkX-oldJerkX
oldJerkX = jerkX
snapY    = jerkY-oldJerkY
oldJerkY = jerkY
--closing velocity calculation
closingV   = clamp((srrDist-oldsrrDist)*60,-10000,-1)
oldsrrDist = srrDist
--time until impact
tgo   = srrDist/(math.abs(closingV))
c1tgo = clamp(tgo,0,20)
c2tgo = clamp(tgo,0.01,15)
--ZEM
x1    = math.sin(LOSX*srrDist)
y1    = math.sin(LOSY*srrDist)
dx1   = x1 - oldx1
dy1   = y1 - oldy1
oldx1 = x1
oldy1 = y1	
ZEMX  = x1+(dx1*c1tgo)
ZEMY  = y1+(dy1*c1tgo)
--variable nav constant
if varnav == true then
	if tgo > 1 then
		nc = nc/tgo
	else
		nc = nc
	end
end
--guidance laws implemented
if guidlaw == 1 then --PP
	commandX = nc*srrX
	commandY = nc*srrY
end
if guidlaw == 2 then --PN
	commandX = (nc*LOSX)
	commandY = (nc*LOSY)
end
if guidlaw == 3 then --TPN
	commandX = (nc*LOSX*closingV)
	commandY = (nc*LOSY*closingV)
end
if guidlaw == 5 then --APN
	commandX = (nc*LOSX*closingV)+(nc*accX*0.5)
	commandY = (nc*LOSY*closingV)+(nc*accY*0.5)
end
if guidlaw == 6 then --EPN
	commandX = (nc*LOSX*closingV)+(nc*accX*0.5)+(nc*jerkX*0.25)
	commandY = (nc*LOSY*closingV)+(nc*accY*0.5)+(nc*jerkY*0.25)
end
if guidlaw == 7 then --MEPN
	commandX = (nc*LOSX*closingV)+(nc*accX*0.5)+(nc*jerkX*0.25)+(nc*snapX*0.0625)
	commandY = (nc*LOSY*closingV)+(nc*accY*0.5)+(nc*jerkY*0.25)+(nc*snapY*0.0625)
end
if guidlaw == 8 then --ZEMPN
	commandX = ((srgain*ZEMX)/(c2tgo^2))
	commandY = ((srgain*ZEMY)/(c2tgo^2))
end
if guidlaw == 9 then --ZEMAPN
	commandX = ((srgain*ZEMX)/(c2tgo^2))+(srgain*accX*0.1)
	commandY = ((srgain*ZEMY)/(c2tgo^2))+(srgain*accY*0.1)
end
if guidlaw == 10 then --ZEMEPN
	commandX = ((srgain*ZEMX)/(c2tgo^2))+(srgain*accX*0.1)+(srgain*jerkX*0.1)*(c2tgo^3)
	commandY = ((srgain*ZEMY)/(c2tgo^2))+(srgain*accY*0.1)+(srgain*jerkY*0.1)*(c2tgo^3)
end
if guidlaw == 11 then --ZEMMEPN
end
----rolling airframe
if ras == true then
	if srrActive == 1 then
		sSpin = 0
	else
		sSpin = sSpin
	end
	dvcommandX = commandX - oldcommandX
	oldcommandX = commandX
	roll = ((commandX+(dvcommandX*0.5))*rSens)+sSpin
	--kalman filter
	--if srrY < -0.005 then
		--roll = roll-0.001
	--end
	osN(3,roll)
end
----long range guidance section---
--kalman filter
srrX=0.1*srrX+(1-0.1)*oldsrrX
srrY=0.1*srrY+(1-0.1)*oldsrrY
oldsrrX = srrX
oldsrrY = srrY
--ZEM exception
if guidlaw >= 8 then
	srgain = 1
end
--switching guidance
if srrDist<500 or dseek==false then
	osN(1,((commandX*srgain)))
	osN(2,((commandY*srgain)+trim))
else
	osN(1,(((commandX*(srgain/nc))+srrX*lrgain)))
	osN(2,(((commandY*(srgain/nc))+srrY*lrgain)+trim))
end
	
end

------------------

--Made by thatcoolcat1#1574 for NNTC.
--Not made for reuse or reupload.