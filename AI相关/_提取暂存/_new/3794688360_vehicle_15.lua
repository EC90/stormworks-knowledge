-- source: steam id 3794688360 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794688360
shortRangeTrack = false
horizSensitivity = property.getNumber("Horizontal Sensitivity")
vertSensitivity = property.getNumber("Vertical Sensitivity")
verticalTrim = property.getNumber("Vertical Trim")
horizontalTrim = property.getNumber("Horizontal Trim")
yToXRatio = 1
xAvg = 0
yAvg = 0
prevDetected = false

function onTick()
    distance = input.getNumber(1)
    xValue = input.getNumber(2)
    yValue = input.getNumber(3)
    detected = input.getBool(1)

    if detected then
        if not prevDetected then
            xAvg = xValue
            yAvg = yValue
        else
            xAvg = xAvg*0.3 + xValue*0.6
            yAvg = yAvg*0.3 + yValue*0.6
        end
    else
        xAvg = 0
        yAvg = 0
    end

    if detected and distance > 1333 then
        output.setNumber(1,xValue*horizSensitivity)
        output.setNumber(2,yValue*vertSensitivity)
    else
        output.setNumber(1,0)
        output.setNumber(2,0)
    end

    prevDetected = detected
end