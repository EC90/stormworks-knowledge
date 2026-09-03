-- source: steam id 2835713385 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2835713385
igN = input.getNumber
osN = output.setNumber
igB = input.getBool
osB = output.setBool
ssC = screen.setColor
sdL = screen.drawLine
sdC = screen.drawCircle
sdR = screen.drawRect
sdTF = screen.drawTriangleF
sdRF= screen.drawRectF
sdCF = screen.drawCircleF
sdT = screen.drawText
stf = string.format
sts = string.sub

x,y,i=32,12,0

function onTick()
	change,songnum = igB(1),igN(32)
	if change == true then
		x,y=32,12
		i=0
	end
	if 120 <= i then
		x = x-0.2
		i = 121
	elseif 0<=i then
		i = i+1
	end
	if x <= -96 then 
		x = 96
	end
	osN(32,songnum)
end


function onDraw()
	if songnum == 0 then sdT(32,12,'NONE')
	elseif songnum == 1 then sdT(x,y,'MERRY GO ROUND OF LIFE') 
	elseif songnum == 2 then sdT(32,12,'NATSUMATSURI') 
	elseif songnum == 3 then sdT(32,12,'GAS GAS GAS') 
	elseif songnum == 4 then sdT(32,12,'DEJA VU') 
	elseif songnum == 5 then sdT(32,12,'YAKETY SAX') 
	elseif songnum == 6 then sdT(x,y,'CAMPFIRE SONG SONG') 
	elseif songnum == 7 then sdT(x,y,'TAKE ME HOME COUNTRY ROAD') 
	end
end