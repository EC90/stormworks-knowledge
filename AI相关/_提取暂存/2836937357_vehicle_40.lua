-- source: steam id 2836937357 / vehicle.xml block#40
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
    EG1FIRE = input.getBool(1)
	EG2FIRE = input.getBool(2)
	APUFIRE = input.getBool(3)
	FTEST = input.getBool(5)
	GGEAR = input.getBool(4)
	ELECFAIL = input.getBool(6)
	ELECFAIL2 = input.getBool(7)
	AP1FAIL = input.getBool(8)
	AP2FAIL = input.getBool(9)
	PBRAKE = input.getBool(10)
	APU = input.getBool(11)
	RAT = input.getBool(12)
	ADIRS = input.getBool(13)
	GHYD = input.getBool(14)
	BHYD = input.getBool(15)
	YHYD = input.getBool(16)
	FGEAR = input.getBool(17)
	
end

function onDraw() 
SC(255, 255, 255)
offset = 6
obbset =6

if EG1FIRE or FTEST == true then
    SC(255, 0, 0)
	DST(1,32+offset,"ENG1 FIRE")
	offset = offset+6	
end		
if EG2FIRE or FTEST == true then
    SC(255, 0, 0)
	DST(1,32+offset,"ENG2 FIRE")
	offset = offset+6
end
if APUFIRE or FTEST == true then
    SC(255, 0, 0)
	DST(1,32+offset,"APU FIRE")
	offset = offset+6
end
if ELECFAIL and ELECFAIL2 == true then
    SC(255, 0, 0)
	DST(1,32+offset,"ELEC EMER")
	offset = offset+6
else if ELECFAIL == true then
    SC(255, 50, 20)
	DST(1,32+offset,"GN1+2 FAIL")
	offset = offset+6
end
end
if FGEAR == true then
    SC(255, 0, 0)
	DST(1,32+offset,"LDG NOT DN")
	offset = offset+6
end
if GHYD == true then
    SC(255, 0, 0)
	DST(1,32+offset,"G-HYD LOW")
	offset = offset+6
end
if YHYD == true then
    SC(255, 0, 0)
	DST(1,32+offset,"Y-HYD LOW")
	offset = offset+6
end
if BHYD == true then
    SC(255, 0, 0)
	DST(1,32+offset,"B-HYD LOW")
	offset = offset+6
end
if ADIRS == true then
    SC(255, 0, 0)
	DST(1,32+offset,"IRS-DISSAL")
	offset = offset+6
end
if AP1FAIL and AP2FAIL or ELECFAIL2 == true then
    SC(255, 50, 20)
	DST(1,32+offset,"AP1+2 FAIL")
	offset = offset+6
else if AP1FAIL == true then
    SC(255, 50, 20)
	DST(1,32+offset,"AP1 FAIL")
	offset = offset+6
else if AP2FAIL == true then
    SC(255, 50, 20)
	DST(1,32+offset,"AP2 FAIL")
	offset = offset+6
end
end
end

if GGEAR == true then --Right side of memos--
    SC(255, 50, 20)
	DST(42,32+obbset,"GGEAR")
	obbset = obbset+6	
end
if RAT == true then
    SC(255, 50, 20)
	DST(42,32+obbset,"RAT EX")
	obbset = obbset+6	
end	
if PBRAKE == true then
    SC(0, 255, 0)
	DST(42,32+obbset,"PBRK")
	obbset = obbset+6	
end	
if APU == true then
    SC(0, 255, 0)
	DST(42,32+obbset,"APU")
	obbset = obbset+6	
end	



end
