-- source: steam id 3524040776 / vehicle.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--generator & thrust monitor
--draw small number
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}
num[0]=2122222
function DN(x,y,s)
	x,y=math.floor(x+0.5),math.floor(y+0.5)
	s=tostring(s) 
	local l=string.len(s)
	for i=1,l do
		local n,w=s:sub(i,i),5
		if n=='.' then local w=2 end
		local N=tonumber(n)
		if N then
            w=4
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
function onTick()
	curRPS=input.getNumber(1)
	tarRPS=input.getNumber(2)
	curBat=input.getNumber(3)
	curThr=math.min(input.getNumber(4),1)--throttle
	starting=input.getNumber(5)>0.5
	--from propusion
	motorL=math.min(math.max(input.getNumber(6),-0.99),0.99)
	motorR=math.min(math.max(input.getNumber(7),-0.99),0.99)
end
function onDraw()
	w,h=screen.getWidth(),screen.getHeight()
	screen.setColor(8,8,8)
	screen.drawClear()
	--battery
	screen.setColor(22,222,22)
	BatPercent='B'..string.format('%2.2f',math.min(curBat*100,99.99))..'%'
	DN(1,2,BatPercent)
	--rps
	if starting then
		screen.setColor(222,22,22)
	else
		screen.setColor(22,222,22)
	end
	RPSmsg='R'..string.format('%02.0f',curRPS)..'/'..string.format('%02.0f',tarRPS)
	DN(1,8,RPSmsg)
	--throttle bar
	screen.setColor(5,55,5)
	screen.drawRectF(1,14,1+30*curThr,4)
	screen.setColor(222,222,222)
	for i=0,5 do
		screen.drawLine(1+i*6,14,2+i*6,16)
	end
	--motors
	screen.setColor(22,222,22)
	screen.drawText(1,20,'THRUST')
	colLred=22+math.max(0,-motorL)*200
	colLgreen=22+math.max(0,motorL)*200
	colRred=22+math.max(0,-motorR)*200
	colRgreen=22+math.max(0,motorR)*200
	screen.setColor(colLred,colLgreen,22)
	DN(1,26,string.format('%+02.0f',motorL*100))
	screen.setColor(colRred,colRgreen,22)
	DN(17,26,string.format('%+02.0f',motorR*100))
end