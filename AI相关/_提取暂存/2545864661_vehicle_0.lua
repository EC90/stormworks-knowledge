-- source: steam id 2545864661 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2545864661
function drawArc(...) --x,y,radius,(angle1,angle2,filled,step)
	local x,y,r,a1,a2,pie,step = ...
	a1 = a1 or 0
	a2 = a2 or 360
	step = step or 22.5
	if a2<a1 then a2,a1=a1,a2 end
	local a,px,py,ox,oy,ar = false,0,0,0,0,0
	repeat
		a = a and math.min(a+step,a2) or a1
		ar = (a-90) *math.pi /180
		px,py = x +r *math.cos(ar), y +r *math.sin(ar)
		if a~=a1 then
			if pie then
				screen.drawTriangleF(x,y, ox,oy, px,py)
			else
				screen.drawLine(ox,oy,px,py)
			end
		end
		ox,oy = px,py
	until(a>=a2)
end

function UpdateAllSonar()
for i=-50,50,1 do
		if Data[i] == nil then
		else
		local Rotation = (i/200)*(math.pi*2)
		local Distance =(Data[i][3]/Max)*cx
		local X = math.sin(Rotation)*Distance
		local Y = math.cos(Rotation)*Distance
		Data[i] = {X+cx,Displayh-Y,Data[i][3]}
		end	
	end	
end

UpdateSonar=false
Data={}
cx=0
Display=0
DisplayON = false

function onTick()
AlarmON=input.getBool(4)
ON=input.getBool(3)			 
Rotation,EdgeDegMax,EdgeTurnsMax = input.getNumber(7)*(math.pi*2),input.getNumber(9)*360,math.floor(input.getNumber(9)*200)
EdgeDegMin = input.getNumber(11)*360
EdgeTurnsMin = math.floor(input.getNumber(11)*200)
RotationTurns = math.floor(input.getNumber(7)*200+0.5)
inputX = input.getNumber(3)
inputY = input.getNumber(4)
Pressed = input.getBool(1)
Auto=property.getBool("auto")
Blink = input.getBool(5)
output.setBool(6,Detected)

if not Pressed and not NotWait then
	if UpdateSonar then 
	UpdateAllSonar() 
	UpdateSonar=false
	end
NotWait = true
output.setBool(1,false)
output.setBool(2,false)
output.setBool(3,false)
output.setBool(4,false)
output.setBool(5,false)
output.setBool(7,false)
output.setBool(8,false)
end
	
if Auto then
output.setBool(1,DisplayON)
output.setBool(2,not DisplayON)
end

if Pressed and NotWait and DisplayON then
	if ON then
		local X = inputX-cx
		local Y = math.abs(inputY-Displayh)
		if inputY > (Displayh)+2 then
			if inputX<cx then 
				if not Auto then output.setBool(2,true)  end
			else
				if AlarmON then output.setBool(8,true) else output.setBool(7,true) end
			end
		elseif (X*X)+(Y*Y) <= (cx*cx) then
			NewEdge=(math.atan(X/Y))/(math.pi*2)
			if NewEdge>((input.getNumber(9)+input.getNumber(11))/2)then
				output.setNumber(1,NewEdge)
				output.setNumber(2,input.getNumber(11))
			else
				output.setNumber(1,input.getNumber(9))
				output.setNumber(2,NewEdge)
			end
			output.setBool(3,true)		
		else 
			if inputX<cx then
				output.setBool(5,true)
				UpdateSonar=true
			else
				output.setBool(4,true)
				UpdateSonar=true
			end	
		end	
	else
	output.setBool(1,true)
	end
	NotWait = false
end
	
if ON then
	Max = input.getNumber(10)
	Distance =(input.getNumber(8)/Max)*cx
	local X = math.sin(Rotation)*Distance
	local Y = math.cos(Rotation)*Distance
	Data[RotationTurns] = {X+cx,Displayh-Y,input.getNumber(8)}
end
DisplayON = false	
Detected=false
end

function onDraw()
DisplayON = true
	w = screen.getWidth()
	h = screen.getHeight()
	cx,cy = w/2,h/2
	Displayh=h-((h-cx)/2)
if ON then
	for i =1,5,1 do
	screen.setColor(0,225,50,125)
	drawArc(cx,Displayh,(w/10)*i,EdgeDegMin,EdgeDegMax,false)
	end
	EdgeRad=EdgeDegMax*(math.pi/180)
	for i=1,2,1 do
	Edgex=math.sin(EdgeRad)*cx
	Edgey=math.cos(EdgeRad)*cx
	screen.drawLine(cx,Displayh,Edgex+cx,Displayh-Edgey)
	EdgeRad=EdgeDegMin*(math.pi/180)
	end
	screen.drawLine(cx,Displayh,cx+(math.sin(Rotation)*cx),Displayh-(math.cos(Rotation)*cx))
	Div=(math.floor(Max/5+0.5)).."0 m"
	screen.drawText(cx-(string.len(Div)*2.5),1,Div)	
	screen.drawText(w-4,7,">")
	screen.drawText(1,7,"<")
	if Auto then screen.drawText(cx-17,h-5,"ABTO") else screen.drawText(cx-17,h-5,"on") end
	if AlarmON then
	screen.drawText(cx+7,h-5,"")
	else
	screen.setColor(240,240,240)
	screen.drawText(cx+7,h-5,"")
	end
	screen.setColor(255,240,40,125)
	for i=EdgeTurnsMin,EdgeTurnsMax,1 do
		if Data[i] == nil then
		
		elseif Data[i][3]<Max then
			screen.drawCircleF(Data[i][1],Data[i][2],0.5)
			Detected=true
		end	
	end
	if Blink then
	screen.setColor(32,252,3)
	screen.drawRect(0,0,w-1,h-1)
	end
else
screen.setColor(240,240,240)

end
end