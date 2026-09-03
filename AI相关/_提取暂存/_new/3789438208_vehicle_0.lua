-- source: steam id 3789438208 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3789438208

o=output

r=200
g=85
b=3

function onTick()


	R= input.getNumber(1)
	L= input.getNumber(2)
	
	
	o.setNumber(1,(r/255)*R)
	
	o.setNumber(2,(g/255)*R)
	
	o.setNumber(3,(b/255)*R)		
		
		
		
	o.setNumber(4,(r/255)*L)
	
	o.setNumber(5,(g/255)*L)
	
	o.setNumber(6,(b/255)*L)	 

end
