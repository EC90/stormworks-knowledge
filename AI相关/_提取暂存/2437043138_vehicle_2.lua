-- source: steam id 2437043138 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2437043138
IGN=input.getNumber
OSN=output.setNumber
SDT=screen.drawText

lafetpos=0.0
lafetB=false
lafetdone=true
startpos=false
keystart=false
keyreturn=false
state=0			-- 0-off, 1-to ready, 2-start, 3-return
ssart=false
sreturn=false
keymaxspeed=false
antiturret=false
started=false
done=false

a_state=0
a_signal=0.0
a_batt=0.0
a_fuel=0.0
a_rps=0.0
a_temp=0.0
a_X,a_Y,a_alt,a_speed,a_targX,a_targY=0,0,0,0,0,0

x1,y1,a1,x2,y2,a2=0,0,0,0,0,0
bX,bY=0,0
balt=0.0
dist=0
p1dist, p2dist=0,0
p1,p2=false,false

prevfuel=0.0
tick=0
sftime=""

function onTick()
	a_state = IGN(1)
	a_signal = IGN(2)
	a_batt = IGN(3)
	a_fuel = IGN(4)
	a_X = IGN(5)
	a_Y = IGN(6)
	a_alt = IGN(7)
	a_speed = IGN(8)
	a_targX = IGN(9)
	a_targY = IGN(10)
	
	
	a_rps = IGN(11)
	a_temp = IGN(12)
	x1,y1,a1,x2,y2,a2 =IGN(21),IGN(22),IGN(23),IGN(24),IGN(25),IGN(26)
	bX,bY,balt=IGN(27),IGN(28),IGN(29)
	
	
	lafetB=input.getBool(21)
	sstart=input.getBool(22)
	sreturn=input.getBool(23)
	keymaxspeed=input.getBool(24)
	antiturret=input.getBool(25)
	
	
	
	
	if not started then
		a_X=bX
		a_Y=bY
		a_alt=balt
		
		keystart=startpos
		if keystart and state<2 then
			state=1	
		else
			if state ==1 then state=0 end
		end
		if sstart and state==1 then state=2 started=true end
	else
		keystart=false
		
		if a_speed>50 then keyreturn=true done=true end
		if sreturn then state=3 end
	end
	checklafet()
	
	if done then
		tick=tick+1
		
		if tick>60 then
			df=prevfuel-a_fuel
			prevfuel=a_fuel
			if df>0.01 then
				sftime=" ("..string.format("%.1f",a_fuel/df/60).." min)"
			else
				sftime=""
			end
		
			tick=0
		end
		
	end
		
	
	
	
	
	output.setNumber(1, state)
	OSN(2,x1) OSN(3,y1) OSN(4,a1) OSN(5,x2) OSN(6,y2) OSN(7,a2)
	
		
	output.setNumber(11, -lafetpos)
	output.setBool(11, keystart)	
	output.setBool(12, keyreturn)
	output.setBool(13, keymaxspeed)
	output.setBool(14, antiturret)
end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	screen.setColor(0, 0, 0)
	screen.drawClear()
	
	if state==0 then
		status="Idle"
	elseif state==1 then
		status="Ready to start"
	elseif state==2 then
		status="Started"
	elseif state==3 then
		status="Returns"
	end
	
	
	if x1~=0.0 or y1~=0.0 then p1=true else p1=false end
	if x2~=0.0 or y2~=0.0 then p2=true else p2=false end
	if p1 then p1dist=math.sqrt((x1-a_X)*(x1-a_X)+(y1-a_Y)*(y1-a_Y)) else p1dist=0.0 end
	if p2 then p2dist=math.sqrt((x2-a_X)*(x2-a_X)+(y2-a_Y)*(y2-a_Y)) else p2dist=0.0 end
	if p1dist>4000 then
		screen.setColor(255, 0, 0)
		SDT(2,0,"* warning! p1 is too far *")
	end
	if p2dist>4000 then
		screen.setColor(255, 0, 0)
		SDT(2,8,"* warning! p2 is too far *")
	end
	screen.setColor(255, 255, 255)
	SDT(2,16,"status: "..status) 
	if state>0 then
		SDT(2,32,"signal: "..string.format("%.2f",a_signal*100).."%")
		SDT(2,40,"battery: "..string.format("%.2f",a_batt*100).."%")
		SDT(2,48,"fuel: "..string.format("%.1f",a_fuel).." l"..sftime)
		SDT(2,56,"rps: "..string.format("%.2f",a_rps))
		SDT(2,64,"alt: "..string.format("%.1f",a_alt).." m")
		SDT(2,72,"speed: "..string.format("%.1f",a_speed*3.6).." k/h")
		dist=math.sqrt((bX-a_X)*(bX-a_X)+(bY-a_Y)*(bY-a_Y)+(a_alt-balt)*(a_alt-balt))
		SDT(2,80,"dist: "..string.format("%.0f",dist).." m")
	end
	
end	
function checklafet()
	if lafetB and not done then
		if lafetpos<0.4 then 
			lafetpos=lafetpos+0.002 
		else 
			lafetpos=0.4
			startpos=true
		end	
	
	else
		if  (not started and state<2) or done then
			startpos=false
			if lafetpos>0.0 then lafetpos=lafetpos-0.002 end
			if lafetpos<0.0 then lafetpos=0.0 end
		end
	end
	
end
	
