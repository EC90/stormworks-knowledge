-- source: steam id 2808452796 / vehicle.xml block#2
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
MTS=map.mapToScreen

function len3(x,y,z)
	return (x^2+y^2+z^2)^0.5
end

function reg()
	p=0;ow=false
	t.m=abs(t.m)
	if #l==0 then
		p=1
	elseif #l<N or t.m-l[#l].m>-dM then
		for j=1,#l do
			dmi=t.m-l[j].m
			if abs(dmi)<=dM and len3(t.x-l[j].x,t.y-l[j].y,t.z-l[j].z)<dR then
				p=j;ow=true;break
			elseif dmi>dM then
				p=j;break
			elseif j==#l and #l<N then
				p=j+1;break
			end
		end
	end
	if p>0 then
		if ow then
			if t.t-l[p].t>3 then
				XO,YO,ZO,TO=l[p].x,l[p].y,l[p].z,l[p].t
			else
			XO,YO,ZO,TO=l[p].xO,l[p].yO,l[p].zO,l[p].tO
			end
			N,V=l[p].n,l[p].v
			tR(l,p)
		else
			N,V,XO,YO,ZO,TO=tID,nil,nil,nil,nil,nil
			tID=tID+1
		end
		tI(l,p,{m=t.m,x=t.x,y=t.y,z=t.z,t=t.t,n=N,v=V,xO=XO,yO=YO,zO=ZO,tO=TO})
		if #l>N then
		tR(l,#l)
		end
	end
end
function angDifp(a,b)
	return at(s(a-b),c(a-b))
end

function drA(x0,y0,r,q,qa,dN,fill)
	for j=-1,1,2 do
		dqi=j*qa/dN
		for i=1,dN/2 do
			qi1=q-dqi*i
			qi2=qi1+dqi
			x1,y1,x2,y2=x0+r*c(qi1),y0-r*s(qi1),x0+r*c(qi2),y0-r*s(qi2)
			if fill then
				sc.drawTriangleF(x0,y0,x1,y1,x2,y2)
			else
				drL(x1,y1,x2,y2)
			end
		end
	end
end

function onTick()
	act,map,lcl,orth=inB(1),inB(6),inB(7),inB(8)
	if map then
		yaw=inN(14)*pi2
		o.x,o.y,o.z,o.com=inN(1)+inN(7),inN(2)+inN(8),inN(3)+inN(9),inN(10)*pi2
		rng,fov,dRng=inN(23)/360,inN(24),inN(20)
		dr,cm=inB(4),inB(5)
	end
	if act and map then
		t.m,t.x,t.y,t.z,t.t=inN(25),inN(26),inN(27),inN(28),tick
		if abs(t.m)>=Mmin then
			reg()
		end
		if #l>0 then
			for j=1,#l do
				if l[j]~=nil and tick-l[j].t>delT then
					for k=j,#l-1 do
						l[k]=l[k+1]
					end
					tR(l,#l)
				end
			end
		end
		tick=tick+1
	else
		tick=0
	end
end

function onDraw()
w=sc.getWidth()
h=sc.getHeight()

	if map then
		if lcl then
			if orth then
				scw,sch,lxo,lyo=w/(rng*pi2),h/dRng,w/2,h
				lr,lq=dRng*sch,rng*scw
			else
				if rng>0.5 then
					scr,lxo,lyo=m.min(w,h)/(2*dRng),w/2,h/2
				else
					scr,lxo,lyo=m.min(h/dRng,w/(2*dRng*s(rng*pi))),w/2,h
				end
				lr,lq=dRng*scr,pi/2-yaw
			end
		else
			scr,lxo,lyo=m.min(w,h)/(2*dRng),w/2,h/2
			zoom=w/scr/10^3
			lr,lq=dRng*scr,pi/2+o.com-yaw
		end

sC(a,a,a,b)
		if dr then drT(2,2,"R"..string.format("%d",dRng)) end

sC(0,a,0)
		if act and #l>0 then
			for j=1,#l do
				dwx,dwy=l[j].x-o.x,l[j].y-o.y
				R2,Q=len3(dwx,dwy,0),angDifp(at(dwy,dwx),pi/2+o.com)
				if R2<dRng then
					if lcl and orth then
						mr,mq=R2*sch,-Q*scw
						mx,my=w/2+mq,h-mr
					elseif lcl then
						mr,mq=R2*scr,Q+pi/2
						mx,my=lxo+mr*c(mq),lyo-mr*s(mq)
					else
						mx,my=MTS(o.x,o.y,zoom,w,h,l[j].x,l[j].y)
					end
					sC(0,a,0,delT-(tick-l[j].t));drCF(mx,my,0.7)
				end
			end
		end
	end
end