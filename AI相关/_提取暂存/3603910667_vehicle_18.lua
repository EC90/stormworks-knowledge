-- source: steam id 3603910667 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
S=screen
M=math
pi=M.pi
pi2=pi*2

d={}
for i = 1, 360 do
	if i % 9 == 0 then
		d[i] = 5
		if i % 45 == 0 then
			d[i] = 10
		end
	else
		d[i] = 0
	end
end
compasschar={'N','NE','E','SE','S','SW','W','NW'}

zoom=M.sqrt((-0.35+1)/2)

function onTick()
spdtgt=GN(1)
compass=GN(2)
spd=GN(3)*1.943844
gen=GN(4)+GN(5)
end

function onDraw()
	w = S.getWidth()
	h = S.getHeight()				
	S.setColor(255, 255, 255)
	
	S.drawRectF(0, 90, 3, -clamp(345*((2*gen/16000)/345 + 1/8100)^(1/2) - 23/6,1.5,15)) 
	S.drawLine(0, 75, 0, 90)
	S.drawLine(3, 75, 3, 90)
	S.drawText(15, 79, string.format("%4.1f", clamp(( 345*((2*gen/16000)/345 + 1/8100)^(1/2) - 23/6 )*2,3,30)))
	S.drawRectF(5, 87, 3, -spdtgt)
	S.drawLine(5, 55, 5, 95)
	S.drawLine(8, 55, 8, 95)
	S.drawText(15, 85, string.format("%4.1f", spdtgt))
	S.drawRectF(10, 87, 3, -spd)
	S.drawLine(10, 55, 10, 95)
	S.drawLine(13, 55, 13, 95)
	S.drawText(15, 91, string.format("%4.1f", spd))
	
	gzoom=((2.2-zoom*(2.2-0.025))/pi2)/w
	
	S.setColor(255, 0, 0)
	S.drawLine(w/2, 0, w/2, 8)
	S.setColor(255, 255, 255)
	if compass>0 then
	compass=compass-1
	end
	for i=0,w do
	if ((i*gzoom-compass+2)*360)%5<gzoom*360 then
	S.drawLine(i, 0, i, 1)
	if ((i*gzoom-compass+2)*360)%15<gzoom*360 then
	S.drawLine(i, 1, i, 2)
	end
	end
	end
	for i=1,8 do
	S.drawText((((i-1)*0.125+compass+0.5)%1-0.5)/gzoom+w/2, 3, compasschar[i])
	end
	S.drawText(w/2-6, 9, string.format("%03d",M.floor(-compass*360)))
end

function clamp(x,a,b)
	if x<a then x=a end
	if x>b then x=b end
	return x
end