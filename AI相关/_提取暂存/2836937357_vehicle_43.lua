-- source: steam id 2836937357 / vehicle.xml block#43
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
s=screen
SC=s.setColor
DL=s.drawLine

font35={
0x2482,0x5A00,0x5F7D,0x7CFA,0x52A5,0x2AAB,0x4800,0x1491,0x4494,0x5540,0x5D0,0x14,0x1C0,0x2,0x1494,		
0x7B6F,0x2C97,0x73E7,0x73CF,0x5BC9,0x79CF,0x79EF,0x7249,0x7BEF,0x7BCF,
0x410,0x414,0x1511,0xE38,0x4454,0x6282,0xF67,
0x2BED,0x6BAE,0x3923,0x6B6E,0x79A7,0x79A4,0x792F,0x5BED,0x7497,0x726F,0x5BAD,0x4927,0x5F6D,
0x7B6D,0x2B6A,0x6BA4,0x2B59,0x6BAD,0x388E,0x7492,0x5B6F,0x5B52,0x5B7D,0x5AAD,0x5A92,0x72A7}

function DOT(x,y)
	DL(x,y,x,y+1)
end

function dChar(x,y,char)
	c=string.byte(string.upper(char))-32
	if c>64 then c=c-26 end
	if c>0 and c<59 then
		for i=0,14 do
			if font35[c]&(1<<(14-i))>0 then 
				DOT(x+i%3, y+i//3) end
		end
	end
end

function DST(x,y,str)
	cs=string.len(str)
	for i=0,cs-1 do
		dChar(x+4*i,y,string.sub(str,i+1,i+1))
	end
end

function onTick()
	EN1=input.getBool(1)
	EN2=input.getBool(2)
	PUMPL=input.getBool(3)
	PUMPCL=input.getBool(4)
	PUMPCR=input.getBool(5)
	PUMPR=input.getBool(6)
	APU=input.getBool(7)
	TAT=input.getNumber(1)
	FOB=input.getNumber(2)
	TNKL=input.getNumber(3)
	TNKR=input.getNumber(4)
	
end

function onDraw() 


SC(255, 255, 255)
DL(5,41,59,41) --Tanks draw bottom line
DL(5,41,5,35) --left small line
DL(5,35,21,30) --Left Diagnoal line
DL(59,41,59,35) --right small line
DL(59,35,43,30) --Right Diagnoal line
DL(21,30,44,30) --Top line
DL(32,30,32,41) --Middle line

if AVAIL == true then
SC(0, 255, 0)
DST(23, 8,"AVAIL")
end
if FOPEN == true then
SC(0, 255, 0)
DST(40, 30,"FL ON")
end
if PUMPCL == true then
SC(0, 255, 0)
screen.drawRect(25, 25, 4, 4)
DL(27,26,27,30)
else
SC(255, 50, 20)
screen.drawRect(25, 25, 4, 4)
DL(25,27,30,27)
end
if PUMPCR == true then
SC(0, 255, 0)
screen.drawRect(35, 25, 4, 4)
DL(37,26,37,30)
else
SC(255, 50, 20)
screen.drawRect(35, 25, 4, 4)
DL(35,27,40,27)
end
if PUMPL == true then
SC(0, 255, 0)
screen.drawRect(15, 27, 4, 4)
DL(17,28,17,32)
else
SC(255, 50, 20)
screen.drawRect(15, 27, 4, 4)
DL(15,29,20,29)
end
if PUMPR == true then
SC(0, 255, 0)
screen.drawRect(45, 27, 4, 4)
DL(47,28,47,32)
else
SC(255, 50, 20)
screen.drawRect(45, 27, 4, 4)
DL(45,29,50,29)
end
if EN1 == true then
SC(0, 255, 0)
screen.drawRect(15, 12, 4, 4)
DL(17,12,17,17)
else
SC(255, 50, 20)
screen.drawRect(15, 12, 4, 4)
DL(15,14,20,14)
end
if EN2 == true then
SC(0, 255, 0)
screen.drawRect(45, 12, 4, 4)
DL(47,12,47,17)
else
SC(255, 50, 20)
screen.drawRect(45, 12, 4, 4)
DL(45,14,50,14)
end
if APU == true then
SC(0, 255, 0)
screen.drawRect(25, 15, 4, 4)
DL(27,16,27,20)
else
SC(255, 50, 20)
screen.drawRect(25, 15, 4, 4)
DL(25,17,30,17)
end


SC(0, 255, 0)
DL(27,24,27,20) --FUEL LINE CL
DL(37,24,37,20) --FUEL LINE CR
DL(17,26,17,20) --FUEL LINE L
DL(47,26,47,20) --FUEL LINE R
DL(17,20,28,20) --FUEL LINE Connect L
DL(37,20,48,20) --FUEL LINE Connect R
DL(17,20,17,16) --FUEL LINE Connect EN1
DL(17,11,17,8)
DL(47,20,47,16) --FUEL LINE Connect EN2
DL(47,11,47,8)
DST(20, 56,"+")
DST(24, 56, string.format("%.0f", TAT))
DST(21, 47, string.format("%.0f", FOB))
DST(10, 35, string.format("%.0f", TNKL))
DST(36, 35, string.format("%.0f", TNKR))
SC(0, 255, 255)
DST(33, 56,"C")
DL(37, 56, 38, 56)
SC(255, 255, 255)
DST(25, 1,"FUEL")
DST(32, 12,"APU")
DST(16, 1,"1")
DST(46, 1,"2")
DST(5, 56,"TAT")
DST(5, 47,"FOB:")
DL(0,53,64,53)
end

