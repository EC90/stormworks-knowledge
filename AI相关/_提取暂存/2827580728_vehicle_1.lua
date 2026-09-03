-- source: steam id 2827580728 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2827580728
Td = {0,0,0,0,0,0,0,0,0}
Tx = {0,0,0,0,0,0,0,0,0}
Ty = {0,0,0,0,0,0,0,0,0}

Td1 = {}
Tx1 = {}
Ty1 = {}

Tdold = {}
Txold = {}
Tyold = {}

kalman = 0.75

function onTick()
	lookX = input.getNumber(31)
	lookY = input.getNumber(32)
	
	pov = property.getNumber("Seat center to HUD distance")
	
	for i=1,8,1 do
		Tdold[i] = Td[i]
		Txold[i] = Tx[i]
		Tyold[i] = Ty[i]
		td = input.getNumber(i*4-3)	--distance
		tx = input.getNumber(i*4-2)	--azimuth
		ty = input.getNumber(i*4-1)	--elevation
		for u in pairs(Tx) do
			if false and math.abs(td-Td[u])<10 and math.abs(tx-Tx[u])<0.05 and math.abs(ty-Ty[u])<0.05 and u~=i then
				td = 0
				tx = 0
				ty = 0
			end
		end
			
		Td[i] = td
		Tx[i] = tx
		Ty[i] = ty
		if Tdold[i]~=0 then
			Td1[i] = kalman*Td[i]+(1-kalman)*Tdold[i]
			Tx1[i] = kalman*Tx[i]+(1-kalman)*Txold[i]
			Ty1[i] = kalman*Ty[i]+(1-kalman)*Tyold[i]
		else
			Td1[i] = Td[i]
			Tx1[i] = Tx[i]
			Ty1[i] = Ty[i]
		end
	end
end


function onDraw()
	w = 96
	h = 96
	screen.setColor(255, 255, 0)
	
	modX = lookX*property.getNumber("X modifier")
	modY = lookY*property.getNumber("Y modifier")
	
	count = 0
	
	for i in ipairs(Tx1) do
		if Tx1[i]~=0.0000 and Ty1[i]~=0.0000 then
			count = count + 1
			x=math.tan(Tx1[i]*2*math.pi)*pov*96
			y=math.tan(Ty1[i]*2*math.pi)*pov*96
		
			screen.drawRect(46+x+modX, 36-y-modY, 4, 4)
		end
	end
	
	screen.drawText(2, 13, count)
end