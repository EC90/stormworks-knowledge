-- source: steam id 2156436786 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2156436786
xtable = {} --make a table for target x values
ytable = {} --make a table for target y values
button1 = {x=64-6,y=64-6,s=4}
button2 = {x=64-12,y=64-6,s=4}
maxdis=1000
function onTick()
    w=input.getNumber(1)
    h=input.getNumber(2)
    pressed = input.getBool(1) and not down
    down = input.getBool(1)
	ang = input.getNumber(27) --radar angle input in radians and moves the nedle to forward pos
	dis = (input.getNumber(28)*(h/2-1))/maxdis --radar distance input
	target = input.getBool(27) --target detected input
	disup=input.getBool(30)
	disdown=input.getBool(31)
	xt = input.getNumber(3)
    yt = input.getNumber(4)  
    button1 = {x=w-6,y=h-6,s=4}
    button2 = {x=w-12,y=h-6,s=4}  
    if isPointInRectangle(xt,yt,button1.x,button1.y,button1.s,button1.s) and pressed and h>32 or disup then maxdis=maxdis+100 else toggle1=false end
    if isPointInRectangle(xt,yt,button2.x,button2.y,button2.s,button2.s) and pressed and h>32 or disdown then maxdis=maxdis-100 else toggle1=false end
    if maxdis>3000 then maxdis=3000 end
    if maxdis<100 then maxdis=100 end
    output.setNumber(1, maxdis)
end
function onDraw()
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
    screen.setColor(100, 100, 100)
	if h>32 then 
	screen.drawText(2, h-6, math.floor(maxdis))
	screen.drawTextBox(button1.x+1, button1.y+1, button1.s, button1.s, "+", 0, 0)
    screen.drawTextBox(button2.x+1, button2.y+1, button2.s, button2.s, "-", 0, 0)
	end
end
	
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
