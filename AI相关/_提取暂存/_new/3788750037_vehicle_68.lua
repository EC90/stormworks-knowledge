-- source: steam id 3788750037 / vehicle.xml block#68
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
 gpsx = input.getNumber(4)
 gpsy = input.getNumber(5)
 alt = input.getNumber(6)
 bearing = input.getNumber(17)
 signalam = input.getNumber(18)
 active = input.getBool(1)
 gpsX = input.getNumber(14)
 gpsY = input.getNumber(15)
 radar = input.getBool(2)
end

function onDraw()

gps = gpsX == 0 and gpsY == 0 
signal = signalam > 0.2

w = screen.getWidth()
h = screen.getHeight()


screen.setColor(42,46,33, 225)
	screen.drawCircle(w / 2, h / 2, 2)
	
	screen.drawLine(32, 28, 32, 25)
	screen.drawLine(32, 36, 32, 39)
	
	screen.drawLine(28,32,10,32)
	screen.drawLine(36,32,54,32)


 screen.setColor(0,0,0,218)

  screen.drawRectF(42,48,21,7)	
  screen.drawRectF(42,48,21,7)	
  screen.drawRectF(42,56,21,7)
  screen.drawRectF(1,48,40,7)
  screen.drawRectF(1,55,40,7)	


 if 0 < alt and alt < 10  then size = 53
  elseif 10 < alt and alt < 100 then size = 48
  elseif 100 < alt and alt < 1000 then size = 43
 end	

 if 0 < bearing and bearing  < 10  then size2 = 53
  elseif 10 < bearing  and bearing  < 100 then size2 = 48
  elseif 100 < bearing  and bearing  < 1000 then size2 = 43
 end	

 screen.setColor(255,255,255,218)

  screen.drawText(size,49, string.format("%.0f", alt))	
  screen.drawText(size2,57, string.format("%.0f", bearing))	
   screen.drawText(58,49, "M")
   screen.drawText(58,57, "D")

   screen.drawText(2,49,"X:")
   screen.drawText(2,56,"Y:")
  screen.drawText(10,49, string.format("%.0f", gpsx))	
  screen.drawText(10,56, string.format("%.0f", gpsy))
  
 if signal == false  then
  screen.setColor(0,0,0,218)
  screen.drawRectF(11,24,46,7)
  screen.setColor(255,255,255,218)
  screen.drawText(12,25, "NO SIGNAL")
  end
  if active == false then
  screen.setColor(0,0,0,218)
  screen.drawRectF(11,34,46,7)
  screen.setColor(255,255,255,218)
  screen.drawText(12,35, "INACTIVE")
  end
  if gps then
  screen.setColor(0,0,0,218)
  screen.drawRectF(11,14,46,7)
  screen.setColor(255,255,255,218)
  screen.drawText(12,15, "NO GPS")
  end
  if radar == true then
  screen.setColor(0,0,0,218)
  screen.drawRectF(11,14,46,7)
  screen.setColor(255,255,255,218)
  screen.drawText(12,15, "ENGAGING")
  end
 end

