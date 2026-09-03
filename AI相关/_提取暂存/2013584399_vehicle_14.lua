-- source: steam id 2013584399 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2013584399
--Navigation Plotter by Supremeboi--

function onTick()
	--Screen Inputs
	w=input.getNumber(1)
	h=input.getNumber(2)
	w2=w / 2
	h2=h / 2
	tx=input.getNumber(3)
	ty=input.getNumber(4)
	fk=input.getBool(1)
	--Map Script Inputs	
	mapX=input.getNumber(13)
	mapY=input.getNumber(14)
	mapZ=input.getNumber(15)
	pR=input.getNumber(16)
	--Stored values
	sX=input.getNumber(17)
	sY=input.getNumber(18)
	sZ=input.getNumber(19)
	--Distance Value Rounding
	Distance = input.getNumber(21)
	if Distance>=1000 then
	Dist=Distance/1000
	mult = 10^(1 or 0)
	Dis = math.floor(Dist * mult + 0.5) / mult else
	Dis = math.ceil(Distance-0.5)
	end
	--Focus Output
	output.setNumber(10, mapX)
	output.setNumber(11, mapY)
	output.setNumber(12, mapZ)
	--Button State Output
	output.setBool(13, NavSet)
	output.setBool(14, Reset)
	--Button State
	NavSet = fk and isNavSet(tx, ty)
	Reset = fk and isReset(tx, ty)
end

--Button Press
function isNavSet(tx, ty) 
return tx<10 and ty<58 and ty>46 
end 
function isReset(tx, ty) 
return tx<22 and ty>57
end	
		
function onDraw()
	--Target Aiming
	screen.setColor(255, 255, 255)
	screen.drawCircle(w/2, h/2, pR)
	screen.drawLine(0, h/2, w, h/2)
	screen.drawLine(w/2, 0, w/2, w - 6)
	--Distance Text
	if Distance<1 then
	elseif Distance>=1000 then
	screen.setColor(0, 255, 0)
	screen.drawText(4, 1, Dis.."km") else
	screen.setColor(0, 255, 0)
	screen.drawText(4, 1, Dis.."m")
	end
	--Button Interaction
	if NavSet then
		screen.setColor(0, 27, 41)
	else
		screen.setColor(0, 94, 142)
	end 
	--Target Button
	screen.drawRectF(0, h-16, 9, 9)
	screen.setColor(255, 255, 255)
	screen.drawText(3, h-14, "T")
	screen.setColor(15, 15, 15)
	screen.drawLine(0, h-7, 9, h-7)
end

