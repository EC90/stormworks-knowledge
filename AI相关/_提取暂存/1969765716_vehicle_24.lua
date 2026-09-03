-- source: steam id 1969765716 / vehicle.xml block#24
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
i=input
o=output
s=screen
pageNr=0

infrared=false --NoseCam Infrared
fov=0.4 --NoseCam FOV (0.4-1)
function onTick()
	isP = i.getBool(12)
	iX = i.getNumber(23)
	iY = i.getNumber(24)

	nextPage = isP and iPIR(iX,iY,56,0,8,8)
	if nextPage and not nextpage then
		if pageNr<1 then pageNr=pageNr+1 elseif pageNr==1 then pageNr=0 end
	end
	nextpage = nextPage

	if pageNr==1 then
		fovIn=isP and iPIR(iX,iY,0,27.8,6,12.8)
		fovOut=isP and iPIR(iX,iY,0,40.6,6,12,8)
		infraredP=isP and iPIR(iX,iY,0,53.4,6,12.8)
		
		if fovIn and fov < 1 then fov = fov+.005 end
		if fovOut and fov > 0.4 then fov = fov-.005 end
		if fovIn or fovOut then showFov = true else showFov = false end
		if infraredP and not infraredp then infrared = not infrared end
		infraredp = infraredP
	end

	output.setBool(1,pageNr==1)
	output.setBool(2,infrared)
	output.setNumber(1,fov)
end

function iPIR(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	if pageNr==1 then s.setColor(255,255,0,100) else s.setColor(0,0,0,150) end
	s.drawRect(56,0,8,8)
	if nextPage then s.setColor(0,255,0,200) elseif pageNr==1 and not nextPage then
	s.setColor(255,255,0,100) else s.setColor(0,0,0,100) end
	s.drawText(59,2,">")

	if pageNr==1 then
	if infrared then s.setColor(255,0,0,75) else s.setColor(0,0,0,150) end
	s.drawRectF(0,27.8,6,38.4)

	if fovIn then s.setColor(255,255,255) else s.setColor(255,255,255,50)end
	s.drawTextBox(1,27.8,4,12.8,"+",0,0)
	if fovOut then s.setColor(255,255,255) else s.setColor(255,255,255,50)end
	s.drawTextBox(1,40.6,4,12.8,"-",0,0)
	s.setColor(255,255,255)
	if showFov then s.drawText(24,10,string.format("%.2f",fov)) end
	
	if infraredP then s.setColor(255,255,255) else s.setColor(255,255,255,50)end
	s.drawTextBox(1,53.4,4,12.8,"I",0,0)
	end
end