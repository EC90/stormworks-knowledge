-- source: steam id 2046605849 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2046605849
function onTick()
	time=input.getNumber(1)
	name=property.getText("CameraName")
	r=property.getNumber("TextColor(R)")
	g=property.getNumber("TextColor(G)")
	b=property.getNumber("TextColor(B)")
	timeH=math.floor(time*24)
	timeM=math.floor(((time*24)%1)*60)
	r2=property.getNumber("BackgroundColor(R)")
	g2=property.getNumber("BackgroundColor(G)")
	b2=property.getNumber("BackgroundColor(B)")
	bagt=property.getNumber("BackgroundTransparency(%)")
	bg=property.getNumber("Background")
	bt=bagt*2.55
	nl=string.len(name)
end

function onDraw()

	w = screen.getWidth()
	h = screen.getHeight()
	
	screen.setColor(r2,g2,b2,bt)
	if bg==1 then
		screen.drawRectF(w-26,0,23,7)
		screen.drawRectF(4,h-7,(nl*5)+1,7)
	end
	
	screen.setColor(r,g,b)
	screen.drawText(5,h-6,name)
	if timeH <10 then
		screen.drawText(w-25,1,"0")
		screen.drawText(w-20,1,timeH)
	else
		screen.drawText(w-25,1,timeH)
	end
	screen.drawText(w-16,1,":")
	if timeM <10 then
		screen.drawText(w-13,1,"0")
		screen.drawText(w-8,1,timeM)
	else
		screen.drawText(w-13,1,timeM)
	end
	
end