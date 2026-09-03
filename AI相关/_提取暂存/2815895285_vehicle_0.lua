-- source: steam id 2815895285 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2815895285
w=96
h=96
col=0
step=0.5/w
resolution=1
resStrArray={"f","h","t","q"}
resIntArray={0,2,-9,-16}
n=0
min=0
max=0
array = {}
for i = 0,(3*(h-1)/4)+1 do
	array[i] = {}
	for j = 0,w-1 do
		array[i][j] = -1
	end
end
isButPressed = false
wait = true
isResPressed = false
isColPressed = false
function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	button = isPressed and isPointInRectangle(inputX, inputY, 66,3*h/4+1,21,7)
	resButton = isPressed and isPointInRectangle(inputX, inputY, 58,3*h/4+1,6,7)
	colButton = isPressed and isPointInRectangle(inputX, inputY, 50,3*h/4+1,6,7)
	value = input.getBool(3)
	distance = input.getNumber(7)
	near = input.getNumber(8)
	far = input.getNumber(9)
	distChk = false
	if isPressed and inputY < (3*(h-1)/4)+1 then
		distChk = true
	end
	if button == true then
		for i = 0,(3*(h-1)/4)+1 do
			for j = 0,w-1 do
				array[i][j] = -1
			end
		end
		isButPressed = true
		n = 0
		output.setBool(1, true)
	end
	if isResPressed == false and resButton == true and isButPressed == false then
		resolution = (resolution%4)+1
		isResPressed = true
	end
	if isResPressed == true and isPressed == false then
		isResPressed = false
	end
	if isColPressed == false and colButton == true then
		col = (col+1)%2
		isColPressed = true
	end
	if isColPressed == true and colButton == false then
		isColPressed = false
	end
	if value == true and isButPressed == true then
		output.setNumber(1,n%w*step-w/2*step)
		output.setNumber(2,n/h*resolution*step-w/2*step)
		if n > resolution*6-1 then
			for i = 0,resolution-1 do
				for j = 0,resolution-1 do
					array[math.floor((n-6*resolution)/w)*resolution+i][math.floor((n-6*resolution)%w)+j]=distance
				end
			end
		end
		n = n+resolution
		if n>(((3*(h-1)/4)+1)*96)/resolution-resIntArray[resolution] then
			isButPressed = false
			output.setNumber(1, 0)
			output.setNumber(2, 0)
			output.setBool(1, false)
		end
		min = 5000
		max = 0
		for i = 0,(3*(h-1)/4)+1 do
			for j = 0,w-1 do
				if array[i][j] < min and array[i][j] >= 0 then
					min=array[i][j]
				end
				if array[i][j] > max then
					max=array[i][j]
				end
			end
		end
	end	
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function white()
	screen.setColor(255,255,255)
end

function onDraw()					
	for i = 0,(3*(h-1)/4)+1 do
	for j=0,w-1 do
	z=array[i][j]-near
	range=far-near
	rat=z/range
	if col==1 then
	if rat<0.0 then
		r=255
		g=0
		b=0
		elseif rat<0.25 then
		r=255
		g=rat*4*255
		b=0
		elseif rat<0.75 then
		r=(1-((rat-0.25)*4))*255
				if r<0.0 then
					r=0
				end
				g=255
				b=(rat-0.5)*4*255
				if b<0 then
					b=0
				end
			elseif rat<=1 then
				r=0
				g=(1-((rat-0.75)*4))*255
				b=255
			else
				r,g=0,0
				b=255
			end
			else
			u=math.min(rat*255,255)
			u=math.max(u,0)
			r,g,b=u,u,u
			end
			if array[i][j]<0 then
				r,g,b=0
			end
			screen.setColor(r,g,b)
			screen.drawRectF(j,i,1,1)
		end
	end
	screen.setColor(10,10,10)
	screen.drawRectF(0,3*h/4,w,h)
	white()
	screen.drawText(0,h-12,"Near:")
	screen.drawText(0,h-6,math.floor(min))
	screen.drawText(32,h-12,"Far:")
	screen.drawText(32,h-6,math.floor(max))
	screen.setColor(20,20,20)
	screen.drawRectF(50,3*h/4+1,6,7)
	white()
	screen.drawText(51,3*h/4+2,"C")
	screen.setColor(32,0,0)
	screen.drawRectF(58,3*h/4+1,6,7)
	white()
	screen.drawText(59,3*h/4+2,resStrArray[resolution])
	screen.setColor(20,20,20)
	screen.drawRectF(66,3*h/4+1,21,7)
	if col==1 then
	white()
	else
	screen.setColor(0,255,0)
	end
	screen.drawText(67,3*h/4+2,"scan")
	if distChk == true then
		screen.drawRectF(inputX,inputY,1,1)
		if inputX < 48 then
			screen.drawText(inputX+2,inputY,math.floor(array[math.floor(inputY)][math.floor(inputX)]))
		else
			o = string.len(tostring(math.floor(array[math.floor(inputY)][math.floor(inputX)])))
			screen.drawText(inputX-o*5,inputY,math.floor(array[math.floor(inputY)][math.floor(inputX)]))
		end
	end
end