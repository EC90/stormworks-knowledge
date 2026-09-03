-- source: steam id 2013584399 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2013584399
-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()					
	screen.setColor(property.getNumber("Red [0..255]"),
					property.getNumber("Green [0..255]"),
					property.getNumber("Blue [0..255]"), 
					property.getNumber("Alpha [0..255]"))			 
	text = property.getText("Text")

	screen.drawText(9, 3, "alt")
	screen.drawText(9, 10, "low")
	
	screen.drawText(4, 18, "pitch")
	screen.drawText(4, 25, "reset")
	
	;
end