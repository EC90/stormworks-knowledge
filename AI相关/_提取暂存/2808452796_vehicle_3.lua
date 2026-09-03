-- source: steam id 2808452796 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2808452796
irEnabled=false
buttons={}

-- Register a button into the list of buttons:
function registerButton(key,button)
	if buttons[key]~=button then 
		buttons[key]=button
	end
end

 -- Get a button given the click coordinates:
function getButton(inputX,inputY)
	for key,button in pairs(buttons) do
		if inputX>button.X and inputY>button.Y and inputX<button.X+button.W and inputY<button.Y+button.H then
			return button
		end
	end
	return {action=function() end}
end

function drawCrossHairs()
	width=screen.getWidth()
	height=screen.getHeight()
	centerGap=5 -- Play with this number to change the center gap size.
	lineLength=screen.getWidth()/13 -- Play with this number to change the crosshair size.
	XCenter=screen.getWidth()/2
	YCenter=screen.getHeight()/2
	XOrigin=XCenter-centerGap/2-lineLength
	YOrigin=YCenter-centerGap/2-lineLength
	
	-- Set crosshair color to slightly transparent green.
	screen.setColor(50,180,100,200)
	-- Draw left crosshair
    screen.drawLine(XOrigin,YCenter,XOrigin+lineLength,YCenter)
    -- Right crosshair
    screen.drawLine(width-XOrigin,YCenter,width-XOrigin-lineLength,YCenter)
    -- Upper crosshair
    screen.drawLine(XCenter,YOrigin,XCenter,YOrigin+lineLength)
	-- Lower crosshair
    screen.drawLine(XCenter,height-YOrigin,XCenter,height-YOrigin-lineLength)
end

-- Draw the button and register it:
function drawIRButton()
	W=10
	H=5
	X=5
	Y=screen.getHeight()-H-5
    -- Register the button and set it to toggle the corresponding variable.
	registerButton("IRToggle",{X=X,Y=Y,W=W,H=H,action=function() irEnabled= not irEnabled end})
	if not irEnabled then
		-- Set button color to slightly transparent white when IR is disabled.
		screen.setColor(50,100,100,100)
	else
		-- Set button color to slightly transparent green when IR is enabled.
		screen.setColor(0,180,100,200)
	end
	screen.drawTextBox(X,Y,W,H,"IR",0,0)
	screen.drawRect(X-1,Y-2,W+1,H+3) -- Play with the "-1" and "+1" to get a nice bounding rectangle. 
	screen.setColor(100,100,100)
end

function onTick()
	inputX=input.getNumber(3)
	inputY=input.getNumber(4)
	canPress = input.getBool(1) and not inputPressed
	inputPressed = input.getBool(1)
	
    -- If the screen has been clicked, get the button for the coordinates and do the corresponding action if a button is found:
	if inputPressed and canPress then getButton(inputX,inputY).action() end
	output.setBool(10,irEnabled) -- Change the number to the channel you used.
end

function onDraw()
    drawCrossHairs()
    drawIRButton()
end