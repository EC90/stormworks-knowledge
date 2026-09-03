-- source: steam id 2913735149 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2913735149
local pi2 = math.pi*2
function onTick()
    radar_distance = input.getNumber(1)
    radar_azimuth = input.getNumber(2)*pi2
    radar_elevation = input.getNumber(3)*pi2

    target_local_x = math.sin(radar_azimuth)*radar_distance*math.cos(radar_elevation)
    target_local_y = math.cos(radar_azimuth)*radar_distance*math.cos(radar_elevation)
    target_local_z = radar_distance*math.sin(radar_elevation)

    output.setNumber(1,target_local_x)
    output.setNumber(2,target_local_y)
    output.setNumber(3,target_local_z)
end
