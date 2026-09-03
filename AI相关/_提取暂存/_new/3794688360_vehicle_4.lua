-- source: steam id 3794688360 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794688360
function onTick()
    for i = 1, 14 do
        a = input.getNumber(i)
        b = input.getNumber(i+14)
        if a > 1000000 then
            output.setNumber(i+2,a)
        else
            output.setNumber(i+2,b)
        end
    end

    hardpointSelection = input.getNumber(32)
    a = input.getNumber(hardpointSelection)
    b = input.getNumber(hardpointSelection+14)
    if a > 1000000 then
        output.setNumber(32,a)
    else
        output.setNumber(32,b)
    end

    weaponSelected = input.getNumber(31)
    a = input.getNumber(weaponSelected)
    b = input.getNumber(weaponSelected+14)
    if a > 1000000 then
        output.setNumber(31,a)
    else
        output.setNumber(31,b)
    end
end
