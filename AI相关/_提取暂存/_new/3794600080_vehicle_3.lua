-- source: steam id 3794600080 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080
pi = math.pi
pi2 = pi*2
function pulse(c,b)if not a then a={}a[b]={pulse=false,touch=false}elseif not a[b]then a[b]={pulse=false,touch=false}end;a[b].pulse=c~=a[b].touch and c;a[b].touch=c;return a[b].pulse end
function abs(val)
	if val < 0 then
		val = val * -1
	else
		val = val
	end
	return val
end
function back(r)
		screen.setColor(0,0,0,25)
		screen.drawCircleF(cX,cY+1,r)
		screen.setColor(100,110,120,25)
		screen.drawCircleF(cX,cY,r)
end
function protract(x,y)
	for i = 0,330,30 do
    	screen.drawLine(math.cos(i/180*pi)*25+x,math.sin(i/180*pi)*25+y,x,y)
	end		
	for i = 0,350,10 do
		screen.drawCircleF(math.cos(i/180*pi)*23+x,math.sin(i/180*pi)*23+y,1)
	end
end
function crc(x,y,r,t)
	for i = 0,359,1 do
	   screen.drawCircleF(math.cos(i/180*pi)*(r/2)+x,math.sin(i/180*pi)*(r/2)+y,0.7)
	end
	for i = 0,324,2 do
	   screen.drawCircleF(math.cos((i/180*pi)+pi)*(r/4)+x,math.sin((i/180*pi)+pi)*(r/4)+y,0.7)
	end
	screen.drawRect(x+1,y-1,-w/2,0)
	screen.drawText(3,y+4,"/2")
	screen.drawText(w/4,y+4,"/4")
	screen.drawText(x-4,3+y-(w/2),t)
	screen.drawText(x-6,9+y-(w/2),"nmi")

	for i = 0,5,1 do
		screen.drawRect(0+i*w/10,cY,0,2)
	end
end
rng = {
	"01",
	"05",
	"10",
	"20"
}
toolVal = 0
function onTick()
	time = input.getNumber(1) - 0.5
	zoomVal = input.getNumber(2)
	cycle = pulse(input.getBool(1),"cycle")
	manVal = property.getNumber("Brightness")
	manBool = property.getBool("Automatic Dimming")
	offset = property.getBool("Highlight")
	
	if manBool then
		dark = (abs(time)*400)
	else
		dark = (abs(manVal)*400)
	end
	if cycle then
		toolVal = toolVal + 1
	end
	if toolVal > 2 then
		toolVal = 0
	end
end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	cX = (w/2)-0.5
	cY = (h/2)-0.5
	
	if offset then
		bloomY =	(h/2)+h*0.2
	else
		bloomY = cY
	end
	
	screen.setColor(0,0,0, dark)
	screen.drawRectF(0,0,w,h)
	
	if toolVal == 1 then
		back(25)
		screen.setColor(0,0,0,50)
		protract(cX,cY)
		screen.setColor(0,0,0,10)
		protract(cX,cY+1)
	end
	if toolVal == 2 and zoomVal > 0 then
		back(2+w/2)
		screen.setColor(0,0,0,10)
		crc(cX,cY+1,w,rng[zoomVal])
		screen.setColor(0,0,0,60)
		crc(cX,cY,w,rng[zoomVal])
	end
	
	screen.setColor(250,250,200,1)
	
	for i=1,25, 1 do
		screen.drawCircleF(w/2,bloomY,(i*(w/32))^0.94)
	end
			
end