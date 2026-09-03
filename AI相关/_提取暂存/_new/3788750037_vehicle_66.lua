-- source: steam id 3788750037 / vehicle.xml block#66
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
gb = input.getBool
gn = input.getNumber
sb = output.setBool
sn = output.setNumber
pgb = property.getBool
pgn = property.getNumber

ON = false
DS = {0,0,0,0,0} -- Distances
PS = {0,0,0,0,0} -- Powers
YS = {0,0,0,0,0} -- Yaws
L = false
DV = 0
DH = 0
PV = 0
PH = 0
BLINK = false
P = 0
RG = 1000
OD = 0 -- old distance

_SCX = pgn('HUD Scale X')
_SCY = pgn('HUD Scale Y')
_TX = pgn('HUD Translate X')
_TY = pgn('HUD Translate Y')

_R = pgn('HUD R')
_G = pgn('HUD G')
_B = pgn('HUD B')

_LRS = pgn('HUD Lock Rect Size')

function onTick()
	ON = gb(3)
	L = gb(4)
	DV = gn(5)
	DH = gn(6)
	PV = gn(7)
	PH = gn(8)
	P = gn(29)
	RG = gn(28)
	BLINK = gb(32)
	for i = 1, 5 do
		DS[i] = gn(10+i)
		PS[i] = gn(15+i)
		YS[i] = gn(20+i)
	end
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
		w = screen.getWidth()
		h = screen.getHeight()-8
			screen.setColor(_R,_G,_B,225)
			if BLINK or (DV < 1 and DH < 1) then
				x = clamp(w*(0.5-PV*4*_SCX)+_TX,0,w)
				y = clamp(h*(0.5-PH*4*_SCY)+_TY,0,h)
				screen.drawRect(x-_LRS/2,y-_LRS/2,_LRS,_LRS)
				
				d = 0
				c = 0

				if DV > 1 then
					d = d + DV
					c = c + 1
				end
				if DH > 1 then
					d = d + DH
					c = c + 1
				end
				OD = d
			end
	screen.setColor(42,46,33, 225)
	screen.drawCircle(w / 2, h / 2, 2)
	
	screen.drawLine(32, 28, 32, 10)
	screen.drawLine(32, 36, 32, 54)
	
	screen.drawLine(28,32,10,32)
	screen.drawLine(36,32,54,32)
		end
		-- idle



function clamp(x,min,max)
	if x < min then
		return min
	elseif x > max then
		return max
	else
		return x
	end
end
	