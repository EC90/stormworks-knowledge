-- source: steam id 3524040776 / vehicle.xml block#41
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--anti radio show radio signal
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
bools={}
nums={}
for i=1,32 do
	bools[i]=false
	nums[i]=0
end
function onTick()
	for i=1,32 do
		bools[i]=input.getBool(i)
		nums[i]=input.getNumber(i)
	end
end
function onDraw()
	w,h=screen.getWidth(),screen.getHeight()
	screen.setColor(8,8,8)
	screen.drawClear()
	--64 pixels = 10 lines text
	for i=1,32 do
		if bools[i] then
			screen.setColor(222,22,22)
		else
			screen.setColor(44,22,22)
		end
		screen.drawLine(w-2,2*i-1,w-3,2*i-1)
		if nums[i]~=0 then
			screen.setColor(22,222,22)
		else
			screen.setColor(22,44,22)
		end
		screen.drawLine(w-4,2*i-1,w-5,2*i-1)
	end
	screen.setColor(22,222,22)
end