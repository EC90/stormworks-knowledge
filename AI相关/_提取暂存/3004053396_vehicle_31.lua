-- source: steam id 3004053396 / vehicle.xml block#31
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3004053396
-----------------------------------------------------
-------------MICROWAVES BASIC EPN--------------------
-----------------------------------------------------

	i,p,o= input,property,output
	gb,gn,pgn,on = i.getBool,i.getNumber,p.getNumber,o.setNumber	 
	
	pD,scv = 0,0
	
	--Get n Value
	n=pgn("n Value")

function onTick()
	
	--Get Inputs (X and Y LOS Rates and Distance)
	XlosR,YlosR,D = gn(1),gn(2),gn(3)
	
		--Get Closing Velocity and Smooth Closing Velocity
		cv = pD-D
		pD = D
		scv = scv+(cv-scv)/2
	
	--If launch then output
	if gn(4)==1 then	
		on(1,scv*n*XlosR)
		on(2,scv*n*YlosR)
	else
		on(1,0)
		on(2,0)
	end

	
end