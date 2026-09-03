-- source: steam id 3750251471 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3750251471
function clamp(x, minVal, maxVal)
	return math.max(math.min(x, maxVal), minVal)
end
-- Kalman 3-axis (X,Y,Z) for Stormworks
local M={}function M.copy(a)local b={}for i=1,#a do b[i]={}for j=1,#a[i]do b[i][j]=a[i][j]end end return b end
function M.add(a,b)local c={}for i=1,#a do c[i]={}for j=1,#a[i]do c[i][j]=a[i][j]+b[i][j]end end return c end
function M.sub(a,b)local c={}for i=1,#a do c[i]={}for j=1,#a[i]do c[i][j]=a[i][j]-b[i][j]end end return c end
function M.mul(a,b)local R,C=#a,#a[1]local C2=#b[1]local c={}for i=1,R do c[i]={}for j=1,C2 do local s=0 for k=1,C do s=s+a[i][k]*b[k][j]end c[i][j]=s end end return c end
function M.sm(s,a)local c={}for i=1,#a do c[i]={}for j=1,#a[i]do c[i][j]=s*a[i][j]end end return c end
function M.tr(a)local c={}for i=1,#a[1]do c[i]={}for j=1,#a do c[i][j]=a[j][i]end end return c end
function M.id(n)local I={}for i=1,n do I[i]={}for j=1,n do I[i][j]=i==j and 1 or 0 end end return I end
function M.inv(m)local n=#m local a={}for i=1,n do a[i]={}for j=1,n do a[i][j]=m[i][j]end for j=1,n do a[i][n+j]=i==j and 1 or 0 end end
for i=1,n do local p=i for k=i+1,n do if math.abs(a[k][i])>math.abs(a[p][i])then p=k end end
if p~=i then a[i],a[p]=a[p],a[i]end local d=a[i][i]for j=1,2*n do a[i][j]=a[i][j]/d end
for k=1,n do if k~=i then local f=a[k][i]for j=1,2*n do a[k][j]=a[k][j]-f*a[i][j]end end end end
local inv={}for i=1,n do inv[i]={}for j=1,n do inv[i][j]=a[i][n+j]end end return inv end
KF={}function KF.new(F,H,Q,R,x0,P0,B)local o={F=F,H=H,Q=Q,R=R,B=B,n=#F}
if x0 then o.x=M.copy(x0)else o.x={}for i=1,o.n do o.x[i]={0}end end
if P0 then o.P=M.copy(P0)else o.P=M.id(o.n)end
function o:pred(u)local F=self.F local Q=self.Q local B=self.B
if B and u then local Bu=M.mul(B,u)self.x=M.add(M.mul(F,self.x),Bu)else self.x=M.mul(F,self.x)end
local FP=M.mul(F,self.P)local FPFT=M.mul(FP,M.tr(F))self.P=M.add(FPFT,Q)end
function o:upd(z)local H=self.H local R=self.R local x=self.x local P=self.P
local Hx=M.mul(H,x)local y=M.sub(z,Hx)local HP=M.mul(H,P)local HPHt=M.mul(HP,M.tr(H))local S=M.add(HPHt,R)
local PHt=M.mul(P,M.tr(H))local K=M.mul(PHt,M.inv(S))self.x=M.add(x,M.mul(K,y))
local KH=M.mul(K,H)local I=M.id(self.n)self.P=M.mul(M.sub(I,KH),P)end
function o:state()return self.x end function o:cov()return self.P end return o end

-- Init filters
dt=1/60
F={{1,dt},{0,1}}
H={{1,0}}
x0={{0},{0}}
P0=M.id(2)
Q=M.sm(0.015,{{dt^3/3,dt^2/2},{dt^2/2,dt}})
R={{0.001}}
f1={}
for i=1,3 do f1[i]=KF.new(F,H,Q,R,x0,P0) end

local sin = math.sin
local cos = math.cos
local asin = math.asin
local atan = math.atan
local sqrt = math.sqrt
local log = math.log
local pi = math.pi
tick=0
Targ={}
Aprox={}
TableTickTarg=10
TickCompensate = 8
function onTick()
--0.00005
--0.001

	----------------------------------
	if tick<10 then 
		tick=tick+1 
		for i=1,TableTickTarg do 
			if #Targ<TableTickTarg then 
			table.insert(Targ,{0,0,0}) 
			end 
		end 
	return 
	end
	
	
	
	
	Rad={}
	turretYaw = input.getNumber(13)
	
    ox = input.getNumber(4)
    oy = input.getNumber(12)
    oz = input.getNumber(8)
    
    n = input.getNumber(16)
    o = input.getNumber(20)
    l = input.getNumber(24)

	
	for i=1,8 do 
	DST = input.getNumber((i-1)*4+1)
	if DST~=0 then table.insert(Rad,i,DST) end
	end
	Rd=input.getNumber((#Rad-1)*4+1)
	Rx=input.getNumber((#Rad-1)*4+2)
	Ry=-input.getNumber((#Rad-1)*4+3)
	-- antichaff off
	Rd=input.getNumber(1)
	Rx=input.getNumber(2)
	Ry=-input.getNumber(3)
	

	targetGiven = px ~= 0
	
	pz=Rd*math.sin(Ry*math.pi*2)
	px=Rd*math.cos(Ry*math.pi*2)*math.sin(Rx*math.pi*2)
	py=Rd*math.cos(Ry*math.pi*2)*math.cos(Rx*math.pi*2)
	
	
    local f, m, g = cos(n), cos(o), cos(l)
    local i, k, e = sin(n), sin(o), sin(l)
    local q = f * k * e - i * g
    local pitch = asin(q)
    local yaw = atan(f * m, f * k * g + i * e)
    yaw = -yaw + pi / 2
    
    if yaw > pi then yaw = yaw - 2 * pi elseif yaw <= -pi then yaw = yaw + 2 * pi end
    
    local denom = sqrt(1 - q * q)
    local roll = 0
    if denom > 1e-10 then roll = asin(-m * e / denom) end
    if i * k * e + f * g < 0 then
        roll = pi - roll
        if roll > pi then roll = roll - 2 * pi end
    end
    if roll > pi then roll = roll - 2 * pi elseif roll <= -pi then roll = roll + 2 * pi end
    
    local dx = px
    local dy = py
    local dz = pz
    
    local cx, sx = cos(pitch), sin(pitch)
    local cy, sy = cos(roll), sin(roll)
    local cz, sz = cos(yaw), sin(yaw)
    
    local r11 = cz * cy + sz * sx * sy
    local r12 = sz * cx
    local r13 = cz * sy - sz * sx * cy
    local r21 = -sz * cy + cz * sx * sy
    local r22 = cz * cx
    local r23 = -sz * sy - cz * sx * cy
    local r31 = -cx * sy
    local r32 = sx
    local r33 = cx * cy
    
	local lx = r11 * dx + r12 * dy + r13 * dz +ox
	local ly = r21 * dx + r22 * dy + r23 * dz +oy
	local lz = r31 * dx + r32 * dy + r33 * dz +oz
	
	
	ln={lx,ly,lz}
	
	for i=1,3 do
        local z={{ln[i]}}
        f1[i]:pred()
        f1[i]:upd(z)
        ln[i]=f1[i]:state()[1][1]
    end
		tvx=f1[1]:state()[2][1]/60
		tvy=f1[2]:state()[2][1]/60
		tvz=f1[3]:state()[2][1]/60
lx=ln[1]+tvx*TickCompensate
ly=ln[2]+tvy*TickCompensate
lz=ln[3]+tvz*TickCompensate




	----------------------------------
	--table.insert(Targ,1,{lx,ly,lz})
	--if #Targ > TableTickTarg then table.remove(Targ[#Targ]) end
	----------------------------------

	----------------------------------
	--tvx=(-Targ[TableTickTarg][1]+Targ[1][1])/(TableTickTarg-1)--*(TickCompensate)
	--tvy=(-Targ[TableTickTarg][2]+Targ[1][2])/(TableTickTarg-1)--*(TickCompensate)
	--tvz=(-Targ[TableTickTarg][3]+Targ[1][3])/(TableTickTarg-1)--*(TickCompensate)
	----------------------------------
	
	
	
	--if true then
	--	pz = tvz
	--	px = tvx
	--	py = tvy
	--end
	----------------------------------






	
	
	
	
	
	AngZ = atan(lz/sqrt(lx^2+ly^2))/pi*2
	if input.getBool(1) then
    	output.setNumber(1, lx)
    	output.setNumber(2, lz)
    	output.setNumber(3, ly)
    	output.setNumber(4, 1)
	else
		output.setNumber(4, 0)
	end

end