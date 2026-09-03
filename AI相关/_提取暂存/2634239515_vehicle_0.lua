-- source: steam id 2634239515 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2634239515
function onTick()
--Getting inputs
x = input.getNumber(9) --Look X
y = input.getNumber(10) --Look Y
modx = input.getNumber(11) --Modifier X
mody = input.getNumber(12) --Modifier Y
off = input.getNumber(13) --Vertical Offset

XModifier2 = x*modx
YModifier2 = -y*mody+-off
--Not rounded, makes for smoother movement but bad for the actual post, i use this only for my circles in my gunsight

XModifier = math.floor((x*modx)+0.5)
YModifier = math.floor((-y*mody)+0.5+-off)
--Rounded down movement, i use this for the actual posts and straight lines in my gunsight, use this for what you use to aim with

end

function onDraw() --Drawing of gunsight stuff
w=32

screen.setColor(200, 175, 25, 200)

--Essentially X coordinate of what you want to draw + Xmodifier, and same for Y modifier

screen.drawLine(w/2+XModifier, w/2+2+YModifier, w/2+XModifier, w/2+15+YModifier) --Rounded down movement for my posts
screen.drawLine(w/2+XModifier, w/2-2+YModifier, w/2+XModifier, w/2-15+YModifier)

screen.drawLine(w/2+2+XModifier, w/2+YModifier, w/2+15+XModifier, w/2+YModifier)
screen.drawLine(w/2-2+XModifier, w/2+YModifier, w/2-15+XModifier, w/2+YModifier)

screen.drawCircle(w/2+XModifier2, w/2+YModifier2, 11) --Smoother movement for the circles
screen.drawCircle(w/2+XModifier2, w/2+YModifier2, 6)

end