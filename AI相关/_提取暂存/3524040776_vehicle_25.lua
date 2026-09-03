-- source: steam id 3524040776 / vehicle.xml block#25
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--sonar
S=screen
SC=S.setColor

DC=S.drawCircle
DCF=S.drawCircleF
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
DR=S.drawRect
DRF=S.drawRectF

M=math
Ma=M.atan
Mas=M.asin
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
Mx=M.max
pi=M.pi
pi2=pi*2

tx,ty,tz=0,0,0
txo,tyo,tzo=0,0,0
vtx,vty,vtz=0,0,0

sxo,syo,szo=0,0,0

GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber

R={0,0,0,0}
Rs={}
t1,t2={},{}
pxo,pyo=0,0
ping=false
ctmax=120
rmax=1481*(ctmax/120)
count=0
function DC(x,y,r)
	for i=1,360 do
		x1=x+r*Ms(pi2*i/360)
		y1=y-r*Mc(pi2*i/360)
		x2=x+r*Ms(pi2*(i+1)/360)
		y2=y-r*Mc(pi2*(i+1)/360)
		DL(x1,y1,x2,y2)
	end
end
function DB(x,y,a,l)
DL(x,y,x+l*Ms(a*pi2),y-l*Mc(a*pi2))
end
function psa(x,y,z)
p=-Mas(Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y))
r=Mas(Ms(y)*Mc(z))
c=Ma(Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Mc(x)*Mc(z))
return p,r,c
end
function Av(n,v,t)
	t=Mx(Mf(t),1) table.insert(n,v) local s=0
	if #n>t then for i=1,#n-t do table.remove(n,1) end end
	for i=1,#n do s=s+n[i] end return s/#n
end
function onTick()
	sx,sy,sz=GN(1),GN(3),GN(2)
	dsx,dsy,dsz=Av(t1,sx-sxo,60),Av(t2,sy-syo,60),sz-szo
	sxo,syo,szo=sx,sy,sz
	rp,rr,rc=psa(GN(4),GN(6),GN(5))
	if GN(9)>0.5 then
	if ping then
		count=count+1
	else
		ping=true
	end
	if GN(7)~=0 and count>5 then
		R={count,GN(7),GN(8),0}
		--count=ctmax+1
	end
	if count>ctmax then
		count=0
		ping=false
	end
	R[4]=R[4]+1
	if not ping and R[4]<ctmax then
		txo,tyo,tzo=tx,ty,tz
		rd=((R[1]-3.5)/60)*1481*0.5 ra=R[2]*pi2 re=R[3]*pi2
		xr,yr,zr=rd*Mc(re)*Ms(ra),rd*Mc(re)*Mc(ra),rd*Ms(re)
		src,crc,srp,crp,srr,crr=Ms(rc),Mc(rc),Ms(rp),Mc(rp),Ms(rr),Mc(rr)
		dx=(yr*src*crp+xr*(src*srp*srr+crc*crr)+zr*(src*srp*crr-crc*srr))
		dy=(yr*crc*crp+xr*(crc*srp*srr-src*crr)+zr*(crc*srp*crr+src*srr))
		dz=(yr*(-srp)+xr*(crp*srr)+zr*(crp*crr))
		tx,ty,tz=dx+sx,dy+sy,dz+sz
		if #Rs>16 then
			table.remove(Rs,1)
		end
		table.insert(Rs,{tx,ty,tz})
		vtx=(tx-txo)/R[1] vty=(ty-tyo)/R[1] vtz=(tz-tzo)/R[1]
	end
	if R[4]<ctmax then
		txc=tx+vtx*(count-0)
		tyc=ty+vty*(count-0)
		tzc=tz-vtz*(count-0)
	else
		txc,tyc,tzc=0,0,0
	end
	SB(1,ping)
	SN(1,txc)
	SN(2,tyc)
	SN(3,tzc)
	SN(4,count)
	else
	SB(1,false)
	SN(1,0)
	SN(2,0)
	SN(3,0)
	SN(4,0)
	end
end
function onDraw()
	w,h=S.getWidth(),S.getHeight()
	SC(5,5,5)
	S.drawClear()
	SC(22,222,44,22)
	DC(w/2,h/2,h/2)
	DC(w/2,h/2,h/4)
	DL(w/2,0,w/2,h)
	DL(0,h/2,w,h/2)
	for i=1,4 do
		SC(22,222,44,64/i)
		DC(w/2,h/2,h*count/ctmax+1-i)
	end
	SC(22,222,44)
	DT(0,h-5,0.1*M.ceil(rmax/100)..'km')
	DT(0,0,'SONAR')
	if #Rs>1 then
		for i=1,#Rs do
			px=(Rs[i][1]-sx)/rmax*0.5*h*Mc(rc)-(Rs[i][2]-sy)/rmax*0.5*h*Ms(rc)
			py=(Rs[i][1]-sx)/rmax*0.5*h*Ms(rc)+(Rs[i][2]-sy)/rmax*0.5*h*Mc(rc)
			SC(22,222,44,255*(i/#Rs))
			DCF(w/2+px-1,h/2-py-1,1)
			if i>1 then
				SC(22,222,44,64*(i/#Rs))
				DL(px,py,pxo,pyo)
			end
			pxo,pyo=px,py
		end
	end
end