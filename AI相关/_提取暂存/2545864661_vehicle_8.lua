-- source: steam id 2545864661 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2545864661
gN,gB,sB,sN,sC,s,pN=input.getNumber,input.getBool,output.setBool,output.setNumber,screen.setColor,screen,property.getNumber
dt,dtb,dc,dcf,dr,drf,dtr,dtf,dl=s.drawText,s.drawTextBox,s.drawCircle,s.drawCircleF,s.drawRect,s.drawRectF,s.drawTriangle,s.drawTriangleF,s.drawLine
ma=map
cos=math.cos
sin=math.sin
mts=ma.mapToScreen
stm=ma.screenToMap
z,smy,smx=5,0,0

m=false
function tf(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onTick()
	w,h,gx,gy,gz,tx,ty,t,trgx,trgy,ct,hdg=gN(1),gN(2),gN(8),gN(9),gN(7),gN(3),gN(4),gB(1),gN(10),gN(11),gB(3),-(gN(12)+0.25)*math.pi*2
	zi=t and tf(tx,ty,9,h-10,6,6)
	zo=t and tf(tx,ty,15,h-10,6,6)
	mr=t and tf(tx,ty,21,h-12,6,8)
	ms=t and tf(tx,ty,w/2-4,h-9,7,8)	-- map moving
	mn=t and tf(tx,ty,w/2-4,3,7,7)
	mw=t and tf(tx,ty,2,h/2-6,7,8)
	me=t and tf(tx,ty,w-7,h/2-6,7,8)

	if ms or mn or mw or me and f==false then	--flip for map move
		f=true
	elseif mr then
		f=false
	end
	if not f and not ct then 
		mx=gx
		my=gy
	elseif ct then 
		mx=trgx
		my=trgy	
	end
	if ms then
		my=my-5*z	
	elseif mn then
		my=my+5*z
	elseif me then
		mx=mx+5*z
	elseif mw then
		mx=mx-5*z
	end

	if zi and z>1 then
		z=z-0.1
	elseif zo and z<50 then 
		z=z+0.1
	end
	if zi or zo or mr or ms or mn or mw or me then
		mt=true
	else
		mt=false
	end
	sN(1,w)
	sN(2,h)
	sN(3,gx)
	sN(4,gy)
	sN(5,gz)
	sN(6,tx)
	sN(7,ty)
	sN(8,z)
	sN(9,mx)
	sN(10,my)
	sB(1,t)
	sB(2,mt)
end

r,g,b=1,1,1

function onDraw()
	s.setMapColorOcean(10*r,11*g,12*b)
	s.setMapColorShallows(100*r,110*g,120*b,64)
	s.setMapColorGrass(90*r,90*g,90*b)
	s.setMapColorSand(100*r,100*g,120*b)
	s.setMapColorLand(80*r,80*g,80*b)
	s.setMapColorSnow(120*r,120*g,120*b)
	s.drawMap(mx,my,z)
	sC(40*r,40*g,40*b,64)
	
	if z<25 then
		scale=1.852*1000
	else
		scale=1.852*2000
	end
	
	mmx,mmy=mts(mx,my,z,w,h,gx,gy)
	sx, sy = stm(mx,my,z,w,h,-50,-50)
	sx = sx - sx % scale
	sy = sy - sy % scale
	for i = sx, sx + scale * 50 , scale do
		xl, yl = mts(mx, my, z, w, h, i, i)
		dl(xl, -1, xl, 800)
	end
	for ii=sy,sy-scale*50,-scale do
		xl, yl = mts(mx, my, z, w, h, ii, ii)
		dl(-1, yl, 800, yl)
	end
	sC(67,67,100)
	dc(mmx,mmy,2)
	dl(mmx,mmy,mmx+cos(hdg)*7,mmy+sin(hdg)*7)
	sC(100,100,150)
	dcf(mmx,mmy,2)
	sC(0,0,0,122.5)
	dr(7,h-12,20,8)
	dt(9,h-10,"+")
	dt(15,h-10,"-")
	dt(21,h-10,"r")
	dtb(w/2-3,4,5,5,"N")
	dtb(w/2-3,h-7,5,5,"S")
	dtb(2,h/2-1,5,5,"W")
	dtb(w-9,h/2-1,5,5,"E")
	sC(r*100,g*100,b*100)
	dr(8,h-13,20,8)
	dt(10,h-11,"+")
	dt(16,h-11,"-")
	dt(22,h-11,"r")
	dtb(w/2-2,3,5,5,"N")
	dtb(w/2-2,h-8,5,5,"S")
	dtb(3,h/2-2,5,5,"W")
	dtb(w-8,h/2-2,5,5,"E")
	sC(0,g*255,0,200)
end