-- source: steam id 2013584399 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2013584399
scSC=screen.setColor
scDT=screen.drawText
scDTB=screen.drawTextBox
scDCF=screen.drawCircleF
scDL=screen.drawLine
tabRem=table.remove
cnt=0
lastCnt=0
minTargetDist=property.getNumber("Minimum Target Distance")

function onTick()
	
	radarAct=input.getBool(10)
		
	if radarAct then
		
		radarTouchAct = input.getBool(30)
		
		
		inputX = input.getNumber(23)
		inputY = input.getNumber(24)	
		isPressed = input.getBool(21) 		
		
		if radarTouchAct then
			isRangeIn = isPressed and canPress and isPointInRectangle(inputX, inputY, 1, 1, 9, 8)
			isRangeOut = isPressed and canPress and isPointInRectangle(inputX, inputY, w-11, 2, 9, 7)		
			isPausedClick = isPressed and canPress and isPointInRectangle(inputX, inputY, 1, h-11, 9, 8)
		else
			isRangeIn, isRangeOut, isPausedClick = false
		end		
		
		if isPressed then
			canPress=false
		else
			canPress=true
		end	
		
		if not initialized then						
			targets={}
			angles={}
			sigStr={}
			tarElv={}
						
			radius= 1000
			initialized= true
		end
				
		dataPoint=input.getNumber(5)
		dataPointReset=input.getBool(8)
		rangeChange=input.getBool(31)
		range=input.getNumber(32)
		fwdSweepModeOn=input.getBool(6)
		dp360SweepSpeed=input.getNumber(6)
		dpFwdSweepSpeed=input.getNumber(7)
		minDistExclusion=input.getNumber(8)
		targetSigStr=input.getNumber(9)
		targetElevation=input.getNumber(10)
		pausedSweep=input.getBool(12)
		
		if fwdSweepModeOn then
			sweepSpeed=dpFwdSweepSpeed
			sweepStart=1*sweepSpeed
			sweepEnd=120
			
		else
			sweepSpeed=dpFwdSweepSpeed
			sweepStart=1*sweepSpeed
			sweepEnd=360
		end	
		
		if dataPointReset then					
			for ir=1,360,1 do
	   			 targets[ir]=nil
					angles[ir]=nil
					sigStr[ir]=nil
					tarElv[ir]=nil
    		end			
		end	
		
		hMode=input.getBool(2)
		heading=((1-input.getNumber(4))%1)*math.pi*2
		if hMode then brg=heading else brg=0 end
		if input.getBool(3) then direction=1 else direction= -1 end
		rot=input.getNumber(1)*math.pi*2
		if input.getBool(4) then rot=rot+heading end	
		rot=rot*direction+input.getNumber(3)/180*math.pi
		distance=input.getNumber(2)
		hit=input.getBool(5)								
								
		if hit and (distance > minTargetDist) then
			targets[dataPoint]=distance
			angles[dataPoint]=rot
			sigStr[dataPoint]=targetSigStr
			tarElv[dataPoint]=targetElevation
		else
			targets[dataPoint]=nil
			angles[dataPoint]=nil
			sigStr[dataPoint]=nil
			tarElv[dataPoint]=nil	
		end	
		
		output.setBool(1,isRangeIn)
		output.setBool(2,isRangeOut)
		output.setBool(3,isPausedClick)	
	end
end

function onDraw()
	w=screen.getWidth()				  
	h=screen.getHeight()		
	
	if radarAct then	
	
	-- Check if Range In clicked
		scSC(0,100,0,200)	
		screen.drawText(4, 3, "-")
		if isRangeIn then
			scSC(0,100,0,50)
			screen.drawRectF(1, 1, 9, 8)
		else
			screen.drawRect(1, 1, 9, 8)
		end 

	-- Check if Range Out clicked
		scSC(0,100,0,200)	
		screen.drawText(w-7, 3, "+")
		if isRangeOut then
			scSC(0,100,0,50)
			screen.drawRectF(w-11, 1, 9, 8)
		else
			screen.drawRect(w-11, 1, 9, 8)
		end 
		
	-- Check if Paused
		scSC(0,100,0,200)	
		screen.drawText(4, h-9, "P")
		if pausedSweep then
			scSC(0,100,0,50)
			screen.drawRectF(1, h-11, 9, 9)
		else
			screen.drawRect(1, h-11, 9, 9)
		end 			
		
	pivot=math.min(w,h)/2-1
	radius=pivot
	if radius>20 then radius=radius-3 end	
			
	if targets~=nill then		
		for i=sweepStart,sweepEnd,sweepSpeed do
	   	 if targets[i]~=nil and targets[i]<range then
				px,py = polar2cart(brg+angles[i],targets[i]/range*radius)		
				scSC(255,255,0,255)
				screen.drawRectF(px,py,2,2)
			end
    	end
	end
	scSC(255,255,0,255)	
	
	end	
end
	
function polar2cart(angle,length)
	return pivot+math.sin(angle)*length, pivot-math.cos(angle)*length
end
	
function tableLen(T)
	local c=0
	if T~=nill then		
		for _ in pairs(T) do c=c+1 end
	end	
	return c
end
	
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end