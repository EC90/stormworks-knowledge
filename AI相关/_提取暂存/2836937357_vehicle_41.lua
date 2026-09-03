-- source: steam id 2836937357 / vehicle.xml block#41
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
end

function onTick()
	ssc = screen.setColor
	idb = input.getBool
	idn = input.getNumber
	sdt = screen.drawText
	
	waypoint = idn(2)
	distance = idn(1)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	ssc(255,255,255)
	
	sdt(0,1,"----FPLAN----")
	offset = 15
	
		ssc(0,255,0)
	if waypoint > 0 then
			DST(1,15,"WAYPOINT 1-")
			DST(46,15,math.floor(distance/1000))
			DST(57,15,"KM")
			offset = offset + 10
		if waypoint > 1 then
			DST(1,offset,"WAYPOINT 2")
			offset = offset + 10
		end
		if waypoint > 2 then
			DST(1,offset,"WAYPOINT 3")
			offset = offset + 10
		end
		if waypoint > 3 then	
			DST(1,offset,"WAYPOINT 4")
			offset = offset + 10
		end
		if waypoint > 5 then
			DST(1,offset,"CONT.")
			DST(22,offset, string.format("%.0f", waypoint-4))
			DST(29,offset,"MORE WP")
			
		else if waypoint > 4 then
			DST(1,offset,"WAYPOINT 5")
			offset = offset + 10
		end
		end
		if waypoint < 6 then
			DST(1,offset,"--END OF F-PLN--")
		end
	else
		DST(1,15,"---NO F-PLAN----")
	end

end