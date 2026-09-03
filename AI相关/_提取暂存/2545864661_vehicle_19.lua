-- source: steam id 2545864661 / vehicle.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2545864661
inp=input
n=input.getNumber
out=output
m=math
pi=m.pi
sin=m.sin
cos=m.cos
atan=m.atan
tau=pi*2
tgts={}
yaw=0
dir=1
tick=0
zoom = 1

tgm=0

lL=-0.5 
lR=0.5

gN,gB,sB,sN,sC,s=input.getNumber,input.getBool,output.setBool,output.setNumber,screen.setColor,screen
function cl(x,min,max)
 return max<x and max or min>x and min or x
end

function atan2(y,x)
	if x>0 then
		a=atan(y/x)
	elseif x<0 and y>=0 then
		a=atan(y/x)+pi
	elseif x<0 and y<0 then
		a=atan(y/x)-pi
	elseif x==0 and y>0 then
		a=pi/2
	elseif x==0 and y<0 then
		a=-pi/2
	elseif x==0 and y==0 then
		a=0
	else
		a=0
	end
	return(a)	
end

function onTick()
	launch=gB(1)
	tick=tick+1
	ele=gN(1)
	hdg=-(n(2)*360)%360
	TL=gN(3)
	TF=gN(4)
	TU=gN(5)
	rng=gN(6)
	str=gN(7)
	GX=gN(8)
	GY=gN(9)
	ALT=gN(10)
	setmass=gN(11)

	mass=m.floor((rng*str)/10)*10	
	roll=atan2(TL,TU)
	limitL=lL
	limitR=lR
	if tick%2==1 then
		yaw=yaw+0.01*dir
	end
	
	if yaw>limitR then
		dir=-1
	elseif yaw<limitL then
		dir=1
	end
	
	sN(32,yaw+dir*0.02)
	tlosh=cos(roll)*(yaw*tau)+sin(roll)*(ele*tau)+hdg*(pi/180)
	tlosv=sin(roll)*(yaw*tau)+cos(roll)*(ele*tau)+TF*tau
	tgx=rng*sin(tlosh)*cos(tlosv)+GX
	tgy=rng*cos(tlosh)*cos(tlosv)+GY
	tga=rng*sin(tlosv)+ALT
	found=false

	if mass>1000 and tick%2==1 then
		for i,v in ipairs(tgts) do
			if v[1]==mass and v[1] ~= 0 and mass ~= 0 then
				found=true
				f=i
			end
		end
		if found and tgts[f] then
			tgts[f]={mass,rng,tgx,tgy,tga,tlosh,tlosv,tgts[f][8],tgts[f][9],tgts[f][10],tgts[f][11],tgts[f][12],700}
		else
			table.insert(tgts,{mass,rng,tgx,tgy,tga,tlosh,tlosv,tlosh,tlosv,tgx,tgy,tga,700})
		end
	end
	
	for i,v in ipairs(tgts) do
		if v[13]>0 then
			v[13]=v[13]-1
		else
			if tgm==v[1] then
				tgm=0
			end
			table.remove(tgts,i)
		end
	end
	for i,v in ipairs(tgts) do
		if v[1]==tgm then
			sN(1,v[3])
			sN(2,v[4])
			sN(3,cl(v[5],-999,15))
			sN(4,v[1])
			sB(1,true)
			lR=cl(v[2]/5000,0.025,0.5)
			lL=-lR
		elseif setmass<v[1]+15 and setmass>v[1]-15 and launch then
			tgm=v[1]
		elseif setmass==0 and launch then
			tgm=v[1]
		end
	end
end
