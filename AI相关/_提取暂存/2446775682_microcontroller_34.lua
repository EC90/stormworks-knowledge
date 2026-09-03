-- source: steam id 2446775682 / microcontroller.xml block#34
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()


	wptbutton2 = input.getBool(1)
	page = input.getNumber(31)
	osb = input.getNumber(32)
	compsy = input.getNumber(4)
	compsx = input.getNumber(5)
	comps = input.getNumber(3)
	
	targetx = input.getNumber(6)
	targety = input.getNumber(7)
	targetdist = input.getNumber(8)
	targethdg = input.getNumber(9)
	tgty = input.getNumber(10)
	tgtx = input.getNumber(11)
	
	vis = input.getNumber(12)
	rain = input.getNumber(13)
	temp = input.getNumber(14)
	
	batt = input.getNumber(15)
	drain = input.getNumber(16)
	clock = input.getNumber(17)
	timer = input.getNumber(18)

	
	if page==3 and osb==1 then wptbutton=true else wptbutton=false end
	if page==9 then
	if osb==1 then setx=true else setx=false end
	if osb==2 then sety=true else sety=false end
	end
	if page==24 then
	if osb==2 then tmr1=true else tmr1=false end
	if osb==3 then rst1=true else rst1=false end
	end
	

output.setBool(1, wptbutton)
output.setBool(4, setx)
output.setBool(5, sety)
output.setBool(6, tmr1)
output.setBool(7, rst1)
drwc=screen.drawCircle
sin=math.sin
cos=math.cos
m=math
s=screen
sC=s.setColor
dTF=s.drawTriangleF
function drawRing(cx,cy,r)
for i=0,15 do
local p=m.pi*2/16
sC(0,0,0)x=r*cos(p*i)y=r*sin(p*i)x2=r*cos(p*(i+1))y2=r*sin(p*(i+1))x3=100*cos(p*(i+1))y3=100*sin(p*(i+1))dTF(cx+x,cy+y,cx+x2,cy+y2,cx+x3,cy+y3)x=100*cos(p*i)y=100*sin(p*i)x2=100*cos(p*(i+1))y2=100*sin(p*(i+1))x3=r*cos(p*(i))y3=r*sin(p*(i))dTF(cx+x,cy+y,cx+x2,cy+y2,cx+x3,cy+y3)
end



end



end
function onDraw()
if page==3 then
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, 0, 70, 70)
	screen.setColor(255, 255, 0)
	screen.drawTriangleF(32, 26, 32, 38, compsx, compsy)
	screen.drawTriangleF(26, 32, 38, 32, compsx, compsy)
	screen.setColor(0, 0, 0)
	screen.drawCircleF(32, 32, 17)

	if wptbutton2==true then
	screen.setColor(255, 0, 255)
	screen.drawLine(32, 32, tgtx, tgty)
	end


	screen.setColor(200, 200, 200)
	screen.drawCircleF(25, 32, 1)
	screen.drawCircleF(39, 32, 1)
	screen.drawCircleF(18, 32, 1)
	screen.drawCircleF(46, 32, 1)
	screen.setColor(80, 40, 20)
	screen.drawLine(32, 30, 32, 37)
	screen.drawLine(30, 32, 35, 32)
	drawRing(32,33,20)
	screen.setColor(200, 200, 200)
	screen.drawCircle(32, 32, 20)
	screen.drawTextBox(0, 5, 64, 5,(string.format("%0.0f", comps)) , 0, 0)
	screen.drawText(5, 10, "wpt")
	screen.drawText(25, 55, "mnu")
	
	if wptbutton2==true then
	screen.setColor(255, 0, 255)
	screen.drawTextBox(0, 5, 60, 5, (string.format("%0.0f", targethdg)), 1, 0)
	screen.drawTextBox(0, 50, 60, 5, (string.format("%0.1f", targetdist/1000)), 1, 0)
	end
	end

if page==9 then
screen.setColor(0, 255, 0)
screen.drawTextBox(0, 4, 64, 5,"wpt" , 0, 0)
screen.drawText(5, 10, "x:"..(string.format("%0.0f", targetx)))
screen.drawText(5, 20, "y:"..(string.format("%0.0f", targety)))
screen.drawTextBox(0, 30, 64, 5,"acft" , 0, 0)
screen.drawText(25, 55, "mnu")
end
if page==5 then
screen.setColor(0, 255, 0)
screen.drawTextBox(0, 4, 64, 5,"wthr" , 0, 0)
screen.drawText(5, 10, "vis:"..(string.format("%0.1f", vis)))
screen.drawText(5, 20, "rn:"..(string.format("%0.0f", rain)).."%")
screen.drawText(5, 30, "tmp:"..(string.format("%0.1f", temp)))
screen.drawText(25, 55, "mnu")
end
if page==22 then 
screen.setColor(0, 255, 0)
screen.drawTextBox(0, 4, 64, 5,"elec" , 0, 0)
screen.drawText(5, 10, "batt:"..(string.format("%0.1f", batt)).."%")
if drain<0 then
screen.drawText(5, 20, "draining:")
else
screen.drawText(5, 20, "charging:")
end
screen.drawText(5, 30, (string.format("%0.2f", math.abs(drain))).."A")
screen.drawText(25, 55, "mnu")
end
if page==24 then 
screen.setColor(0, 255, 0)
screen.drawTextBox(0, 4, 64, 5,"chrono" , 0, 0)
screen.drawText(5, 10, (string.format("%0.0f", math.floor(clock)))..":"..string.format("%02d", math.floor((clock-math.floor(clock))*60)))
screen.drawText(5, 20, (string.format("%0.3d", math.floor(timer)))..":"..string.format("%02d", math.floor((timer-math.floor(timer))*60)))
screen.drawText(5, 30, "reset")
screen.drawText(25, 55, "mnu")
end

end