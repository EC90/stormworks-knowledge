-- source: steam id 2379508495 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2379508495
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
	if ON then
		w = screen.getWidth()
		h = screen.getHeight()
		if L then
			screen.setColor(_R,_G,_B,255)
			if DV < 1 and DH < 1 then
				if BLINK then
					screen.drawLine(w*0.125, h*0.125, w*0.25, h*0.125)
					screen.drawLine(w*0.125, h*0.125, w*0.125, h*0.25)
				
					screen.drawLine(w*0.875, h*0.125, w*0.75, h*0.125)
					screen.drawLine(w*0.875, h*0.125, w*0.875, h*0.25)
				
					screen.drawLine(w*0.125, h*0.875, w*0.25, h*0.875)
					screen.drawLine(w*0.125, h*0.875, w*0.125, h*0.75)
				
					screen.drawLine(w*0.875, h*0.875, w*0.75, h*0.875)
					screen.drawLine(w*0.875, h*0.875, w*0.875, h*0.75)
					
					screen.drawRectF(w/2-1,h/2-1,2,2)
				end
			elseif BLINK or (DV > 1 and DH > 1) then
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
				if c > 0 then
					d = d/c
					screen.drawText(x-_LRS/2,y+_LRS/2+3,string.format('%.2f',d/1000)..'km')
					screen.drawText(x-_LRS/2,y+_LRS/2+9,string.format('%d',((d-OD)/0.016)//1)..'m/s')
				end
				OD = d
			end
		else
			
			for i = 1, 5 do
				if DS[i] > 1 and RG > 0 then
					screen.setColor(_R,_G,_B,clamp(255*PS[i],0,255))
					x,y = rotate(0,-(DS[i]/RG)*(w/2),-YS[i])
					screen.drawCircleF(w/2-x,h/2+y,2)
				end
			end
		
			screen.setColor(_R*0.5,_G*0.5,_B*0.5,255)
			x,y = rotate(0,-0.5 * math.max(w,h),P)
			screen.drawLine(w/2,h/2,(w/2)+x,(h/2)+y)
		end
	else
		-- idle
	end
end

function clamp(x,min,max)
	if x < min then
		return min
	elseif x > max then
		return max
	else
		return x
	end
end
	
function rotate(x,y,a) 
	cos = math.cos(a*3.1415*2)
	sin = math.sin(a*3.1415*2)
	return (cos*x-sin*y), (sin*x + cos*y) 
end