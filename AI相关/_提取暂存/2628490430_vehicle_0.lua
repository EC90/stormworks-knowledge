-- source: steam id 2628490430 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2628490430
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
	{900, 0.005, 600},
	{800, 0.002, 1500},
	{700, 0.001, 2400},
	{600, 0.0005,2400},
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
	local dist=iN(1)
	local elv=iN(2)*pi2

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
	oN(3,dist)
	oB(1,success)
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
