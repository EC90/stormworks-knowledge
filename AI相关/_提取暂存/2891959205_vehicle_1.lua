-- source: steam id 2891959205 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891959205
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pi2=math.pi*2
function DropAndETA(dltx,dlty,dltz)
	Hdist,Vdist,Adist=math.sqrt(dltx^2+dlty^2),dltz,math.sqrt(dltx^2+dlty^2+dltz^2)
	ETA=-2.85+0.0869*Adist-1.87*10^-5*Adist^2+1.57*10^-8*Adist^3
	drop=-0.0642+0.00162*Adist-5.86*10^(-7)*Adist^2+4.19*10^(-10)*Adist^3
	drop=drop/360
	aimv=math.atan(Vdist/Hdist)/pi2
	if aimv>0 then
		fix=(1-aimv/0.125)*1.016663*drop
	else
		fix=(1-aimv/0.125)*0.856315*drop
	end
	return fix+aimv,ETA end
function onTick()
	gpsx=GN(2)
	gpsy=GN(3)
	alt=GN(4)
	artx=GN(27)
	arty=GN(28)
	artz=GN(29)
	isart=GB(30)
	if isart and artx~=0 then
		tgta=math.atan(-artx+gpsx,arty-gpsy)/pi2
		tgte,shellETA=DropAndETA(artx-gpsx,arty-gpsy,artz-alt)
	else
		tgta,tgte=0,0
	end
	SN(1,tgta)
	SN(2,tgte)
end
function onDraw()
screen.setColor(222,22,22)
screen.drawText(7,7,tgta)
screen.drawText(7,14,tgte)
end