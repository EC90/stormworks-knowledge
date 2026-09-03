-- source: steam id 3792899963 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792899963
iN=input.getNumber
pN=property.getNumber
pB=property.getBool
sdl=screen.drawLine
sdtf=screen.drawTriangleF
sdrf=screen.drawRectF
ssc=screen.setColor
max=math.max
sin=math.sin
cos=math.cos
tan=math.tan
pi2=math.pi*2
pih=math.pi/2
d2r=math.pi/180

spdScale=pN('Speed Scale')
altScale=pN('Altitude Scale')
xDir=pN('X Tilt Sensor Direction')
cam=pB('Camera Passthrough')
cFov=pN('Camera Fov')
fov=cam and 2.2+(0.025-2.2)*cFov or 1
bga=cam and 200 or 120

function onTick()
	local tx,ty,tz,br=iN(1)*xDir,iN(2),iN(3),iN(4)
	roll=math.atan(sin(tx*pi2),sin(ty*pi2))
	pitch=tz*pi2
	dir=(-br%1)*360

	spd=max(iN(5)*spdScale,0)
	alt=max(iN(6)*altScale,0)
end

function onDraw()
	local w,h=screen.getWidth(),screen.getHeight()
	local hw,hh=w/2,h/2

	if not cam then
		ssc(20,70,220)
		sdrf(0,0,w,h)
	end
	drawHzn(roll,-pitch,hw,hh,w,h)

	ssc(255,255,0)
	sdrf(hw-1,hh-1,2,2)
	sdl(hw-10,hh-1,hw-3,hh-1)
	sdl(hw-3, hh-1,hw-3,hh+1)
	sdl(hw+9, hh-1,hw+2,hh-1)
	sdl(hw+2, hh-1,hw+2,hh+1)

	local dirw=w<64 and 10 or 13
	local dirh=h<64 and 5 or 7
	local diry=h<64 and 0 or 1
	ssc(0,0,0,bga)
	sdrf(hw-dirw/2,0,dirw,dirh)
	ssc(0,255,0)
	local dirs=tos(dir)
	local dfnt=w<64 and dir>99 and f25 or f35
	dTxtC(hw,diry,dirs,dfnt)

	local fnt=w<64 and f25 or f35
	local schh=h<64 and 14 or 20
	local spdX=fnt.acc*3-1
	local altDig=w<64 and 3 or 4
	dScroll2(spdX,hh+5,schh,spd,fnt,3,     1)
	dScroll2(w,   hh+5,schh,alt,fnt,altDig,2)
end

function drawHzn(r,p,cx,cy,w,h)
	local s,c=sin(r),cos(r)
	local diag=math.sqrt(w^2+h^2)
	local ihtfov=h/tan(fov/2)
	local pMax=math.atan(diag/ihtfov)

	function tl(x,a)
		local y=tan(a)*ihtfov/2
		return cx+x*c+y*s,cy+x*s-y*c,cx-x*c+y*s,cy-x*s-y*c
	end
	function dl(a,l)
		a=a*d2r+p
		if a>-pMax and a<pMax then
			sdl(tl(l,a))
		end
	end

	ssc(100,50,20)
	if cam then
	elseif p>=pMax then
		sdrf(0,0,w,h)
	elseif p>-pMax then
		local x1,y1,x2,y2=tl(diag,p)
		local x3,y3,x4,y4=tl(diag,-pMax)
		sdtf(x1,y1+0.5,x2,y2+0.5,x3,y3+0.5)
		sdtf(x3,y3+0.5,x2,y2+0.5,x4,y4+0.5)
	end

	ssc(255,255,255)
	dl(90,10)
	dl(75,3)
	dl(60,5)
	dl(45,3)
	dl(30,5)
	dl(15,3)
	dl(0,20)
	if cam then ssc(255,0,0) end
	dl(-90,10)
	dl(-75,3)
	dl(-60,5)
	dl(-45,3)
	dl(-30,5)
	dl(-15,3)
end

function dScroll2(x,y,hh,value,f,d1,d2)
	local vs,fw=tos(value),f.acc
	local w1=fw*d1+1
	local w2=fw*d2+1
	local w3=fw*vs:len()+1
	local h=hh*2+1
	local scscl=10^d2

	ssc(0,0,0,bga)
	sdrf(x-w1+1,y-hh,w1,h)
	ssc(120,120,120)
	dScroll(x-1,y,hh-2,hh-1,hh/2+3,value/scscl,function(x,y,i)
		if i>=0 then dTxtR(x,y-2,tos(i*scscl):sub(-d1),f) end
	end)

	ssc(0,0,0)
	sdrf(x-w3+1,y-3,w3,7)
	ssc(255,255,255)
	dTxtR(x-1,y-2,vs,f)

	ssc(0,0,0)
	sdrf(x-w2+1,y-7,w2,15)
	ssc(255,255,255)
	dScroll(x-1,y,5,6,6,value,function(x,y,i)
		if i>=0 then dTxtR(x,y-2,tos(i):sub(-d2),f) end
	end)
end

function dScroll(x,y,u,d,h,v,draw)
	for i=1+(v-d/h)//1|0,(v+u/h)//1|0 do
		draw(x,y+(v-i)*h,i)
	end
end

function tos(v)
	return tostring(v//1|0)
end

function dTxtR(x,y,s,f)
	local l,fw=s:len(),f.acc
	x=x-l*fw+2
	for i=1,l do
		dChar(x,y,f,s:byte(i))
		x=x+fw
	end
end
function dTxtC(x,y,s,f)
	local l,fw=s:len(),f.acc
	x=x-(l*fw-1)//2
	for i=1,l do
		dChar(x,y,f,s:byte(i))
		x=x+fw
	end
end

function dChar(x,y,f,c)
	local l=f[c]
	if not l then return end
	x,y=x//1|0,y//1|0
	for i=1,#l do
		local v=l[i]
		local x1,y1=x+v[1],y+v[2]
		for j=3,#v,2 do
			local x2,y2=x+v[j],y+v[j+1]
			sdl(x1,y1,x2,y2)
			x1,y1=x2,y2
		end
	end
end

f35={
	acc=4,
	[48]={{0,0,2,0,2,4,0,4,0,0}},
	[49]={{2,0,2,5}},
	[50]={{0,0,2,0,2,2,0,2,0,4,3,4}},
	[51]={{0,0,2,0,2,4,-1,4},{1,2,2,2}},
	[52]={{0,0,0,2,2,2},{2,0,2,5}},
	[53]={{2,0,0,0,0,2,2,2,2,4,-1,4}},
	[54]={{2,0,0,0,0,4,2,4,2,2,0,2}},
	[55]={{0,1,0,0,2,0,2,5}},
	[56]={{0,0,2,0,2,4,0,4,0,0},{1,2,2,2}},
	[57]={{0,4,2,4,2,0,0,0,0,2,2,2}},
}
f25={
	acc=3,
	[48]={{0,0,1,0,1,4,-1,4}},
	[49]={{1,0,1,5}},
	[50]={{0,0,1,0,1,2,0,2,0,4,2,4}},
	[51]={{0,0,1,0,1,4,-1,4},{0,2,1,2}},
	[52]={{0,1,0,4},{1,0,1,5}},
	[53]={{1,0,0,0,0,2,1,2,1,4,-1,4}},
	[54]={{1,0,0,0,0,4,1,4,1,1}},
	[55]={{0,0,1,0,1,5}},
	[56]={{0,0,0,5},{1,0,1,5}},
	[57]={{0,4,1,4,1,0,0,0,0,3}},
}
