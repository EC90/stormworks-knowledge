-- source: steam id 1969765716 / vehicle.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
h0 = 1/4 --hud size in meters
d0 = 1/4 --#distance from tip of pilot seat to hud
d0 = d0+0.375
pi2 = 2*math.pi
gps,trg,tt,pp,ss,cc,rr,dd,FP = {},{},{},{},{},{},{},{},{}
PTT = 0

function clamp(a,b,c) return math.min(math.max(a,b),c) end

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
	PTT,gps.x,gps.y,gps.z, trg.x,trg.y,trg.z, cp,tf,tu,tr = getN(10,11,12,13, 14,15,16, 17,18,19,20)
	tr = -tr
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	cx = w/2
	cy = h/2

	if (trg.x~=0 or trg.y~=0 or trg.z~=0) then
					
		x,y,z = worldToScreen(trg.x,trg.y,trg.z)
		if PTT == 0 then
			screen.setColor(255,0,0,255)
		elseif PTT == 1 then
			screen.setColor(255,255,0,255)
		elseif PTT == 2 then
			screen.setColor(0,255,0,255)
		end
		
		x,y = math.floor(x+0.5),math.floor(y+0.5)

		if z>0 and x>0 and x<w and y>0 and y<h then
			s = clamp((d0/z)*500,3,250)
			if PTT == 0 then
				screen.drawLine(x-1,y-1,x-s,y-s)
				screen.drawLine(x-1,y+1,x-s,y+s)
				screen.drawLine(x+1,y-1,x+s,y-s)
				screen.drawLine(x+1,y+1,x+s,y+s)

				screen.drawLine(x,y-2-s*2,x-s,y-2-s)
				screen.drawLine(x,y-2-s*2,x+s,y-2-s)
				screen.drawLine(x,y-5-s*2,x-s,y-5-s)
				screen.drawLine(x,y-5-s*2,x+s,y-5-s)
			elseif PTT == 1 then
				screen.drawCircle(x, y, s)
				screen.drawLine(x,y-s-2,x-s,y-s*2-2)
				screen.drawLine(x,y-s-2,x+s,y-s*2-2)
				screen.drawLine(x,y-s-5,x-s,y-s*2-5)
				screen.drawLine(x,y-s-5,x+s,y-s*2-5)
			elseif PTT == 2 then
				screen.drawLine(x-1,y,x-s,y)
				screen.drawLine(x+1,y,x+s,y)
				screen.drawLine(x,y+1,x,y+s)
				screen.drawLine(x,y-1,x,y-s)
				screen.drawLine(x-1,y-s,x-s-1,y)
				screen.drawLine(x-1,y+s,x-s-1,y)
				screen.drawLine(x+1,y-s,x+s+1,y)
				screen.drawLine(x+1,y+s,x+s+1,y)
			end
			
		else
			if z<0 then
				x=cx-x
				y=cy-y
			end
			tx = clamp(x,0,w)
			ty = clamp(y,0,h)
			r = math.atan(x-cx,y-cy)
			r1 = r+pi2/12
			r2 = r-pi2/12
			screen.drawTriangleF(tx,ty, tx-8*math.sin(r1), ty-8*math.cos(r1), tx-8*math.sin(r2), ty-8*math.cos(r2))
		end
	end
end