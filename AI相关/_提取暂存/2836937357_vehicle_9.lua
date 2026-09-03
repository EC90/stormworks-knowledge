-- source: steam id 2836937357 / vehicle.xml block#9
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
	TAT=input.getNumber(1)
	D1L=input.getBool(1)
	D1R=input.getBool(2)
	D2L=input.getBool(3)
	D2R=input.getBool(4)
	D3L=input.getBool(5)
	D3R=input.getBool(6)
	D4L=input.getBool(7)
	D4R=input.getBool(8)
	
end

function onDraw() 


if D1L == true then
SC(255, 50, 20)
screen.drawRect(28, 15, 2, 3)
else
SC(0, 255, 0)
screen.drawRect(28, 15, 2, 3)
end
if D1R == true then
SC(255, 50, 20)
screen.drawRect(33, 15, 2, 3)
else
SC(0, 255, 0)
screen.drawRect(33, 15, 2, 3)
end

if D2L == true then
SC(255, 50, 20)
screen.drawRect(28, 23, 2, 3)
else
SC(0, 255, 0)
screen.drawRect(28, 23, 2, 3)
end
if D2R == true then
SC(255, 50, 20)
screen.drawRect(33, 23, 2, 3)
else
SC(0, 255, 0)
screen.drawRect(33, 23, 2, 3)
end

if D3L == true then
SC(255, 50, 20)
screen.drawRect(28, 34, 2, 3)
else
SC(0, 255, 0)
screen.drawRect(28, 34, 2, 3)
end
if D3R == true then
SC(255, 50, 20)
screen.drawRect(33, 34, 2, 3)
else
SC(0, 255, 0)
screen.drawRect(33, 34, 2, 3)
end

if D4L == true then
SC(255, 50, 20)
screen.drawRect(28, 43, 2, 3)
else
SC(0, 255, 0)
screen.drawRect(28, 43, 2, 3)
end
if D4R == true then
SC(255, 50, 20)
screen.drawRect(33, 43, 2, 3)
else
SC(0, 255, 0)
screen.drawRect(33, 43, 2, 3)
end




SC(0, 255, 0)
DST(20, 56,"+")
DST(24, 56, string.format("%.0f", TAT))
SC(0, 255, 255)
DST(33, 56,"C")
DL(37, 56, 38, 56)
SC(255, 255, 255)
DL(31,8,27,13) --AIRCRAFT SCHEM
DL(32,8,36,13)
DL(28,13,28,15)--
DL(35,13,35,15)
DL(27,15,27,47)--
DL(36,15,36,47)
DL(27,47,29,49)--
DL(36,47,35,49)
DL(27,27,16,30)--WINGS
DL(36,27,47,30)
DST(17, 1,"DOOR/OXY")
DST(5, 56,"TAT")
DL(0,53,64,53)
SC(255, 50, 20)
DST(6, 15,"SLIDE")
DST(39, 15,"SLIDE")
DST(6, 33,"SLIDE")
DST(39, 33,"SLIDE")
DST(6, 45,"SLIDE")
DST(39, 45,"SLIDE")
end

