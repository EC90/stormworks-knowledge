-- source: steam id 3791064111 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3791064111
i=input
o=output
p=property
m=math
o2 = 0
pi1,pi2=m.pi,m.pi*2
sin,cos,asin,acos=m.sin,m.cos,m.asin,m.acos
tan,atan=m.tan,m.atan

ign,igb=i.getNumber,i.getBool
pgn,pgb=p.getNumber,p.getBool
osn,osb=o.setNumber,o.setBool

s=screen
dl=s.drawLine

function txt(x,y,t,c,b)t=tostring(t)for i=1,#t do c=t:sub(i,i):upper():byte()*3-95if c>193then c=c-78 end c="0x"..("0000B0101F6F5FAB6DEDA010096690A4A4E4048444080168F9F8FABDDDB9F47DBBDDF3D1FDFF570500580A4AAA4A0391B96E5E6DF99669F9DF15FD96F4F9F978496F88FF3FF1F69625F79FA5FDDA1F1F8F787FCFB4B3C3BFD09F861F902128880219F60F06F9426"):sub(c,c+2)for j=0,11 do if c&1<<j>0then b=x+j//4+i*4-4 dl(b,y+j%4,b,y+j%4+1)end end end end

function clamp(x,a,b) return math.max(math.min(x,b),a) end

function loc(rad,azi,ele) -- SPHERIC COORDINATES TO LOCAL XYZ

    return rad*cos(ele*pi2)*sin(azi*pi2), rad*cos(ele*pi2)*cos(azi*pi2), rad*sin(ele*pi2)

end

t = -1
function onTick()
if igb(1) then
	t = t+1
else
	t = -1
end
	x = ign(1)
	y = ign(3)
	Volts = ign(4)
	Fuel = ign(5)
	MaxValue = 190
	spdDir = ign(9)
	spd = math.floor(3.6*ign(13))
	H = spd/(MaxValue/100) * 0.44
	W = Volts/ 0.01 * 0.18
	lifetime_avg = 8
	menu = 2
	MaxFuel = 1125
	Fuel_Width = Fuel/(MaxFuel/100) * 0.19
	Bat_Width = Volts * 19
	Odo = ign(7)
	cFuel = ign(7)
	Fuel_km = cFuel/Odo
	x2,y2,z2 = loc(-4,ign(17),0)
	if spdDir > 1 then
	gear = "D"
	elseif spdDir < -1 then
	gear = "R"
	else 
	gear = "P"
end
if t <= 60 then
o = 255
else
o = 0
end
o2 = (o*0.1)+(o2*0.9)
end








function onDraw()

S=screen
SC=S.setColor
DRF=S.drawRectF
DR=s.drawRect
DL=s.drawLine

s.setMapColorOcean(3,3,3)
s.setMapColorShallows(5,5,5)
s.setMapColorLand(40,40,40)
s.setMapColorGrass(17,17,17)
s.setMapColorSand(15,15,15)
s.setMapColorSnow(35,35,35)
s.setMapColorRock(25,25,25)
s.setMapColorGravel(20,20,20)
s.drawMap(x+300,y,1) -- map (layer 0)
SC(25,255,25)








SC(1,1,1) -- mask 1 (layer 1) map window
DRF(36,0.5,60,32)
DRF(0,0.5,36,4)
DRF(0,4.5,2,28)
DRF(2,27.5,34,5)
DRF(35,5.5,1,22)
DRF(34,7.5,1,20)
DRF(33,9.5,1,18)
DRF(32,11.5,1,16)
DRF(31,13.5,1,14)
DRF(30,15.5,1,12)
DRF(29,18.5,1,9)
DRF(28,19.5,1,8)
DRF(27,21.5,1,6)
DRF(26,23.5,1,4)
DRF(25,25.5,2,2)

SC(255,255,255) -- gauges
DRF(31,26,10,clamp(-H,-10,0)) 
DRF(35,16,7,clamp(10-H,-10,0))
DRF(41,7,clamp(H-19,0,27),1)
DRF(40,8,clamp(H-19,0,27),1)
DRF(39,9,clamp(H-19,0,27),1)
DRF(38,10,clamp(H-19,0,27),1)
DRF(73,26,W,2)


SC(1,1,1) -- mask 2 (layer 2) gauge window
DRF(0,0.5,96,5)
DRF(0,5.5,2,27)
DRF(2,27.5,71,5)
DRF(73,28.5,18,4)
DRF(91,5.5,5,27)
DRF(68,5.5,23,21)
DRF(42,11.5,31,16)
DRF(35,5.5,33,2)
DRF(67,8.5,1,3)
DRF(66,9.5,1,2)
DRF(65,10.5,1,1)
DRF(41,12.5,1,2)
DRF(40,14.5,2,13)
DRF(25,26.5,15,1)
DRF(35,24.5,5,2)
DRF(36,22.5,4,2)
DRF(37,20.5,3,2)
DRF(38,18.5,2,2)
DRF(39,16.5,1,2)
DRF(34,7.5,8,1)
DRF(34,8.5,6,1)
DRF(33,9.5,5,1)
DRF(33,10.5,5,1)
DRF(32,11.5,5,2)
DRF(31,13.5,5,2)
DRF(30,15.5,5,2)
DRF(29,17.5,5,2)
DRF(28,19.5,5,2)
DRF(27,21.5,5,2)
DRF(26,23.5,5,3)
DRF(25,25.5,1,1)



SC(200,1,1,255) -- gauge mask
DRF(64,7.5,4,1)
DRF(63,8.5,4,1)
DRF(62,9.5,4,1)
DRF(61,10.5,4,1)
SC(225,225,225,75)
DRF(42,7.5,19,4)
DRF(61,7.5,1,3)
DRF(62,7.5,1,2)
DRF(63,7.5,1,1)
DRF(40,8.5,2,4)
DRF(38,9.5,2,7)
DRF(40,12.5,1,2)
DRF(37,11.5,1,9)
DRF(38,16.5,1,2)
DRF(36,13.5,1,2)
DRF(35,15.5,2,7)
DRF(34,17.5,1,5)
DRF(33,19.5,1,3)
DRF(32,21.5,1,1)
DRF(32,22.5,4,2)
DRF(31,23.5,1,3)
DRF(32,24.5,3,2)
DRF(73,26.5,18,2)
SC(25,25,25,255)

DRF(60,7.5,1,1)
DRF(59,8.5,1,1)
DRF(56,7.5,1,1)
DRF(55,8.5,1,1)
DRF(52,7.5,1,1)
DRF(51,8.5,1,1)
DRF(48,7.5,1,1)
DRF(47,8.5,1,1)
DRF(44,7.5,1,1)
DRF(43,8.5,1,1)
DRF(40,8.5,1,1)
DRF(39,9.5,1,1)

SC(2,2,2) -- bezel
DR(0,0,95,31)

SC(25,255,25)
DRF(43,25,13,1)

SC(120,120,120) -- digits and drive mode 
txt(44,15,tostring(string.sub("000"..tostring(math.floor(spd)),-3)))
txt(48,20,gear)
DR(71,26,0,1)
DR(70,27,0,1)



if menu == 2 then --- menu 2 (fuel

SC(120,120,120)
txt(72,19,tostring(string.sub("00000"..tostring(math.floor(Odo)),-5)))


SC(1,1,1,o2)
DRF(0,0,100,100)
SC(255,255,255,o2)
SC(255,255,255,o2)
DRF(52,11.5,3,3)
DRF(49,14.5,3,3)
DRF(46,11.5,3,3)
DRF(43,14.5,3,3)
end
end
