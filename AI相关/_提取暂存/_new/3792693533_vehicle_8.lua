-- source: steam id 3792693533 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792693533
warning=property.getBool("Display Size Compatabillity Warning")
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	if (w<96 or h<64) and warning then
		screen.setColor(0,0,0)					
		screen.drawClear()
		screen.setColor(255,0,0)
		screen.drawTextBox(0,0,w,h,"Too small display!",0,0)
	end
end