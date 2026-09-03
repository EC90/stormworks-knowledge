-- source: steam id 2851230589 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2851230589
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
PB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
asin=M.asin
atan=M.atan
pi=M.pi
pi2=M.pi*2

sptype,fl=PN('Speed Type'),PN('Filter Length')
state = 0
xbuf = 0
ybuf = 0
zbuf = 0
dis = 100
tha = 0.25
phy = 0
alfb = 0
thab = 0
phyb = 0
m = 0
sxbuf,sybuf,szbuf={},{},{}
p=0
for i = 1,fl do
	sxbuf[i] = 0
	sybuf[i] = 0
	szbuf[i] = 0
end

radarbuf={10,0,0}

compass,pitch,roll,dist,ang,tilt=0,0,0,10,0,0
x,y,z,speedx,speedy,speedz,count=0,0,0,0,0,0,0

LockFlag = false
ButtonBuf = false


function onTick()

local Lock,channel,Dis,Phy,Tha = false,0,{0, 0},{0, 0},{0, 0}
LockFlag = false
channelflag=false
if not LockFlag then
	Phy[2]=GN(2)
	Tha[2]=GN(3)
	Dis[2]=GN(1)
end
for i = 0,5 do
	channelflag=GB(i+2)
	Lock=GB(i+1)
	Dis[1]=GN(1+i*4)
	Phy[1]=GN(2+i*4)
	Tha[1]=GN(3+i*4)
	if Lock and not channelflag and Dis[1] > 4 and Dis[1] < 1500 then
		channel = i
		Dis[2]=Dis[1]
		Phy[2]=Phy[1]
		Tha[2]=Tha[1]
		LockFlag = true
		break
	end
end

	lock=GB(1+channel)
	en=lock
	aa=lock
	sx=GN(30)
	sy=GN(31)
	sz=GN(32)
	if state==0 then
		if lock then
			state=1
		else
			x=0
			y=0
			z=0
			state=0
		end
	end
	if state==1 then
		if lock then
			state=1
			phyb = -GN(27)*pi2
			thab = GN(28)*pi2
			alfb = -GN(29)*pi2
			
			xr = 0
			yr = 0
			zr = 0
			n = 0
			dis=GN(channel*4+1)
			phy=GN(channel*4+2)*pi2
			tha=GN(channel*4+3)*pi2
			xr=dis*cos(tha)*sin(phy)+xr
			yr=dis*cos(tha)*cos(phy)+yr
			zr=dis*sin(tha)+zr
			if xr+yr+zr<10 or xr~=xr then
				xr=radarbuf[1]
				yr=radarbuf[2]
				zr=radarbuf[3]
			end
			radarbuf[1]=xr
			radarbuf[2]=yr
			radarbuf[3]=zr
			
			sphyb = sin(phyb)
			cphyb = cos(phyb)
			sthab = sin(thab)
			cthab = cos(thab)
			salfb = sin(alfb)
			calfb = cos(alfb)
			y = ( yr*cphyb*cthab + xr*(cphyb*sthab*salfb-sphyb*calfb) + zr*(cphyb*sthab*calfb+sphyb*salfb) )
			x = ( yr*sphyb*cthab + xr*(sphyb*sthab*salfb+cphyb*calfb) + zr*(sphyb*sthab*calfb-cphyb*salfb) )
			z = ( yr*(-sthab) + xr*(cthab*salfb) + zr*(cthab*calfb) )
			xl,yl,zl=x,y,z
			if sptype==1 then
				speedx=x-xbuf
				speedy=y-ybuf
				speedz=z-zbuf
				xbuf=x
				ybuf=y
				zbuf=z
				x=x+sx
				y=y+sy
				z=z+sz
			else
				x=x+sx
				y=y+sy
				z=z+sz
				speedx=x-xbuf
				speedy=y-ybuf
				speedz=z-zbuf
				xbuf=x
				ybuf=y
				zbuf=z
			end
			sxbuf[m] = speedx/fl
			sybuf[m] = speedy/fl
			szbuf[m] = speedz/fl
			speedx = 0
			speedz = 0
			speedy = 0
			if aa and en then
				for i=1,fl do
					speedx = speedx + sxbuf[i]
					speedy = speedy + sybuf[i]
					speedz = speedz + szbuf[i]
				end
				m = m+1
				if m > fl then
					m = 1
				end
			else
				for i=1,fl do
					sxbuf[i] = 0
					sybuf[i] = 0
					szbuf[i] = 0
				end
			end
		else
			state=2
		end
	end
	if state==2 then
		--[[if count<120 and not lock then
			x=x+speedx
			y=y+speedy
			z=z+speedz
			state=2
			count=count+1
		end
		if count>=120 or not en then
			state=0
			count=0
		end
		if lock then
			state=1
			count=0
		end]]--
		state=0
	end
	SN(1, x)
	SN(2, y)
	SN(3, z)
	SN(4, speedx)
	SN(5, speedy)
	SN(6, speedz)
	SB(1, GB(32))
	SB(2, lock)
end

function onDraw()
	width = screen.getWidth()
	height = screen.getHeight()
	screen.setColor(255, 255, 255)
	screen.drawText(4, 4, speedx)
	screen.drawText(4, 12, speedy)
	screen.drawText(4, 20, speedz)
	if lock then
		screen.drawText(4, 28, 'Lock')
	else
		screen.drawText(4, 28, 'Unlock')
	end
	screen.drawText(4, 36, p)
	screen.drawText(4, 44, x)
	screen.drawText(4, 52, y)
	screen.drawText(4, 60, z)
end