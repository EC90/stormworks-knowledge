-- source: steam id 2437043138 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2437043138
IGN=input.getNumber
OSN=output.setNumber
relay=false
connect=true

state=0
signal=0.0
batt=0.0
fuel=0.0

start=false
chamb=false
thrtl=0.0
trust=1.0
rps=0.0
temp=0.0

x1,y1,a1,x2,y2,a2=0,0,0,0,0,0
startX,startY,gpsX,gpsY,targX,targY=0,0,0,0,0,0
speed=0.0
alt,startAlt=0,0
compas=0

autop=false
maxspeed=false
antiturret=false
delay=0


function onTick()
	state = IGN(1)
	x1,y1,a1,x2,y2,a2=IGN(2),IGN(3),IGN(4),IGN(5),IGN(6),IGN(7)
	
	signal= IGN(11)
	batt = IGN(12)
	fuel = IGN(13)
	rps = IGN(14)
	temp = IGN(15)
	compas=IGN(16)
	alt=IGN(17)
	speed=IGN(18)
	gpsX=IGN(19)
	gpsY=IGN(20)
	
	maxspeed=input.getBool(13)
	antiturret=input.getBool(14)
	if state==0 then
		if not start then relay=false end
	else 
		 relay=true
	end
	if state==2 then start=true end
	
	if start then
		if rps<2.0 and state~=3 then 
			chamb=true 
		else
			chamb=false
			if rps>17 then
				connect=false
			end
		end
		if connect then 
			thrtl=0.7
			startX=gpsX
			startY=gpsY
			startAlt=alt
		else
			if maxspeed then
				thrtl=0.37
			else
				thrtl=0.33
			end
			trust=0.0
			delay=delay+1
		end
		if delay> 200 then
			autop=true
		end
	end
	
	
			
	output.setNumber(1, state)
	output.setNumber(2, signal)	
	output.setNumber(3, batt)
	output.setNumber(4, fuel)
	OSN(5,gpsX)
	OSN(6,gpsY)
	OSN(7,alt)
	OSN(8,speed)
	OSN(9,targX)
	OSN(10,targY)
	
	
	output.setNumber(11, rps)	
	output.setNumber(12, temp)		
	
	
	output.setNumber(21, thrtl)
	output.setNumber(22, trust)
	output.setNumber(23, startX)
	output.setNumber(24, startY)
	output.setNumber(25, startAlt)
	
	output.setBool(1, connect)
	output.setBool(2, relay)
	output.setBool(3, chamb)
	output.setBool(4, autop)
	
end

