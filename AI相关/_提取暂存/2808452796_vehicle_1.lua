-- source: steam id 2808452796 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2808452796
tick=0
t,l,o={},{},{}
zoom,scr=1,0.1
Mmin=25
dM,dR=2,100
delT=450
tID,N=101,32
divNm,dq=6,10/360
divq=1/8
a,b=255,127
inB=input.getBool;inN=input.getNumber;ouB=output.setBool;ouN=output.setNumber
tI=table.insert;tR=table.remove
m=math
pi=m.pi
pi2=2*pi
s=m.sin
c=m.cos
as=m.asin
at=m.atan
abs=m.abs
sc=screen
sC=sc.setColor
drT=sc.drawText
drL=sc.drawLine
drC=sc.drawCircle
drCF=sc.drawCircleF
drTF=sc.drawTriangleF
MTS=map.mapToScreen

function len3(x,y,z)
	return (x^2+y^2+z^2)^0.5
end

function drA(x0,y0,r,q,qa,dN,fill)
	for j=-1,1,2 do
		dqi=j*qa/dN
		for i=1,dN/2 do
			qi1=q-dqi*i
			qi2=qi1+dqi
			x1,y1,x2,y2=x0+r*c(qi1),y0-r*s(qi1),x0+r*c(qi2),y0-r*s(qi2)
			if fill then
				drTF(x0,y0,x1,y1,x2,y2)
			else
				drL(x1,y1,x2,y2)
			end
		end
	end
end

function angDifp(a,b)
	return at(s(a-b),c(a-b))
end

function onTick()
	act,map,lcl,orth=inB(1),inB(6),inB(7),inB(8)
	if map then
		yaw=inN(14)*pi2
		o.x,o.y,o.z,o.com=inN(1)+inN(7),inN(2)+inN(8),inN(3)+inN(9),inN(10)*pi2
		rng,fov,dRng=inN(23)/360,inN(24),inN(20)
		dr,cm=inB(4),inB(5)
	end
end

function onDraw()
w=sc.getWidth()
h=sc.getHeight()
w=w-1

	if map then
		if lcl then
			if orth then
				scw,sch,lxo,lyo=w/(rng*pi2),h/dRng,w/2,h
				lr,lq0=dRng*sch,0;lq=lq0-yaw
			else
				if rng>0.5 then
					scr,lxo,lyo=m.min(w,h)/(2*dRng),w/2,h/2
				else
					scr,lxo,lyo=m.min(h/dRng,w/(2*dRng*s(rng*pi))),w/2,h
				end
				lr,lq0=dRng*scr,pi/2;lq=lq0-yaw
			end
		else
			scr,lxo,lyo=m.min(w,h)/(2*dRng),w/2,h/2
			zoom=w/scr/10^3
			sc.setMapColorLand(70,70,70);sc.setMapColorGrass(25,40,25);sc.drawMap(o.x,o.y,zoom)
			lr,lq0=dRng*scr,pi/2+o.com;lq=lq0-yaw
		end

		sC(63,a,63,b)
		if rng>divq then
			dlq=divq*pi2
			for i=1,rng/2/divq do
			for j=-1,1,2 do
				lqi=lq0-j*i*dlq
				if orth then
					lqi=lqi*scw+lxo
					drL(lqi,0,lqi,lyo)
				elseif not (rng==1 and i==rng/2/divq and j==1) then
					drL(lxo,lyo,lxo+lr*c(lqi),lyo-lr*s(lqi))
				end
			end
			end
		end
		if orth then
			drL(0,h/2,w,h/2)
			sC(63,a,63,195);drL(lxo,0,lxo,lyo)
		else
			divN=m.ceil(m.ceil(m.max(divNm,rng/dq))/2)*2
			drL(lxo,lyo,lxo+lr*c(lq0),lyo-lr*s(lq0))
			drA(lxo,lyo,lr/2,lq0,rng*pi2,divN,false)
		end

		sC(31,a,31,b)
		if act then
			if orth then
				for j=-1,1 do
					lxl,lxw=lxo+(-lq+j*pi2-fov*pi)*scw,fov*pi2*scw
					sc.drawRectF(lxl,0,lxw,lyo)
				end
			else
				drA(lxo,lyo,lr,lq,fov*pi2,6,true)
			end
		end

		sC(0,a,0)
		if orth then
			sc.drawRect(0,0,w-0,h-1)
		else
			drA(lxo,lyo,lr,lq0,rng*pi2,divN,false)
			if rng<1 then
				for j=-1,1,2 do
					lqe=lq0-j*rng*pi
					drL(lxo,lyo,lxo+lr*c(lqe),lyo-lr*s(lqe))
				end
			end
		end

		if lcl and cm then
			for i=-1,1,2 do
				if orth then
					if i==1 then sC(15,15,a,b) else sC(a,15,15,b) end
					cq=angDifp(o.com+i*pi/2+pi/2,0)*scw
					drL(lxo+cq,1,lxo+cq,lyo-1)
				else
					if i==1 then sC(15,15,a) else sC(a,15,15) end
					cq=-o.com-i*pi/2
					tq=pi/32
					drTF(lxo+(lr-2)*c(cq),lyo-(lr-2)*s(cq),lxo+(lr+2)*c(cq+tq),lyo-(lr+2)*s(cq+tq),lxo+(lr+2)*c(cq-tq),lyo-(lr+2)*s(cq-tq))
				end
			end
		end
	end
end