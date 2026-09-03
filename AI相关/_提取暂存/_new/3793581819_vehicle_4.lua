-- source: steam id 3793581819 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
i=input
igB=i.getBool
igN=i.getNumber
s=screen
sc=s.setColor
dl=s.drawLine
drf=s.drawRectF
dtf=s.drawTriangleF
dtx=s.drawText
dtxb=s.drawTextBox

tickR = 0
radarRotationCheck = 0

radarTrail = property.getNumber("Radar Trail Multiplier (1 = no trail)")

radarTail = {}
key = {}
T = {}
D = {}
A = {}
AzDist = {}
AzRot = {}

function inRect(x, y, rectX, rectY, rectW, rectH)
	return x >= rectX and y >= rectY and x < rectX+rectW and y < rectY+rectH
end

function onTick()
	north = igB(12)
	radarLine = igB(16)

	radarRotation = igN(3)
	rangeM = igN(9)*1000
	
	radarX = 31 + 31 * math.cos((radarRotation*2*math.pi)-0.5*math.pi)
	radarY = 32 + 31 * math.sin((radarRotation*2*math.pi)-0.5*math.pi)
	
	if radarRotation == radarRotationCheck then
		radarOn = false
	else
		radarOn = true
	end
	
	for i=1, 8 do
		T[i] = igB(i)
		D[i] = igN(i+9)
		A[i] = igN(i+17)
		if T[i] and not north then
			AzDist[A[i]] = D[i]
			AzRot[A[i]] = radarRotation
		end
	end
	
	if north or not radarLine or not radarOn then
		for rot, tra in pairs(radarTail) do
			radarTail[rot] = nil
		end

		for k, v in pairs(key) do
			key[k] = nil
		end
	end
end


function onDraw()
	if not north then
		sc(200,0,0)
		for Az, dist in pairs(AzDist) do
			if dist < rangeM then
				drf(31 + dist*(31/rangeM) * math.cos((Az*2*math.pi)-0.5*math.pi),32 + dist*(31/rangeM) * math.sin((Az*2*math.pi)-0.5*math.pi),1,1)
			end
			if radarRotation > 0 then
				if radarRotation > AzRot[Az]+1 or not radarOn then
					AzDist[Az] = nil
					AzRot[Az] = nil
				end
			else
				if radarRotation < AzRot[Az]-1 or not radarOn then
					AzDist[Az] = nil
					AzRot[Az] = nil
				end
			end
		end
		
		if radarLine and radarOn then
			tickR = tickR+1
			key[tickR] = radarRotation
			radarTail[radarRotation] = 255
			
			for rot, tra in pairs(radarTail) do
				for k, v in pairs(key) do
					if v == rot and key[k+1] ~= nil then
						rotDelay = key[k+1]
						if tra <= 0 then
							key[k] = nil	
						else
							radarTailX1 = 31 + 31 * math.cos((rot*2*math.pi)-0.5*math.pi)
							radarTailY1 = 32 + 31 * math.sin((rot*2*math.pi)-0.5*math.pi)
							radarTailX2 = 31 + 31 * math.cos((rotDelay*2*math.pi)-0.5*math.pi)
							radarTailY2 = 32 + 31 * math.sin((rotDelay*2*math.pi)-0.5*math.pi)
							sc(0, 50 , 100, tra)
							dtf(31, 32+1, radarTailX1, radarTailY1+1, radarTailX2, radarTailY2+1)
						end
					end
				end
				if tra <= 0 then
					radarTail[rot] = nil
				else
					radarTail[rot] = tra - 255/radarTrail
				end
			end
			sc(0, 50 , 100)
			dl(31, 32, radarX, radarY)
		end
		radarRotationCheck = radarRotation
	end
end