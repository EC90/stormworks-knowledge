-- source: steam id 2778980873 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2778980873
pN=property.getNumber
iN=input.getNumber
oN=output.setNumber
oB=output.setBool
abs=math.abs
sin=math.sin
cos=math.cos
tan=math.tan
asin=math.asin
atan=math.atan
pi2=math.pi*2

type=pN('Weapon Type')//1|0
params={
	{800, 0.025, 120},
	{1000,0.02,  150},
	{1000,0.01,  300},
	{895, 0.005, 600},
	{800, 0.002, 1500},
	{700, 0.001, 2400},
	{600, 0.0005,2400},
	{0,0,0},
}

type=type<1 and 1 or type>#params and #params or type
vel=params[type][1]
drag=params[type][2]*60
lifeSpan=params[type][3]/60
g=30
error=0.1

offset=0
time=0

function onTick()

oor = input.getBool(28)


targetx = iN(1)
targety = iN(2)
targetz = iN(3)

x = iN(4)
y = iN(5)
z = iN(6)


dx = targetx - x
dy = targety - y
dz = targetz - z
dist = math.sqrt(dx^2+dy^2+dz^2)

	local elv=iN(30)*pi2

	local gunElv,t,success
	if dist<4000 then
		gunElv,t,success=calc(dist,elv)
		if success then
			offset=(gunElv-elv)/pi2
			time=t*60
		end
	end

	oN(1,offset)
	oN(2,time)
	oN(3, params[type][1])
end


function calc(dist,elv)
	local w,h=dist*cos(elv),dist*sin(elv)
	local a,t=elv,0
	for i=1,10 do
		local vx,vy=vel*cos(a),vel*sin(a)
		t=getTime(vx,w)
		if t>lifeSpan then
			return a,t,false
		end
		y=getY(vy,t)
		if y>=h-error then
			return a,t,true
		end
		a=a+elv-atan(y,w)
	end
	return a,t,false
end

function getY(v,t)
	return -g*t/drag+(g/drag+v)*(1-math.exp(-drag*t))/drag
end

function getTime(v,x)
	return -math.log(1-drag*x/v)/drag
end
