-- source: steam id 2778980873 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2778980873
function onDraw()
w = screen.getWidth()
h = screen.getHeight()

screen.setColor(2, 2, 2, 55)
screen.drawClear()

screen.setColor(5,5,5,218)
screen.drawRectF(9,15,46,7)

screen.setColor(220, 220, 220, 240)
screen.drawTextBox(10,16,45,7,"RECV MODE")
end