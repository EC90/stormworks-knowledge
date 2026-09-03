-- source: steam id 3793581819 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
s = screen
sc = s.setColor
drt = s.drawTextBox

function onTick()
	grad2 = input.getNumber(2)			 
			
end


function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()					
	
	sc(35, 123, 60, grad2)
	drt(15, 55, 70, 7, "Booting System", 0, 0)
	
end