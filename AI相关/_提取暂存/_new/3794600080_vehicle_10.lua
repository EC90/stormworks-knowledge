-- source: steam id 3794600080 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080
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
raw1check = 0

radarTrail = property.getNumber("Radar Trail Multiplier (1 = no trail)")

radarTail = {}
key = {}

T = {}
D = {}
A = {}
AngDist = {}
AngCheck = {}

function onTick()
	north = igB(12)
	headingLine = igB(15)
	radarLine = igB(16)
	
	raw1 = (igN(3)%1)
	radarRotation = raw1-math.ceil(raw1-0.5)
	heading = -igN(4)
	raw2 = radarRotation + heading
	radarHeading = raw2-math.ceil(raw2-0.5)
	rangeM = igN(9)*1000
	
	radarX = 31 + 31 * math.cos(((radarHeading)*2*math.pi)-0.5*math.pi)
	radarY = 32 + 31 * math.sin(((radarHeading)*2*math.pi)-0.5*math.pi)
	
	headingX1 = 31 + 31 * math.cos((heading*2*math.pi)-0.5*math.pi)
	headingY1 = 32 + 31 * math.sin((heading*2*math.pi)-0.5*math.pi)
	headingX2 = 31 + 7 * math.cos((heading*2*math.pi)-0.5*math.pi)
	headingY2 = 32 + 7 * math.sin((heading*2*math.pi)-0.5*math.pi)
	headingX3 = 31 + 3.5 * math.cos((heading*2*math.pi)-math.pi)
	headingY3 = 32 + 3.5 * math.sin((heading*2*math.pi)-math.pi)
	headingX4 = 31 + 4 * math.cos(heading*2*math.pi)
	headingY4 = 32 + 4 * math.sin(heading*2*math.pi)
	headingX5 = 31 + 4 * math.cos((heading*2*math.pi)-0.74*math.pi)
	headingY5 = 32 + 4 * math.sin((heading*2*math.pi)-0.74*math.pi)
	headingX6 = 31 + 4 * math.cos((heading*2*math.pi)-0.26*math.pi)
	headingY6 = 32 + 4 * math.sin((heading*2*math.pi)-0.26*math.pi)
	
	if raw1 == raw1check then
		radarOn = false
	else
		radarOn = true
	end
	
	for i=1, 8 do
		T[i] = igB(i)
		D[i] = igN(i+9)
		A[i] = igN(i+17)
		angle = A[i]+heading
		if T[i] and north then
			AngDist[angle-math.ceil(angle-0.5)] = D[i]
			AngCheck[angle-math.ceil(angle-0.5)] = false
		end
	end
	
	if not north or not radarLine or not radarOn then
		for rot, tra in pairs(radarTail) do
			radarTail[rot] = nil
		end
		
		for k, v in pairs(key) do
			key[k] = nil
		end
	end
end


function onDraw()
	if north then
		if headingLine then
			sc(50, 50, 50)
			dl(31, 32, headingX1, headingY1)
		end
		sc(200, 200, 200)
		dl(31, 32, headingX2, headingY2)
		dl(headingX3, headingY3, headingX4, headingY4)
		dl(headingX2, headingY2, headingX5, headingY5)
		dl(headingX2, headingY2, headingX6, headingY6)
		
		sc(200,0,0)
		for Ang, dist in pairs(AngDist) do
			if dist < rangeM then
				drf(31 + dist*(31/rangeM) * math.cos((Ang*2*math.pi)-0.5*math.pi),32 + dist*(31/rangeM) * math.sin((Ang*2*math.pi)-0.5*math.pi),1,1)
			end
			if Ang > radarHeading-0.05 and Ang < radarHeading+0.05 then
				
			else
				AngCheck[Ang] = true
			end
			if Ang > radarHeading-0.01 and Ang < radarHeading+0.01 or not radarOn then
				if AngCheck[Ang] or not radarOn then
					AngDist[Ang] = nil
					AngCheck[Ang] = nil
				end
			end
		end
		
		if radarLine and radarOn then
			tickR = tickR+1
			key[tickR] = radarHeading
			radarTail[radarHeading] = 255


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
		raw1check = raw1
	end
end