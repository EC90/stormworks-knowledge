-- source: steam id 2851230589 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2851230589
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pN=property.getNumber
pB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
sqrt=M.sqrt
asin=M.asin
atan=M.atan
pi=M.pi
pi2=M.pi*2

type=pN('Weapon Type')//1|0
params={
	{800, 0.025, 120, 0.025*0.1,  0},
	{1000,0.02,  150, 0.02*0.1,   0},
	{1000,0.01,  300, 0.01*0.1,   0},
	{900, 0.005, 600, 0.005*0.1,  0},
	{800, 0.002, 1500,0.002*0.5,  0},
	{700, 0.001, 2400,0.001*0.75, 0},
	{600, 0.0005,2400,0.0005*0.75,0},
	{50,  0.005, 2400,0.005*0.75, 600},
	{100000,  0, 2400,0, 0},
}

type=type<1 and 1 or type>#params and #params or type
vel=params[type][1]
drag=params[type][2]*60
winddrag=params[type][4]*60
lifeSpan=params[type][3]
power=params[type][5]
g=30
error=0.1

tha=0
time=0

phy_buf = 0
turn = 0
n = 1
phyc = 0
thac = 0

dcbuf = {0,0.25*pi2}

sucess = false
test = 0
function onTick()
gx=GN(1)
gy=GN(2)
gz=GN(3)+1
spx=GN(4)
spy=GN(5)
spz=GN(6)
sx=GN(7)
sy=GN(8)
sz=GN(9)
phyb=GN(10)*pi2
thab=GN(11)*pi2
alfb=GN(12)*pi2
windd=GN(15)*pi2
winds=-GN(16)
sp=sin(phyb)
cp=cos(phyb)
st=sin(-thab)
ct=cos(-thab)
sa=sin(-alfb)
ca=cos(-alfb)
sw=sin(windd)
cw=cos(windd)
if sw <0.00001 then sw=0.00001 end
xr=winds*sw
yr=winds*cw
xww = ( xr*cp*ct + yr*(cp*st*sa-sp*ca) )
yww = ( xr*sp*ct + yr*(sp*st*sa+cp*ca) )
zww = ( xr*(-st) + yr*(ct*sa) )
winds=winds^2/sqrt(xww^2+yww^2)
xw=xww/sqrt(xww^2+yww^2)*winds
yw=yww/sqrt(xww^2+yww^2)*winds
local x,y,z=0,0,0
if gx==0 and gy==0 and gz==0 then
	x=10
	y=0
	z=0
else
	x=(gx-sx)
	y=(gy-sy)
	z=gz-sz
end
if abs(x)<0.01 then
	x=10
	y=0.001
	z=1
end
sucess = false
if GB(1) then
	x1,y1,z1,time,sucess=calc(x,y,z,xw,yw,spx,spy,spz)
	if sucess then
		x=x1
		y=y1
		z=z1
	end
end
zt=( z*ca*ct + x*(ca*st*sp+sa*cp) + y*(-ca*st*cp+sa*sp) )
yt=( z*(-sa*ct) + x*(-sa*st*sp+ca*cp) + y*(sa*st*cp+ca*sp) )
xt=( z*(st) + x*(-ct*sp) + y*(ct*cp) )
if yt>0 and xt<0 then
	phy = math.atan(yt/xt)+math.pi
else if yt<0 and xt<0 then
	phy = math.atan(yt/xt)-math.pi
	else
		phy = math.atan(yt/xt)
	end
end
tha = math.acos(zt/math.sqrt(xt^2+yt^2+zt^2))
phy=phy/pi2
thaout = tha/pi2-0.25

if not GB(2) then
phy=GN(20)
thaout=-GN(21)
end
if phy~=phy or phy==math.huge or phy==-math.huge or phy==nil then
	phy=phy_buf
end
if tha~=tha or tha==math.huge or tha==-math.huge or tha==nil then
	tha=0
end
phy_buf=phy
SN(1, phy)
SN(2, thaout)
SN(3, GN(13))
SN(4, GN(14))
SN(5, xw)
SN(6, yw)
SB(1, not GB(1))
SB(2, not GB(1))
SB(32,sucess and GB(1))
end

function calc(x,y,z,wx,wy,spx,spy,spz)
local w,h,dis0=sqrt(x^2+y^2+z^2),z,sqrt(x^2+y^2)
local elv=atan(z/w)
if w==0 then
	elv=pi/2
	w=0.1
end
local wr=(wx*x+wy*y)/dis0
local a,t,wbuf,xl,yl,zl,tbuf,int=elv,0,0,x,y,z,0,{0,0,0,sqrt(spx^2+spy^2+spz^2)/50+1.2}
for i=1,20 do
local v={}
table.insert(v,{x=vel*xl/w,y=vel*yl/w,z=vel*zl/w})
xc,yc,zc,t,life=getcalc(v,dis0,wx,wy)
if not life then
	return x,y,z,t,false
end
tgt={x+(t+24)*spx,y+(t+24)*spy,h+(t+24)*spz}
err={xc-tgt[1],yc-tgt[2],zc-tgt[3]}
int[1]=int[1]+err[1]
int[2]=int[2]+err[2]
int[3]=int[3]+err[3]
zl=tgt[3]-int[3]*int[4]
xl=tgt[1]-int[1]*int[4]
yl=tgt[2]-int[2]*int[4]
if sqrt(err[1]^2+err[2]^2+err[3]^2)<0.1 then
	return xl,yl,zl,t,true
end
dis0=sqrt(tgt[1]^2+tgt[2]^2)
w=sqrt(xl^2+yl^2+zl^2)
wbuf=xl+yl+zl
tbuf=t
end
return x,y,z,t,false
end

function getcalc(v,dis0,wx,wy)
	local s,a,dis,aa={},{},0,0
	table.insert(s, {x=0,y=0,z=0})
	for t=1,lifeSpan do
		local speed=sqrt((v[t].x-wx)^2+(v[t].y-wy)^2+v[t].z^2)
		if t>70 then eng=0 else eng=1 end
		table.insert(a,{x=-drag*(v[t].x+wx)+eng*power/speed*(v[t].x-wx),y=-drag*(v[t].y+wy)+eng*power/speed*(v[t].y-wy),z=-drag*v[t].z+eng*power/speed*v[t].z-g})
		table.insert(v,{x=v[t].x+a[t].x/60,y=v[t].y+a[t].y/60,z=v[t].z+a[t].z/60})
		table.insert(s,{x=s[t].x+v[t].x/60,y=s[t].y+v[t].y/60,z=s[t].z+v[t].z/60})
		dis=sqrt(s[t+1].x^2+s[t+1].y^2)
		if dis>=dis0 then
			pe=(dis0-sqrt(s[t].x^2+s[t].y^2))/(dis-sqrt(s[t].x^2+s[t].y^2))
			aa=pe+t
			s[t+1].x=s[t].x+v[t].x*pe/60
			s[t+1].y=s[t].y+v[t].y*pe/60
			s[t+1].z=s[t].z+v[t].z*pe/60
			return s[t+1].x,s[t+1].y,s[t+1].z,aa,true
		end
		aa=t
	end
	return x,y,z,aa,false
end