-- source: steam id 1969765716 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
function onTick()
	-- Read the touchscreen data from the script's composite input
	inputX = input.getNumber(25)
	inputY = input.getNumber(26)
	isPressed = input.getBool(11)

	-- Check if the player is pressing the rectangle at (10, 10) with width and height of 20px
	isPR = isPressed and isPIR(inputX, inputY, 12, 12, 8, 8)
	altUnit = isPressed and isPIR(inputX, inputY, 0, 0, 32, 16) and not isPIR(inputX, inputY, 12, 12, 8, 8)
	speedUnit = isPressed and isPIR(inputX, inputY, 0, 16, 32, 16) and not isPIR(inputX, inputY, 12, 12, 8, 8)
	-- Set the composite output, on/off channel 1
	output.setBool(1, isPR)
	output.setBool(2, speedUnit)
	output.setBool(3, altUnit)
end

-- Returns true if the point (x, y) is inside the rectangle at (rectX, rectY) with width rectW and height rectH
function isPIR(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
