-- source: steam id 3097129660 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
--payload mng
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
wp=1
wpo=12
switcho=false
trgo=false
ldxy={
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
	{16,17}}
	name={}
	name[1]='EO pod'
	name[5]='LS6500'
	name[7]='Rocket'
	name[8]='LD-10'
	name[9]='YJ-83K'
	name[10]='PL-10'
	name[12]='Gsh301'
	weit={}
	weit[1]=200
	weit[5]=600
	weit[7]=300
	weit[8]=200
	weit[9]=850
	weit[10]=90
	weit[12]=30
function onTick()
	lds={}
	guna=GN(13)
	for i=1,12 do
		table.insert(lds,GN(i))
	end
	wps={{12,{13}}}
	for i=1,12 do
		if lds[i]>0 then
			add=false
			for j=1,#wps do
				if lds[i]==wps[j][1] then
					add=false
					table.insert(wps[j][2],i)
					break
				else
					add=true
				end
			end
			if add then table.insert(wps,{lds[i],{i}}) end
		end
	end
	switch=GB(2)
	if switch and not switcho then
		wp=wp+1
	end
	if wp>#wps then wp=wp%(#wps) end
	switcho=switch
	for i=1,13 do SB(i,false) end
	trg=GB(31)
	if trg and wps[wp][1]==12 and wpo==12 then SB(wps[wp][2][1],true) end
	if trg and wps[wp][1]~=7 and wps[wp][1]~=1 and not trgo then SB(wps[wp][2][1],true) end
	if trg and wps[wp][1]==7 and wpo==7 then
		rls=rls+1
		SB(31,true)
		if rls>300 then
			for i=1,#wps[wp][2] do
				SB(wps[wp][2][i],true)
			end
		end
	else
		rls=0
		SB(31,false)
	end
    if not trg then wpo=wps[wp][1] end
	trgo=trg
	addw=0
	for i=1,#wps do
		addw=addw+weit[wps[i][1]]*(#wps[i][2])
	end
	SN(11,addw)
	SN(12,wps[wp][1])
	if wps[wp][1]~=12 then
		SN(13,#wps[wp][2])
	else
		SN(13,guna)
	end
	for i=1,6 do
	SN(i,GN(i+13))
	end
end
S=screen
SC=S.setColor
DR=S.drawRect
DT=S.drawText
DL=S.drawLine
function onDraw()
	w=S.getWidth() h=S.getHeight()
	SC(3,3,3) S.drawClear()
	for i=1,12 do
		x,y=ldxy[i][1],ldxy[i][2]
		if lds[i]>0 then
			if wps[wp][1]==lds[i] then
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
	S.drawTextBox(0,1,w,6,name[wps[wp][1]],0,-1)
	if wps[wp][1]==12 then
		S.drawTextBox(0,h-6,w,6,math.floor(guna)..'rnd',0,-1)
	else
		S.drawTextBox(0,h-6,w,6,#wps[wp][2]..'rnd',0,-1)
	end
end
