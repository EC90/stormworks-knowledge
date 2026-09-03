-- source: steam id 2213181424 / vehicle.xml block#35
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
xtable = {} --make a table for target x values
ytable = {} --make a table for target y values
button1 = {x=64-6,y=64-6,s=4}
button2 = {x=64-12,y=64-6,s=4}
maxdis=1000
function onTick()
act=input.getBool(32)
if act then
    w=input.getNumber(1)
    h=input.getNumber(2)
    pressed = input.getBool(1)
    down = input.getBool(1)
	ang = input.getNumber(27) --radar angle input in radians and moves the nedle to forward pos
	dis = (input.getNumber(28)*(h/2-1))/maxdis --radar distance input
	target = input.getBool(27) --target detected input
	disup=input.getBool(30)
	disdown=input.getBool(31)
	xt = input.getNumber(3)
    yt = input.getNumber(4)
	on = input.getBool(27)  
    button1 = {x=w-7,y=h-7,s=4}
    button2 = {x=w-13,y=h-7,s=4}  
    if isPointInRectangle(xt,yt,button1.x,button1.y,button1.s,button1.s) and pressed and h>32 or disup then maxdis=maxdis+100 else toggle1=false end
    if isPointInRectangle(xt,yt,button2.x,button2.y,button2.s,button2.s) and pressed and h>32 or disdown then maxdis=maxdis-100 else toggle1=false end
    if maxdis>5000 then maxdis=5000 end
    if maxdis<100 then maxdis=100 end
switch = pressed and isPointInRectangle(xt, yt, 47,0,16,8)
rtn = pressed and isPointInRectangle(xt, yt, 15, 59, 33, 5)
    output.setNumber(1, maxdis)
	output.setBool(9, switch)
	output.setBool(32,rtn)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
end

function onDraw()
if act then
	screen.setColor(1, 6, 2)					
	x = (h/2-1)*math.cos(ang)+w/2 --roatting line xpos
    y = (h/2-1)*math.sin(ang)+h/2 --roatting line ypos
    for a=0.03,5.1,0.03 do
        x1 = (h/2-1)*math.cos(ang-a)+w/2 --roatting line xpos
        y1 = (h/2-1)*math.sin(ang-a)+h/2 --roatting line ypos
        screen.setColor(0, 100, 0, 120-a*20)
        screen.drawLine(x1, y1, w/2, h/2)
    end
	screen.setColor(60, 0, 0)
	xtable[ang+2.57*100] = dis*math.cos(ang)+w/2 --saves the x postitions of the targetsin a table
    ytable[ang+2.57*100] = dis*math.sin(ang)+h/2 --saves the y postitions of the targetsin a table
    for i,_ in pairs(xtable) do
        if xtable[i]==32 and ytable[i]==32 then else screen.drawLine(xtable[i], ytable[i], xtable[i]+0.9, ytable[i]+0.9) end
    end
	screen.setColor(2, 20, 4)
    screen.drawLine(x, y, w/2, h/2)
    screen.drawCircle(w/2, h/2, h/2)
    screen.setColor(25, 50, 100)
	if h>32 then 
	screen.drawText(2, 1, math.floor(maxdis))
	screen.drawTextBox(button1.x+1, button1.y+1, button1.s, button1.s, "+", 0, 0)
    screen.drawTextBox(button2.x+1, button2.y+1, button2.s, button2.s, "-", 0, 0)
		
	if on then
	screen.drawRectF(47,0,17,10)
	screen.setColor(0,0,0)
	screen.drawTextBox(48,1,15,7 , "ON", 0 , 0)
	screen.setColor(25,50,100)
	else
	screen.drawTextBox(49,1, 15,7 , "OFF", 0 , 0)
	screen.drawRect(47,0,16,8)
	end
	screen.drawRectF(16,61,32,3) --rtn
	end
end
end
	
