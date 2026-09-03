-- source: steam id 2829260776 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2829260776
width = property.getNumber("View width at distance")

local function fovToZoom(fov)
    return (fov - 2.2) / (.025 - 2.2)
end

function onTick()
	dist = input.getNumber(1)
	
	fov = math.atan(width/dist)*2
	zoom = fovToZoom(fov)
	
	output.setNumber(1, zoom)
end