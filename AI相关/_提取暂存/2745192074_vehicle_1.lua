-- source: steam id 2745192074 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2745192074
PI = math.pi

Atime=125


xdata={}
ydata={}
hdata={}
timedata={}
for i=1,Atime do
	table.insert(xdata,0)
	table.insert(ydata,0)
	table.insert(hdata,0)
	table.insert(timedata,-i)
end

timeadd=0
timetime=0
for i=1,Atime do
	timeadd = timeadd + timedata[i]
	timetime = timetime + timedata[i]^2
end

UpDownPivot = 0
LeftRightPivot = 0


function onTick()
	hre = input.getNumber(1)
	cs = input.getNumber(2)
	vrdis = input.getNumber(3)
	hrdis = input.getNumber(4)
	GPSx = input.getNumber(5)
	GPSy = input.getNumber(6)
	vre = input.getNumber(7)
	rtp = input.getNumber(8)
	alts = input.getNumber(9)
	UpDown = input.getNumber(10)
	LeftRight = input.getNumber(11)
	UpDownpos = input.getNumber(12)
	AutoAim = input.getBool(1)
	
	Tdirec = math.fmod(-hre+cs+5.5,1)-0.5
	distance = (vrdis+hrdis)/2
	Tpitch = vre+rtp
	hdis = distance*math.cos(Tpitch*2*PI)
	
	x = hdis*math.sin(-Tdirec*2*PI)+GPSx
	y = hdis*math.cos(Tdirec*2*PI)+GPSy
	
	h = distance*math.sin(Tpitch*2*PI)+alts
	
	for i=Atime,2,-1 do
		xdata[i]=xdata[i-1]
		ydata[i]=ydata[i-1]
		hdata[i]=hdata[i-1]
	end
	
	xdata[1]=x
	ydata[1]=y
	hdata[1]=h
	
	xadd=0
	yadd=0
	hadd=0
	timexdata=0
	timeydata=0
	timehdata=0
	
	for i=1,Atime do
		xadd = xadd+xdata[i]
		yadd = yadd+ydata[i]
		hadd = hadd+hdata[i]
		timexdata = timexdata + xdata[i]*timedata[i]
		timeydata = timeydata + ydata[i]*timedata[i]
		timehdata = timehdata + hdata[i]*timedata[i]
	end
	
	X = (xadd*timetime-timeadd*timexdata)/(Atime*timetime-timeadd^2)
	Y = (yadd*timetime-timeadd*timeydata)/(Atime*timetime-timeadd^2)
	H = (hadd*timetime-timeadd*timehdata)/(Atime*timetime-timeadd^2)
	
	VX = (Atime*timexdata-timeadd*xadd)/(Atime*timetime-timeadd^2)
	VY = (Atime*timeydata-timeadd*yadd)/(Atime*timetime-timeadd^2)
	VH = (Atime*timehdata-timeadd*hadd)/(Atime*timetime-timeadd^2)
	
	
	
	if vrdis ~= 0 and hrdis ~= 0 then
		Locktime=Locktime+1
		if Locktime>Atime then
			output.setBool(1,true)
		else
			output.setBool(1,false)
		end
	else
		Locktime=0
		output.setBool(1,false)
	end
	
	UpDownPivot = UpDown*0.1
	if UpDownpos < -0.1 and UpDownPivot < 0 then
		UpDownPivot = 0
	elseif UpDownpos > 0.23611 and UpDownPivot > 0 then
		UpDownPivot = 0
	end
	
	LeftRightPivot = LeftRight * -0.1
	
	if AutoAim and vrdis ~= 0 and hrdis ~= 0 then
		LeftRightPivot = LeftRightPivot - hre*4
		UpDownPivot = UpDownPivot + vre*4
	end
	
	output.setNumber(1,X)
	output.setNumber(2,Y)
	output.setNumber(3,H)
	output.setNumber(4,VX)
	output.setNumber(5,VY)
	output.setNumber(6,VH)
	output.setNumber(7,UpDownPivot)
	output.setNumber(8,LeftRightPivot)
	
end