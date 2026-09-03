-- source: steam id 2080390771 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2080390771
-- edit this
graphs = {
	{label="target rps",min=0,max=20,r=120,g=0,b=0},
	{label="rps",min=0,max=20,r=0,g=120,b=0},
	{label="throttle",min=0,max=1,r=0,g=0,b=120},
	{label="temp",min=-20,max=130,r=120,g=0,b=120},
	{label="generator",min=0,max=600,r=120,g=120,b=0},
	{label="fuel",min=0,max=187.5,r=0,g=120,b=120}
}


ticksBetweenMeasurements = 10









-- dont edit below here!


for i=1,#graphs do
	graphs[i].values={}
end

interval = ticksBetweenMeasurements
intervalCounter = 0
function onTick()
	if not input.getBool(32) then
		intervalCounter = intervalCounter + 1
	end
	if intervalCounter >= interval then
		intervalCounter = 0
			
		for i=1,#graphs do
			table.insert(graphs[i].values, 1, input.getNumber(i))
		
			if PAD and #graphs[i].values > SW - 2*PAD then
				table.remove(graphs[i].values,#graphs[i].values)
			end
		end
	end
end

function onDraw()
	SW = screen.getWidth()
	SH = screen.getHeight()
	
	PAD = 7
	H = SH - 2*PAD
	
	xt = 0
	for i=1,#graphs do
		g = graphs[i]
		screen.setColor(g.r,g.g,g.b)
		
		screen.drawText(xt+1, SH - PAD + 1, g.label)
		xt = xt + string.len(g.label)*5+3
		
		values = g.values
		for x=1,SW - 2*PAD do
			if values[x] then
				value = (values[x]-g.min)/(g.max-g.min)
			end
			if not (values[x+1] == nil) then
				valueAfter = (values[x+1]-g.min)/(g.max-g.min)
			end
			
			if value and valueAfter then
				screen.drawLine(PAD + x, PAD + H * (1 - value), PAD + x + 1, PAD + H * (1 - valueAfter))
			end
		end
	end
end

