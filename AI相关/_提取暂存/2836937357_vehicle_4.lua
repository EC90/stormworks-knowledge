-- source: steam id 2836937357 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
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


sin = math.sin
cos = math.cos
function dial(cx,cy,r,v,label,rgbs,rgbs2,rgbc)
	cx, cy = cx + r, cy + r
	rgbs[4],rgbs[5] = (((1-rgbs[5])*3.839725)+1.22173),(((1-rgbs[4])*3.839725)+1.22173)
	rgbs2[4],rgbs2[5] = (((1-rgbs2[5])*3.839725)+1.22173),(((1-rgbs2[4])*3.839725)+1.22173)
	local s = 0.0349066
	for i = 1.22173,5.061455,s do
		if i > rgbs[4] and i < rgbs[5] then
			screen.setColor(rgbs[1],rgbs[2],rgbs[3])
		elseif i > rgbs2[4] and i < rgbs2[5] then
			screen.setColor(rgbs2[1],rgbs2[2],rgbs2[3])
			else screen.setColor(rgbc[1],rgbc[2],rgbc[3],rgbc[4])
		end
		local x = cx+(r*sin(i))
		local y = cy+(r*cos(i))
		local x2 = cx+(r*sin(i+s))
		local y2 = cy+(r*cos(i+s))
		screen.drawLine(x,y,x2,y2)
	end
	screen.setColor(0,255,0,200)
	dStr(cx-((string.len(label)-1)*2)-1,cy+3,label)
	screen.setColor(rgbc[1],rgbc[2],rgbc[3])
	value = -math.max(((((v[2]-v[1])/(v[3]-v[1]))*3.839725)+1.22173),0)
	local x3 = cx+((r-r/3)*sin(value))
	local y3 = cy+((r-r/3)*cos(value))
	screen.drawLine(cx,cy,x3,y3)
end
p = property
gn = p.getNumber
gt = p.getText
values = {}
function onTick()
	for i = 1,4 do
		values[i] = input.getNumber(i)
	end
end
function onDraw()
	dial(gn("Dial 1 X"),gn("Dial 1 Y"),gn("Dial 1 Radius"),{gn("Dial 1 Min"),values[1],gn("Dial 1 Max")},"" ,{gn("Dial 1 Sector I R"),gn("Dial 1 Sector I G"),gn("Dial 1 Sector I B"),gn("Dial 1 Sector I Start (0-1)"),gn("Dial 1 Sector I End (0-1)")},{gn("Dial 1 Sector II R"),gn("Dial 1 Sector II G"),gn("Dial 1 Sector II B"),gn("Dial 1 Sector II Start (0-1)"),gn("Dial 1 Sector II End (0-1)")},{gn("Dial 1 Text R"),gn("Dial 1 Text G"),gn("Dial 1 Text B"),100})
	dial(gn("Dial 2 X"),gn("Dial 2 Y"),gn("Dial 2 Radius"),{gn("Dial 2 Min"),values[2],gn("Dial 2 Max")},"",{gn("Dial 2 Sector I R"),gn("Dial 2 Sector I G"),gn("Dial 2 Sector I B"),gn("Dial 2 Sector I Start (0-1)"),gn("Dial 2 Sector I End (0-1)")},{gn("Dial 2 Sector II R"),gn("Dial 2 Sector II G"),gn("Dial 2 Sector II B"),gn("Dial 2 Sector II Start (0-1)"),gn("Dial 2 Sector II End (0-1)")},{gn("Dial 2 Text R"),gn("Dial 2 Text G"),gn("Dial 2 Text B"),100})
	dial(gn("Dial 3 X"),gn("Dial 3 Y"),gn("Dial 3 Radius"),{gn("Dial 3 Min"),values[3],gn("Dial 3 Max")},string.format("%.0f", values[3]),{gn("Dial 3 Sector I R"),gn("Dial 3 Sector I G"),gn("Dial 3 Sector I B"),gn("Dial 3 Sector I Start (0-1)"),gn("Dial 3 Sector I End (0-1)")},{gn("Dial 3 Sector II R"),gn("Dial 3 Sector II G"),gn("Dial 3 Sector II B"),gn("Dial 3 Sector II Start (0-1)"),gn("Dial 3 Sector II End (0-1)")},{gn("Dial 3 Text R"),gn("Dial 3 Text G"),gn("Dial 3 Text B"),100})
	dial(gn("Dial 4 X"),gn("Dial 4 Y"),gn("Dial 4 Radius"),{gn("Dial 4 Min"),values[4],gn("Dial 4 Max")},string.format("%.0f", values[4]),{gn("Dial 4 Sector I R"),gn("Dial 4 Sector I G"),gn("Dial 4 Sector I B"),gn("Dial 4 Sector I Start (0-1)"),gn("Dial 4 Sector I End (0-1)")},{gn("Dial 4 Sector II R"),gn("Dial 4 Sector II G"),gn("Dial 4 Sector II B"),gn("Dial 4 Sector II Start (0-1)"),gn("Dial 4 Sector II End (0-1)")},{gn("Dial 4 Text R"),gn("Dial 4 Text G"),gn("Dial 4 Text B"),100})
end