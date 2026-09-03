-- source: steam id 2403178838 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2403178838
gN = input.getNumber
gB = input.getBool
sC = screen.setColor
oN = output.setNumber
gT = property.getText
m = math
fl = m.floor
ab = m.abs
ce = m.ceil
de = m.deg
at = m.atan
t  = m.tan
si = m.sin
co = m.cos
ac = m.acos
as = m.asin
rF = gT("Rader FOV")

sG = {}
GP = {}
Re = {}
a = 360
b = 0
i = 0
pi = 3.14159265359
pi2 = 6.28531412565026

function touch(x, y, rectX, rectY, rectW, rectH)
return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function sgn(x)
  return x<0 and -1 or x>0 and 1 or 0
end

function all(x1,y1,z1,x2,y2,z2)
return {["p"] = de(at((z1-z2)/m.sqrt(ab(x1-x2)^2+ab(y1-y2)^2)))*1,["a"] = de(at((y1-y2)/(x1-x2)))+90*sgn(x2-x1),["s"] = m.sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2)} end

function com(c,x)
	return c + x > 0.5 and -1 + c + x or c + x < -0.5 and 1 + c + x or c + x
end

function pic(p,x)
	local n = p + x
	return n > 0.25 and 0.5-n or -0.25 > n and -0.5+n or n end
function CGPS(c,l,p,x,y,z)
	local lpa = co((p+1)*pi2)*l
return {["x"] = x-(si(-c*pi2)*lpa),["y"] = (co(-c*pi2)*lpa)+y,["z"] = z-(si((p+1)*pi2)*l),["l"] = l}end

function surface(sc,sp,st,sr)
	local vf = sr*pi2
	if st > 0 then
		Re = {sc*si(vf)+sp*co(vf),-sc*co(vf)+sp*si(vf)}
	else
		Re = {sc*si(vf)-sp*co(vf),sc*co(vf)+sp*si(vf)}
	end
	return Re
end

function setting(ic,l,ip,ir,it,x,y,z,GP,rp,rc,ne)
	if rc > 0 then
		gc,gl,gp = gT("c(up)"),gT("l(up)"),gT("p(up)")
	elseif rc < 0 then
		gc,gl,gp = gT("c(down)"),gT("l(down)"),gT("p(down)")
	else
		gc,gl,gp = 0,0,0
	end
	if rc ~= nil then
		surface(gc,gp,it,ir)
		local c = com(-Re[2],ic)
		local p = pic(Re[1],-ip)
		sG = CGPS(c,gl,p,x,y,z)
		surface(rc,rp,it,ir)
		local c = com(-Re[2],ic)
		local p = pic(Re[1],-ip)
		if ne ~= nil then
			GP[ne] = CGPS(c,l,p,sG["x"],sG["y"],sG["z"])
		end
	end
	return GP
end

function onTick()
	t1,t2 = gB(10),gB(11)
	th,tx,ty = gB(1),gN(3),gN(4)
	p1,p2,s1,s2,l1,l2,ic = -gN(10),gN(11),gN(12),gN(13),gN(14),gN(15),-gN(16)
	iz,ix,iy,ip,ir,it = gN(18),gN(19),gN(20),gN(21),gN(22),gN(23)
	max,min,ia = gN(24),gN(25),gN(26)
	Cr = m.asin(si(ir*pi2)/si((0.5-ip*2)*pi))/pi2
	hf = fl(gN(17)+0.5)
	hs = fl(-gN(17)+0.5)
	setting(ic,l1,ip,Cr,it,ix,iy,iz,GP,p1,hf/100000,hf)
	setting(ic,l2,ip,Cr,it,ix,iy,iz,GP,p2,hs/100000,hs)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	i,s,GPz,check = 1,1,{},{}
	for x = -max,max,1250 do
		if GP[x] ~= nil and GP[x]["l"] ~= 0 then
			if check[x] == n then
				check[x] = 1
				GPz[s] = GP[x]
				for y = -max,max,1250 do
					if GP[y] ~= nil and GP[x]["l"] ~= 0 and check[y] == nil then
						GPx = GPz[s]
						GPy = GP[y]
						di = ab(GPx["x"]-GPy["x"]) + ab(GPx["y"]-GPy["y"]) + ab(GPx["z"]-GPy["z"])
						if di < 2*GPx["l"]*m.tan(rF*4)+gT("error") then
							check[y] = 1
							GPx = {
							["x"] = (GPx["x"]+GPy["x"])/2,
							["y"] = (GPx["y"]+GPy["y"])/2,
							["z"] = (GPx["z"]+GPy["z"])/2,
							["l"] = (GPx["l"]+GPy["l"])/1.5
							}
							GPz[s] = GPx
							i = i + 1
						end
					end
				end
				v = GPz[s]
				view = all(v["x"],v["y"],v["z"],ix,iy,iz)
				vx = com(-view["a"]/a,-ic)
				vy = view["p"]/a-ip
				surface(vy,vx,it,-Cr)
				ra = gT("ratio")
				screen.drawRect(fl((w/2-2)+Re[1]*a*ra+0.5),fl((h/2-2)+Re[2]*a*ra+0.5),4,4)
				s = s + 1
			end
		end
	end
end