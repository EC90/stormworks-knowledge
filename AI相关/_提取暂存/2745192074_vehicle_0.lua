-- source: steam id 2745192074 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2745192074
Atime=125
function onTick()
	
	x = input.getNumber(1)
	y = input.getNumber(2)
	xdis = input.getNumber(3)
	ydis = input.getNumber(4)
	
	if xdis ~= 0 and ydis ~= 0 then
		Locktime=Locktime+1
		Aiming=true
		if Locktime > Atime then
			lock = true
			output.setBool(1,true)
		end
	else
		Aiming=false
		lock = false
		Locktime=0
		output.setBool(1,false)
	end
	
	distance = (xdis+ydis)/2
	ookisa = 21.6
	en = 5
	
end

function onDraw()
	dx = 96/2 -ookisa/2
	dy = 96/2 -ookisa/2
	screen.setColor(60, 202, 0)
	
	screen.drawRect(dx, dy, ookisa, ookisa)
	screen.drawLine(0,95,95*(Locktime/Atime),95)
	
	if Aiming then
		if lock then
			screen.setColor(255, 0, 0)
			screen.drawText(30,66,"LOCKED!")
		end
		screen.drawCircle(96/2+x*360, 96/2-y*360, en)
		screen.drawText(26, 20, math.floor(distance+0.5))
	end
	
end