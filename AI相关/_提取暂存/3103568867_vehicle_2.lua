-- source: steam id 3103568867 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3103568867
INN=input.getNumber
INB=input.getBool
OUN=output.setNumber
OUB=output.setBool


RANP=800
RANM=-900
RAN=0
MV=2.2
Tx=0
Ty=0
Th=0
TVx=0
TVy=0
TVh=0
Gx=0
Gy=0
Gh=0
FirstYaw=0
FirstPitch=0
FirstTilt=0
yFire=false
LAUNCHED=false
radar=false
BO=false
state=0
Fsince=0
FFsince=0
Peley=0
Yeley=0
low=0
ticks=0
hx=0
hy=0
hGdistance =0
function atan2(y, x)
	if y ~= 0 and x ~= 0 then
		if 0 < y and 0 < x then
			return math.atan(y/x)
		elseif 0 < y and x < 0 then
			return math.pi+math.atan(y/x)
		elseif y < 0 and x < 0 then
			return -math.pi+math.atan(y/x)
		elseif y < 0 and 0 < x then
			return math.atan(y/x)
		end
	else
		if x == 0 then
				if 0 < y then
					return math.pi/2
				else
					return -math.pi/2
				end
		else
			if 0 < x then
				return 0
			else
				return math.pi
			end
		end
	end
end
function clamp(x,pm)
	if math.abs(x) < pm then
		return x
	else
		if x > 0 then
			return pm
		else
			return -pm
		end
	end
end
function onTick()
	Find=INB(1)
	Fire=INB(2)
	if Find then
		Tx=INN(1)
		Ty=INN(2)
		Th=INN(3)
		TVx=INN(4)
		TVy=INN(5)
		TVh=INN(6)
		hx=(Tx+Mx)/2
		hy=(Ty+My)/2
	end
	Mx=INN(7)
	My=INN(8)
	Mh=INN(9)
	FRdirec=INN(10)
	UPdirec=INN(11)
	Ptilt=INN(12)
	Rtilt=INN(13)
	Rrotate=INN(14)
	PRele=INN(15)
	PRdis=INN(16)
	Protate=INN(17)
	YRele=INN(18)
	YRdis=INN(19)
	Yrotate=INN(20)
	distance = (YRdis+PRdis)/2
	Gdistance = math.sqrt((Gx-Mx)^2+(Gy-My)^2+(Gh-Mh)^2)
	if yFire == true and Fire == false then
		LAUNCHED=true
		
		Tx=Tx+TVx*1
		Ty=Ty+TVy*1
		Th=Th+TVh*1
		
		t=0
		for i=1,5 do
			Gx=Tx+TVx*(t/5)
			Gy=Ty+TVy*(t/5)
			Gh=Th+TVh*(t/5)
			t=math.sqrt((Gx-Mx)^2+(Gy-My)^2+(Gh-Mh)^2)/MV
		end
		Gx=Tx+TVx*(t/5)
		Gy=Ty+TVy*(t/5)
		Gh=Th+TVh*(t/5)
		
		Tdirec=atan2(-Gx+Mx,Gy-My)/(2*math.pi)
		Tdirec=math.fmod(UPdirec+0.5-Tdirec+10.5,1)-0.5
		FirstYaw=1.3*math.sin(Tdirec*2*math.pi)
		FirstPitch=-0.06*math.cos(Tdirec*2*math.pi)
		FirstTilt=math.atan((Gh-Mh)/math.sqrt((Gx-Mx)^2+(Gy-My)^2))/(2*math.pi)
	end
	Pas=2*math.pi*PRdis*(PRele-(Peley+Protate/60))
	Yas=2*math.pi*YRdis*(YRele-(Yeley-Yrotate/60))
	YAW=0
	PITCH=0
	ROLL=0
	if LAUNCHED then
	   if state==0 then
			YAW=0
			PITCH=0
			ROLL=0
			if 100 < Mh then
			hGdistance = math.sqrt((Gx-Mx)^2+(Gy-My)^2+(Gh-Mh)^2)
			hGdistance =hGdistance*1.35
			if hGdistance>45000 then
				hGdistance=44990
				end		
			state=1	
			end	
		elseif state==1 then
			Gdirec=atan2(-hx+Mx,hy-My)/(2*math.pi)
			Gdirec=math.fmod(FRdirec-Gdirec+10.5,1)-0.5
			Gtilt=math.atan((hGdistance-Mh)/math.sqrt((hx-Mx)^2+(hy-My)^2))/(2*math.pi)
			YAW=Gdirec*1
			PITCH=(Gtilt-Ptilt)*1
			ROLL=Rtilt*-6
if Mh>hGdistance*0.85 then
state=3
elseif Mh>29500 then
state=3
end

		elseif state==3 then
			Gdirec=atan2(-Gx+Mx,Gy-My)/(2*math.pi)
			Gdirec=math.fmod(FRdirec-Gdirec+10.5,1)-0.5
			Gtilt=math.atan((1-Mh)/math.sqrt((Gx-Mx)^2+(Gy-My)^2))/(2*math.pi)
			YAW=Gdirec*0.3
			PITCH=(Gtilt-Ptilt)*0.35
			ROLL=Rtilt*-6
			radar=false
			BO=false
			ticks=ticks+1
		if ticks>1000 then
			state=4
		end
			
		elseif state==4 then
			Gdirec=atan2(-Gx+Mx,Gy-My)/(2*math.pi)
			Gdirec=math.fmod(FRdirec-Gdirec+10.5,1)-0.5
			Gtilt=math.atan((7-Mh)/math.sqrt((Gx-Mx)^2+(Gy-My)^2))/(2*math.pi)
			YAW=Gdirec*2.5
			PITCH=(Gtilt-Ptilt)*2.5
			ROLL=Rtilt*-6
			if Gdistance <21000 then
			BO=true
			radar=true
			end
				
		else
			Pgain=50/distance
			YAW=clamp(Yas*Pgain,0.2)
			PITCH=clamp(Pas*Pgain,0.2)
			ROLL=Rrotate
		end
	end
	OUN(1,YAW)
	OUN(2,PITCH)
	OUN(3,-ROLL)
	OUB(1,radar)
	OUB(2,BO)
	yFire=Fire
	Peley=PRele
	Yeley=YRele
end
