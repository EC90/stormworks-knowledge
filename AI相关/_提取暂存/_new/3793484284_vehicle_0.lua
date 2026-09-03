-- source: steam id 3793484284 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793484284
--RX^gonTickO
 headFixX = 11
 headFixUY = -32
 headFixLY = -5
function onTick()
--hoge = IN(n)gonTick()OIN = input.getNumber (IN})
  headAngleX = input.getNumber(1) * math.pi*2
  headAngleY = input.getNumber(2) * math.pi*2
  
--onTickgl
  Red = input.getNumber(3)
  Green = input.getNumber(4)
  Blue = input.getNumber(5)
  Alpha = input.getNumber(6)

  headX = headFixX * math.sin(headAngleX)

  if headAngleY > 0 then
    headY =headFixUY * math.sin(headAngleY)
  else
    headY = headFixLY * math.sin(headAngleY)
  end
end

--onDraw()O
function onDraw()
  w = screen.getWidth()
  h = screen.getHeight()
  cw = w / 2 + headX - 1
  ch = h / 2 + headY + 1
--headXheadYG[oonTickO

  screen.setColor(Red, Green, Blue, Alpha)
  screen.drawCircle(cw, ch, 9)
  screen.drawCircle(cw, ch, 4)
  screen.drawLine(cw, ch-13, cw, ch+13)
  screen.drawLine(cw-13, ch, cw+13, ch)
  screen.drawLine(cw+4, ch+4, cw+12, ch+12)
  screen.drawLine(cw-4, ch+4, cw-12, ch+12)
end