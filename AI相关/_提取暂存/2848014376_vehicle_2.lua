-- source: steam id 2848014376 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2848014376
function onTick()
	range = input.getNumber(1)
	dy = input.getNumber(2)
	zoom = input.getNumber(3)
    cos=math.cos
	sin=math.sin
	tan=math.tan
	pi=math.pi
    rt=pi/2+(range/3000)*0.5*pi
end

function onDraw()

	    w = screen.getWidth()				 
	    h = screen.getHeight()					
	    screen.setColor(0, 0, 0)	
	    mil=360/(135-zoom*(135-1.43))/6283.1853*w
		dy=mil*(1000*dy)/range
	    wo=w/2
	    ho=h/2		 
	    screen.drawTriangleF(wo-w/24, 0, wo,w/12,wo+w/24, 0)
	    screen.drawText(w*0.7, h/16, "pzgr39")
	    screen.drawTriangle(wo-mil*2, ho+dy+mil*4, wo,ho+dy,wo+mil*2, ho+dy+mil*4)

	    for i=0,6 do
		screen.drawCircle(cx, cy, cr)
		cx=wo+w/3*cos(rt-i*pi/12)
		cy=ho-h/3*sin(rt-i*pi/12)
	    tx=wo+(w/3+8)*cos(rt-i*pi/12)
		ty=ho-(h/3+8)*sin(rt-i*pi/12)
		cr=1
		screen.drawText(tx, ty, 5*i)
		end
		
		--left
		for i=1,3 do
		wlo=wo-mil*4*i
		screen.drawTriangle(wlo-mil, ho+dy+mil*2, wlo,ho+dy,wlo+mil, ho+dy+mil*2)
		end
        
		--right
		for i=1,3 do
		wro=wo+mil*4*i
		screen.drawTriangle(wro-mil, ho+dy+mil*2, wro,ho+dy,wro+mil, ho+dy+mil*2)
		end
		screen.drawLine(wo, h, wo, ho+dy+mil*8)
		
	end