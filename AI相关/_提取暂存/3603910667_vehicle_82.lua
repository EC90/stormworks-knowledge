-- source: steam id 3603910667 / vehicle.xml block#82
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
T=true
F=false

dur=0

pid_speed={0,0,0}
coff_speed={pN('Speed P'),pN('Speed I'),pN('Speed D')}
bypath_speed=pN('Speed Bypath')

pid_acceleration={0,0,0}
coff_acceleration={pN('Acceleration P'),pN('Acceleration I'),pN('Acceleration D')}
bypath_acceleration=pN('Acceleration Bypath')

wsbuf=F
speed_buf=0

speed_table={-8,0,8,16,24,32}
speed_level=2
reverse=F

clush_timer=0
function onTick()
	ws,speed=GN(2),GN(3)
	wsp,wsn,ws0=ws>0.5,ws<-0.5,ws<=0.5 and ws>=-0.5
	if not ws0 and wsbuf then
		if wsp and speed_level<5.5 then
			speed_level=speed_level+1
			shipbell=T
		elseif wsn and speed_level>1.5 then
			speed_level=speed_level-1
			shipbell=T
		else
			fullbell=T
		end
		trainbell=speed_level==2
	else
		trainbell=F
		shipbell=F
		fullbell=F
	end
	wsbuf=ws0
	speed_target=speed_table[speed_level]*0.514444
	
	park=speed_target==0 and abs(speed)<0.5

	pid_speed[1]=speed
	pid_speed,acceleration_target=pid(pid_speed,speed_target,coff_speed,-0.1,0.1,not park)
	clamp(acceleration_target,-0.2,0.2)
	
	acceleration=(speed-speed_buf)*60
	speed_buf=speed
	
	pid_acceleration[1]=acceleration
	pid_acceleration,rps_target1=pid(pid_acceleration,acceleration_target,coff_acceleration,-1,1,not park)
	rps_target2=rps_target1+speed*bypath_speed+acceleration_target*bypath_acceleration
	rps_target3=abs(rps_target2)
	rps_target=rps_target3+3
	
	if rps_target3<0.5 and abs(speed)<0.5 then
		clush_timer=0
		clush=0
	elseif clush_timer<120 then
		clush_timer=clush_timer+1
		clush=clush_timer/120
	else
		clush_timer=120
		clush=1
	end
	
	if rps_target3<0.5 then
		reverse=rps_target2<0
	end
	
	SN(1,rps_target)
	SN(2,clush)
	SN(3,speed_target)
	SB(1,reverse)
	SB(2,shipbell)
	SB(3,trainbell)
	SB(4,fullbell)
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

function pid(data,setpoint,coff,min,max,enable)
	if data[1]~=data[1] or data[1]==M.huge or data[1]==-M.huge then
		data[1]=0
	end
	if setpoint~=setpoint or setpoint==M.huge or setpoint==-M.huge then
		setpoint=0
	end
	if data[2]~=data[2] or data[2]==M.huge or data[2]==-M.huge then
		data[2]=0
	end
	data[2]=clamp(data[2]+(setpoint-data[1])*coff[2],min,max)
	local out=(setpoint-data[1])*coff[1]+(data[2])+(setpoint-data[1]-data[3])*coff[3]
	data[3]=setpoint-data[1]
	if not enable then
		data={0,0,0}
		out=0
	end
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