-- source: steam id 3524040776 / vehicle.xml block#27
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--4 point altitude control system monitor
function onTick()
	tarAltF=input.getNumber(1)
	tarAltB=input.getNumber(2)
	curAltFL=input.getNumber(3)
	curAltFR=input.getNumber(4)
	curAltBL=input.getNumber(5)
	curAltBR=input.getNumber(6)
	outFL=input.getNumber(7)
	outFR=input.getNumber(8)
	outBL=input.getNumber(9)
	outBR=input.getNumber(10)
	tarAltAvg=(tarAltF+tarAltB)/2
end
function greenOrRedA(num)
	if num>0 then
		screen.setColor(3,33,3)
	else
		screen.setColor(33,3,3)
	end
end
function greenOrRedB(num)
	if math.abs(num)>0.075 then
		screen.setColor(33,3,3)
	else
		screen.setColor(3,33,3)
	end
end
function mathclamp(num,low,high)
	return math.min(math.max(num,low),high)
end
--draw small number
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}
num[0]=2122222
function DN(x,y,s)
	x,y=math.floor(x+0.5),math.floor(y+0.5)
	s=tostring(s) 
	local l=string.len(s)
	for i=1,l do
		local n,w=s:sub(i,i),4
		if n=='.' then local w=2 end
		local N=tonumber(n)
		if N then
			--if N==1 then w=2 end
			local startx,starty,dx,dy=x,y+4,0,0
			for j=1,7 do
				startx,starty=startx+dx*2,starty-dy*2
				if j==5 then starty=starty-2 end
				dx,dy=math.sin(0.25*math.pi*2*(j-1)),math.cos(0.25*math.pi*2*(j-1))
				if string.sub(num[N],j,j)=='2' then
					screen.drawLine(startx,starty,startx+dx*3,starty-dy*3)
				end
			end
		else
			screen.drawText(x,y,n)
		end
		x=x+w
	end
end
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
    screen.setColor(8,8,8)
    screen.drawClear()
	greenOrRedA(outFL)
	screen.drawRectF(8,1,mathclamp(outFL*16,-8,8),7)
	greenOrRedA(outFR)
	screen.drawRectF(25,1,mathclamp(outFR*16,-8,8),7)
	greenOrRedA(outBL)
	screen.drawRectF(8,h-8,mathclamp(outBL*16,-8,8),7)
	greenOrRedA(outBR)
	screen.drawRectF(25,h-8,mathclamp(outBR*16,-8,8),7)
	screen.setColor(111,111,111)
	--greenOrRedB(curAltFL-tarAltF)
	DN(3,2,string.format("%0.1f",math.abs(curAltFL-tarAltF)))
	--greenOrRedB(curAltFR-tarAltF)
	DN(19,2,string.format("%0.1f",math.abs(curAltFR-tarAltF)))
	--greenOrRedB(curAltBL-tarAltB)
	DN(3,h-7,string.format("%0.1f",math.abs(curAltBL-tarAltB)))
	--greenOrRedB(curAltBR-tarAltB)
	DN(19,h-7,string.format("%0.1f",math.abs(curAltBR-tarAltB)))
	screen.setColor(22,222,22)
	--screen.drawTextBox(0,h/2-3,w,6,'TA'..string.format("%0.1f",tarAltAvg),0,0)
	screen.drawText(2,10,'TGTALT')
	DN(4,16,string.format("%0.2f",tarAltAvg)..'m')
	screen.drawRect(0,0,31,8)
	screen.drawLine(16,0,16,8)
	screen.drawRect(0,h-9,31,8)
	screen.drawLine(16,h-9,16,h)
end