-- source: steam id 2836937357 / vehicle.xml block#46
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
	APU=input.getBool(1)
	RAT=input.getBool(2)
	TAT=input.getNumber(1)
	B1V=input.getNumber(2)
	B2V=input.getNumber(3)
	B1A=input.getNumber(4)
	B2A=input.getNumber(5)
	GEN1V=input.getNumber(6)
	GEN2V=input.getNumber(7)
	GEN1HZ=input.getNumber(8)
	GEN2HZ=input.getNumber(9)
	
end

function onDraw() 

SC(25, 25, 25)
screen.drawRectF(24, 33, 15, 7)
screen.drawRectF(23, 21, 17, 7)

if APU == true then
SC(0, 255, 0)
DST(26, 34,"APU")
else
SC(255, 50, 20)
DST(26, 34,"APU")
end

if RAT == true then
SC(0, 255, 0)
DST(24, 22,"EGEN")
else
SC(255, 50, 20)
DST(24, 22,"EGEN")
end


SC(25, 25, 25)
screen.drawRectF(5, 22, 17, 7)
screen.drawRectF(41, 22, 17, 7)
SC(0, 255, 0)
DST(20, 56,"+")
DST(8, 23,"PC1")
DST(44, 23,"PC2")
DST(24, 56, string.format("%.0f", TAT))
DST(9, 8, string.format("%.0f", B1V))
DST(43, 8, string.format("%.0f", B2V))
DST(9, 14, string.format("%.0f", B1A))
DST(43, 14, string.format("%.0f", B2A))
DST(6, 38, string.format("%.0f", GEN1V))
DST(42, 38, string.format("%.0f", GEN2V))
DST(4, 45, string.format("%.0f", GEN1HZ))
DST(40, 45, string.format("%.0f", GEN2HZ))
SC(0, 255, 255)
DST(33, 56,"C")
DST(19, 8,"V")
DST(53, 8,"V")
DST(19, 14,"A")
DST(53, 14,"A")
DST(19, 38,"V")
DST(55, 38,"V")
DST(17, 45,"HZ")
DST(53, 45,"HZ")
DL(37, 56, 38, 56)
SC(255, 255, 255)
DST(25, 1,"ELEC")
DST(5, 56,"TAT")
DST(12, 1,"B1")
DST(46, 1,"B2")
DST(6, 31,"GEN1")
DST(42, 31,"GEN2")
DL(0,53,64,53)
end

