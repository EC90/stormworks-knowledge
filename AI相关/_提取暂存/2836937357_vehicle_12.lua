-- source: steam id 2836937357 / vehicle.xml block#12
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



function onTick()
	mx = 64
	my = 64
	Compass = input.getNumber(10)
	HDG = (((360 + Compass) % 1)*360)
	HDG2 = (((360 + -Compass) % 1)*360)
	gpsx = input.getNumber(11)
	gpsy = input.getNumber(12)
	navx = input.getNumber(13)
	navy = input.getNumber(14)
	speedF = input.getNumber(15)
	speedR = input.getNumber(16)
	speedT = math.sqrt(speedF^2 + speedR^2)
	speedA = ((math.atan(speedF,speedR)*180/math.pi-180)+360)%360
	deltaX = (gpsx - navx)
	deltaY = (gpsy - navy)
	dtt = (math.sqrt(((gpsx - navx)^2) + ((gpsy - navy)^2)))/1850
	htt = ((math.atan(deltaX,deltaY)*180/math.pi-180)+360)%360
	speedScale = (speedT/100)*45
	if navx == 0  or navy == 0 then navLine = false else navLine = true end
	if dtt > 9 then range = 1.5 end
	if dtt < 9 then range = 5 end	
	if dtt < 3 then range = 15 end
	
	output.setNumber(1,htt)
	output.setNumber(2,dtt)
	
end
function onDraw()
    screen.setColor(0,0,0)
    screen.drawClear()
	screen.setColor(255,0,0)
	screen.drawCircle(mx/2,my,15)
	screen.drawCircle(mx/2,my,30)
	screen.drawCircle(mx/2,my,45)
	screen.setColor(0, 255, 255)
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG-90))),(my+(39)*math.sin(math.rad(HDG-90))), "N")
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG-45))),(my+(39)*math.sin(math.rad(HDG-45))), "NE")
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG-135))),(my+(39)*math.sin(math.rad(HDG-135))), "NW")
	screen.drawText (mx/2,my-10,"1")
	screen.drawText (mx/2+5,my-25,"2")
	screen.drawText (mx/2+10,my-40,"3")
	screen.setColor(0,0,0)
	screen.drawRectF(0,0,mx,16)
	screen.setColor(255,0,0)
	DST(7, 7, "MAP NOT AVAIL")
end
