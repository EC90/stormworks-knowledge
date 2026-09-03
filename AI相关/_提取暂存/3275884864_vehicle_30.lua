-- source: steam id 3275884864 / vehicle.xml block#30
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
--lidar2024
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.atan
Mas=M.asin
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
pi2=M.pi*2
pi=M.pi
px=0 py=0
--sensor count
sx=PN('laser column')
sy=PN('laser row')
--xps yps
xps=PN('x per sensor')
yps=PN('y per sensor')
--resolution
mx=sx*xps
my=sy*yps
r={}
delayfix=PN('System Delay')
timer=delayfix
for i=1,my do r[i]={} for j=1,mx do r[i][j]=0 end end
function Mp(value,vmin,vmax)
	return math.max(math.min(vmax,value),vmin)
end
maxd=4000
function onTick()
	--
	pvtox=GN(1)
	pvtoy=GN(2)
	--
	rendermode=GN(4)
	--camera
	if GN(3)~=0 then cfov=GN(3) else cfov=0.5 end
	--camera fov to laser sen fov
	fov=8*(2.2-cfov*2.175)/pi2
	if cfov<0.8 then rk=2 else rk=1 end
	--resolution
	mx=sx*xps/rk
	my=sy*yps/rk
	if rendermode>0 then
		for i=0,sx*sy-1 do
			cury=py+1+Mf(i/sx)*(yps/rk)
			curx=px+1+(i%sx)*(xps/rk)
			r[cury][curx]=GN(11+i)
			SN(2*i+11,pvtox+fov/mx*(timer%(xps/rk)+(i%sx)*(xps/rk))-fov/2+fov/mx/2)
			SN(2*i+12,pvtoy-(fov/my*(Mf((timer%((xps/rk)*(yps/rk)))/(xps/rk))+(yps/rk)*Mf(i/sx))-fov/2+fov/my/2))
		end
		timer=timer+1
		px=(timer-delayfix)%(xps/rk)
		py=Mf((timer-delayfix)/(yps/rk))%(yps/rk)
		--
		rpux=fov*0.25*pi/mx
		rpuy=fov*0.25*pi/my*(my/mx)
		--
	end
end
S=screen
SC=S.setColor
DC=S.drawCircle
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
DR=S.drawRect
DRF=S.drawRectF
D3F=S.drawTriangleF
function onDraw()
	rx=S.getWidth()
	ry=S.getHeight()
	psx=rx/mx
	psy=ry/my
	if rendermode>0 then
		for i=1,my do
			for j=1,mx do
				dC=r[i][j]
				scale=Mp(1-dC/maxd,0,1)^2
				--scale=1
				if i==1 then dU=dC+(dC-r[i+1][j]) else dU=r[i-1][j] end
				if i==my then dD=dC+(dC-r[i-1][j]) else dD=r[i+1][j] end
				if j==1 then dL=dC+(dC-r[i][j+1]) else dL=r[i][j-1] end
				if j==mx then dR=dC+(dC-r[i][j-1]) else dR=r[i][j+1] end
				nmlx=Ma(dR-dL,2*Ms(rpux)*dC)/pi
				nmly=-Ma(dD-dU,2*Ms(rpuy)*dC)/pi
				if rendermode==2 then
					maxd=2000
					SC((128+128*nmlx)*scale,(128-128*nmly)*scale,scale*255)
				elseif rendermode>2 then
					maxd=2000
					alf=(128+128*nmlx)*0.6+(128-128*nmly)*0.4
					if rendermode==3 then
						SC(alf*scale,alf*scale,alf*scale)
					else
						SC(255-alf*scale,255-alf*scale,255-alf*scale)
					end
				else
					maxd=4000
					crb=Mp(4*nmly^4+8*nmlx^4,0,1)*255
					cg=(16+16*nmly)
					SC(crb,Mp(crb+cg,0,255),crb,Mp(scale*255+crb,0,255))
				end
				DRF((j-1)*psx,(i-1)*psy,psx,psy)
			end
		end
	end
	--SC(255,0,0)
end