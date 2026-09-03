-- source: steam id 2904076080 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2904076080
--Minecraft Clock
--By Mr Lennyn

--Feel Free to copy/modify the script

S = screen
SC = S.setColor
DL = S.drawLine
DTF = S.drawTriangleF
DRF = S.drawRectF
PI = math.pi

a = PI

l_bg = 30 -- lenght of triangles background
l_sun = 9 -- distance to sun/moon

function onTick()
    a = PI*2*input.getNumber(1)+PI/2
end

function onDraw()
   
    SC(13,32,174) --day
    drawRotTriSqr(16,19,a,l_bg)
    SC(2,1,1) --night
    drawRotTriSqr(16,19,a+PI,l_bg)
    
    SC(255,255,0)
    drawSun(math.cos(a)*l_sun+16, math.sin(a)*l_sun+19)
    
    SC(36,35,62)
    drawMoon(math.cos(a+PI)*l_sun+16, math.sin(a+PI)*l_sun+19)
    
    --Clock Sprite
    for i=1,#p do SC(p[i][1],p[i][2],p[i][3],p[i][4])
		for w=5,#p[i],4 do 
			DRF(p[i][w],p[i][w+1]+0.5,p[i][w+2],p[i][w+3]) 
		end 
	end 
end

function drawRotTriSqr(x,y,a,l)
	DTF(x,y, math.cos(a-PI/2)*l+x, math.sin(a-PI/2)*l+y, math.cos(a)*l+x, math.sin(a)*l+y)
	DTF(x,y, math.cos(a+PI/2)*l+x, math.sin(a+PI/2)*l+y, math.cos(a)*l+x, math.sin(a)*l+y)
end

function drawSun(x,y)
	DRF(-4+x,-1.5+y,8,4)
	DRF(-2+x,-3.5+y,4,8)
end

function drawMoon(x,y)
	DRF(-3+x,-3.5+y,4,2)
	DRF(-1+x,-1.5+y,4,4)
	DRF(-3+x,2.5+y,4,2)
end
 p={{7,8,0,255,12,0,8,2,8,2,4,2,20,2,4,2,6,4,2,2,24,4,2,2,4,6,2,4,26,6,2,2,2,10,2,8},{1,0,0,255,0,0,12,2,20,0,12,2,0,2,8,2,24,2,8,2,0,4,6,2,26,4,6,2,0,6,4,4,28,6,4,4,0,10,2,14,30,10,2,14,0,24,4,2,28,24,4,2,0,26,6,2,26,26,6,2,0,28,8,2,24,28,8,2,0,30,12,2,20,30,12,2},{179,177,57,255,12,2,8,2,8,4,4,2,20,4,4,2,6,6,2,4,24,8,2,2,4,10,2,8,16,14,2,2,14,16,4,4,26,16,2,2,4,18,4,2,24,18,4,2,6,20,20,2,4,22,2,2,8,22,16,2,6,24,2,2,12,24,8,2},{0,0,0,113,12,4,8,2,8,6,16,2,8,8,4,2,22,8,2,2,6,10,4,6,24,10,2,6,18,14,2,2,8,16,6,2,18,16,6,2},{186,182,184,255,24,6,2,2,26,10,2,6,14,14,2,2,6,16,2,2,24,16,2,2,8,18,6,2,18,18,6,2,8,26,2,2},{3,3,0,255,26,8,2,2,28,10,2,14,2,18,2,6,4,24,2,2,26,24,2,2,6,26,2,2,24,26,2,2,8,28,4,2,20,28,4,2,12,30,8,2},{30,32,0,255,4,20,2,2,26,20,2,2,6,22,2,2,24,22,2,2,8,24,4,2,20,24,4,2,12,26,8,2},{95,27,2,255,26,22,2,2,24,24,2,2,22,26,2,2},{117,120,2,255,10,26,2,2,20,26,2,2,12,28,8,2},}