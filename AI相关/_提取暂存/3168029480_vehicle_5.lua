-- source: steam id 3168029480 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3168029480
--scope sight
S=screen
SC=S.setColor
SF=string.format
function C(c)
if c==0 then SC(0,0,0)
elseif c==1 then SC(200,30,15)
elseif c==17 then SC(200,30,15,180)
elseif c==3 then SC(200,120,15)
elseif c==4 then SC(15,220,30)
elseif c==47 then SC(15,220,30,180)
end
end

DC=S.drawCircle
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
DR=S.drawRect
DTF=S.drawTriangleF
DRF=S.drawRectF

M=math
function Mf(x) return M.floor(x+0.5) end
Mc=M.sin
Ms=M.cos
pi=M.pi
pi2=pi*2

GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool

z=0.502
fov=1.1125
PN=property.getNumber
rx=PN('Radar Fov X') ry=PN('Radar Fov Y')
function onTick()
	F=(1-z)*(2.2-0.025)+0.025
	Ft=F/pi2
	SN(1,F)
	fx0,fy0=0.5*((M.floor(GN(24)/1000)-500)*0.002),-1.38*((GN(24)%1000-500)*0.002)-0.0439
end
function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	fx,fy=Mf(w*(fx0/(fov*w/h))),Mf(h*(fy0/fov))
	C(47)
	DR(w/2-h*rx/Ft/2+fx,h/2-h*ry/Ft/2+fy,2*h/2*rx/Ft,2*h/2*ry/Ft)
end