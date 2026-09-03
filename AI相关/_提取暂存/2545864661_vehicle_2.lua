-- source: steam id 2545864661 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2545864661
xtable = {} --make a table for target x values
ytable = {} --make a table for target y values
button1 = {x=64-6,y=64-6,s=4}
button2 = {x=64-12,y=64-6,s=4}
maxdis=1000
ang=0
function onTick()
	pi = math.pi
    w=input.getNumber(1)
    h=input.getNumber(2)
    pressed = input.getBool(1) and not down
    down = input.getBool(1)
    if input.getBool(31)==true then zoomeg = property.getNumber("Scan Speed")/100 else zoomeg=0 end
	ang=ang+zoomeg
	if ang>2*pi then ang=0 end
	dis = (input.getNumber(28)*(h/2-1))/maxdis
	disup=input.getBool(29)
	disdown=input.getBool(30)
	xt = input.getNumber(3)
    yt = input.getNumber(4)  
    button1 = {x=w-6,y=h-6,s=4}
    button2 = {x=w-12,y=h-6,s=4}  
    if isPointInRectangle(xt,yt,button1.x,button1.y,button1.s,button1.s) and pressed and h>32 or disup then maxdis=maxdis+100 else toggle1=false end
    if isPointInRectangle(xt,yt,button2.x,button2.y,button2.s,button2.s) and pressed and h>32 or disdown then maxdis=maxdis-100 else toggle1=false end
    if maxdis>5000 then maxdis=5000 end
    if maxdis<100 then maxdis=100 end
    output.setNumber(1, (ang/(2*pi))-0.5)
    output.setNumber(2, maxdis)
end
function onDraw()
	
	screen.setColor(0, 0, 0)	
	screen.drawCircleF(w/2, h/2, h/2)
	
	x = (h/2-1)*math.cos(ang+(pi/2))+w/2 
    y = (h/2-1)*math.sin(ang+(pi/2))+h/2 
	xtable[ang*1000] = dis*math.cos(ang+(pi/2))+w/2 
    ytable[ang*1000] = dis*math.sin(ang+(pi/2))+h/2 
	for a=0,1.8*pi,0.01 do
        x1 = (h/2-1)*math.cos(ang+(pi/2)-a)+w/2 
        y1 = (h/2-1)*math.sin(ang+(pi/2)-a)+h/2 
        screen.setColor((1.8*pi-a)*10,(1.8*pi-a)*5,0)	
        screen.drawLine(x1, y1, w/2, h/2)
    end
    screen.setColor(60, 0, 0)
    for i,_ in pairs(xtable) do
        if xtable[i]==32 and ytable[i]==32 then else screen.drawLine(xtable[i], ytable[i], xtable[i]+0.9, ytable[i]+0.9) end
    end
	screen.setColor(255, 100, 0)
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
