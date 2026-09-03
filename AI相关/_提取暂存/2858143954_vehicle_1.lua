-- source: steam id 2858143954 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2858143954
pi2 = 2*math.pi

function clamp(a,b,c) return math.min(math.max(a,b),c) end

function getN(...)
	local r={}
	for i,v in ipairs({...}) do r[i]=input.getNumber(v) or 0 end
	return table.unpack(r)
end

function onTick()
	x1,y1,z1, x2,y2, rx1,ry1,rx2,ry2,rx3,ry3,rx4,ry4, ha,da = getN(1,2,13, 3,4, 5,6,7,8,9,10,11,12, 26,27)
	h0 = ha/4
	d0 = da/4
	d0 = d0+0.375
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	cx = w/2
	cy = h/2
	if y1>5 then
		screen.setColor(255, 0, 0)
		screen.drawLine(rx3,ry3,rx4,ry4)
		screen.setColor(255, 250, 0)		
		screen.drawLine(rx1,ry1,rx3,ry3)
		screen.drawLine(rx2,ry2,rx4,ry4)
		screen.setColor(0, 255, 0)	
		screen.drawLine(x1,y1,x2,y2)
		screen.drawLine(rx1,ry1,rx2,ry2)
		else
		screen.setColor(255, 0, 0)
		screen.drawLine(rx3,ry3,rx4,ry4)	
		screen.setColor(255, 250, 0)
		screen.drawLine(rx2,h,rx3,ry3)
		screen.drawLine(rx1,h,rx4,ry4)
		screen.setColor(0, 255, 0)	
		screen.drawLine(w-x1,h,x2,y2)	
	end
		
	if x1<5 or x1>w-5 and y1>0 then
		tx = clamp(x1,0,w)
		ty = clamp(y1,0,h)
		r = math.atan(x1-cx,y1-cy)
		r1 = r+pi2/12
		r2 = r-pi2/12
		screen.setColor(0, 255, 0)
		screen.drawTriangle(tx,ty, tx-8*math.sin(r1), ty-8*math.cos(r1), tx-8*math.sin(r2), ty-8*math.cos(r2))
	end

end
