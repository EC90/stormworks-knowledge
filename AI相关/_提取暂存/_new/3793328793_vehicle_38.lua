-- source: steam id 3793328793 / vehicle.xml block#38
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793328793
avgPeriod = 0.2
avgA = {}
avg = 0

function onTick()
    inputNumber = input.getNumber(2)
    --Check that time isnt 0
    if (avgPeriod > 0) then
        table.insert(avgA, inputNumber)

        --Collect 60 samples per second
        if (#avgA > (avgPeriod * 60)) then
            table.remove(avgA, 1)
        end

        --Average Samples
        tempTot = 0
        for k, v in pairs(avgA) do
            tempTot = tempTot + v
        end
        avg = tempTot / #avgA
    end
    output.setNumber(3, avg)
end

--Over Time Average
-- By Multiversal USB on Steam/Unimposed on Youtube