-- source: steam id 2836937357 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
time = 0
radius = property.getNumber("Dot Radius")
moveRadius = property.getNumber("Movement Radius")
speed = property.getNumber("Spinning Speed")
textSpeed = property.getNumber("Text Pulse Speed")
circleCount = property.getNumber("Dot Count")
hOffset = property.getNumber("Vertical Offset")
text = property.getText("Text")
dotFade = property.getBool("Dot Fade")
offRadius = property.getNumber("Off Screen Dot Radius")
textPlacement = property.getNumber("Text Placement")

dotR = property.getNumber("Dot Colour R")
dotG = property.getNumber("Dot Colour G")
dotB = property.getNumber("Dot Colour B")

textR = property.getNumber("Text Colour R")
textG = property.getNumber("Text Colour G")
textB = property.getNumber("Text Colour B")

offR = property.getNumber("Off Colour R")
offG = property.getNumber("Off Colour G")
offB = property.getNumber("Off Colour B")

function onTick()
	bool = input.getBool(1)
	if bool then
		time = time+0.1
	end
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0,0,0)
	screen.drawClear()

	if bool then
		if dotFade then
			for i = 1,circleCount do
				screen.setColor(dotR,dotG,dotB,255*(i/circleCount))
				screen.drawCircleF((w/2)+(math.cos((math.pi*2/circleCount)*i+time*speed)*moveRadius),(h/2+hOffset)+(math.sin((math.pi*2/circleCount)*i+time*speed)*moveRadius),radius)
			end
		else
			for i = 1,circleCount do
				screen.setColor(dotR,dotG,dotB)
				screen.drawCircleF((w/2)+(math.cos((math.pi*2/circleCount)*i+time*speed)*moveRadius),(h/2+hOffset)+(math.sin((math.pi*2/circleCount)*i+time*speed)*moveRadius),radius)
			end
		end
		
		if textPlacement == 1 then
			screen.setColor(textR,textG,textB,255*(math.sin(time*textSpeed)*0.5+0.5))
			screen.drawTextBox(1,3,w-2,h-4,text,0,-1)
		end
		if textPlacement == 2 then
			screen.setColor(textR,textG,textB,255*(math.sin(time*textSpeed)*0.5+0.5))
			screen.drawTextBox(1,1,w-2,h-2,text,0,0)
		end
		if textPlacement == 3 then
			screen.setColor(textR,textG,textB,255*(math.sin(time*textSpeed)*0.5+0.5))
			screen.drawTextBox(1,1,w-2,h-4,text,0,1)
		end
	else
		screen.setColor(offR,offG,offB)
		screen.drawCircleF(w/4,h/2,offRadius)
		screen.drawCircleF(w/4*2,h/2,offRadius)
		screen.drawCircleF(w/4*3,h/2,offRadius)
	end
end