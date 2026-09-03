-- source: steam id 3793581819 / vehicle.xml block#55
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
-- Tick function that will be executed every logic tick
function onTick()
	value = input.getNumber(1)			 -- Read the first number from the script's composite input
	w = input.getNumber(2)
	h = input.getNumber(3)
	max = input.getNumber(4)
	onefourth = w/4 
	threefourths = onefourth*3
	onefourthH = h/4
	threefourthsH = onefourthH*3
	halfW = w/2
	sixteenW = w/16
	halfH = h/2
	thirtysecond = h/32
	sixteenH = h/16
	nam = property.getText("name")
	displayValue = input.getNumber(5)
	
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
						
	screen.setColor(100, 100, 100)			 -- Set draw color to green
	screen.drawLine(threefourths,onefourthH,threefourths,threefourthsH)
	
	screen.drawText(1,h-7,displayValue)
	screen.drawLine(threefourths,halfW,threefourths-sixteenW,halfW)
	screen.setColor(50,50,50)
	screen.drawCircleF(halfW-onefourth,halfH,sixteenH)
	screen.setColor(10,10,10)
	
	screen.drawLine(sixteenW,halfH,threefourths,onefourth)
	screen.drawLine(sixteenW,halfH,threefourths,threefourths+1)
	
	screen.setColor(255,0,0)
	screen.drawLine(halfW-onefourth,halfH,threefourths,threefourthsH-value)
	screen.drawText(1,1,nam)
end