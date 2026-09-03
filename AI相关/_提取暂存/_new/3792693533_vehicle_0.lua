-- source: steam id 3792693533 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792693533
function onTick()
	rotation = -(input.getNumber(1))
	rot = (rotation-0.25)*2*math.pi
	r=25
	x1,y1=64/2+r*math.cos(rot+0.282743339),64/2-1+r*math.sin(rot+0.282743339)
	x2,y2=64/2+r*math.cos(rot-0.282743339),64/2-1+r*math.sin(rot-0.282743339)
end

function xPoly(x,y,r,s) --x,y center, radius, sides
 for i=1,s,1 do
  local t,R=2*math.pi,r+575
  local x1,y1,
  x2,y2,
  x3,y3=R*math.cos(i/s*t)+x,R*math.sin(i/s*t)+y,
  r*math.cos((i-.5)/s*t)+x,r*math.sin((i-.5)/s*t)+y,
  r*math.cos((i+.5)/s*t)+x,r*math.sin((i+.5)/s*t)+y
  screen.drawTriangleF(x1,y1,x2,y2,x3,y3)
  x1,y1,
  x2,y2,
  x3,y3=r*math.cos((i+.5)/s*t)+x,r*math.sin((i+.5)/s*t)+y,
  R*math.cos(i/s*t)+x,R*math.sin(i/s*t)+y,
  R*math.cos((i+1)/s*t)+x,R*math.sin((i+1)/s*t)+y
  screen.drawTriangleF(x1,y1,x2,y2,x3,y3)
 end
end

function notches(notchL,notchD) --r*math.cos(rot) r*math.sin(rot)
	for i = 360,0,-notchD do screen.drawLine(w/2+32*math.cos(math.rad(i)),w/2-1+32*math.sin(math.rad(i)),w/2+(32-notchL)*math.cos(math.rad(i)),w/2-1+(32-notchL)*math.sin(math.rad(i)))
	end
end



function onDraw()
	w = 64
	h = 64	
	screen.setColor(150, 145, 90, 255)
	screen.drawClear()
	screen.setColor(0, 0, 0, 255)
	notches(4,10)
	notches(7,45)
	screen.drawLine(w/2, h/2-1, x1,y1)
	screen.drawLine(w/2, h/2-1, x2,y2)
		
	screen.drawCircle(w/2,h/2-1,1)
	
	screen.drawLine(w/2-4, h/2-1-7,w/2-4,h/2-1-7+14)
	screen.drawLine(w/2+4, h/2-1-7,w/2+4,h/2-1-7+14)	
	
	screen.drawLine(w/2-4, h/2-1-7,w/2+1, h/2-1-7-8)
	screen.drawLine(w/2+4, h/2-1-7,w/2, h/2-1-7-8+1.5)	
	
	screen.drawLine(w/2+4,h/2-1-7+14,w/2+4-2,h/2-1-7+14+2)
	screen.drawLine(w/2-4,h/2-1-7+14,w/2-4+2,h/2-1-7+14+2)
	
	screen.drawLine(w/2+4-2,h/2-1-7+14+2,w/2-4+2-1,h/2-1-7+14+2)	
			
	screen.setColor(6, 6, 6, 255)	
	xPoly(h/2,w/2,30,32)
	screen.setColor(4.5, 4.5, 4.5, 255)	
	xPoly(h/2,w/2,30.5,32)
	screen.setColor(3, 3, 3, 255)	
	xPoly(h/2,w/2,31,32)
	screen.setColor(1.5, 1.5, 1.5, 255)	
	xPoly(h/2,w/2,31.5,32)
	screen.setColor(3.4, 4, 5, 255)
	xPoly(h/2,w/2,32,32)
end