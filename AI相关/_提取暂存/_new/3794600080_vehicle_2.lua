-- source: steam id 3794600080 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080
s,i,o= screen,input,output
oc,shl,lc,grc,sdc,snc,rc,gvc,dwmp,gn,gb,sn,sb,dt,dr,scol= s.setMapColorOcean,s.setMapColorShallows,s.setMapColorLand,s.setMapColorGrass,s.setMapColorSand,s.setMapColorSnow,s.setMapColorRock,s.setMapColorGravel,s.drawMap,i.getNumber,i.getBool,o.setNumber,o.setBool,s.drawText,s.drawRect,s.setColor
function snap(a,r,z)
	a=a-(z*500)
	return (math.floor((a+(r/2))/r)*r)
end
function pls(c,b)if not a then a={}a[b]={pulse=false,touch=false}elseif not a[b]then a[b]={pulse=false,touch=false}end;a[b].pulse=c~=a[b].touch and c;a[b].touch=c;return a[b].pulse end
function to24hr(time)
    local time=math.min(math.max(time,0),1)*1440
    local hours=math.floor(time/60)
    local minutes=math.floor(time%60)
    return tostring(hours)..":"..string.format("%02d",minutes)
end
function clamp(var,min,max)if var<=min then var=min end if var>=max then var=max end return var
end
function rem(a)
	return (math.floor((gn(a)+(4630))/9260)*9260)
end
read=1
zoom=9.26
zoomVal=2
panVal=zoom
panX=4630
panY=-4630
nmi=1852
pn=nmi*5
check=1
call=false
desperation=0
hist={{},{},{},{},{},{},{},{},{},{}}
magn={1.852,9.26,18.52,37.04}
function onTick()
	b1=pls(gb(1),"1")--prev/left
	b2=pls(gb(2),"2")--next/right
	b3=pls(gb(3),"3")--out/up
	b4=pls(gb(4),"4")--in/down	
	update=gb(5)
	panMode=gb(6)
	posData=gb(9)
	lines=gb(8)
	clear=gb(10)
	if desperation<10 then
		desperation=desperation+1
	end
	if desperation==10 then
		call=true
	end
	if pls(call,"call") then
		panX=(math.floor((gn(1)+(4630))/9260)*9260)+4630
		panY=(math.floor((gn(2)+(4630))/9260)*9260)+4630
	end
	if pls(update,"update")then	
		table.insert(hist,1,{
			gn(1),
			gn(2),
			gn(3),
			gn(4),
			gn(5)			
		})
		hist[11]=nil
	end
	if pls(clear,"clear")then
		hist={{},{},{},{},{},{},{},{},{},{}}
	end
	if panMode then
		zoom=9.26
		zoomVal=2
		if b1 then
			panX=panX-pn
		end
		if b2 then 
			panX=panX+pn
		end
			if b3 then
			panY=panY+pn
		end
		if b4 then 
			panY=panY-pn
		end
		fX=panX
		fY=panY
	else
		if b1 and read<10then
			read=read+1
		end
		if b2 and read>1then
			read=read-1
		end
		if b3 and zoomVal<=3then
			zoomVal=zoomVal + 1
		end
		if b4 and zoomVal>0then 
			zoomVal=zoomVal-1
		end
		for i=1,10,1 do
			if hist[i][1]==nil then
				check=i
				break
			end
		end
		read=clamp(read,1,check)
		zoom=magn[zoomVal]
		fX=hist[read][1]
		fY=hist[read][2]
	end
	sn(1,gn(4))
	sn(2,zoomVal)
	sb(1,gb(7))
end
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	dwmp(fX,fY,zoom)
	if panMode then
		oc(110,105,100)
		shl(100,95,90)
		lc(60,55,50)
		grc(70,65,60)
		sdc(80,75,70)
		snc(80,75,70)
		rc(60,55,50)
		gvc(70,65,60)
		scol(0,0,0,70)
		dt(2,2,(string.format("%.0f",((panX)/nmi)-2.5))..",")
		dt(2,8,(string.format("%.0f",((panY)/nmi)+2.5)).." nmi")
	else
		oc(100, 105, 115)
		shl(30, 70, 120)
		lc(100,90,40)
		grc(90,80,30)
		sdc(90,80,30)
		snc(90,80,30)
		rc(100,90,40)
		gvc(100,90,40)
	end	
		if zoomVal > 0 then
			l1X,l1Y=map.mapToScreen(fX,fY,zoom,w,h,snap(fX or 0,nmi,zoom),snap(fY or 0,nmi,zoom))
			scol(0,0,0,(4-zoomVal)*10+3)
			for w1=0,(zoom*nmi/2000),1 do
				dr(l1X+w1*(w*magn[1]/zoom),-1,0,h+2)
				dr(-1,l1Y-w1*(h*magn[1]/zoom),w+2,0)
			end
			l2X,l2Y=map.mapToScreen(fX,fY,zoom,w,h,snap(fX or 0,nmi*5,zoom),snap(fY or 0,nmi*5,zoom))
			scol(0,0,0,(4-zoomVal)*25+5)
			for w2=0,(zoom*nmi/4000),1 do
				dr(l2X +w2*(w*magn[2]/zoom),-1,0,h+2)
				dr(-1,l2Y-w2*(h*magn[2]/zoom),w+2,0)
			end
		end
	for k,v in ipairs(hist) do
		pX,pY=map.mapToScreen(fX,fY,zoom,w,h,v[1],v[2])
		if v[1]~=nil then
			scol(1,1,6,230)
			screen.drawCircleF(pX-0.5,pY-0.5,2)
			scol(1,3,9,150)
			if posData then
				dt(pX-2,pY+3,(string.format("%02.0f",(v[3]*1.94384449)).."kt"))
				dt(pX-2,pY+9,(string.format("%03.0f",(-v[5]*359)%359)))
				screen.drawCircle(pX+14,pY+10,1)
				dt(pX-2,pY+15,to24hr(v[4]))
			end
			if lines and k < 10 then
				lX, lY = map.mapToScreen(fX,fY,zoom,w,h,hist[k+1][1],hist[k+1][2])
				if hist[k+1][3]~=nil then
					screen.drawLine(pX,pY,lX,lY)
				end
			end
		end
	end
end

