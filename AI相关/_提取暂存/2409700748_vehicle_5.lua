-- source: steam id 2409700748 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2409700748
function onDraw()
	screen.getWidth()
	screen.getHeight()
	
	screen.setColor(225, 225, 225)
	
	screen.drawText(0, 8, "BIOS.........")
	screen.drawText(0, 16, "MEMORY ....OK")
	screen.drawText(0, 24, "FLASH......OK")
	screen.drawText(0, 32, "EDOS.......OK")
	screen.drawText(0, 40, "ABRIS......OK")
	screen.drawText(0, 48, "BOOT COMPLETE")
end