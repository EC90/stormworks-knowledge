-- source: steam id 2213181424 / vehicle.xml block#55
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
gB=input.getBool

w1u = false
w2u = false
w1d = false
w2d = false
rws = false
cws = false
pwc = false

function onTick()
l1 = input.getNumber(11)
l2 = input.getNumber(12)
act = gB(2) or input.getNumber(11)>0.2 or input.getNumber(12)>0.2

	rwu = gB(10) == not rwup
	rwd = gB(11) == not rwdp
	if gB(12) == not rwsp then
	rws = not rws
	end
	rwup = gB(10)
	rwdp = gB(11)
	rwsp = gB(12)	
	
	pwu = gB(13) and not pulsep
	pwd = gB(14) and not pulsep
	if gB(15) and not pulsep then
	pws = not pws
	end
	pulsep = gB(13) or gB(14) or gB(15)

	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = gB(1)
	
	cwu = isPressed and not lastPressed and isPointInRectangle(inputX, inputY, 16, 0, 15, 15)
	
	cwd = isPressed and not lastPressed and isPointInRectangle(inputX, inputY, 16, 16, 15, 15)
	
	if isPressed and not lastPressed and isPointInRectangle(inputX, inputY, 0, 0, 15, 15) then
	cws = not cws
	end
	
	lastPressed = isPressed

if gB(16) then
w2u = true
w1u = true
end

if ((rwu and not rws) or (pwu and not pws) or (cwu and not cws)) and not w1d then
w1u = not w1u
elseif ((rwd and not rws) or (pwd and not pws) or (cwd and not cws)) and not w1u then
w1d = not w1d
end
if l1<0.1 then
w1u = false
elseif l1>19.9 then
w1d = false
end

if ((rwu and rws) or (pwu and pws) or (cwu and cws)) and not w2d then
w2u = not w2u
elseif ((rwd and rws) or (pwd and pws) or (cwd and cws)) and not w2u then
w2d = not w2d
end

if l2<0.1 then 
w2u = false
elseif l2 >19.9 then
w2d = false
end
	output.setBool(1,w1u)
	output.setBool(2,w1d)
	output.setBool(3,w2u)
	output.setBool(4,w2d)
	output.setBool(5,pws)

end



function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
if act then
	w = screen.getWidth()			
	h = screen.getHeight()					
	screen.setColor(25, 50, 100)			
	
if isPressed and isPointInRectangle(inputX, inputY, 0, 0, 15, 15) then
screen.drawRectF(0, 0, 15, 16)
end
screen.drawRect(0, 0, 15, 15) -- winch cntrl
screen.drawText(3, 2, "<")
screen.drawText(10, 2, ">")
screen.drawLine(3, 4, 12, 4)

if cws then 
screen.drawTextBox(2, 7, 12, 7, "2", 0, 0)
else
screen.drawTextBox(0, 7, 12, 7, " 1", 0, 0)
end

screen.drawRect(0, 16, 15, 15) -- Winch lengths

screen.drawTextBox(2, 14, 7, 7, " 1", 0, 0)
screen.drawTextBox(8, 17, 7, 7, "2", 0, 0)


if l1 >19.9 then
screen.setColor(100,0,0)
else
screen.setColor(100,25,0)
end
screen.drawRectF(4, 25, 2,(l1/20)*6)

if l2 >19.9 then
screen.setColor(100,0,0)
else
screen.setColor(100,25,0)
end
screen.drawRectF(10, 25, 2,(l2/20)*6)

screen.setColor(25,50,100)
screen.drawLine(3, 24, 7, 24)
screen.drawLine(9, 24, 13, 24)
screen.drawLine(3, 30, 13, 30)


if (l1 >0.1 and not cws) or (l2 >0.25 and cws) then
screen.drawTriangleF(24, 4, 20, 13, 29, 14) 
end

if (w1u and not cws) or (w2u and cws) then --Up arrow
screen.setColor(0,100,0)
screen.drawRectF(17, 0, 15, 16)
screen.setColor(0,0,0)
screen.drawTriangleF(24, 4, 20, 13, 29, 14) 
end
screen.drawRect(16, 0, 15, 15)

screen.setColor(25,50,100)

if (l1 <19.9 and not cws) or (l2 <19.9 and cws) then
screen.drawTriangleF(24, 29, 19.5, 19, 29, 19) 
end
 
if (w1d and not cws) or (w2d and cws) then -- Down Arrow
screen.setColor(150,112,0)
screen.drawRectF(17, 17, 15, 15)
screen.setColor(0,0,0)
screen.drawTriangleF(24, 29, 19.5, 19, 29, 19)
end
screen.drawRect(16, 16, 15, 15)

end					
end