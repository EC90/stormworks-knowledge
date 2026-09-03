-- source: steam id 3788743617 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
engine = false

function onTick()
    local starter = input.getBool(1)
    local battery = input.getNumber(1)


    if starter then
        engine = true
    end


    if battery >= 0.9 then
        engine = false
    end

    output.setBool(1, engine)
end