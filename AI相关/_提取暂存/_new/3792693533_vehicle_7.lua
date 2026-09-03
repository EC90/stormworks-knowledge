-- source: steam id 3792693533 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792693533
s,m,inP,tb=screen,math,input,table
dA=property.getBool("Display Draw Area")
function rnd(n)
	return m.floor(n+0.5)
end
function berDistCord(x,y,b,d,v2)
	v2=v2 or false
	local a=90-b
	if v2 then
		a=b-90
	end
	local r=m.rad(a)
	return x+m.cos(r)*d,y-m.sin(r)*d
end
function cordBer(x1,y1,x2,y2)
	return ((m.atan(x2-x1,y2-y1)*(180/m.pi))+360)%360
end
function distMapToPx(z,pxW,d)
	return pxW/(z*1000)*d
end
function cordDist(x1,y1,x2,y2)
	return m.sqrt((x2-x1)^2+(y2-y1)^2)
end
function longestValue(...)
	local a={...}
	local l=0
	for i=1,#a do
		local r=tostring(a[i])
		local len=#r
		if len>l then
			l=len
		end
	end
	return 1+l*5
end
function mark(x,y,r,g,b,a)
	x=rnd(x)
	y=rnd(y)
	a=a or 255
	s.setColor(r,g,b,a)
	s.drawLine(x-2,y-2,x+3,y+3)
	s.drawLine(x-2,y+2,x+3,y-3)
end
function cross(x,y,r,g,b,a)
	x=rnd(x)
	y=rnd(y)
	a=a or 255
	s.setColor(r,g,b,a)
	s.drawLine(x-1,y,x+2,y)
	s.drawLine(x,y+1,x,y-2)
end
function addMk(x,y,c)
	tb.insert(pT,{type=4,x=x,y=y,c=c})
	sP=#pT
end
function addCirc(x,y,r,c)
	tb.insert(pT,{type=1,x=x,y=y,r=r,c=c})
	sP=#pT
end
function addLn(x1,y1,x2,y2,c)
	tb.insert(pT,{type=3,x1=x1,y1=y1,x2=x2,y2=y2,c=c})
	sP=#pT
