-- source: steam id 2745192074 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2745192074
INN=input.getNumber
INB=input.getBool
OUN=output.setNumber

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
state=0
Fsince=0
Peley=0
Yeley=0

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
	--nyuuryoku
	distance = (YRdis+PRdis)/2
	Gdistance = math.sqrt((Gx-Mx)^2+(Gy-My)^2+(Gh-Mh)^2)
	if yFire == true and Fire == false then
		LAUNCHED=true
		
		Tx=Tx+TVx*7
		Ty=Ty+TVy*7
		Th=Th+TVh*7
		
		t=0
		for i=1,5 do
			Gx=Tx+TVx*t
			Gy=Ty+TVy*t
			Gh=Th+TVh*t
			t=math.sqrt((Gx-Mx)^2+(Gy-My)^2+(Gh-Mh)^2)/MV
		end
		Gx=Tx+TVx*t
		Gy=Ty+TVy*t
		Gh=Th+TVh*t
		
		Tdirec=atan2(-Gx+Mx,Gy-My)/(2*math.pi)
		Tdirec=math.fmod(UPdirec+0.5-Tdirec+10.5,1)-0.5
		
		FirstYaw=0.5*math.sin(Tdirec*2*math.pi)
		FirstPitch=-0.5*math.cos(Tdirec*2*math.pi)
		FirstTilt=math.atan((Gh-Mh)/math.sqrt((Gx-Mx)^2+(Gy-My)^2))/(2*math.pi)
	end
	
	Pas=2*math.pi*PRdis*(PRele-(Peley+Protate/60))
	Yas=2*math.pi*YRdis*(YRele-(Yeley-Yrotate/60))
	
	
	YAW=0
	PITCH=0
	ROLL=0
	if LAUNCHED then
	
		if state==0 then
			YAW=FirstYaw
			PITCH=FirstPitch
			ROLL=0
			
			if Ptilt < FirstTilt+(-0.25*FirstTilt+0.0625) then
				state=1
			end
			
		elseif state==1 then
			YAW=0
			PITCH=0
			ROLL=Rtilt*-8
			if math.abs(Rtilt) < 0.1 then
				state=2
			end
			
		elseif state==2 then
			Gdirec=atan2(-Gx+Mx,Gy-My)/(2*math.pi)
			Gdirec=math.fmod(FRdirec-Gdirec+10.5,1)-0.5
			Gtilt=math.atan((Gh-Mh)/math.sqrt((Gx-Mx)^2+(Gy-My)^2))/(2*math.pi)
			
			YAW=Gdirec*3
			PITCH=(Gtilt-Ptilt)*3
			ROLL=Rtilt*-8
			
			if PRdis~=0 and YRdis~=0 then
				Fsince=Fsince+1
				if Fsince >= 20 and distance <= 750 and Gdistance <= 1250 then
					state=3
				end
			else
				Fsince=0
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
	OUN(3,ROLL)
	
	yFire=Fire
	Peley=PRele
	Yeley=YRele
end
