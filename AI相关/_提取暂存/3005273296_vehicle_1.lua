-- source: steam id 3005273296 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3005273296
local ssc=screen.setColor
local sdl=screen.drawLine
local drf=screen.drawRectF
local txt=screen.drawText
local dr=screen.drawRect
local ign=input.getNumber
local ts=tostring
local res=""

local function rnd(num) return math.floor(num+.5) end

function onTick()
	mid=ign(3)
	max=ign(4)
	pix=rnd(ign(5))
	enhanced=rnd(ign(6))
	w=rnd(ign(7))
	h=rnd(ign(8))
	res=ts(w).." x "..ts(h)
end
	
function onDraw()
	--ssc(0,0,0)
	--drf(0,0,84,20)
	ssc(255,0,0)
	--dr(0,0,84,20)
	txt(2,2,"MaxP = "..rnd(max))
	local pct=rnd((pix/max)*100)
	txt(2,8,"Scan = "..pix.."("..pct.."%)")
	local pct_calc=rnd((enhanced/max)*100)
	txt(2,14,"Enhd = "..enhanced.."("..pct_calc.."%)")
	txt(2,20,"Head = "..rnd(mid).." deg")
	txt(2,26,"Res. = "..res)
end
	
