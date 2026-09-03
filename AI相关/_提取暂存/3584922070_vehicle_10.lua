-- source: steam id 3584922070 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3584922070
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pN=property.getNumber
pB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
sqrt=M.sqrt
asin=M.asin
atan=M.atan
exp=M.exp
pi=M.pi
pi2=M.pi*2

brakebuf=false

dur=0

pidrps={0,0,0}

mspd=pN('mspd')/3.6
mrps=pN('mrps')

function onTick()
ws,ad,rps,spd,chg,tem,fulelvl,pressure=GN(2),GN(1),GN(3),GN(4),GN(5),GN(6),GN(7),GN(8)
boost,start,mstart=GB(1),GB(7),GB(8)
air,fuel,brake,pbrake,cluch,pcluch,gcluch,gearl,gearr,spdl,spdr,motor=0,0,0,false,0,0,0,{false,false,false,false},{false,false,false,false},abs(spd)/2+(ws+ad*0.5)*10,abs(spd)/2+(ws-ad*0.5)*10,0

ws0,ad0,rps0,spd0= ws<0.1 and ws>-0.1,ad<0.1 and ad>-0.1,rps<3,spd<2 and spd>-2
dur=dur+abs(spd)/60
if GB(2) then
dur=0
end

brakebuf=spd0 or brakebuf
brakebuf=brakebuf and (ws0 and ad0)
brake=brakebuf or not start

cluch=clamp((rps-5)/10,0,1)^0.5+0.3

espd=abs(ws)
cspd=ws

if boost then
tspd=ws*mspd
else
tspd=ws*mspd*0.7
end
if start then
	if (tspd*spd>0 or abs(spd)<2) and abs(tspd) > abs(spd) then
		thr=(tspd-spd)*0.03+spd/33*0.5
	else
		thr=spd/33*0.5
	end
else
	thr=0
end
fuel,air=enginectrl(rps,rpswhell,abs(thr),pressure,clamp((0.99-chg)*100,0,30),spd)

if brake then
cluch=0
end

if rps<2 then
starter=true
cluch=0
else
starter=false
end

if rps<4 then
gcluch=0
cluchr=0
cluchl=0
end
if mstart then
cluch=1
end
	
if not start then
air=0
fuel=0
starter=false
gcluch=0
cluchr=0
cluchl=0
cluch=0
end
if ws*spd<0 then
wbr=0.1*abs(ws)
if tow==1 then
cluch=0
end
else
wbr=0
end
--SN(1,cluchl)
--SN(2,cluchr)
SN(3,cluch)
SN(4,air)
SN(5,fuel)
SN(6,pcluch)
SN(7,thr)
SN(8,motor)
SN(9,brake)
SN(10,rps)
SN(11,abs(spd)*3.6)
SN(12,fulelvl)
SN(13,GN(9)*60/abs(spd)*1000)
SN(14,fulelvl/GN(9)/60)
SN(15,fulelvl/GN(9)/60*abs(spd))
SN(16,pressure)
SN(17,GN(10)/GN(9))
SN(18,tem)
SN(19,gearlvl)
SN(20,dur)
SN(21,chg)
SN(22,wbr)

--[[SB(1,gear[1])
SB(2,gear[2])
SB(3,gear[3])
SB(4,gear[4])
SB(5,gearl)
SB(6,gearr)]]
SB(7,starter)
SB(8,brake)
SB(9,tem>114)
SB(10,not (tem>115 or (rps<3 and fuel>0.001)))
SB(11,boost)
end

function atan2(x,y)
	if x>0 then
		return atan(y/x)
	else
		if y>=0 then
			return atan(y/x)+pi
		else
			return atan(y/x)-pi
		end
	end
end

function enginectrl(rps,rpsw,throttle,pressure,rpse,speed)
local fuel,air,rpst,a
rpst=clamp(throttle*27+5,5,mrps)+clamp(rpse,0,mrps)

pidrps[1]=rps
pidrps,a=pid(pidrps,rpst,{0.1,0.002,0})
a=a+rpst*0.047
air=clamp(a,0,(115-tem))
fuel=clamp(a,0,clamp((115-tem),0,1))*(-(0.98^pressure)*(0.4)+(0.9))
return fuel,air
end

function pid(data,setpoint,coff)
	if data[1]~=data[1] or data[1]==M.huge or data[1]==-M.huge then
		data[1]=0
	end
	if setpoint~=setpoint or setpoint==M.huge or setpoint==-M.huge then
		setpoint=0
	end
	if data[2]~=data[2] or data[2]==M.huge or data[2]==-M.huge then
		data[2]=0
	end
	data[2]=clamp(data[2]+(setpoint-data[1])*coff[2],0,1)
	local out=(setpoint-data[1])*coff[1]+(data[2])+(setpoint-data[1]-data[3])*coff[3]
	data[3]=setpoint-data[1]
	return data,out
end

function sgn(x)
	if x>0 then return 1 end
	if x<0 then return -1 end
	return 0
end

function clamp(x,a,b)
	if x<a then x=a end
	if x>b then x=b end
	return x
end

function onDraw()

end