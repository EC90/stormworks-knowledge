-- source: steam id 2816850764 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2816850764
TargetTime = {}
TargetAzimuth = {}
TargetElevation = {}
counter = 0
Range = 2000
PingDelay = 0
TargetCount = 0
TargetRedundancy = {}
function onTick()
	counter = counter+1
	
	output.setBool(1, false)
	if(counter > PingDelay)
	then
		counter = 0
		output.setNumber(32,TargetCount)
		TargetCount = 0
		output.setBool(1, true)
		Range = input.getNumber(32)
	end
	
	for i = 1,8,1
	do
		if(input.getBool(i) == true and TargetRedundancy[i] == false)
		then
			TargetCount = TargetCount + 1
			TargetRedundancy[i] = true
			TargetTime[TargetCount] = counter
		    TargetAzimuth[TargetCount] = input.getNumber((i*2)-1)
		    TargetElevation[TargetCount] = input.getNumber(i*2)
			output.setNumber(TargetCount, TargetAzimuth[TargetCount])
			
		else
			TargetRedundancy[i] = false
		end
		
	end
	
end


function onDraw()
	w = screen.getWidth()/2			  
	h = screen.getHeight()/2		
	scale = (w-2)/Range
	PingDelay = Range*120/1480
	
	screen.setColor(0, 100, 0)			 
	screen.drawCircle(w, h, 1480*counter*scale/120)
	if(TargetCount > 0)
	then
		for i = 1,TargetCount,1 
		do 
			d = 1480*TargetTime[i]/120
			hd = d*math.cos(6.28*TargetElevation[i])
			pos = hd*scale
			if(TargetElevation[i]<0)
			then
				screen.setColor(255, 255, 255)
			else
				screen.setColor(50, 50, 50)
			end
			screen.drawRect(pos*math.cos(6.28*TargetAzimuth[i]-1.57)+w, pos*math.sin(6.28*TargetAzimuth[i]-1.57)+w, 1, 1)
		end
	end
end