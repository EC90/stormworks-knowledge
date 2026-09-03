-- source: steam id 3794647482 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
pi=math.pi
pi2=pi*2
sin=math.sin
cos=math.cos
data={}
removeFrame=property.getNumber("remove frame")

function onTick()
	
	angle=input.getNumber(4)*pi2
	range=input.getNumber(8)
	
	for i=0,7 do
		if input.getBool(i+1) then
			table.insert(data,{input.getNumber(i*4+1),input.getNumber(i*4+2)*pi2,input.getNumber(i*4+3)*pi2,removeFrame})
		end
	end
	
end

function onDraw()
	
	local cw,wh,radius
	w=screen.getWidth()
	h=screen.getHeight()
	
	cw=w/2
	ch=h/2
	
	radius=h/2
	
	lineX=cw+radius*sin(angle)
	lineY=ch-radius*cos(angle)
	
	for i=#data,1,-1 do
		if data[i][4]<=0 then
			table.remove(data,i)
		end
	end
	
	for i=1,#data do
		if data[i][1]<range then
			echox=cw+(data[i][1]/range)*radius*sin(data[i][2])
			echoy=ch-(data[i][1]/range)*radius*cos(data[i][2])
			colorG=255*(data[i][4]/removeFrame)
			screen.setColor(0,colorG,0)
			screen.drawCircle(echox,echoy,2)
			data[i][4]=data[i][4]-1
		end
	end
	
	screen.setColor(0,50,0)
	--screen.drawText(0,0,string.format("%.0f",range))
	screen.drawCircle(cw,ch,radius)
	screen.drawLine(cw,ch,lineX,lineY)
	
end