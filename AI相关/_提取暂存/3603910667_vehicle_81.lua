-- source: steam id 3603910667 / vehicle.xml block#81
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
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

dur=0

pidrps={0,0,0}
coffrps={pN('P'),pN('I'),pN('D')}

mrps=pN('mrps')

function onTick()
	rps_target,rps,spd,chg,tem,fulelvl,pressure=GN(1),GN(3),GN(4),GN(5),GN(6),GN(7),GN(8)
	start,mstart=GB(7),GB(8)
	air,fuel,cluch,gcluch,motor=0,0,0,0,0,0

	dur=dur+abs(spd)/60
	if GB(2) then
		dur=0
	end

	cluch=clamp((rps-3)/3,0,1)^0.5
	gcluch=clamp((1-chg)*5,0,1)

	fuel,air=enginectrl(rps,clamp(rps_target,3,mrps),pressure,clamp((0.9-chg)*50,0,30),spd)

	if rps<2 then
		starter=true

		cluch=0
	else
		starter=false
	end

	if rps<3 then
		gcluch=0
	end
	if mstart then
		cluch=1
	end
		
	if not start then
		air=0
		fuel=0
		starter=false
		gcluch=0
		cluch=0
	end
	SN(3,cluch)
	SN(4,air)
	SN(5,fuel)
	SN(8,motor)
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

	SB(1,true)
	SB(2,start)
	SB(8,starter)
	SB(9,tem>114)
	SB(10,not (tem>115 or (rps<3 and fuel>0.001)))
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

function enginectrl(rps,rpst,pressure,rpse,speed)
	local fuel,air,a

	pidrps[1]=rps
	pidrps,a=pid(pidrps,rpst,coffrps)
	a=a+rpst*0.06
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
	data[2]=clamp(data[2]+(setpoint-data[1])*coff[2],-0.3,1)
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