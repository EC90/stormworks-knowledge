-- source: steam id 2372828168 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2372828168
function onTick()
  scale = math.max(0.1, input.getNumber(1))
  inputX = input.getNumber(3)
  inputY = input.getNumber(4)
  click = input.getBool(1) and not isPressed
  isPressed = input.getBool(1)
      
      -- Check if the player is pressing the rectangle at (10, 10) with width and height of 20px
  if click then
    if isPointInRectangle(inputX, inputY, 1, 32, 16, 7) then
      cam = not cam
    elseif isPointInRectangle(inputX, inputY, 47,32,16,7) then
    	ifr = not ifr
    end
  end
      
  output.setBool(1, cam)
  output.setBool(2, ifr)
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
  return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
   screen.setColor(200,200,200)
   screen.drawText(48,33, "IFR")
   if ifr then
   screen.setColor(200,200,200)
   screen.drawRectF(47,32,16,7)
   screen.setColor(0,0,0)
   screen.drawText(48,33, "IFR")
   end

   screen.setColor(200,200,200)
   screen.drawText(2,33, "CAM")
	if cam then
   screen.setColor(200,200,200)
   screen.drawRectF(1,32,16,7)
   screen.setColor(0,0,0)
   screen.drawText(2,33, "CAM")
	end

end