-- source: steam id 3603910667 / vehicle.xml block#37
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
function onTick()

	h1 = input.getBool(1)
	h2 = input.getBool(2)
	h3 = input.getBool(3)
	h4 = input.getBool(4)
	h5 = input.getBool(5)
	h6 = input.getBool(6)
	h7 = input.getBool(7)
	h8 = input.getBool(8)

	r = input.getNumber(30)
	g = input.getNumber(31)
	b = input.getNumber(32)
	
	br = input.getNumber(27)
	bg = input.getNumber(28)
	bb = input.getNumber(29)
end

function onDraw()

	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(r, g, b)

if h1 then
		screen.drawTextBox(1,38,64, 7," north eastern", 0, 0)
end

if h2 then
		screen.drawTextBox(1, 38,64, 7, "eastern", 0, 0)
end

if h3 then
		screen.drawTextBox(1,38,64, 7," south eastern", 0, 0)
end

if h4 then
		screen.drawTextBox(1, 38,64, 7, "southen", 0, 0)
end

if h5 then
		screen.drawTextBox(1,38,64, 7," south western", 0, 0)
end

if h6 then
		screen.drawTextBox(1, 38,64, 7, "western", 0, 0)
end

if h7 then
		screen.drawTextBox(1,38,64, 7," north western", 0, 0)
end

if h8 then
		screen.drawTextBox(1,38,64, 7,"northern", 0, 0)
end

end	
		