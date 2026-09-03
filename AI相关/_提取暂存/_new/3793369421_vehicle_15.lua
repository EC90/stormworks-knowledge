-- source: steam id 3793369421 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793369421
-- Function called every tick
function onTick()
    -- Read touch data (X and Y coordinates of touch)
    inputX = input.getNumber(3)
    inputY = input.getNumber(4)
    isPressed = input.getBool(1)  -- Detect if the screen is being touched

    -- Check if the touch is in the top half (Y < 16) or bottom half (Y >= 16)
    isTouchingTopHalf = isPressed and inputY < 16
    isTouchingBottomHalf = isPressed and inputY >= 16

    -- Set outputs based on which half of the screen is being touched
    output.setBool(1, isTouchingTopHalf)  -- Output 1 for top half
    output.setBool(2, isTouchingBottomHalf)  -- Output 2 for bottom half
end

-- Function called to draw on the HUD
function onDraw()
    -- Draw a visual indicator for the top and bottom halves
    screen.setColor(50, 255, 50)
    if inputY < 16 then
        screen.drawRectF(0, 0, screen.getWidth(), screen.getHeight() / 2)  -- Top half filled
    else
        screen.drawRectF(0, screen.getHeight() / 2, screen.getWidth(), screen.getHeight() / 2)  -- Bottom half filled
    end

    -- Draw some text to show which part of the screen is being pressed
    screen.setColor(255, 255, 255)
    screen.drawText(10, 10, "Touch Y: " .. string.format("%.1f", inputY))  -- Show touch Y-coordinate
    screen.drawText(10, 30, "Top = Output 1")
    screen.drawText(10, 50, "Bottom = Output 2")
end