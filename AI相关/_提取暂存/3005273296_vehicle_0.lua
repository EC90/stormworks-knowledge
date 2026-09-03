-- source: steam id 3005273296 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3005273296
local w=720 --540 --multiples of 360
local wm=w/360
local h=144--96,144 
local ts=tostring
local ssc=screen.setColor
local ia=input.getNumber
local ib=input.getBool
local osn=output.setNumber
local drf=screen.drawRectF
local dr=screen.drawRect
local sdl=screen.drawLine
local txt=screen.drawText
local speed=0.03 --0.044167 (540) --0.066667 (360)
local function res()
	d,de,pause,mid,r1,r2,r3,r4,r5,r6,r7,r8,d1,d2,d3,d4,d5,d6,d7,d8,v_w,v_h,m_x,m_y,cnt,z,pass,px,e,last_r,sp,pps,init={},{},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,false
 	r=nil
	 max=w*h
end
res()

local function rnd(num)return math.floor(num+.5)end

function onTick()
	osn(4,max)osn(5,px)osn(6,e)osn(7,w)osn(8,h)local r_b=ib(1)zoom=ia(9)c_adj=255/zoom if r_b then res() end m_r,m_l,m_u,m_d=ib(2),ib(3),ib(4),ib(5)
	if m_r then if m_x+1<w then m_x=m_x+1 end end
	if m_l then if m_x-1>(-.5*w) then m_x=m_x-1 end end
	if m_u then if (v_h+m_y+1)<h then m_y=m_y+1 end end
	if m_d then if (m_y-1)>0 then m_y=m_y-1 end end
	osn(1,speed)
	osn(3,mid/wm)
	if pass==1 then
		e=0
		enhanceData()
		pass,px=0,0
	end
	if init then
		if max==0 then max=w*h end
		osn(2,(z/h)-.5)
		if pause==0 then
			d1,d2,d3,d4,d5,d6,d7,d8=ia(1),ia(3),ia(4),ia(5),ia(11),ia(12),ia(13),ia(14)
			total=rnd(ia(7)*w)
			lineskip=ia(8)
			if r==nil then r=ia(2*wm) sp=px end
			r1,rc=rnd(ia(2)*wm),rnd(ia(2)*wm)
			r7=rnd(r1-(w*.125)) r3=rnd(r1-(w*.25)) r5=rnd(r1-(w*.375)) r2=rnd(r1-(w*.5)) r8=rnd(r1-(w*.625)) r4=rnd(r1-(w*.75)) 			r6=rnd(r1-(w*.875))
			if r2<0 then r2=w+r2 end
			if r3<0 then r3=w+r3 end
			if r4<0 then r4=w+r4 end
			if r5<0 then r5=w+r5 end
			if r6<0 then r6=w+r6 end
			if r7<0 then r7=w+r7 end
			if r8<0 then r8=w+r8 end
			if d[z][r1]==0 then cnt=cnt+1 px=px+1 end d[z][r1]=d1
			if d[z][r2]==0 then cnt=cnt+1 px=px+1 end d[z][r2]=d2  
			if d[z][r3]==0 then cnt=cnt+1 px=px+1 end d[z][r3]=d3 
			if d[z][r4]==0 then cnt=cnt+1 px=px+1 end d[z][r4]=d4
			if d[z][r5]==0 then cnt=cnt+1 px=px+1 end d[z][r5]=d5 
			if d[z][r6]==0 then cnt=cnt+1 px=px+1 end d[z][r6]=d6 
			if d[z][r7]==0 then cnt=cnt+1 px=px+1 end d[z][r7]=d7 
			if d[z][r8]==0 then cnt=cnt+1 px=px+1 end d[z][r8]=d8 
			if rc>r+1 then r=nil pps=px-sp end
			if cnt>=total then cnt=0 z=z+1+lineskip pause=3 if z>=h then pass=pass+1 z=0+pass end end
		else
			pause=pause-1
		end
	end
end

function init_d2() de={} for i=-2,h+2 do de[i]={} for v=-2*w,2*w do de[i][v]=0 end end end
function init_d() for i=-2,h+2 do d[i]={} for v=-2*w,2*w do d[i][v]=0 end end end
function enhanceData() for a=0,h do for i=0,w do local v=d[a][i] if v~=0 then de[a][i]=d[a][i] end end end for a=0,h do for i=0,w do local ax,ac,out=0,0,0 local v=d[a][i] if v==0 then if d[a+1][i]~=0 then ax=ax+d[a+1][i] ac=ac+1 end if d[a-1][i]~=0 then ax=ax+d[a-1][i] ac=ac+1 end if ac>0 then out=ax/ac de[a][i]=out e=e+1 end end end end secondPass() init_d() end
function secondPass() for a=0,h do for i=0,w do local ax,ac,out=0,0,0 local v=de[a][i] if v==0 then if de[a][i-1]~=0 then ax=ax+de[a][i-1] ac=ac+1 end if de[a][i+1]~=0 then ax=ax+de[a][i+1] ac=ac+1 end if de[a+1][i]~=0 then ax=ax+de[a+1][i] ac=ac+1 end if de[a-1][i]~=0 then ax=ax+de[a-1][i] ac=ac+1 end if ac>0 then out=ax/ac de[a][i]=out e=e+1 end end end end end
function onDraw()if init==false then init=true v_w,v_h=screen.getWidth(),screen.getHeight()if w<v_w and w~=0 then v_w=w end if h<v_h and h~=0 then v_h=h end if w==0 then w=v_w h=v_h max=w*h end init_d()init_d2()end for a=0+m_y,v_h+m_y do mid=m_x+(v_w*.5) if mid>w then mid=mid-w end if mid<0 then mid = w+mid end for i=m_x,m_x+v_w do if i==w or i==0 then v=de[a][1]if v==0 then v=d[a][1]end end if i>w then v=de[a][i-w]if v==0 then v=d[a][i-w]end end if i<0 then v=de[a][i+w]if v==0 then v=d[a][i+w]end end if i>0 and i<w then v=de[a][i]if v==0 then v=d[a][i]end end  if v~=0 then ssc(0,v*c_adj,0)drf((i-m_x),(v_h-1)-a+m_y,1,1)end end end ssc(64,0,0)sdl(0, v_h-(z+2), v_w, v_h-(z+2))end