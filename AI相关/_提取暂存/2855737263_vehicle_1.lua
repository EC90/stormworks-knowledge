-- source: steam id 2855737263 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2855737263
tg = {}
pi = math.pi
pi2 = 2*pi
cos = math.cos
sin = math.sin
t = 0
tgs = {}
ping = false
tgc = 0
tgcm = {}
pc = 0


function deg(x)
return (((-x*360+450)%360)/360*pi2)
end

function stabilizer(x, y, z)
return -(cos(z)*x+sin(z)*y)*pi2
end

function clamp(x,min,max)
return math.max(math.min(x, max), min)
end

function onTick()

if active and system then
t = t + 1
else t=0
end

--er = (360-property.getNumber("Effective Range(deg)"))/360*pi2/2
r = input.getNumber(27)*1000
tiltx = input.getNumber(28)
tilty = input.getNumber(29)
maxd = input.getNumber(30)
scale = input.getNumber(31)/10
active = input.getBool(17)
system = input.getBool(18)

output.setBool(1, ping)
if active and t == 0 or t/60*1430/r*96/2 > 96 then
	ping = true
	output.setBool(1, ping)
	ping = false
	t = 0
	pc = pc + 1
	tgcm[pc] = {tgc}
	tgc = 0
end

for i = 1, 13 do
	tg[i] = {input.getBool(i), deg(input.getNumber(i*2-1)), input.getNumber(i*2)*pi2}
end

if active then
for i in pairs(tg) do
	if tg[i][1] then
		tgc = tgc + 1
		ymod = tg[i][3]-stabilizer(tiltx, tilty, tg[i][2])
		dxy = t/120*1430*cos(ymod)
		tgs[tgc] = {tg[i][2], dxy}
	end
	
	if  pc > 2 and tgcm[pc-1][1] > tgcm[pc][1] then
	for m = tgcm[pc][1] , tgcm[pc-1][1] do
		tgs[m] = nil
	end
	end
end
end

if not active then
	for tgc in pairs(tgs) do
		tgs[tgc] = nil
		pc = 0
	end
end

end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	screen.setColor(0, 0, 200, 100)
	screen.drawCircleF(0, 0, 1000)
	
for j = 1, 8 do
	screen.setColor(0, 255, 0, 50)
	screen.drawLine(w/2, h/2, w/2 + h/2*cos(pi/4*j), h/2 + h/2*sin(pi/4*j))
	--end
	if j < 5 then
	screen.drawCircle(w/2, h/2, h/2/4*j)
	end
end

screen.setColor(255, 0, 0, 150)
if active then
for tgc in pairs(tgs) do
	screen.drawCircleF(w/2 + tgs[tgc][2]/r*h/2*cos(tgs[tgc][1]), h/2 - tgs[tgc][2]/r*h/2*sin(tgs[tgc][1]), 1)
end
	screen.setColor(100, 100, 100)
	screen.drawCircle(w/2, h/2, t/120*1430/r*h/2)
	screen.setColor(100, 100, 100, 150)
	screen.drawCircle(w/2, h/2, t/120*1430/r*h/2-1)
else
screen.setColor(255, 0, 0, 150)
for i in pairs(tg) do
	if tg[i][1] then
	screen.drawLine(w/2,w/2, w/2 + h/2*cos(tg[i][2]), h/2 - h/2*sin(tg[i][2]))
	end
end

end

	screen.setColor(0, 255,0 ,100)

	screen.drawText(w-30, 2, "R=")
	screen.drawText(w-21, 2, string.format("%02d", r/1000))
	screen.drawText(w-11, 2, "km")

end
