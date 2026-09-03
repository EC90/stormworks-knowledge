-- source: steam id 3788750037 / vehicle.xml block#28
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
GpsX=input.getNumber(6)
GpsY=input.getNumber(7)
Zoom=input.getNumber(5)
L=input.getNumber(17)
E=input.getNumber(18)
end
function onDraw()
width = screen.getWidth() --96--
height = screen.getHeight() --64--



screen.drawMap(GpsX, GpsY, Zoom)
screen.setMapColorOcean(204-L*E, 204-L*E, 198-L*E, 255)
screen.setMapColorShallows(109-L*E, 105-L*E, 158-L*E, 255)
screen.setMapColorLand(185-L*E, 183-L*E, 48-L*E, 255)
screen.setMapColorGrass(185-L*E, 183-L*E, 48-L*E, 255)
screen.setMapColorSand(185-L*E, 183-L*E, 48-L*E, 255)
screen.setMapColorSnow(185-L*E, 183-L*E, 48-L*E, 255)

screen.setColor(200-L*E, 200-L*E, 200-L*E)
screen.drawCircleF(38, 40, 2)
end
