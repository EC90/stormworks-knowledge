-- source: steam id 3430170617 / vehicle.xml block#0
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

	return rx,ry,rz,lx,ly,lz
end

scl=pgn("Scale Method")
mw,mh=pgn("Width"),pgn("Height")

function Radar_to_Monitor(rx,ry,rz,w,h,zoom,size)
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

	local px=cx*(fdx*ry/rx)/asp*mpx
	local py=cy*(fdy*rz/rx)*mpy

	local mx=cx+px
	local my=cy-py
	local size=cx*size*(fdx/rx)/asp

	mx,my=flr(mx*100)/100,flr(my*100)/100
	size=flr(size*100)/100

	return mx,my,size
end

max_tgt=pgn("Max Target")
rect_size=pgn("Rectangle Size")
r,g,b,a=pgn("R"),pgn("G"),pgn("B"),pgn("A")

merg_dis=pgn("Merg Distance")
dsp_dis_mx=pgn("Target Display Distance (MAX)")
dsp_dis_mn=pgn("Target Display Distance (MIN)")

num_tag=pgb("Number Tag")
info_tp=pgn("Target Info(Top)")
info_bm=pgn("Target Info(Bottom)")
rdr_pos=pgn("Radar Position")

w,h=0,0
function onTick()
	tgts={}
	rects={}
	tgtn=0

	zoom=ign(32)
	camx,camy=ign(30),ign(31)

	for i=1,max_tgt do
	num=(i-1)*4
	dtc=igb(i)
	if dtc then
	tgtn=tgtn+1
	lx,ly,lz=ign(num+1),ign(num+2),ign(num+3)
	rdis=sqrt((lx^2)+(ly^2)+(lz^2))
	rspd=ign(num+4)

	if rdis<=dsp_dis_mx and rdis>=dsp_dis_mn then
	mcx,mcy,mcz,rx,ry,rz=Cam_Rotate(lx,ly,lz,camx,camy)
	table.insert(tgts,{mcx,mcy,mcz,rdis,rspd,#tgts+1})
	elseif dsp_dis_mx==0 and dsp_dis_mn==0 then
	mcx,mcy,mcz,rx,ry,rz=Cam_Rotate(lx,ly,lz,camx,camy)
	table.insert(tgts,{mcx,mcy,mcz,rdis,rspd,#tgts+1})
	end
	end
	end

	tgts=Merg_by_Dis(tgts,merg_dis)

	if #tgts>0 then
	for i=1,#tgts do
	tx,ty,tz=tgts[i][1],tgts[i][2],tgts[i][3]
	mx,my,size=Radar_to_Monitor(tx,ty,tz,w,h,zoom,rect_size)
	rects[i]={mx,my,size,size,tgts[i][4],tgts[i][5],tgts[i][6]}
	end

	for i=#tgts,tgtn+1,-1 do
	table.remove(tgts,i)
	table.remove(rects,i)
	table.remove(p_tgts,i)
	end
	end
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	draw_Custom_Rect(rects,w,h,r,g,b)
end

function Custom_Rect(x,y,w,h,tp,bm,lt,rt)
	local w=w/2
	local h=h/2

	draw_Cut_Line(x-w,y-h,x+w,y-h,tp)
	draw_Cut_Line(x-w,y+h,x+w,y+h,bm)
	draw_Cut_Line(x-w,y-h,x-w,y+h,lt)
	draw_Cut_Line(x+w,y-h,x+w,y+h,rt)
end

function draw_Custom_Rect(crds,w,h,r,g,b)
	crds=Sort_by_Active(crds,w,h)

	for i=1,#crds do
	local tp_crds={}
	local bm_crds={}
	local lf_crds={}
	local ri_crds={}

	local x,y=0,0
	local sx,sy=0,0
	local dis,spd=0,0

	local cx,cy=0,0
	local px,py=0,0
	local rx,ry=0,0

	local cxs,cys=0,0
	local pxs,pys=0,0
	local rxs,rys=0,0
	local sxs,sys=0,0

	x,y=crds[i][1],crds[i][2]
	sx,sy=crds[i][3],crds[i][4]
	dis,spd,num=crds[i][5],crds[i][6],crds[i][7]

	cx,cy=crds[i][1],crds[i][2]
	cxs,cys=crds[i][3],crds[i][4]
	for j=1,i-1 do
	--cx,cy=crds[i][1],crds[i][2]
	px,py=crds[j][1],crds[j][2]
	rx,ry=cx-px,cy-py

	--cxs,cys=crds[i][3],crds[i][4]
	pxs,pys=crds[j][3],crds[j][4]
	rxs,rys=abs(cxs+pxs)/2,abs(cys+pys)/2
	sxs,sys=(cxs-pxs)/2,(cys-pys)/2

	tr1,br1=(ry<=rys and ry>=sys),(ry>=-rys and ry<=-sys)
	tr2,br2=(ry<=rys and ry>=0),(ry>=-rys and ry<=0)
	lr1,rr1=(rx<=rxs and rx>=sxs),(rx>=-rxs and rx<=-sxs)
	lr2,rr2=(rx<=rxs and rx>=0),(rx>=-rxs and rx<=0)

	local tp=((tr1 and lr2) or (tr1 and rr2))
	local bm=((br1 and lr2) or (br1 and rr2))
	local lf=((lr1 and tr2) or (lr1 and br2))
	local ri=((rr1 and tr2) or (rr1 and br2))

	local x1,x2=((rxs-rx-pxs)>0 and (rxs-rx-pxs)) or 0,((rxs-rx)<cxs and rxs-rx) or cxs
	local y1,y2=((rys-ry-pys)>0 and (rys-ry-pys)) or 0,((rys-ry)<cys and rys-ry) or cys

	if tp then table.insert(tp_crds,{x1,x2}) end
	if bm then table.insert(bm_crds,{x1,x2}) end
	if lf then table.insert(lf_crds,{y1,y2}) end
	if ri then table.insert(ri_crds,{y1,y2}) end
	end

	if dis>1000 then
	dis=flr(dis/100)/10
	else
	dis=flr(dis)
	end

	spdm=tostring(flr(spd) .. "m/s")
	spdk=tostring(flr(spd*3.6) .. "k/h")

	ift=((info_tp==1 and dis) or (info_tp==2 and spdm) or (info_tp==3 and spdk)) or ""
	ifb=((info_bm==1 and dis) or (info_bm==2 and spdm) or (info_bm==3 and spdk)) or ""

	tlen=string.len(ift)
	blen=string.len(ifb)

	if crds[i][8] then
	screen.setColor(r,g,b)

	screen.drawText(x-tlen*2,y-sy/2-6,ift) --tp
	screen.drawText(x-blen*2,y+sy/2+3,ifb) --down
	else
	screen.setColor(r,g,b,a)
	end

	if num_tag and cxs>5 then
	screen.drawText(x-sy/2-5,y-sy/2,num)
	end

	Custom_Rect(x,y,sx,sy,tp_crds,bm_crds,lf_crds,ri_crds)
	end
end

function draw_Cut_Line(x1,y1,x2,y2,ct)
	local td=math.sqrt((x2-x1)^2+(y2-y1)^2)
	if td==0 then return end

	local mg=merg(ct)
	local ri={}
	local cst=0

	for i,c in ipairs(mg) do
	local cstt=c[1]
	local cend=c[2]

	if cstt>cst then
	table.insert(ri,{cst,math.min(cstt,td)})
	end

	cst=math.min(cend,td)
	if cst>=td then break end
	end

	if cst<td then
	table.insert(ri,{cst,td})
	end

	local dx,dy=(x2-x1)/td,(y2-y1)/td

	for _,iv in ipairs(ri) do
	local sd,ed=iv[1],iv[2]
	local sx,sy=x1+sd*dx,y1+sd*dy
	local ex,ey=x1+ed*dx,y1+ed*dy
	screen.drawLine(sx,sy,ex,ey)
	end
end

function Sort_by_Active(crds,w,h)
	for i=1,#crds do
	crds[i][8]=false
	end

	local in_Rects={}
	for i=1,#crds do
	local cx,cy=crds[i][1],crds[i][2]
	local cxs,cys=crds[i][3],crds[i][4]
	
	local dx=cx-w/2
	local dy=cy-h/2
	if (abs(dx)<cxs/2) and (abs(dy)<cys/2) then
	table.insert(in_Rects,i)
	end
	end

	if #in_Rects>0 then
	local new_atv=-1
	if atv_rect and crds[atv_rect] then
	for _,idx in ipairs(in_Rects) do
	if idx==atv_rect then
	new_atv=atv_rect
	break
	end
	end
	end

	if new_atv==-1 then
	new_atv=in_Rects[#in_Rects]
	end

	atv_rect=new_atv
	else	  
	if atv_rect and crds[atv_rect] then
	local cx,cy=crds[atv_rect][1],crds[atv_rect][2]
	local cxs,cys=crds[atv_rect][3],crds[atv_rect][4]

	local dx=cx-w/2
	local dy=cy-h/2
	if not ((abs(dx)<cxs/2) and (abs(dy)<cys/2)) then
	atv_rect=nil
	end
	end
	end

	if atv_rect and crds[atv_rect] then
	crds[atv_rect][8]=true
	local topShape=table.remove(crds,atv_rect)
	table.insert(crds,1,topShape)
	end

	return crds
end

function Merg_by_Dis(crds,dis)
	if #crds>1 then
	local merged={}
	local used={}

	for i=1,#crds do
	if not used[i] then

	table.insert(merged,crds[i])
	used[i]=true

	for j=i+1,#crds do
	if not used[j] then
	local dx=crds[j][1]-crds[i][1]
	local dy=crds[j][2]-crds[i][2]
	local dz=crds[j][3]-crds[i][3]
	if abs(dx)<dis and abs(dy)<dis and abs(dz)<dis then
	used[j]=true
	end
	end
	end
	end
	end

	return merged
	else
	return crds
	end
end

function merg(ct)
	if #ct<=1 then return ct end
	table.sort(ct,function(a,b) return a[1]<b[1] end)
	local mgd={}
	local cs=ct[1][1]
	local ce=ct[1][2]
	for i=2,#ct do
	local ns=ct[i][1]
	local ne=ct[i][2]
	if ns<=ce then 
	ce=math.max(ce,ne)
	else
	table.insert(mgd,{cs,ce})
	cs,ce=ns,ne
	end
	end
	table.insert(mgd,{cs,ce})
	return mgd
end