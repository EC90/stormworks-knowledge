-- source: steam id 3793581819 / vehicle.xml block#61
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
aggression=property.getNumber("Aggressiveness")
warningRange=property.getNumber("Warning Range")
cangle=0
tangle=0
turn=0
range=0
-- Tick function that will be executed every logic tick
function onTick()
	gn=input.getNumber
	heading=gn(1)
	cx=gn(2)
	cy=gn(3)
	tx=gn(4)
	ty=gn(5)
	
	dx=tx-cx
	dy=ty-cy
	
	--There's a 90 degree clockwise difference between 
	--measured heading and calculated heading.
	range=math.sqrt(dx*dx+dy*dy)
	tangle=math.atan(dy,dx)/(math.pi*2)
	--theading is 0 east, 0.25 north,+-0.5 west
	--base heading is 0 north, -0.25 east,+-0.5 south
	cangle=heading+0.25
	if (cangle > 0.5) then cangle=cangle-1 end
	if (cangle < -0.5) then cangle=cangle+1 end
	d=tangle-cangle
	if d>0.5 then d=d-1
	elseif d<-.5 then d=d+1 end
	
	turn=-d*aggression
	
	output.setNumber(1,turn)
	output.setBool(1,range<warningRange)
end

function msg(t)
	txt(2,my,t)
	my=my+6
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	my=2
	txt=screen.drawText
	w = screen.getWidth()
	h = screen.getHeight()
	msg("Turn:"..turn)
	msg("CurrGPS "..math.floor(cx)..","..math.floor(cy))
	msg("TargGPS "..math.floor(tx)..","..math.floor(ty))
	
	msg("Raw Heading:"..cangle)
	msg("Adjusted Heading:"..cangle)
	msg("Target Heading:"..tangle)
--	txt(2,26,heading)
--	txt(2,32,theading)
end