-- source: steam id 3788743617 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
targetHeading=0
holdActive=false
lastPress=false

leftPressed=false
rightPressed=false

currentHeading=0
depth=0

holdTicks=0

function angleDiff(target,current)
    return (target-current+540)%360-180
end

function onTick()

    currentHeading=input.getNumber(1)
    depth=input.getNumber(2)

    tx=input.getNumber(3)
    ty=input.getNumber(4)

    pressed=input.getBool(1)

    leftPressed=false
    rightPressed=false

    if pressed then

        if tx>=0 and tx<=6 and ty<=8 then

            leftPressed=true

            if not lastPress then
                targetHeading=(targetHeading-1)%360
                holdTicks=0
            else
                holdTicks=holdTicks+1

                if holdTicks>20 and holdTicks%6==0 then
                    targetHeading=(targetHeading-1)%360
                end
            end

        elseif tx>=25 and tx<=31 and ty<=8 then

            rightPressed=true

            if not lastPress then
                targetHeading=(targetHeading+1)%360
                holdTicks=0
            else
                holdTicks=holdTicks+1

                if holdTicks>20 and holdTicks%6==0 then
                    targetHeading=(targetHeading+1)%360
                end
            end

        elseif tx>=7 and tx<=24 and ty<=8 then

            if not lastPress then

                holdActive=not holdActive

                if holdActive then
                    targetHeading=currentHeading
                end

            end

            holdTicks=0

        else
            holdTicks=0
        end

    else
        holdTicks=0
    end

    lastPress=pressed

   local steering=0

if holdActive then

    local error = angleDiff(targetHeading,currentHeading)
    local derivative = error - lastError

    steering =
        error * 0.03 +
        derivative * 0.15

    lastError = error

    if steering > 1 then
        steering = 1
    elseif steering < -1 then
        steering = -1
    end

else
    lastError = 0
end

    output.setNumber(1,steering)
    output.setBool(1,holdActive)

end

function drawDisplay(x,y,w,h)

    screen.setColor(5,5,5)
    screen.drawRectF(x,y,w,h)

    screen.setColor(0,0,0)
    screen.drawRectF(x+1,y+1,w-2,h-2)

end

function drawButton(x,y,w,h,r,g,b)

    screen.setColor(5,5,5)
    screen.drawRectF(x,y,w,h)

    screen.setColor(r,g,b)
    screen.drawRectF(x+1,y+1,w-2,h-2)

end

function centerText(text,y)

    local x=(32-(#text*5))/2

    screen.drawText(x,y,text)

end

function onDraw()

    screen.setColor(0,0,0)
    screen.drawClear()

    if leftPressed then
        drawButton(0,0,6,8,15,23,30)
    else
        drawButton(0,0,6,8,5,8,10)
    end

    if holdActive then
        drawButton(7,0,17,8,10,30,15)
    else
        drawButton(7,0,17,8,5,8,10)
    end

    if rightPressed then
        drawButton(25,0,6,8,15,23,30)
    else
        drawButton(25,0,6,8,5,8,10)
    end

    drawDisplay(0,10,32,9)
    drawDisplay(0,21,32,11)

    screen.setColor(100,100,100)

    screen.drawText(2,1,"<")
    screen.drawText(27,1,">")

    local targetText=string.format("%03d",math.floor(targetHeading+0.5))
    screen.drawText(9,1,targetText)

    local headingText=string.format("%03d",math.floor(currentHeading+0.5))
    centerText(headingText,12)

    local depthText=tostring(math.floor(depth+0.5))
    centerText("D:" .. math.floor(depth) .. "m", 23)

end