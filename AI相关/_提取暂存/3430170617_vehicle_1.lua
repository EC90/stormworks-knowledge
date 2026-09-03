-- source: steam id 3430170617 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3430170617
I=input
O=output
P=property
ign=I.getNumber
igb=I.getBool
osn=O.setNumber
osb=O.setBool
pgn=P.getNumber
pgb=P.getBool

M=math
pi=M.pi
pi2=pi*2
rad=M.rad
deg=M.deg
cos=M.cos
sin=M.sin
tan=M.tan
acos=M.acos
asin=M.asin
atan=M.atan

flr=M.floor
abs=M.abs
sqrt=M.sqrt

rdr_pos=pgn("Radar Position")
max_tgt=pgn("Max Target")

filters={}

for i=1,max_tgt do
	filters[i]={
	ax={x=0,v=0,
	P={10,0,0,10},
	Q={100,0,0,100},
	R=25000},

	ay={x=0,v=0,
	P={10,0,0,10},
	Q={100,0,0,100},
	R=25000},

	az={x=0,v=0,
	P={10,0,0,10},
	Q={100,0,0,100},
	R=25000}}
end

function predict(filter,dt)
	local x_pred=filter.x+filter.v*dt
	local v_pred=filter.v
	local P11=filter.P[1]+filter.P[2]*dt+filter.P[3]*dt+filter.P[4]*dt*dt+filter.Q[1]
	local P12=filter.P[2]+filter.P[4]*dt
	local P21=filter.P[3]+filter.P[4]*dt
	local P22=filter.P[4]+filter.Q[4]
	filter.x=x_pred
	filter.v=v_pred
	filter.P={P11,P12,P21,P22}
end

function update(filter,z)
	local H={1,0}
	local S=H[1]*filter.P[1]+H[2]*filter.P[3]+filter.R
	local K1=(filter.P[1]*H[1]+filter.P[2]*H[2])/S
	local K2=(filter.P[3]*H[1]+filter.P[4]*H[2])/S
	local y=z-(H[1]*filter.x+H[2]*filter.v)
	filter.x=filter.x+K1*y
	filter.v=filter.v+K2*y
	local I11=1-K1*H[1]
	local I12=-K1*H[2]
	local I21=-K2*H[1]
	local I22=1-K2*H[2]
	local P11_new=I11*filter.P[1]+I12*filter.P[3]
	local P12_new=I11*filter.P[2]+I12*filter.P[4]
	local P21_new=I21*filter.P[1]+I22*filter.P[3]
	local P22_new=I21*filter.P[2]+I22*filter.P[4]
	filter.P={P11_new,P12_new,P21_new,P22_new}
end

function get_local(dis,az,el,osx,osy,osz)
	local az,el=az*pi2,el*pi2
	local x=dis*cos(el)*cos(az)+osx*0.25
	local y=dis*cos(el)*sin(az)+osz*0.25
	local z=dis*sin(el)+osy*0.25
	x,y,z=flr(x*100)/100,flr(y*100)/100,flr(z*100)/100

	return x,y,z
end

function rotate(lx,ly,lz,ex,ey,ez)
	local cx,cy,cz=flr(cos(ex)*1000)/1000,flr(cos(ey)*1000)/1000,flr(cos(ez)*1000)/1000
	local sx,sy,sz=flr(sin(ex)*1000)/1000,flr(sin(ey)*1000)/1000,flr(sin(ez)*1000)/1000

	local m={
	{sz*sx+cz*cx*sy, cz*cy,cz*sx*sy-cx*sz},
	{cx*cy,-sy,cy*sx},
	{-cz*sx+cx*sz*sy, cy*sz,cz*cx+sx*sy*sz}
	}

	if rdr_pos==3 or rdr_pos==4 then
	ly,lz=lz,ly
	end

	local rx=lx*m[1][1]+ly*m[1][2]+lz*m[1][3]
	local ry=lx*m[2][1]+ly*m[2][2]+lz*m[2][3]
	local rz=lx*m[3][1]+ly*m[3][2]+lz*m[3][3]

	return rx,ry,rz
end

p_gps={}
osx,osy,osz=pgn("Offset X (block)"),pgn("Offset Y (block)"),pgn("Offset Z (block)")
function onTick()
	local dt=1/1000
	local data={}
	tgtn=0

	px,py,pz=ign(25),ign(27),ign(26) --position
	ex,ey,ez=ign(28),ign(29),ign(30) --euler
	for i=1,max_tgt do
	numi=(i-1)*3
	numo=(i-1)*4
	tgtn=tgtn+1

	dis,az,el=ign(numi+1),ign(numi+2),ign(numi+3)

	if rdr_pos==1 or rdr_pos==3 then
	az=az
	el=el
	end
	if rdr_pos==2 or rdr_pos==4 then
	az=az
	el=-el
	end

	lx,ly,lz=get_local(dis,az,el,osx,osy,osz)

	data[i]={
	ax=lx,
	ay=ly,
	az=lz}

	local out={}

	out[i]={ax=0,ay=0,az=0}

	local fx=filters[i].ax
	predict(fx,dt)
	update(fx,data[i].ax)
	out[i].ax=fx.x

	local fy=filters[i].ay
	predict(fy,dt)
	update(fy,data[i].ay)
	out[i].ay=fy.x

	local fz=filters[i].az
	predict(fz,dt)
	update(fz,data[i].az)
	out[i].az=fz.x

	rx,ry,rz=rotate(fx.x,fy.x,fz.x,ex,ey,ez)
	gx,gy,gz=px+rx,py+ry,pz+rz

	gx,gy,gz=flr(gx*100)/100,flr(gy*100)/100,flr(gz*100)/100

	if p_gps[i] then
	dx=gx-p_gps[i][1]
	dy=gy-p_gps[i][2]
	dz=gz-p_gps[i][3]
	dspd=sqrt(dx^2+dy^2+dz^2)/(1/60)
	end

	osn(numo+1,out[i].ax)
	osn(numo+2,out[i].ay)
	osn(numo+3,out[i].az)
	osn(numo+4,dspd)
	osb(i,igb(i))

	p_gps[i]={gx,gy,gz}
	end

	for i=#p_gps,tgtn+1,-1 do
	table.remove(p_gps,i)
	end
end