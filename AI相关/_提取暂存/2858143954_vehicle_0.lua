-- source: steam id 2858143954 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2858143954
pi2 = 2*math.pi
gps,trg,tt,pp,ss,cc,rr,dd = {},{},{},{},{},{},{},{}


function getN(...)
	local r={}
	for i,v in ipairs({...}) do r[i]=input.getNumber(v) or 0 end
	return table.unpack(r)
end

function worldToScreen(...) --x,y,z
	if gps.x == nil then return 0,0,0 end
	tt.x,tt.y,tt.z = ...

	a1 = tr/math.cos(pi2*tf)
	rr.y = pi2*(tu<0 and (1.5+a1)%1 or (1-a1)%1)
	rr.x = pi2*tf
	rr.z = pi2*cp

	for k,v in pairs(rr) do
		pp[k] = tt[k]-gps[k]
		cc[k] = math.cos(v)
		ss[k] = math.sin(v)
	end	
	a2=(cc.y*pp.z+ss.y*(ss.z*pp.y+cc.z*pp.x))
	a3=(cc.z*pp.y-ss.z*pp.x)
	dd.x = cc.y*(ss.z*pp.y+cc.z*pp.x)-ss.y*pp.z
	dd.y = ss.x*a2+cc.x*a3
	dd.z = cc.x*a2-ss.x*a3
	px = w/2+w*((d0/dd.y)*(dd.x/h0))
	py = h/2-h*((d0/dd.y)*(dd.z/h0))
	return px,py,dd.y
end

function onTick()
	trg.x1,trg.y1,trg.z1, trg.x2,trg.y2, trg.rx1,trg.ry1, trg.rx2,trg.ry2, trg.rx3,trg.ry3, trg.rx4,trg.ry4, gps.x,gps.y,gps.z, cp,tf,tu,tr, ha,da = getN(1,2,13, 3,4, 5,6, 7,8, 9,10, 11,12, 19,20,21, 22,23,24,25, 26,27)
	h0 = ha/4
	d0 = da/4
	d0 = d0+0.375
	output.setNumber(1, x1)
	output.setNumber(2, y1)
	output.setNumber(3, x2)
	output.setNumber(4, y2)
	output.setNumber(5, rx1)
	output.setNumber(6, ry1)
	output.setNumber(7, rx2)
	output.setNumber(8, ry2)
	output.setNumber(9, rx3)
	output.setNumber(10, ry3)
	output.setNumber(11, rx4)
	output.setNumber(12, ry4)
	output.setNumber(13, z1)
	output.setNumber(26, ha)
	output.setNumber(27, da)
end

function onDraw()
	screen.setColor(0, 0, 0,255)
	w = screen.getWidth()
	h = screen.getHeight()
	cx = w/2
	cy = h/2

	if (trg.x1~=0 or trg.y1~=0 or trg.z1~=0) then
		x1,y1,z1 = worldToScreen(trg.x1,trg.y1,trg.z1)		
		screen.setColor(0,200,0)
		x1,y1 = math.floor(x1+0.5),math.floor(y1+0.5)
	end
	if (trg.x2~=0 or trg.y2~=0 or trg.z1~=0) then
		x2,y2,z1 = worldToScreen(trg.x2,trg.y2,trg.z1)		
		screen.setColor(0,200,0)
		x2,y2 = math.floor(x2+0.5),math.floor(y2+0.5)
	end
	if (trg.rx1~=0 or trg.ry1~=0 or trg.z1~=0) then
		rx1,ry1,z1 = worldToScreen(trg.rx1,trg.ry1,trg.z1)		
		screen.setColor(0,200,0)
		rx1,ry1 = math.floor(rx1+0.5),math.floor(ry1+0.5)
	end
	if (trg.rx2~=0 or trg.ry2~=0 or trg.z1~=0) then
		rx2,ry2,z1 = worldToScreen(trg.rx2,trg.ry2,trg.z1)		
		screen.setColor(0,200,0)
		rx2,ry2 = math.floor(rx2+0.5),math.floor(ry2+0.5)
	end
	if (trg.rx3~=0 or trg.ry3~=0 or trg.z1~=0) then
		rx3,ry3,z1 = worldToScreen(trg.rx3,trg.ry3,trg.z1)		
		screen.setColor(0,200,0)
		rx3,ry3 = math.floor(rx3+0.5),math.floor(ry3+0.5)
	end
	if (trg.rx4~=0 or trg.ry4~=0 or trg.z1~=0) then
		rx4,ry4,z1 = worldToScreen(trg.rx4,trg.ry4,trg.z1)		
		screen.setColor(0,200,0)
		rx4,ry4 = math.floor(rx4+0.5),math.floor(ry4+0.5)
	end
end
