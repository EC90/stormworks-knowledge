-- source: steam id 2836937357 / vehicle.xml block#34
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
igb=input.getBool
s=screen
DL=screen.drawLine
SC=screen.setColor
DR=screen.drawRect
DRF=screen.drawRectF
DT=screen.drawTriangle
DTF=screen.drawTriangleF
DTX=screen.drawText
GN=input.getNumber
SN=output.setNumber
FMT=string.format
SUB=string.sub
FLOOR=math.floor

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


function onDraw()

	SC(255, 0, 0, 255) --Lines for speed
	DL(0, 9, 15, 9)
	DL(0, 53 ,15, 53)
	DL(12, 9 ,12, 53)
	SC(20, 20, 20, 255)
	DRF(0, 10, 12, 43)
	SC(255, 0, 0, 255) --Lines for Altitude
	DL(51, 9, 67, 9)
	DL(51, 53 ,67, 53)
	SC(20, 20, 20, 255)
	DRF(51, 10, 12, 43)
	SC(255, 0, 0, 255)
	DR(20, 56, 24, 10)---lines for HDG
	SC(20, 20, 20, 255)
	DRF(21, 57, 23, 9)
	SC(0, 0, 0)             --ALT place
	DRF(48, 28, 15, 8)
	SC(255, 255, 255, 200)
	SC(0, 255, 0, 200)
	SC(255, 255, 255, 255)
	DL(48, 0, 48, 7)
	DL(15, 0, 15, 7)
	DL(32, 0, 32, 7)
	SC(255, 0, 0)
	DST(52,29,"ALT")
	DST(1,29,"SPD")
	DST(27,29,"ATT")
	DST(27,58,"HDG")

end
	
