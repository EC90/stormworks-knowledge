-- source: steam id 3788743617 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
-- Individual silence states
fuelSilenced = false
tempSilenced = false

-- Previous button state
lastButton = false

function onTick()

    -- Inputs
    lowFuel = input.getBool(1)
    highTemp = input.getBool(2)
    silenceButton = input.getBool(3)

    -- Detect button press
    buttonPressed = silenceButton and not lastButton

    -- Silence currently active warnings
    if buttonPressed then

        if lowFuel then
            fuelSilenced = true
        end

        if highTemp then
            tempSilenced = true
        end

    end

    lastButton = silenceButton

    -- Reset each warning's silence when that warning disappears
    if not lowFuel then
        fuelSilenced = false
    end

    if not highTemp then
        tempSilenced = false
    end

    -- Individual alarm outputs
    fuelAlarm = lowFuel and not fuelSilenced
    tempAlarm = highTemp and not tempSilenced

    -- Buzzer sounds if ANY unsilenced warning is active
    buzzer = fuelAlarm or tempAlarm

    -- Buzzer output
    output.setBool(1, buzzer)

end