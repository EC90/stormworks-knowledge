-- source: steam id 3788743617 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
tick = 0

function onTick()
    tick = tick + .333

    local level = math.max(0, math.min(1, input.getNumber(1)))
    local pos = level * 8

    local bars = math.floor(pos)
    local frac = pos - bars

    local mask = 0

    if level >= 1 then
        mask = 255

    elseif level > 0 then
        -- Show the next bar
        mask = (1 << (bars + 1)) - 1

        -- Blink it during the first half of the segment
        if frac < 0.5 and (math.floor(tick / 15) % 2 == 0) then
            mask = (1 << bars) - 1
        end
    end

    output.setNumber(1, mask)
end