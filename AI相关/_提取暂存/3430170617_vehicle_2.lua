-- source: steam id 3430170617 / vehicle.xml block#2
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

function clamp(num,min,max)
    return max<num and max or min>num and min or num
end

function FOV(min,max,zoom,w,h)
	maxx=max+((w/h)-1)*7.5
	local fovx=rad(min+(maxx-min)*(1-zoom))
	local fovy=rad(min+(max-min)*(1-zoom))
	return fovx,fovy
end

function get_local(dis,ax,ay,osx,osy,osz)
	local lx=dis*cos(ay)*cos(ax)+osx*0.25
	local ly=dis*cos(ay)*sin(ax)+osy*0.25
	local lz=dis*cos(ax)*sin(ay)+osz*0.25
	lx,ly,lz=flr(lx*100)/100,flr(ly*100)/100,flr(lz*100)/100

	local rx,ry,rz=Cam_Rotate(lx,ly,lz,camx,camy)
	rx,ry,rz=flr(rx*100)/100,flr(ry*100)/100,flr(rz*100)/100

	return rx,ry,rz
end

function Cam_Rotate(lx,ly,lz,cmx,cmy)
	local v=Cam_Vector(cmx,cmy)

	if rdr_pos==3 or rdr_pos==4 then
	ly,lz=lz,ly
	end

	local rx=lx*v[1][1]+ly*v[1][2]+lz*v[1][3]
	local ry=lx*v[2][1]+ly*v[2][2]+lz*v[2][3]
	local rz=lx*v[3][1]+ly*v[3][2]+lz*v[3][3]
	rx=clamp(rx,1,rx)

	rx,ry,rz=flr(rx*100)/100,flr(ry*100)/100,flr(rz*100)/100

	return rx,ry,rz
end

function Cam_Vector(camx,camy)
	cmx,cmy=camx*pi/4,camy*pi/4
	local v={}
	local cx,cy=flr(cos(cmx)*1000)/1000,flr(cos(cmy)*1000)/1000
	local sx,sy=flr(sin(cmx)*1000)/1000,flr(sin(cmy)*1000)/1000

	v={
	{cy*cx,cy*sx,sy},
	{-sx,cx,0},
	{-sy*cx,-sy*sx,cy}}
	return v
end

scl=pgn("Scale Method")
mw,mh=pgn("Width"),pgn("Height")

function to_monitor(rx,ry,rz,w,h,zoom)
	if scl==0 then aw,ah=w,h bw,bh=w,h mpx,mpy=1,1 end
	if scl==1 then
	if (mw/w)>(mh/h) then
	aw,ah=mw,mh bw,bh=1,1 mpx,mpy=(mw/mh)/(w/h),1
	else
	aw,ah=mw,mh bw,bh=mw,mh mpx,mpy=1,(mh/mw)/(h/w)
	end
	end
	if scl==2 then aw,ah=w,h bw,bh=1,1 mpx,mpy=mw,mh end

	local cx,cy=w/2,h/2
	local asp=aw/ah
	local fovx,fovy=FOV(1.43,125,zoom,bw,bh)
	local fdx=1/tan(fovx/2)
	local fdy=1/tan(fovy/2)

	local px=cx+cx*(fdx*ry/rx)/asp*mpx
	local py=cy-cy*(fdy*rz/rx)*mpy
	return px,py
end

function draw_radar_FOV(dis,rfx,rfy,w,h,zoom,osx,osy,osz)
	rfx,rfy=rfx*pi,rfy*pi
	osx=(osx or 0)*0.25
	osy=(osy or 0)*0.25
	osz=(osz or 0)*0.25

	local rx1,ry1,rz1=get_local(dis,-rfx,rfy,osx,osy,osz) --top left
	local rx2,ry2,rz2=get_local(dis,rfx,rfy,osx,osy,osz) --top right
	local rx3,ry3,rz3=get_local(dis,-rfx,-rfy,osx,osy,osz) --bottom left
	local rx4,ry4,rz4=get_local(dis,rfx,-rfy,osx,osy,osz) --bottom right

	local px1,py1=to_monitor(rx1,ry1,rz1,w,h,zoom)
	local px2,py2=to_monitor(rx2,ry2,rz2,w,h,zoom)
	local px3,py3=to_monitor(rx3,ry3,rz3,w,h,zoom)
	local px4,py4=to_monitor(rx4,ry4,rz4,w,h,zoom)

	screen.drawLine(px1,py1,px2,py2) --top
	screen.drawLine(px3,py3,px4,py4) --bottom
	screen.drawLine(px1,py1,px3,py3) --left
	screen.drawLine(px2,py2,px4,py4) --right
end

function draw_center(dis,w,h,zoom,osx,osy,osz)
	osx=(osx or 0)*0.25
	osy=(osy or 0)*0.25
	osz=(osz or 0)*0.25
	local cx,cy=w/2,h/2

	local rx,ry,rz=get_local(dis,0,0,osx,osy,osz) --center
	local px,py=to_monitor(rx,ry,rz,w,h,zoom)

	px,py=flr(px),flr(py)

	if ctr_bdy==1 then
	screen.drawLine(px-0.5,py-0.5,px+0.5,py+0.5)
	end

	if ctr_bdy==2 then
	screen.drawLine(px,py-2.25,px,py-5.25) --top
	screen.drawLine(px,py+2.25,px,py+5.25) --bottom
	screen.drawLine(px-2.25,py,px-5.25,py) --left
	screen.drawLine(px+2.25,py,px+5.25,py) --right
	end
end

r,g,b,a=pgn("R"),pgn("G"),pgn("B"),pgn("A")
osx,osy,osz=pgn("Offset X (block)"),pgn("Offset Y (block)"),pgn("Offset Z (block)")

rdr_fov=pgb("Draw Radar FOV")
rdr_fovx,rdr_fovy=clamp(pgn("FOV X"),0.01,0.25),clamp(pgn("FOV Y"),0.01,0.25)
eff_rng=pgn("Effective Range")

ctr_bdy=pgn("Draw Center (Body)")
ctr_cam=pgn("Draw Center (Cam)")
rdr_pos=pgn("Radar Position")

w,h=0,0
--camv={}
function onTick()
	zoom=ign(32)
	camx,camy=ign(30),ign(31)
	--camv=cam_Vector(camx,camy)
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	
	local cx=w/2
	local cy=h/2

	if rdr_fov then
	screen.setColor(r,g,b)
	draw_radar_FOV(eff_rng,rdr_fovx,rdr_fovy,w,h,zoom,osx,osy,osz)
	end

	if ctr_bdy<3 then
	screen.setColor(r,g,b)
	draw_center(eff_rng,w,h,zoom,osx,osy,osz)
	end

	if ctr_cam==1 then
	screen.setColor(r,g,b)
	screen.drawLine(cx,cy,cx+0.5,cy+0.5)
	end

	if ctr_cam==2 then
	screen.setColor(r,g,b)
	screen.drawLine(cx,cy-2.25,cx,cy-5.25) --top
	screen.drawLine(cx,cy+2.25,cx,cy+5.25) --bottom
	screen.drawLine(cx-2.25,cy,cx-5.25,cy) --left
	screen.drawLine(cx+2.25,cy,cx+5.25,cy) --right
	end
end