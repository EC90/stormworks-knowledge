-- source: steam id 2836937357 / vehicle.xml block#49
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
 EN1PUMP=input.getBool(1)
 EN2PUMP=input.getBool(2)
 EN1FIRE=input.getBool(3)
 EN2FIRE=input.getBool(4)
 BLUPUMP=input.getBool(5)
	 TAT=input.getNumber(1)
	GHYD=input.getNumber(2)
	BHYD=input.getNumber(3)
	YHYD=input.getNumber(4)
	
end

function onDraw() 

if GHYD > (1400) then
SC(0, 255, 0)
DST(3, 16, string.format("%.0f", GHYD))
DL(10,22,10,30)--G
DL(10,35,10,38)--G
else
SC(255, 50, 20)
DST(3, 16, string.format("%.0f", GHYD))
DL(10,22,10,30)--G
DL(10,35,10,38)--G
end
if BHYD > (1400) then
SC(0, 255, 0)
DST(25, 16, string.format("%.0f", BHYD))
DL(32,22,32,33)--B
DL(32,38,32,42)--B
else
SC(255, 50, 20)
DST(25, 16, string.format("%.0f", BHYD))
DL(32,22,32,33)--B
DL(32,38,32,42)--B
end
if YHYD > (1400) then
SC(0, 255, 0)
DST(47, 16, string.format("%.0f", YHYD))
DL(54,22,54,30)--Y
DL(54,35,54,38)--Y
else
SC(255, 50, 20)
DST(47, 16, string.format("%.0f", YHYD))
DL(54,22,54,30)--Y
DL(54,35,54,38)--Y
end
if EN2PUMP == true then
SC(0, 255, 0)
screen.drawRect(52, 30, 4, 4)
DL(54,31,54,35)
else
SC(255, 50, 20)
screen.drawRect(52, 30, 4, 4)
DL(52,32,57,32)
end
if EN1PUMP == true then
SC(0, 255, 0)
screen.drawRect(8, 30, 4, 4)
DL(10,31,10,35)
else
SC(255, 50, 20)
screen.drawRect(8, 30, 4, 4)
DL(8,32,13,32)
end
if EN2FIRE == false then
SC(0, 255, 0)
screen.drawRect(52, 38, 4, 4)
DL(54,39,54,43)
else
SC(255, 50, 20)
screen.drawRect(52, 38, 4, 4)
DL(52,40,57,40)
end
if EN1FIRE == false then
SC(0, 255, 0)
screen.drawRect(8, 38, 4, 4)
DL(10,39,10,43)
else
SC(255, 50, 20)
screen.drawRect(8, 38, 4, 4)
DL(8,40,13,40)
end
if BLUPUMP == true then
SC(0, 255, 0)
screen.drawRect(30, 33, 4, 4)
DL(32,34,32,38)
else
SC(255, 50, 20)
screen.drawRect(30, 33, 4, 4)
DL(30,35,35,35)
end


SC(0, 255, 0)
DST(20, 56,"+")
DL(14,26,32,26)--PTU LINE
DL(47,26,52,26)--PTU LINE 2nd
DL(29,31,32,31)--RAT LINE
DL(9,43,9,50)--GR
DL(31,43,31,50)--BR
DL(31,42,34,42)
DL(53,43,53,50)--YR
DL(10,8,12,8)
DL(32,8,34,8)
DL(54,8,56,8)
DST(24, 56, string.format("%.0f", TAT))
SC(0, 255, 255)
DST(33, 56,"C")
DL(37, 56, 38, 56)
SC(255, 50, 20)
DL(11,49,11,46)--orange lines resevouarG
DL(33,49,33,46)--orange lines resevouarB
DL(55,49,55,46)--orange lines resevouarY
SC(255, 255, 255)
DL(9,50,12,50)--White lines resevouarG
DL(31,50,34,50)--White lines resevouarB
DL(53,50,56,50)--White lines resevouarY
DST(27, 1,"HYD")
DST(35, 24,"PTU")
DST(18, 29,"RAT")
DST(05, 10,"GRE")
DST(27, 10,"BLU")
DST(49, 10,"YEL")
DST(5, 56,"TAT")
DL(0,53,64,53)
end

