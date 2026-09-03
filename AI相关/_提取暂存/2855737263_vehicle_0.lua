-- source: steam id 2855737263 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2855737263
tg = {}
pi = math.pi
pi2 = 2*pi
cos = math.cos
sin = math.sin
abs = math.abs
t = 0
tgc = 0
tgs={}
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

--er = (360-property.getNumber("Effective Range(deg)"))/360*pi
r = input.getNumber(27)*1000
tiltx = input.getNumber(28)
tilty = input.getNumber(29)
maxd = input.getNumber(30)
scale = input.getNumber(31)/10
active = input.getBool(17)
system = input.getBool(18)

for i = 1, 13 do
	tg[i] = {input.getBool(i), deg(input.getNumber(i*2-1)), input.getNumber(i*2)*pi2}
end

if active and system then
t = t + 1
else
t=0
end

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

if not active then
	for tgc in pairs(tgs) do
		tgs[tgc] = nil
		pc = 0
	end
end

for i in pairs(tg) do
	if tg[i][1] then
		tgc = tgc + 1
		ymod = tg[i][3]-stabilizer(tiltx, tilty, tg[i][2])
		dxy = t/120*1430--*cos(ymod)
		tgs[tgc] = {tg[i][2], ymod, dxy}
	end
	if  pc > 2 and tgcm[pc-1][1] > tgcm[pc][1] then
	for m = tgcm[pc][1] , tgcm[pc-1][1] do
		tgs[m] = nil
	end
	end
end

end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	screen.setColor(0, 0, 200, 100)
	screen.drawCircleF(0, 0, 1000)
	
	screen.setColor(0, 255, 0)

	screen.setColor(100, 100, 100)
	screen.drawLine(0, 10*t-1, w, 10*t-1)

for j = -20, 20 do
	screen.setColor(0, 255, 0, 50)
	screen.drawLine(w/2+h/8*j, h, w/2+h/8*j, 0)
	screen.drawLine(0, (10*j+maxd)*scale, w, (10*j+maxd)*scale)
	if j%2 == 0 then
	screen.setColor(0, 255, 0, 100)
	screen.drawText(1, (10*j+maxd-1)*scale, string.format("%+.0f",10*(-j)))
	end
end
	
screen.setColor(255,0,0,150)
if active then
for tgc in pairs(tgs) do
	screen.drawCircleF(w/2 + tgs[tgc][3]/r*h/2*cos(tgs[tgc][1]), (-tgs[tgc][3]*sin(tgs[tgc][2])+maxd)*scale, 1)

end

end


end
