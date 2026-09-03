-- source: steam id 3788946785 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785
FONT=property.getText("FONT1")..property.getText("FONT2") FONT_D={} FONT_S=0 for n in FONT:gmatch("....")do FONT_D[FONT_S+1]=tonumber(n,16)FONT_S=FONT_S+1 end function dt(x,y,t,s,r,m)s=s or 1 r=r or 1 if r>2then t=t:reverse()end t=t:upper()for c in t:gmatch(".")do ci=c:byte()-31if 0<ci and ci<=FONT_S then for i=1,15 do if r>2 then p=2^i else p=2^(16-i)end if FONT_D[ci]&p==p then xx,yy=((i-1)%3)*s,((i-1)//3)*s if r%2==1then screen.drawRectF(x+xx,y+yy,s,s)else screen.drawRectF(x+5-yy,y+xx,s,s)end end end if FONT_D[ci]&1==1 and not m then i=2*s else i=4*s end if r%2==1then x=x+i else y=y+i end end end end

s=screen
sc=s.setColor
iN=input.getNumber
iB=input.getBool
ms=math.sin
mc=math.cos
pi=math.pi
pi2=pi*2
S={}
ping=0
buz=false
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
	sT=iN(21)
	roll=iN(23)*pi2
	pitch=iN(22)*pi2
	t=iB(6)
	if sT==2 then
		ping=ping+1
		dist=(ping/60)*(1480/2)
		_,y=map.mapToScreen(gx,gy,z,w,h,gx,gy+dist)
		s_dist=cy-y
		if s_dist>cy+1 then ping=0 end
		if iB(1) and ping>1 then
			ta=pi2*iN(1)
			te1=pi2*iN(2)
			te=corr_ea(-te1,ta,roll,-pitch)
			tra=ta-ba
			td=dist
			th=ms(te)*td
			x=gx+td*ms(tra)
			y=gy+td*mc(tra)
			buz=true
			table.insert(S,{a=-ta-pi+ba,x=x,y=y,d=td,m=0,h=th,t=255,tg=false})
		end
		scale=w/(z*1000)
		scb,ssb=scale*mc(ba),scale*ms(ba)
		for i,v in pairs(S) do
			if mm==3 then
				local dx,dy=v.x-gx,v.y-gy
				x=cx+scb*dx+ssb*dy
				y=cy-scb*dy+ssb*dx
			else
				x,y=map.mapToScreen(gx,gy,z,w,h,v.x,v.y)
			end
			v.sx,v.sy=x,y
			if math.floor(v.h)~=0 and t and ping>1 and tx>x-1 and tx<x+1 and ty>y-1 and ty<y+1 and v.d>0 then v.tg=true return else v.tg=false end
			--if v.t>0 then v.t=v.t-1 else table.remove(S,i) end
			if v.d-dist<50 and v.d-dist>1 then table.remove(S,i) end
		end
	else
		S={}
		ping=0
		dist=0
	end
	output.setBool(1,sT>0)
	output.setBool(2,ping>0)
	output.setBool(3,buz)
	output.setNumber(1,iN(1))
	output.setNumber(2,ta)
	buz=false
end
function onDraw()
	if sT==2 then
		for i,v in pairs(S) do
			if v.d>0 and v.sx and ((v.sx-cx)^2+(v.sy-cy)^2)^(1/2)<cy then
				sc(0,0,255,255*v.t/400)
				s.drawRectF(v.sx-.5,v.sy-.5,1,1)
			end
		end
		for i,v in pairs(S) do
			if v.tg then
				sc(100,100,100)
				dt(v.sx+2,v.sy+2,"".. math.floor(v.h))
				break
			end
		end
		sc(0,0,255,100)
		s.drawCircle(cx,cy,s_dist)
	end
end
function xor(bool1,bool2)
	return (bool1 and bool2) or (not bool1 and not bool2)
end
function corr_ea(e,a,r,p)
	return e-p*mc(a)+r*ms(a)
end