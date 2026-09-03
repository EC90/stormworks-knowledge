-- source: steam id 2013584399 / vehicle.xml block#1
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
	x = 0 y = 0 dx = text:len()*5-1
	align = property.getNumber("Horizontal Alignment")
	if align==0 then x = (w-dx)/2 elseif align>0 then x = w-dx end
	x = math.max(0, x+property.getNumber("Horizontal Offset"))
	align = property.getNumber("Vertical Alignment")
	if align==0 then y = h/2-3 elseif align>0 then y = h-5 end
	y = math.max(0, y+property.getNumber("Vertical Offset"))
	screen.drawText(x, y, text);
end