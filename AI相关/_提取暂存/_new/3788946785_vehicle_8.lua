-- source: steam id 3788946785 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785
FONT=property.getText("FONT1")..property.getText("FONT2") FONT_D={} FONT_S=0 for n in FONT:gmatch("....")do FONT_D[FONT_S+1]=tonumber(n,16)FONT_S=FONT_S+1 end function dt(x,y,t,s,r,m)s=s or 1 r=r or 1 if r>2then t=t:reverse()end t=t:upper()for c in t:gmatch(".")do ci=c:byte()-31if 0<ci and ci<=FONT_S then for i=1,15 do if r>2 then p=2^i else p=2^(16-i)end if FONT_D[ci]&p==p then xx,yy=((i-1)%3)*s,((i-1)//3)*s if r%2==1then screen.drawRectF(x+xx,y+yy,s,s)else screen.drawRectF(x+5-yy,y+xx,s,s)end end end if FONT_D[ci]&1==1 and not m then i=2*s else i=4*s end if r%2==1then x=x+i else y=y+i end end end end

s=screen
sc=s.setColor
iN=input.getNumber
iB=input.getBool
oB=output.setBool
oN=output.setNumber
ms=math.sin
mc=math.cos
pi=math.pi
pi2=pi*2
R={}
buz=false
old_ra=0
function onTick()
	w=iN(11)cx=w/2-.5
	h=iN(12)cy=h/2
	tx=iN(13)
	ty=iN(14)
	gx=iN(15)
	gy=iN(16)
	ba=iN(17)*pi2
	z=iN(18)
	mm=iN(19)
	alt=iN(20)
	ra=iN(21)*pi2
	roll=iN(23)*pi2
	pitch=iN(22)*pi2
	t=iB(6)
	rT=iB(7)
	rs=(ra-old_ra)*25
	if rT then
		if iB(1) then
			td=iN(1)
			ta=iN(2)*pi2
			te=corr_te(iN(3)*pi2,ta,roll,-pitch)
			th=ms(te)*td+alt
			tra=ta-ba
			x=gx+td*ms(tra)
			y=gy+td*mc(tra)
			table.insert(R,{a=-ta-pi+ba,x=x,y=y,d=td,m=0,h=th,t=150/rs,tg=false})
			buz=true
		end
		scale=w/(z*1000)
		scb,ssb=scale*mc(ba),scale*ms(ba)
		for i,v in pairs(R) do
			if mm==3 then
				local dx,dy=v.x-gx,v.y-gy
				x=cx+scb*dx+ssb*dy
				y=cy-scb*dy+ssb*dx
			else
				x,y=map.mapToScreen(gx,gy,z,w,h,v.x,v.y)
			end
			v.sx,v.sy=x,y
			if math.floor(v.h)~=0 and t and tx>x-1 and tx<x+1 and ty>y-1 and ty<y+1 then v.tg=true return else v.tg=false end
			if v.t>0 then v.t=v.t-1 else table.remove(R,i) end
		end
	else
		R={}
	end
	oB(1,rT)
	oB(2,buz)
	oN(1,iN(3)*pi2)
	oN(2,pitch)
	oN(3,te)
	old_ra=ra
	buz=false
end
function onDraw()
	if rT then
		for i,v in pairs(R) do
			if v.sx and ((v.sx-cx)^2+(v.sy-cy)^2)^(1/2)<cy then
				sc(0,255,0,255*v.t/400)
				s.drawRectF(v.sx-.5,v.sy-.5,1,1)
			end
		end
		for i,v in pairs(R) do
			if v.tg then
				sc(100,100,100)
				dt(v.sx+2,v.sy+2,"".. math.floor(v.h))
				break
			end
		end
		u=45
		f=cy+2
		if mm==3 then ba=0 end
		for i=1,u do
			rla1=(ra+pi-(i-1)/(pi2*8))-ba
			rx2=cx+f*ms(-rla1)
			ry2=cy+f*mc(-rla1)
			rla2=(ra+pi-i/(pi2*8))-ba
			rx3=cx+f*ms(-rla2)
			ry3=cy+f*mc(-rla2)
			sc(0,100,0,85*(u-i)/u)
			s.drawTriangleF(cx,cy,rx2,ry2,rx3,ry3)
		end
	end
end
function corr_te(e,a,r,p)
	return e-p*mc(a)+r*ms(a)
end