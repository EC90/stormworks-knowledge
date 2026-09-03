-- source: steam id 2885633937 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2885633937
ign=input.getNumber
sdtf=screen.drawTriangleF
ssc=screen.setColor
pi=math.pi
rsta,rstd={},{}
function onTick()
	gpsx=ign(11)
	gpsy=ign(12)
	cps=ign(3)
	mapx=ign(15)
	mapy=ign(16)
	z=ign(7)
	--ipt rst
	for i=1,8 do
		rstd[i]=ign(-3+4*i)
		rsta[i]=ign(-2+4*i)
	end
	tgtx,tgty=ign(4),ign(8)
end
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	ssc(15,233,15,128)
	selfx,selfy=map.mapToScreen(mapx,mapy,z,w,h,gpsx,gpsy)
	screen.drawLine(selfx,selfy,selfx-0.4*w*math.sin((cps-0.06)*2*pi),selfy-0.4*w*math.cos((cps-0.08)*2*pi))
	screen.drawLine(selfx,selfy,selfx-0.4*w*math.sin((cps+0.06)*2*pi),selfy-0.4*w*math.cos((cps+0.08)*2*pi))
	screen.setColor(15,233,15,200)
	screen.drawCircleF(selfx,selfy,h/32)
	screen.setColor(0,0,0,128)
	screen.drawCircle(selfx,selfy,h/32)
	--show target pos
	for i=1,#rstd do
		if rstd[i]>100 then
			tx,ty=rstd[i]*math.sin((cps-rsta[i])*2*pi),rstd[i]*math.cos((cps-rsta[i])*2*pi)
			txs,tys=map.mapToScreen(mapx,mapy,z,w,h,gpsx-tx,gpsy+ty)
			ssc(200,200,15)
			screen.drawCircleF(txs,tys,h/32)
			screen.setColor(0,0,0,128)
			screen.drawCircle(txs,tys,h/32)
		end
	end
	if math.abs(tgtx-gpsx)>10 and math.abs(tgty-gpsy)>10 and tgtx~=0 and tgty~=0 then
		txs,tys=map.mapToScreen(mapx,mapy,z,w,h,tgtx,tgty)
		ssc(200,15,200)
		screen.drawCircleF(txs,tys,h/32)
		screen.setColor(0,0,0,128)
		screen.drawCircle(txs,tys,h/32)
	end
end