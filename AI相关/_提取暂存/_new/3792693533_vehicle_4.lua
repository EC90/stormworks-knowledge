-- source: steam id 3792693533 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792693533
function is_even(n)
    return n % 2 == 0
end

function round_sig(x, n)
    if x == 0 then return 0 end
    local sign = x < 0 and -1 or 1
    x = math.abs(x)

    -- order of magnitude (digits before decimal)
    local d = math.floor(math.log(x) / math.log(10)) + 1
    local power = n - d
    local factor = 10 ^ power

    local rounded = math.floor(x * factor + 0.5) / factor
    return sign * rounded
end

function get_range(x)
    if x <= 0 then return nil end  -- only works for positive numbers

    -- find order of magnitude using natural log
    local exp = math.floor(math.log(x) / math.log(10))

    -- lower bound is 10^exp
    local lower = 10 ^ exp
    local upper = lower * 10

    return lower, upper
end

function drawMapScale(zoom,x,y,w,h,notDraw)

	if not notDraw then
		notDraw=false
	end
	
	local mapW0=round_sig(zoom*1000,1)/4
	local mapW=zoom*1000
	local mLW = 1
	if mapW then
		mLW = w/mapW * mapW0
	end
	
	
	local pxLW = mLW/4
	
	if not notDraw then
		screen.setColor(5,5,5)
		screen.drawText(x,y,0)
	end
	x=x+5
	local yL = 2
	if not notDraw then
		for i=1,4 do
			if is_even(i) then
				screen.setColor(5,5,5)
			else
				screen.setColor(255, 255, 150)
			end
		
			screen.drawLine(
				x+(pxLW*(i-1)),
				y+yL,
				x+(pxLW*(i-1))+pxLW,
				y+yL
			)
			screen.drawLine(
				x+(pxLW*(i-1)),
				y+yL+1,
				x+(pxLW*(i-1))+pxLW,
				y+yL+1
			)
		
			screen.drawLine(
				x+(pxLW*(i-1)),
				y+yL-1,
				x+(pxLW*(i-1))+pxLW,
				y+yL-1
			)
		
			screen.setColor(5,5,5)
			screen.drawLine(
				x+(pxLW*(i-1)),
				y+yL+2,
				x+(pxLW*(i-1))+pxLW,
				y+yL+2
			)
		
			screen.drawLine(
				x+(pxLW*(i-1)),
				y+yL-2,
				x+(pxLW*(i-1))+pxLW,
				y+yL-2
			)
		end

		screen.setColor(255, 255, 150)
		screen.drawText(x+mLW-4,y,"+")
		screen.setColor(5,5,5)
		screen.drawText(x+2,y,"-")
			screen.drawLine(
				x,
				y+yL+2,
				x,
				y+yL-2
			)
		screen.drawText(x+mLW+2,y, string.format("%.0f",mapW0))
	end
	return 5+mLW+2+((#string.format("%.0f",mapW0))*5)
end


function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onTick()	
	--disp
	w=input.getNumber(1)
	h=input.getNumber(2)
	iX = input.getNumber(3)
	iY = input.getNumber(4)
	iP = input.getBool(1)
	
	mapX=input.getNumber(13)
	mapY=input.getNumber(14)
	zoom=input.getNumber(15)
	mapZoom=zoom*0.001
	
	scaleStartX = 2
	scaleStartY = h-13
	--scaleWidth = drawMapScale(mapZoom,scaleStartX,scaleStartY,w,h,true)
	scaleWidth = .8*w/2
	
	output.setBool(2,iP and isPointInRectangle(iX,iY, scaleStartX+(scaleWidth/2)   ,scaleStartY-1, (scaleWidth/2)+1 ,7)) -- pZOUT
	output.setBool(1,iP and isPointInRectangle(iX,iY, scaleStartX-1				,scaleStartY-1, (scaleWidth/2)+1 ,7))  -- pZIN
	
	
end
	

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()					

	scaleStartX = 2
	scaleStartY = h-13
	drawMapScale(mapZoom,scaleStartX,scaleStartY,w,h)
end