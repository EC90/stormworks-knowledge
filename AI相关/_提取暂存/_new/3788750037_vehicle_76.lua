-- source: steam id 3788750037 / vehicle.xml block#76
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
lasttargetcoords={0,0,0}
lasttargetcoords1={0,0,0}
targetcoords={0,0,0}
lastmissilecoords={0,0,0}
last_vertical_los=0
last_horizontal_los=0
delta_delta_vlos=0
delta_delta_hlos=0
pitch=0
yaw=0
last_acceleration_vlos = 0
last_acceleration_hlos = 0
vlos_jerk_pitch_gain = 0
hlos_jerk_yaw_gain = 0

ipgn = input.getNumber
ipgb = input.getBool
opsn = output.setNumber
function onTick()
Rpngle=ipgn(1)*math.pi*2
Ryngle=ipgn(2)*math.pi*2
RDist=ipgn(3)
mGPSX=ipgn(4)
mGPSY=ipgn(5)
mA=ipgn(6)
mComp=ipgn(7)*math.pi*2
TSF=ipgn(8)*math.pi*2
TSU=ipgn(9)*math.pi*2
TSL=ipgn(10)*math.pi*2
PitchGain=ipgn(11)
YawGain=ipgn(12)
Compensation=ipgn(13)
gpsX=ipgn(14)
gpsY=ipgn(15)
dis2=ipgn(16)
Fired=ipgb(1)
sw=ipgb(2)

sw2 = (sw and dis2>0.1 and (RDist>0.1 and RDist<4000) and Fired)
output.setBool(2, sw2)

if sw2 then 
cartesianRotate1=math.atan(math.sin(TSL),math.sin(TSU))
cartesianRotate2=Ryngle*math.sin(cartesianRotate1)+Rpngle*math.cos(cartesianRotate1)+TSF
cartesianRotate3=(Ryngle*math.cos(cartesianRotate1)-Rpngle*math.sin(cartesianRotate1)+mComp)*-1
targetRelativeAltitude=math.sin(cartesianRotate2)*RDist
targetRelativeZY=math.cos(cartesianRotate2)*RDist
tRX=math.sin(cartesianRotate3)*targetRelativeZY
tRY=math.cos(cartesianRotate3)*targetRelativeZY
targetGPSX=tRX+mGPSX
targetGPSY=tRY+mGPSY
targetAltitude=targetRelativeAltitude+mA
targetcoords={targetGPSX,targetGPSY,targetAltitude}
missilecoords={mGPSX,mGPSY,mA}

lasttargetcoords1=targetcoords
delta=subtract_vectors(targetcoords,lasttargetcoords1)
lastDelta=delta
deltadelta=subtract_vectors(delta,lastDelta)
targetcoords=linearExtrapolate(targetcoords,Compensation)

grid_displacement={targetcoords[1]-missilecoords[1],targetcoords[2]-missilecoords[2],targetcoords[3]-missilecoords[3]}
closing_velocity=-vector_magnitude(subtract_vectors(targetcoords,lasttargetcoords),subtract_vectors(missilecoords,lastmissilecoords))
distance=vector_magnitude(missilecoords,targetcoords)
vertical_los=math.atan(grid_displacement[3]/(grid_displacement[1]^2+grid_displacement[2]^2)^.5)
horizontal_los=math.atan(grid_displacement[2]/grid_displacement[1])
delta_vlos=vertical_los-last_vertical_los
delta_hlos=horizontal_los-last_horizontal_los
acceleration_vlos=delta_vlos-delta_delta_vlos
acceleration_hlos=delta_hlos-delta_delta_hlos

if Fired then
pitch=PitchGain*delta_vlos*closing_velocity+PitchGain*acceleration_vlos+vlos_jerk_pitch_gain+-0.035
yaw=YawGain*delta_hlos*closing_velocity+YawGain*acceleration_hlos+hlos_jerk_yaw_gain  else pitch=0
yaw=0
end
delta_delta_vlos=delta_vlos
delta_delta_hlos=delta_hlos
last_horizontal_los=horizontal_los
last_vertical_los=vertical_los
lasttargetcoords=targetcoords
lastmissilecoords=missilecoords
acceleration_vlos_delta = acceleration_vlos - last_acceleration_vlos
last_acceleration_vlos = acceleration_vlos
vlos_jerk = acceleration_vlos_delta 
vlos_jerk_pitch_gain = vlos_jerk * PitchGain

acceleration_hlos_delta = acceleration_hlos - last_acceleration_hlos
last_acceleration_hlos = acceleration_hlos
hlos_jerk = acceleration_hlos_delta
hlos_jerk_yaw_gain = hlos_jerk * YawGain
opsn(1,pitch)
opsn(2,yaw)
opsn(3,targetGPSX)
opsn(4,targetGPSY)
else
outx,outy=rotate(gpsX-mGPSX, gpsY-mGPSY, -mComp)
opsn(2, math.atan(outx, outy))
opsn(3,gpsX)
opsn(4,gpsY)
end
end
function vector_magnitude(a,b)
return((a[1]-b[1])^2+(a[2]-b[2])^2+(a[3]-b[3])^2)^.5 
end
function subtract_vectors(c,b)return{c[1]-b[1],c[2]-b[2],c[3]-b[3]}
end
function linearExtrapolate(d,e)return{d[1]+(delta[1]+deltadelta[1])*e,d[2]+(delta[2]+deltadelta[2])*e,d[3]+(delta[3]+deltadelta[3])*e}end
function rotate(x, y, angle)
outx=x*math.cos(angle)-y*math.sin(angle) 
outy=x*math.sin(angle)+y*math.cos(angle)
return outx, outy
end

