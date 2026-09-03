-- source: steam id 3794618673 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794618673
Up,Down,Radio,PTT,temp,step= false,false,false,false,true,true
Channel,Timer = 0,0
igN=input.getNumber
igB=input.getBool


function onTick()
	IX = igN(3)
	IY = igN(4)
	Time = igN(10)
	Strength = igN(11)
	Temperature = igN(4)
	IP = igB(1)
	EPTT = igB(10)
	Rec = igB(11)


	Hour=Time/(1/24)-(Time/(1/24))%1
	Min=(Time/(1/24))%1/(1/60)-((Time/(1/24))%1/(1/60))%1
	

	Up = isPointInRectangle(IX,IY,27,25,4,7) and IP and Radio
	Down = isPointInRectangle(IX,IY,19,25,4,7) and IP and Radio
	PTT = ((isPointInRectangle(IX,IY,2,25,15,7) and IP and Radio) or (EPTT and Radio)) and not Rec
	
	
	UpS = Up and step
	DownS = Down and step
	
	
	if Up or Down then
		step = false
		Timer = Timer + 1/60
	end
	if not IP or Timer >= 0.25 then
		step = true
		Timer = 0
	end
	
	
	if UpS then
		Channel = Channel+1
	elseif DownS then
		Channel = Channel-1
	end
	if Channel == 101 then
		Channel = 0
	end
	if Channel == -1 then
		Channel = 100
	end
	
	
	if IP then
		Radio = changeStatus(IX,IY,0,7,32,7,Radio)
	else
		temp = true
	end
	
	
	output.setBool(1,Radio)
	output.setBool(2,PTT)
	output.setNumber(1,Channel)
end



function onDraw()
	screen.setColor(0,0,0)
	screen.drawClear()
	
	
	screen.setColor(200,200,200)
	if Hour < 10 then
		H = "0"..string.format("%.0f",Hour)
	else
		H = string.format("%.0f",Hour)
	end
	if Min < 10 then
		M = "0"..string.format("%.0f",Min)
	else
		M = string.format("%.0f",Min)
	end
	screen.drawTextBox(1,0,10,7,H,0,0)
	screen.drawTextBox(11,0,3,7,":",0,0)
	screen.drawTextBox(13,0,10,7,M,0,0)
	
	
	for i=0,3 do
		if Strength > i*0.25 then
			screen.setColor(200,200,200)
		else
			screen.setColor(5,5,5)
		end
		screen.drawLine(24+2*i,4-i,24+2*i,6)
	end
	
	
	setColor(Radio,200,5)
	screen.drawRectF(0,7,32,7)
	screen.setColor(0,0,0)
	screen.drawTextBox(6,7,32,7,"Rad",-1,0)
	screen.drawTextBox(20,7,10,7,"i",-1,0)
	screen.drawTextBox(23,7,10,7,"o",-1,0)
	setColor(Radio,200,5)
	screen.drawLine(0,23,32,23)
	screen.drawTextBox(2,15,28,7,"Ch:",-1,0)
	screen.drawTextBox(2,15,28,7,string.format("%.0f",Channel),1,0)
	

	if PTT then
		screen.setColor(0,200,0)
	else
		setColor(Radio,200,5)
	end
	if Rec then
		screen.setColor(200,0,0)
	end
	screen.drawTextBox(2,25,15,7,"PTT",0,0)
	if Down then
		screen.setColor(0,200,0)
	else
		setColor(Radio,200,5)
	end
	screen.drawTextBox(19,25,4,7,"<",-1,0)
	if Up then
		screen.setColor(0,200,0)
	else
		setColor(Radio,200,5)
	end
	screen.drawTextBox(27,25,4,7,">",-1,0)
end



function setColor(Status,on,off)
	if Status then
		screen.setColor(on,on,on)
	else
		screen.setColor(off,off,off)
	end
end


function isPointInRectangle(x,y,rectX,rectY,rectW,rectH)
	return x >= rectX and y >= rectY and x <= rectX+rectW and y <= rectY+rectH
end



function changeStatus(x,y,rectX,rectY,rectW,rectH,status)
	if isPointInRectangle(x,y,rectX,rectY,rectW,rectH) and status == true and temp == true then
		status = false
		temp = false
	elseif isPointInRectangle(x, y, rectX, rectY, rectW, rectH) and status == false and temp == true then
		status = true
		temp = false
	end
	return status
end