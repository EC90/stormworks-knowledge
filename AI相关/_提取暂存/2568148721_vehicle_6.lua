-- source: steam id 2568148721 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2568148721
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
font34={
0x0D0,0xC0C,0xFAF,0x2F4,0xB2D,0x6F5,0x0C0,0x690,0x096,0xAEA,0x4E4,0x560,0x444,0x010,0x168,0x79E,0x5F1,
0x9B5,0x9DA,0x6F2,0xDDA,0x6DA,0x9AC,0x3FC,0x4A7,0x050,0x1A0,0x44A,0xAAA,0xA44,0xA41,0x69D,0x7A7,0xFD6,
0x699,0xF96,0xFD9,0xFA8,0x69B,0xF2F,0x9F9,0x19E,0xF4B,0xF11,0xF4F,0xF6F,0x696,0xFA4,0x6B7,0xFA5,0x5BA,
0x8F8,0xE1E,0xC3C,0xF5F,0x969,0xC7C,0xBD9,0xF90,0x861,0x09F,0x484,0x111,0x084,0x2F9,0x0F0,0x9F4,0x462}

function dDot(x,y)
	screen.drawLine(x,y,x,y+1)
end

function dChar(x,y,char)
	c=string.byte(string.upper(char))-32
	if c>64 then c=c-26 end
	if c>0 and c<69 then
		for i=0,11 do
			if font34[c]&(1<<(11-i))>0 then dDot(x+i//4, y+i%4) end
		end
	end
end

function dStr(x,y,str)
	cs=string.len(str)
	for i=0,cs-1 do
		dChar(x+4*i,y,string.sub(str,i+1,i+1))
	end
end

function onTick()
	stop,pause = igB(2),igB(3)
end


function onDraw()
	ssC(0,0,0)
	sdRF(0,0,32,32)
	sdRF(91,0,5,32)
	sdRF(0,0,96,4)
	sdRF(0,28,96,4)	
	ssC(5,5,5)
	sdRF(1,1,30,30)
	sdRF(92,1,3,30)
	sdRF(1,1,94,3)
	sdRF(1,28,94,3)
	ssC(255,255,255)
	sdL(32,26,91,26)
	if stop == true then dStr(32,5,'STOP')
	elseif pause == true then dStr(32,5,'PAUSE')
	else dStr(32,5,'NOW PLAYING ...')
	end
	ssC(7,7,7)
	dStr(4,24,'FAULDS')
	ssC(3,3,3)
	dStr(4,23,'FAULDS')
end