-- source: steam id 2084796098 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2084796098

function onTick()
Dist = input.getNumber(1)
Time = input.getNumber(2)
TM = Time/60
Tround = math.floor(TM)
TS = 1-(Tround*60-Time)
Tsround = math.floor(TS)
Mode = 1
	if Time>15 then Mode = 1
	end
	if Time<=15 and Time>0 then Mode = 2
	end
	if Time<=0 then Mode = 3
	end
end


function onDraw()
w = screen.getWidth()
h = screen.getHeight()
screen.setColor(0, 250, 0)
if Mode==1 
	then
			screen.drawLine(w-33,h-15,w+1,h-15)
			screen.drawText(w-30, h-22,math.floor(Dist))
			screen.drawText(w-30, h-30, 'Dist')
			screen.drawText(w-30, h-13, 'Time')
			screen.drawText(w-30, h-6, Tround.. ':'.. Tsround)
	elseif Mode==2
		then
			screen.setColor(250, 0, 0)
			screen.drawText(w-30, h-18, 'Ready?')
			screen.drawText(w-20, h-10,Tsround)
	elseif Mode==3
		then
			screen.setColor(20, 250, 20)
			screen.drawText(w-25,h-18, 'JUMP')
	end
end