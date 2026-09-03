-- source: steam id 3351472205 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3351472205
--pyo's payload mng
--set draw cordinate here
HardPntXY={
	{2,19},
	{30,19},
	{5,18},
	{27,18},
	{8,17},
	{24,17},
	{11,15},
	{21,15},
	{14,14},
	{18,14},
	{16,9},
	{16,17}
}
--
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
CurWeapon=1
wpo=12
switcho=false
trgo=false
PT=property.getText
--
name={
	PT('Rename Utility'),
	PT('Rename Fuel'),
	PT('Rename UGDBomb'),
	PT('Rename LSRBomb'),
	PT('Rename GPSBomb'),
	PT('Rename Rocket'),
	PT('Rename RktPod'),
	PT('Rename LSRMSL'),
	PT('Rename GPSMSL'),
	PT('Rename RDRMSL'),
	PT('Rename Torpedo'),
	PT('Rename Cannon')
}
function onTick()
	HardPnt={}
	GunAmmo=GN(32)
	for i=1,#HardPntXY do
		table.insert(HardPnt,GN(i))
	end
	Weapons={{12,{#HardPntXY+1}}}
	for i=1,#HardPnt do
		if HardPnt[i]>0 then
			add=false
			for j=1,#Weapons do
				if HardPnt[i]==Weapons[j][1] then
					add=false
					table.insert(Weapons[j][2],i)
					break
				else
					add=true
				end
			end
			if add then table.insert(Weapons,{HardPnt[i],{i}}) end
		end
	end
	if Weapons[CurWeapon] then
		if Weapons[CurWeapon][1]~=wpo then
			for i=1,#Weapons do
				if Weapons[i][1]==wpo then
					CurWeapon=i
				end
			end
		end
	end
	switch=GB(property.getNumber('Switch Weapon Key'))
	if switch and not switcho then
		CurWeapon=CurWeapon+1
	end
	if CurWeapon>#Weapons then CurWeapon=CurWeapon%(#Weapons) end
	if Weapons[CurWeapon] then
		wp=Weapons[CurWeapon][1]
	else
		wp=12
		CurWeapon=1
	end
	switcho=switch
	for i=1,32 do
		SB(i,false)
	end
	trg=GB(31)
	if trg and wp~=7 and wp~=12 and not trgo then SB(Weapons[CurWeapon][2][1],true) end
	if trg and wp==12 and wpo==12 then
		rls1=rls1+1
		SB(30,true)
		if rls1>300 then
			for i=1,#(Weapons[CurWeapon][2]) do
				SB(Weapons[CurWeapon][2][i],true)
			end
		end
	else
		rls1=0
		SB(30,false)
	end
	if trg and wp==7 and wpo==7 then
		rls2=rls2+1
		SB(31,true)
		if rls2>300 then
			for i=1,#Weapons[CurWeapon][2] do
				SB(Weapons[CurWeapon][2][i],true)
			end
		end
	else
		rls2=0
		SB(31,false)
	end
	if not trg then wpo=wp end
	trgo=trg
	--debug)
end
S=screen
SC=S.setColor
DR=S.drawRect
DT=S.drawText
DL=S.drawLine
function onDraw()
	w=S.getWidth() h=S.getHeight()
	SC(3,3,3) S.drawClear()
	for i=1,#HardPntXY do
		x,y=HardPntXY[i][1],HardPntXY[i][2]
		if HardPnt[i]>0 then
			if wp==HardPnt[i] then
				SC(22,22,222)
			else
				SC(22,222,22)
			end
		else
			SC(222,22,22)
		end
		DL(x,y,x,y+5)
	end
	SC(22,222,22)
	S.drawTextBox(0,1,w,6,name[wp],0,-1)
	if wp==12 then
		S.drawTextBox(0,h-6,w,6,math.floor(GunAmmo)..'rnd',0,-1)
	else
		S.drawTextBox(0,h-6,w,6,#Weapons[CurWeapon][2]..'rnd',0,-1)
	end
end