end
function txtMk(x,y,w,h,t,x0,y0,off,v2)
	v2=v2 or false
	local rw={}
	if type(t)=="table" then
		rw=t
	else
		rw={tostring(t)}
	end
	if x>x0 and v2 then
		x=x+off+2
	elseif x>x0 or v2 then
		x=x-w-off
	else
		x=x+off+2
	end
	if y>y0 and v2 then
		y=y+off
	elseif y>y0 or v2 then
		y=y-(h*#rw)-off
	else
		y=y+off
	end
	for i=1,#rw do
		s.drawTextBox(x,y+((i-1)*h),w,h,tostring(rw[i]),-1,0)
	end
end
function txtCircle(x,y,r,w,h,t,x0,y0)
	local rw={}
	if type(t)=="table" then
		rw=t
	else
		rw={tostring(t)}
	end
	y=y-1-(h*2)

	if r-2<m.sqrt((w/2)*(w/2)+(h*2)*(h*2)) or x+w>x0*2 or x-w<0 or y-(h*4)<0 or y+(h*4)>y0*2 then
		txtMk(x,y+1+(h*2),w,h,t,x0,y0,(r+2)/m.sqrt(2))
	else
		for i=1,#rw do
			if i==3 then
				y=y+5
			end
			s.drawTextBox(x-(w/2),y+((i-1)*h),w,h,tostring(rw[i]),-1,0)
		end
	end
end
function isPointInRectangle(x,y,X,Y,W,H)
	return x>X and y>Y and x<X+W and y<Y+H
end
function isPointInCircle(x,y,X,Y,R)
	return (x-X)^2+(y-Y)^2<=R*R
end
function isPointInLn(x,y,x1,y1,x2,y2,r)
	local APx,APy=x-x1,y-y1
	local ABx,ABy=x2-x1,y2-y1
	local AB2=ABx*ABx+ABy*ABy
	if AB2==0 then return cordDist(x,y,x1,y1)<=r end
	local t=(APx*ABx+APy*ABy)/AB2
	if t<0 then t=0 elseif t>1 then t=1 end
	return cordDist(x,y,x1+ABx*t,y1+ABy*t)<=r
end
cT={
	{r=0,g=0,b=0},
	{r=255,g=0,b=0},
	{r=0,g=65,b=0},
	{r=0,g=0,b=255}
}
function getRGB(id)
	return cT[id].r,cT[id].g,cT[id].b
end
pT={}
click=true
cID=1
sP=0
cord={}
function onTick()	
	w=inP.getNumber(1)
	h=inP.getNumber(2)
	iX=inP.getNumber(3)
	iY=inP.getNumber(4)
	iP=inP.getBool(1)
	mX=inP.getNumber(13)
	mY=inP.getNumber(14)
	z=input.getNumber(15)
	mZ=z*0.001
	tPOS=inP.getBool(14)
	tX=inP.getNumber(9)
	tY=inP.getNumber(10)
	dData=inP.getBool(17)
	dRng=inP.getNumber(17)
	dBer=inP.getNumber(18)
	del=inP.getBool(20)
	if not iP then
		click=true
	end
	if inP.getNumber(19) and inP.getNumber(19) > 0 then
		cID=rnd(inP.getNumber(19))
	end
	if inP.getNumber(20) then
		if tID~=rnd(inP.getNumber(20)) or rnd(inP.getNumber(20))==0 then
			cord={}
		end
		tID=rnd(inP.getNumber(20))
	end
	if sP>0 and del then
		tb.remove(pT,sP)
		sP=0
	end
	inPA=iP and isPointInRectangle(iX,iY,12,10,w-24,h-27)
	if tID==1 then
		if #cord==0 then
			if tPOS then
				cord={tX,tY}
			elseif inPA and click then
				wX,wY=map.screenToMap(mX,mY,mZ,w,h,iX,iY)
				cord={wX,wY}
				click=false
			end
		elseif #cord==2 then
			if tPOS then
				addCirc(cord[1],cord[2],cordDist(cord[1],cord[2],tX,tY),cID)
				cord={}
			elseif inPA and click then
				wX,wY=map.screenToMap(mX,mY,mZ,w,h,iX,iY)
				addCirc(cord[1],cord[2],cordDist(cord[1],cord[2],wX,wY),cID)
				cord={}
				click=false
			elseif dData and dRng>0 then
				addCirc(cord[1],cord[2],dRng,cID)
				cord={}
			end
		end
	elseif tID==3 then
		if #cord==0 then
			if tPOS then
				cord={tX,tY}
			elseif inPA and click then
				wX,wY=map.screenToMap(mX,mY,mZ,w,h,iX,iY)
				cord={wX,wY}
				click=false
			end
		elseif #cord==2 then
			if tPOS then
				addLn(cord[1],cord[2],tX,tY,cID)
				cord={}
			elseif inPA and click then
				wX,wY=map.screenToMap(mX,mY,mZ,w,h,iX,iY)
				addLn(cord[1],cord[2],wX,wY,cID)
				cord={}
				click=false
			elseif dData and dRng>0 then
				wX,wY=berDistCord(cord[1],cord[2],dBer,dRng,true)
				addLn(cord[1],cord[2],wX,wY,cID)
				cord={}
			end
		end
	elseif tID==4 then
		if tPOS then
			addMk(tX,tY,cID)
		elseif inPA and click then
			wX,wY=map.screenToMap(mX,mY,mZ,w,h,iX,iY)
			addMk(wX,wY,cID)
			click=false
		end
	elseif tID==0 and #pT>0 and click and inPA then
		click=false
		for i=1,#pT+1 do
			if i==#pT+1 then
				sP=0
			elseif i~=sP then
				if pT[i].type==4 then
					pX,pY=map.mapToScreen(mX,mY,mZ,w,h,pT[i].x,pT[i].y)
					if isPointInRectangle(iX,iY,pX-5,pY-5,10,10) then
						sP=i
						break
					end
				elseif pT[i].type==1 then
					pX,pY=map.mapToScreen(mX,mY,mZ,w,h,pT[i].x,pT[i].y)
					if isPointInCircle(iX,iY,pX,pY,distMapToPx(mZ,w,pT[i].r)+3) then
						sP=i
						break
					end
				elseif pT[i].type==3 then
					pX1,pY1=map.mapToScreen(mX,mY,mZ,w,h,pT[i].x1,pT[i].y1)
					pX2,pY2=map.mapToScreen(mX,mY,mZ,w,h,pT[i].x2,pT[i].y2)
					if isPointInLn(iX,iY,pX1,pY1,pX2,pY2,3) then
						sP=i
						break
					end				
				end
			end
		end
	end
end
function onDraw()
	w=s.getWidth()
	h=s.getHeight()
	x0=w/2
	y0=h/2
	if tID>0 and dA then
		s.setColor(0,0,0,25)
		s.drawRect(12,10,w-24,h-27)
	end
	if #pT>0 then
		for i=1,#pT do
			if pT[i].type==4 then
				pxX,pxY=map.mapToScreen(mX,mY,mZ,w,h,pT[i].x,pT[i].y)
				mark(pxX,pxY,getRGB(pT[i].c))
			elseif pT[i].type==1 then
				pxX,pxY=map.mapToScreen(mX,mY,mZ,w,h,pT[i].x,pT[i].y)
				s.setColor(getRGB(pT[i].c))
				s.drawCircle(pxX,pxY,distMapToPx(mZ,w,pT[i].r))
			elseif pT[i].type==3 then
				pxX,pxY=map.mapToScreen(mX,mY,mZ,w,h,pT[i].x1,pT[i].y1)
				pxX2,pxY2=map.mapToScreen(mX,mY,mZ,w,h,pT[i].x2,pT[i].y2)
				s.setColor(getRGB(pT[i].c))
				s.drawLine(pxX,pxY,pxX2,pxY2)
			end
		end
	end
	if sP>0 and sP<=#pT then
		if pT[sP].type==4 then
			wX=rnd(pT[sP].x)
			wY=rnd(pT[sP].y)
			r,g,b=getRGB(pT[sP].c)
			pxX,pxY=map.mapToScreen(mX,mY,mZ,w,h,wX,wY)
			s.setColor(r,g,b,150)
			s.drawRect(pxX-4,pxY-4,8,8)
			tbW=longestValue(wX,wY)
			s.setColor(r,g,b,220)
			txtMk(pxX,pxY,tbW+10,6,{"X:"..wX,"Y:"..wY},x0,y0,4)
		elseif pT[sP].type==1 then
			wX=rnd(pT[sP].x)
			wY=rnd(pT[sP].y)
			wR=rnd(pT[sP].r)
			r,g,b=getRGB(pT[sP].c)
			pxX,pxY=map.mapToScreen(mX,mY,mZ,w,h,wX,wY)
			cross(pxX,pxY,r,g,b,150)
			s.setColor(r,g,b,150)
			pxR=distMapToPx(mZ,w,wR)
			s.drawCircle(pxX,pxY,pxR+2)
			tbW=longestValue(wX,wY,wR)
			s.setColor(r,g,b,220)
			txtCircle(pxX,pxY,pxR,tbW+10,6,{"X:"..wX,"Y:"..wY,"R:"..wR},x0,y0)
		elseif pT[sP].type==3 then
			wX1=rnd(pT[sP].x1)
			wY1=rnd(pT[sP].y1)
			wX2=rnd(pT[sP].x2)
			wY2=rnd(pT[sP].y2)
			r,g,b=getRGB(pT[sP].c)
			pxX1,pxY1=map.mapToScreen(mX,mY,mZ,w,h,wX1,wY1)
			pxX2,pxY2=map.mapToScreen(mX,mY,mZ,w,h,wX2,wY2)
			s.setColor(r,g,b,150)
			ber=cordBer(wX1,wY1,wX2,wY2)
			dist=cordDist(wX1,wY1,wX2,wY2)
			pX1A,pY1A=berDistCord(pxX1,pxY1,ber+225,3)
			pX1B,pY1B=berDistCord(pxX1,pxY1,ber+135,3)
			pX2A,pY2A=berDistCord(pxX2,pxY2,ber+315,3)
			pX2B,pY2B=berDistCord(pxX2,pxY2,ber+45,3)
			s.drawLine(pX1A,pY1A,pX1B,pY1B)
			s.drawLine(pX2B,pY2B,pX1B,pY1B)
			s.drawLine(pX2B,pY2B,pX2A,pY2A)
			s.drawLine(pX1A,pY1A,pX2A,pY2A)
			tbW1=longestValue(wX1,wY1)
			tbW2=longestValue(wX2,wY2)
			tbWB=longestValue(rnd(ber))
			tbWD=longestValue(rnd(dist))
			pX0,pY0=berDistCord(pxX1,pxY1,ber,distMapToPx(mZ,w,dist/2))
			s.setColor(r,g,b,220)
			txtMk(pxX1,pxY1,tbW1+15,6,{"X1:"..wX1,"Y1:"..wY1},pX0,pY0,4,true)
			txtMk(pxX2,pxY2,tbW2+15,6,{"X2:"..wX2,"Y2:"..wY2},pX0,pY0,4,true)
			pX0A,pY0A=berDistCord(pX0,pY0,ber+90,3)
			pX0B,pY0B=berDistCord(pX0,pY0,ber-90,3)
			txtMk(pX0A,pY0A,tbWB+10,6,"B:"..rnd(ber),pX0,pY0,4,true)
			txtMk(pX0B,pY0B,tbWD+10,6,"D:"..rnd(dist),pX0,pY0,4,true)
		end
	end
	if #cord>0 then
		pxX,pxY=map.mapToScreen(mX,mY,mZ,w,h,cord[1],cord[2])
		r,g,b=getRGB(cID)
		cross(pxX,pxY,r,g,b,220)
	end
end