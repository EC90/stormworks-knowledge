-- source: steam id 2841993101 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2841993101
b=property;c=screen;
--yyy--
a=0;e,f=32,32;h=b.getNumber("movement per tick")i,j,k=b.getNumber("R"),b.getNumber("G"),b.getNumber("B")g=b.getNumber("fade length")function onTick()if a-g<f then a=a+h else a=0 end end;function onDraw()e,f=c.getWidth(),c.getHeight()for d=1,g,0.5 do c.setColor(i,j,k,50/d)c.drawLine(0,a-d,e,a-d)end end