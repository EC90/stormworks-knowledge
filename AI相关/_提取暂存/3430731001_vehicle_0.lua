-- source: steam id 3430731001 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3430731001
--By SMITHY, Unscented Kalman Filter 2025 Visualiser
--SHORTHAND NOTATIONS
m=math
s,tau=screen,m.pi*2
IN,IB,ON,PN=input.getNumber,input.getBool,output.setNumber,property.getNumber



function mat_mult(A,B)
	local r = {}
	for i = 1,#A do
		r[i] = {}
		for j = 1,#B[1] do 
			r[i][j] = 0
			for k = 1,#B do
				r[i][j] = r[i][j] + A[i][k]*B[k][j]
			end
		end
	end
	return r
end
function mat_trans(A)
	local r = {}
	for i = 1, #A[1] do
		r[i] = {}
		for j = 1, #A do
			r[i][j] = A[j][i]
		end
	end
	return r
end
function mat_op(A, B, op)
	local r = {}
	for i = 1, #A do
		r[i] = {}
		for j = 1, #A[1] do
			if op == 0 then
				r[i][j] = A[i][j] + B[i][j]
			elseif op == 1 then
				r[i][j] = A[i][j] - B[i][j]

			else
				r[i][j] = A[i][j] * B

			end
		end
	end
	return r
end

use = PN("Physics Sensor Layout")

fovx=PN("fovx")*tau/2
fovy=PN("fovy")*tau/2

--INITIALISE UI
zoom = 0

function onTick()
	mpos={{IN(1)},{IN(2)-0.25},{IN(3)}}

	rx,ry,rz=IN(4),IN(5),IN(6)
	cx,cy,cz=m.cos(rx),m.cos(ry),m.cos(rz)
	sx,sy,sz=m.sin(rx),m.sin(ry),m.sin(rz)
	O = { --Rotation Matrix
	{cy*cz,cy*sz,-sy},
	{-cx*sz+sx*sy*cz,cx*cz+sx*sy*sz,sx*cy},
	{sx*sz+cx*sy*cz,-sx*cz+cx*sy*sz,cx*cy}
	}

	roll_offset = {
	{0,-1,0},
	{1,0,0},
	{0,0,1}
	}

	radar = {}
	for i = 1,4 do
	
		if use == 1 then
			radar[i] = {IN(i*3+12),IN(i*3+13)*tau,IN(i*3+14)*tau}

		else
			radar[i] = {IN(i*3+12),-IN(i*3+14)*tau,IN(i*3+13)*tau}

		end
	end

	zoom = m.min(m.max(0,zoom+IN(13)/70),1)
	ON(1,zoom)
	fov = m.tan((zoom*(0.025-2.2)+2.2)/2)

	X = {}
	for i = 1,6 do
		X[i] = {IN(i+6)}

	end
	if X[2][1] == -100 or X[2][1] == 0 then
		X = nil

	end

	if X~=nil then
		if use~=1 then
			O = mat_mult(roll_offset,O)

		end

		tgt_local = mat_mult(O,mat_op({{X[1][1]},{X[2][1]},{X[3][1]}},mpos,1))
		ON(2,m.atan(tgt_local[1][1],tgt_local[3][1])) --local azimuth angle
		ON(3,m.atan(tgt_local[2][1],m.sqrt(tgt_local[3][1]^2+tgt_local[1][1]^2))) --local elevation angle

	else
		ON(2,0)
		ON(3,0)

	end

	auto = IN(14)
end

function drawCircle(x, y, r, split)
	local step = 2*m.pi/24
	for i = 0,24 do
		if i%2 == 0 or not split then
			local i = step*i
			local step = step/2
			s.drawLine(x+math.cos(i-step)*r,y+math.sin(i-step)*r,x+math.cos(i+step)*r,y+math.sin(i+step)*r)

		end
	end
end

function onDraw()
	w,h = s.getWidth(),s.getHeight()

if X ~= nil then
if tgt_local[3][1]>0 then
	s.setColor(255,255,255)
	local x,y = w/2+h*(tgt_local[1][1]/tgt_local[3][1]/fov)/2,h/2-h*(tgt_local[2][1]/tgt_local[3][1]/fov)/2
	local gain = m.min((0.4+(0.4-0.01)*180/m.sqrt(tgt_local[1][1]^2+tgt_local[2][1]^2+tgt_local[3][1]^2))/28,1)
	drawCircle(x,y,h*(m.max(gain/fov,0.1))/2,true)


	s.setColor(120,120,120)
	local frame = mat_mult(O,mat_op({{X[1][1]+X[4][1]/2},{X[2][1]+X[5][1]/2},{X[3][1]+X[6][1]/2}},mpos,1))
	s.drawLine(w/2+h*(frame[1][1]/frame[3][1]/fov)/2,h/2-h*(frame[2][1]/frame[3][1]/fov)/2,x,y)

end
end


s.setColor(255,255,255)
local x = h*(m.tan(fovx)/fov)/2
local y = h*(m.tan(fovy)/fov)/2

s.drawRectF(w/2-x,h/2-y,1,1)--it's ugly and I don't care
s.drawRectF(w/2+x,h/2-y,1,1)
s.drawRectF(w/2+x,h/2+y,1,1)
s.drawRectF(w/2-x,h/2+y,1,1)

if auto==1 then
	s.drawText(15,15,"A")

end
s.setColor(255,0,0)

for i = 1,4 do
	if radar[i][1]>0 then
		s.drawRectF(w/2+h*(m.tan(radar[i][2])/fov)/2-1,h/2-h*(m.tan(radar[i][3])/fov)/2-1,2,2)

	end
end

end