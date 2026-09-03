-- source: steam id 3603910667 / vehicle.xml block#68
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
acos=M.acos
atan=M.atan
exp=M.exp
pi=M.pi
pi2=M.pi*2
floor=M.floor
T=true
F=false

--Lib={"ESM","SMD","SMS","FRE"}
--Lib[0]="N/A"
Lib={{"ER","SM","SS","FE"},
	{{0,255,0},{255,192,0},{0,112,192},{255,0,0}}}
Lib[1][0]="XX"
Lib[2][0]={32,32,32}
VLSID={1,2,3,4,5,6,7,8,9,10}

Launch_queue = {0,0,0,0}
Launch_freq = {0,0,0,0}
Launch_buf = {0,0,0,0}
launchtype = 0
freq = 0
Launch_channel = 0

launchid=0
launched=F

launchtiming=F
launchtimer=0
function onTick()
	--???
	missle={}
	for i=0,8 do
		missle[i]=0
	end
	VLS={}
	NUM={}
	launchid=0
	--??????????????
	for i=1,4 do
		if GN(33-i*2)~=Launch_buf[i] and GN(33-i*2)~=0 then
			Launch_queue[i] = GN(33-i*2)
			Launch_freq[i] = GN(34-i*2)
		end
		Launch_buf[i] = GN(33-i*2)
	end

	for i=1,4 do
		if not launching and Launch_queue[i]~=0 and GB(Launch_queue[i]+24) and GB(32) and launchtype == 0 then
			launchtype = Launch_queue[i]
			freq = Launch_freq[i]
			Launch_channel = floor(i+0.1)
			Launch_queue[i] = 0
			Launch_freq[i] = 0
		end
		if launchtype~=0 then
			break
		end
	end
	
	for i=1,24 do
		VLS[i]=floor(GN(i))
		NUM[i]=floor((GN(i)%1)*10+0.5)
		missle[VLS[i]]=missle[VLS[i]]+NUM[i]
		if launchtype>VLS[i]-0.1 and launchtype<VLS[i]+0.1 and NUM[i]>0.5 and GB(VLS[i]+24) and GB(32) then
			launchid=i
		end
	end
	SN(1,launchid)
	outmissle=0
	j=0
	for i=1,8 do
		if missle[i]>0.5 and j<2.5 and GB(i+24) and GB(32) then
		outmissle=outmissle*100+i
		j=j+1
		end
	end
	launching=F
	for i=1,24 do
		launching=launching or GB(i)
	end
	if launching then
		launchtype = 0
	end
	--[[if not launching and launched then
		launchtiming=T
	end
	if launchtiming and launchtimer<=1 then
		launchtimer=launchtimer+1
	else
		launchtiming=F
	end]]
	launchtiming=not launching and launched
	
	if launchtiming then
		SN(2,outmissle*10+Launch_channel)
	else
	SN(2,outmissle*10+0)
	end
	launched=launching
	
	SN(29, freq)
	SN(11, Launch_queue[1])
	SN(12, Launch_queue[2])
	SN(13, Launch_queue[3])
	SN(14, Launch_queue[4])
end
S=screen
SC=S.setColor
DL=S.drawLine
DR=S.drawRect
DF=S.drawRectF
DT=S.drawText
function onDraw()
	width = screen.getWidth()
	height = screen.getHeight()
	
	for i=1,10 do
		drawx,drawy=((i-1)%2)*10,floor((i-1)/2)*10
		
		SC(255,255,255)
		DR(drawx, drawy, 10, 10)
		
		id=VLSID[i]
		col=Lib[2][VLS[id]*clamp0(NUM[id])]
		
		SC(col[1],col[2],col[3])
		DT(drawx+1,drawy+1, Lib[1][VLS[id]*clamp0(NUM[id])])
		if VLS[id]==1 then
			buf=NUM[id]
			for j=1,5 do
			col=Lib[2][VLS[id]*clamp0(buf)]
			SC(col[1],col[2],col[3])
			DL(drawx+j*2-1,drawy+7,drawx+j*2-1,drawy+10)
			buf=buf-1
			end
		else
			DF(drawx+1,drawy+7,9,3)
		end
	end
	
end
	
function clamp0(x)
	if x<0 then x=0 end
	if x>1 then x=1 end
	return x
end