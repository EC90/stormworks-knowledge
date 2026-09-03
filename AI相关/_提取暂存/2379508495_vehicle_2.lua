-- source: steam id 2379508495 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2379508495
gb = input.getBool
gn = input.getNumber
sb = output.setBool
sn = output.setNumber
pgb = property.getBool
pgn = property.getNumber

L = false -- mode
P = 0 -- Current position
OP = 0 -- Old pos (2 tick before)
OBL = false -- old button state
OBR = false -- old button state
DS = {0,0,0,0,0} -- Distances
PS = {0,0,0,0,0} -- Powers
YS = {0,0,0,0,0} -- Yaws
CI = 1 -- current echo index

RGS = {pgn('Range 1'),pgn('Range 2'),pgn('Range 3'),pgn('Range 4')} -- ranges
RG = 1
-- cache
TMPD = 0 -- dist
TMPC = 0 -- count
TMPAY = 0 -- yaw angle
TMPB = false -- detection when radar backward ?

_T = 0.016/pgn('Rotate Duration') -- local tick duration to rotate the radar in 'Rotate Duration' second (0.016 = 60fps)
_FOV = pgn('Tracking FOV')

function onTick()
	-- Copy input to output
	for i = 1, 10 do
		sb(i, gb(i))
		sn(i, gn(i))
	end
	
	-- if enabled
	if gb(3) then
		-- screen q click
		M = gb(1)
		MX = gn(1)
		MY = gn(2)
		-- or screen e click
		if not M then
			M = gb(2)
			MX = gn(3)
			MY = gn(4)
		end
		
		BR = M and click(MX, MY, 1, 24, 6, 7) -- button Range pressed
		BL = M and click(MX, MY, 8, 24, 6, 7) -- button Lock pressed
		sb(1, BR)
		sb(2, BL)
		
		sb(30, false)
		sb(31, false)
		-- lock toggle ?
		if (not M) and OBL then 
			L = not L
			sb(30, true)
		end
		OBL = BL
		sb(4, L)
		
		-- change range ?
		if (not M) and OBR then
			RG = (RG%4)+1
			sb(31, true)
		end
		OBR = BR
		sn(28, RGS[RG])
		
		if L then
			-- we look forward to lock 1 target
			sn(29,0)
			sn(30,0)
			sn(31, _FOV)
			sn(32, _FOV)
		else
			-- radar input
			DV = gn(5)
			DH = gn(6)
			PV = gn(7)
			PH = gn(8)
			
			-- rotate
			
			sn(29, P)
			sn(31, 0.125)
			
			sn(30,0)
			sn(32, 0.01)
			
			-- if echo
			if DH > 0 then
			-- save radar data in cache
			
			TMPD = TMPD + DH
			TMPC = TMPC + 1
			TMPAY = TMPAY + OP
			
			-- Correction in case we are looking backward
			-- (Angle change from 0.5 to -0.5 so the avg position will be incorrect)
			if TMPB then
				TMPAY = TMPAY + 1
			end
			
			-- if we will looking backward
			if OP > 0 and P < 0 then
				TMPB = true
			end
			
			-- store avg
			DS[CI] = TMPD / TMPC
			PS[CI] = 3
			tmp = TMPAY / TMPC
			-- Keep an angle between -0.5 and 0.5
			if tmp > 0.5 then
				tmp = tmp - 1
			end
			YS[CI] = tmp
			
			elseif TMPC > 0 then
			-- echo end			
			-- change index
			CI = (CI % 5) + 1
			
			-- reset
			TMPD = 0
			TMPC = 0
			TMPAY = 0
			TMPB = false 
			else
			-- idle
			end
			
			OP = P
			P = P + _T
			if P > 0.5 then
				P = -0.5
			end
			
			-- copy echo data to composite
			for i = 1, 5 do
				if DS[i] > 1 then
					--if will be updated in less than 2 tick
					if YS[i] > P and YS[i] < P + _T*2 then
						-- clear
						DS[i] = 0
						PS[i] = 0
						YS[i] = 0
					else
						PS[i] = PS[i]-_T*3
					end
				end
				sn(10+i, DS[i])
				sn(15+i, PS[i])
				sn(20+i, YS[i])
			end
		end
	end
end

function click(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw() 
	screen.drawText(1,13,'OBR ' .. tostring(OBR))
	screen.drawText(1,19,'OBL ' .. tostring(OBL))
end