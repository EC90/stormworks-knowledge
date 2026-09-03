-- source: steam id 3482121776 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3482121776
-- stewart v1_1

local pistMin = 8
local pistMax = 12
local maxAng = 0.08

local base = {
{4,0,5},
{2,0,6},
{-6,0,1},
{-6,0,-1},
{2,0,-6},
{4,0,-5}
}

local top = {
{6,0,1},
{-2,0,6},
{-4,0,5},
{-4,0,-5},
{-2,0,-6},
{6,0,-1}
}

function clamp(val, min, max)
if val < min then return min
elseif val > max then return max
else return val
end
end

local function d2r(d)
return d*2*math.pi
end

local function rotX(a)
return {
{1, 0, 0},
{0, math.cos(a), -math.sin(a)},
{0, math.sin(a), math.cos(a)}
}
end

local function rotZ(a)
return {
{math.cos(a), -math.sin(a), 0},
{math.sin(a), math.cos(a), 0},
{0, 0, 1}
}
end

local function matmul(a, b)
return {
a[1][1]*b[1] + a[1][2]*b[2] + a[1][3]*b[3],
a[2][1]*b[1] + a[2][2]*b[2] + a[2][3]*b[3],
a[3][1]*b[1] + a[3][2]*b[2] + a[3][3]*b[3]
}
end

local function add(a, b)
return {a[1]+b[1], a[2]+b[2], a[3]+b[3]}
end

local function sub(a, b)
return {a[1]-b[1], a[2]-b[2], a[3]-b[3]}
end

local function dist(v)
return math.sqrt(v[1]^2 + v[2]^2 + v[3]^2)
end

local function norm(len)
local norm = (len - pistMin) / (pistMax - pistMin)
return norm * 2 - 1
end

function onTick()
local damping = input.getNumber(1)
local spring = input.getNumber(2)
local plath = clamp(input.getNumber(3), 7, 10)
local vely = input.getNumber(8)
local pitch = d2r(clamp(input.getNumber(15), -maxAng, maxAng))
local roll = d2r(clamp(input.getNumber(16), -maxAng, maxAng))
local offset = clamp(damping * vely - spring * (offset or 0), -1, 1)
local Rx = rotX(roll)
local Rz = rotZ(pitch)
local R = {}
for i = 1,3 do
R[i] = {}
for j = 1,3 do
R[i][j] = 0
for k = 1,3 do
R[i][j] = R[i][j] + Rx[i][k] * Rz[k][j]
end
end
end
for i = 1,6 do
local rotated = matmul(R, top[i])
local world = add(rotated, {0, plath + offset, 0})
local len = sub(world, base[i])
local pist = norm(dist(len))
output.setNumber(i, pist)
end
end

-- by tio99 & chatGPT <3