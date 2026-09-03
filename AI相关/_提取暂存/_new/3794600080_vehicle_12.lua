-- source: steam id 3794600080 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080
drf=screen.drawRectF pgt=property.getText FONT=pgt("FONT1")..pgt("FONT2") FONT_D={} FONT_S=0 for n in FONT:gmatch("....")do FONT_D[FONT_S+1]=tonumber(n,16)FONT_S=FONT_S+1 end function dst(x,y,t,s,r,m)s=s or 1 r=r or 1 if r>2then t=t:reverse()end t=t:upper()for c in t:gmatch(".")do ci=c:byte()-31if 0<ci and ci<=FONT_S then for i=1,15 do if r>2 then p=2^i else p=2^(16-i)end if FONT_D[ci]&p==p then xx,yy=((i-1)%3)*s,((i-1)//3)*s if r%2==1then drf(x+xx,y+yy,s,s)else drf(x+5-yy,y+xx,s,s)end end end if FONT_D[ci]&1==1 and not m then i=2*s else i=4*s end if r%2==1then x=x+i else y=y+i end end end end
s=screen
mc=math.cos
ms=math.sin
pi=math.pi
pi2=pi*2
dtf=s.drawTriangleF
dl=s.drawLine
sc=s.setColor
iN=input.getNumber
iB=input.getBool
oB=output.setBool
T={}
life=3600
toggle=false
function onTick()
	fish=iB(1)t=iB(2)tp=iB(3)tyaw=-iN(1)*pi2 tdist=iN(2)tdepth=math.abs(iN(3))w=iN(11)h=iN(12)ix=iN(13)iy=iN(14)depth=iN(15)gpsx=iN(16)gpsy=iN(17)ba=iN(18)*pi2
	r=h/3
	scale=(r-2)/100
	if fish and (#T<=0 or tdepth~=T[#T].z) then table.insert(T,{x=gpsx+ms(tyaw+ba)*tdist,y=gpsy+mc(tyaw+ba)*tdist,z=tdepth,sx=0,sy=0,sz=r*2+tdepth*scale,l=0,dis=false,rg=false})end
	local scb,ssb=scale*mc(ba),scale*ms(ba)
    for i=#T,1,-1 do
        local target = T[i]
		target.l=target.l+1
		target.dis=false
		local dx,dy=target.x-gpsx,target.y-gpsy
		target.sx=r-1+scb*dx+ssb*dy
		target.sy=r-scb*dy+ssb*dx
		if target.l>=life then table.remove(T,i)end
		target.rg=distance(target.sx,target.sy,r,r)<r
	end
	if t then
	for _, target in pairs(T) do if distance(ix,iy,target.sx,target.sy)<3 or distance(ix,iy,target.sx,target.sz)<3 and target.rg then target.dis=true break end end
	if tp and ix>r*5/2-8 and iy>r*2-21 and ix<r*5/2+6 and iy<r*2-15 then toggle=not toggle end
	end
	oB(1,toggle)
end
function onDraw()
	w,h=s.getWidth(),s.getHeight()
	if toggle then
	sc(0,3,10)
	drf(0,0,w,h)
	for _,target in pairs(T) do
	if target.rg then
	--sc(50,50,50,50-clamp(target.l*2,0,50))
	--dl(target.sx,target.sy,target.sx,target.sz)
	sc(50,50,50,100*(life-target.l)/life)
	dl(target.sx-.5,target.sz-.5,target.sx-.5,r*2+scale*depth)
	sc(60,30*clamp(target.l*2,0,life)/life,0,255*(life-target.l)/life)
	drf(target.sx-1,target.sy-.5,1,1)
	drf(target.sx-1,target.sz-.5,1,1)
	sc(0,0,100,240-clamp(target.l*2,0,240))
	s.drawCircle(target.sx-.5,target.sy-.5,target.l/24)
	end end end
	for i=1,h do
	a=(i/h)*pi2
    x,y=r-1+r*mc(a),r+r*ms(a)
    pa=a-pi2/h
    x1,y1=r-1+r*mc(pa),r+r*ms(pa)
	x2,y2=x>r and 2*r-1 or 0,y>r and 2*r or 0
    x3,y3=r-1+r*mc(a)/2,r-1+r*ms(a)/2
    x4,y4=r-1+r*mc(pa)/2,r-1+r*ms(pa)/2
	sc(25,25,25,50)
	dl(x3,y3,x4,y4)
	sc(7,7,7)
	dtf(x,y,x1,y1,x2,y2)
	end
	drf(2*r-1,0,w,2*r)
	sc(0,20,120,50)
	drf(0,r*2+scale*depth+1,r*2-1,h)
	sc(50,50,50,50)
	dl(0,r*2+scale*depth,r*2-1,r*2+scale*depth)
	sc(25,25,25)
	dl(r*2-.5,r*2+(r-2)/2-1,r*2+2-.5,r*2+(r-2)/2-1)
	dl(r*2,r*2+(r-2)-1,r*2+2,r*2+(r-2)-1)
	sc(25,25,25)
	dst(r*2+3,r*2+(r-2)/2-4,string.format("%03d",50).."m")
	dst(r*2+3,r*2+(r-2)-4,string.format("%03d",100).."m")
	s.drawRect(0,2*r-1,r*2-1,r)
	s.drawRect(2*r-1,r*2-1,r,0)
	drf(r-1,r-.5,1,1)
	dst(r*5/2-6,r*2-13,string.format("%03d",#T))
	dst(r*5/2-6,r*2-7,string.format("%03d",average(T)))
	sc(30,15,1)
	if h>32 then
	dst(2*r+10,1,"sh")dst(2*r+10,7,"nd")dl(2*r+7,1,2*r+7,11)dl(2*r+6,1,2*r+9,1)dl(2*r+6,11,2*r+9,11)dl(2*r+2,1,2*r+2,12)dl(2*r+2,1,2*r+5,1)dl(2*r+2,6,2*r+4,6)
	end
	if toggle then sc(30,30,30) else sc(5,5,5) end
	drf(r*5/2-7,r*2-20,13,5)
	if toggle then sc(10,50,10) else sc(50,10,10) end
	dst(r*5/2-6,r*2-20,toggle and "on" or "off")
	for _,target in pairs(T) do
	if target.dis then
	sc(5,5,5,150)
	drf(target.sx,target.sy-3,15,7)
	sc(50,50,50)
	dst(target.sx+1,target.sy-2,math.floor(target.z).." m")
	end
	end
end
function distance(x1,y1,x2,y2) return ((x1-x2)^2+(y1-y2)^2)^(1/2) end
function clamp(x,y,z) if x<y then return y elseif x>z then return z else return x end end
function average(m) if #m>0 then j=0 for _,v in pairs(m) do j=j+v.z end return math.floor(j/#m+.5) else return 0 end end