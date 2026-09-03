-- source: steam id 2983982391 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2983982391
-- LASER DISTANCE CAMERA Script by KwentiN
-- You may use and or modify this script to your needs

-- Use this to set the color of the output {R,G,B}
c_scale = {0.2,1,0.2}

X_max, Y_max = 1,1
xres,yres = 15,15
xstep,ystep = X_max/xres,Y_max/yres
X_out = -X_max
Y_out = -Y_max

w,h = 64,64

min_v,max_v = 0,0

m,n = 1,1

lastpressed = false

data = {}
for i=1,yres do
	data[i]={}
	for j=1,xres do
		data[i][j] = 0
	end
end

running = true

function onTick()
	isPressed = input.getBool(1)
	inputX = input.getNumber(3)
    inputY = input.getNumber(4)
	
    dst = input.getNumber(32)



    
    if running then
    max_v = find_max(data)
    min_v = findSmallest(data)
    
    	X_out = X_out + 2*xstep
    		if n>xres then
    		X_out = -X_max
    		n = 0
    		Y_out = Y_out + 2*ystep
    		m = m + 1
    		if m>yres-1 then
    			running = false
    			end
    		end
    	data[m][n] = dst
    	n = n + 1
    end

	-- Touch Eingaben testen
	if button_pressed(w-7, h*0.1, 7, 6) then -- + Zoom
		X_max = X_max*0.5
		Y_max = Y_max*0.5
		reset_img()
	end
	
	if button_pressed(w-7, h*0.1+9, 7, 6) then -- - Zoom
		X_max = X_max*(1/0.5)
		Y_max = Y_max*(1/0.5)
		reset_img()
	end
	
	if button_pressed(w*0.8-7.5,h-9,15,7) then -- HD
		xres,yres = w,h	
		running=true
		reset_img()
	end
	
	if button_pressed(w/2-15/2, h-9, 15, 7) then -- MD
		xres,yres = w*0.6,h*0.6	
		running=true
		reset_img()
	end

	if button_pressed(w*0.2-7.5,h-9,15,7) then -- LD
		xres,yres = w*0.3,h*0.3	
		running=true
		reset_img()
	end
    
    output.setNumber(1,X_out)
    output.setNumber(2,Y_out)
    output.setBool(1,running)
    output.setNumber(3,m)
    output.setNumber(4,n)
    
    if not isPressed then
    	lastpressed = false
    end
end

function onDraw()
	w,h = screen.getWidth(),screen.getHeight()
	for m,v in ipairs(data) do
		for n,dis in ipairs(data[m]) do
			scaled = skalieren(dis, min_v, max_v)
			screen.setColor(c_scale[1]*255*scaled,c_scale[2]*255*scaled,c_scale[3]*255*scaled)
			screen.drawRectF(h/2-yres/2+n-1,w/2-xres/2+m-1,1,1)
		end
	end

	-- Knpfe
	setC(0,0,0)
	screen.drawRectF(w*0.8-7.5,h-9,15,7)
	setC(96,96,96,50)
	screen.drawRectF(w*0.8-7.5,h-9,15,7)
	setC(0,0,0)
	screen.drawTextBox(w*0.8-7.5,h-9,15,7, "L", 0, 0)
	
	setC(0,0,0)
	screen.drawRectF(w/2-15/2, h-9, 15, 7)
	setC(96,96,96,50)
	screen.drawRectF(w/2-15/2, h-9, 15, 7)
	setC(0,0,0)
	screen.drawTextBox(w/2-15/2, h-9, 15, 7, "M", 0, 0)
	
	setC(0,0,0)
	screen.drawRectF(w*0.2-7.5,h-9,15,7)
	setC(96,96,96,50)
	screen.drawRectF(w*0.2-7.5,h-9,15,7)
	setC(0,0,0)
	screen.drawTextBox(w*0.2-7.5,h-9,15,7, "S", 0, 0)
	
	setC(96,96,96,50)
	screen.drawRectF(w-7, h*0.1, 7, 6)
	setC(0,0,0)
	screen.drawTextBox(w-7, h*0.1, 7, 6, "+", 0, 0)

	setC(96,96,96,50)
	screen.drawRectF(w-7, h*0.1+9, 7, 6)
	setC(0,0,0)
	screen.drawTextBox(w-7, h*0.1+9, 7, 6, "-", 0, 0)
	
	setC(255,255,255)

end

function find_max(matrix)
	max_m = {}
	for i,v in ipairs(matrix) do
		table.insert(max_m,math.max(table.unpack(v)))
	end
	return math.max(table.unpack(max_m))
end

function findSmallest(matrix)
  local smallest = math.huge
  for i = 1, #matrix do
    for j = 1, #matrix[i] do
      local element = matrix[i][j]
      if element ~= 0 and element < smallest then
        smallest = element
      end
    end
  end
  return smallest
end


function setC(r,g,b,a)
if a==nil then a=255 end
screen.setColor(r,g,b,a)
end

function button_pressed(x,y,w,h)
	
	if isPressed and not lastpressed and inputX >= x and inputX <= x+w and inputY >= y and inputY <= y+h then
		lastpressed = true
		return true
	else
		return false
	end
end

function reset_img()
	X_out,Y_out = -X_max,-Y_max
	xstep,ystep = X_max/xres,Y_max/yres
	m,n = 1,1
	data = {}
	for i=1,yres do
		data[i]={}
		for j=1,xres do
			data[i][j] = 0
		end
	end
end

function skalieren(wert,minimum,maximum)
	return (wert-minimum)/(maximum-minimum)
end