-- source: steam id 2800117544 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2800117544
i=input
ign=i.getNumber
osb=output.setBool
pi=math.pi; pi2=pi*2
s=screen; m=math
ssc=s.setColor
stt=s.drawText
stb=s.drawTextBox
srf=s.drawRectF
fom=string.format
w=64; h=64
iof=0; dof=0; terof=0; tervof=0
iofo=0; dofo=0; terfo=0; tervo=0
dt=0; it=0; tert=0; tervt=0

viewo=0
viewo1=0
viewold=0
tmxold=0
tmyold=0

info=false
data=false
terminal=false
info1=false
data1=false
terminal1=false
vold=false
viewtoggle=false
terminalold=false
function onTick()
inputX=ign(1)
inputY=ign(2)
tx=ign(4)
ty=ign(5)
sx=ign(6)
sy=ign(7)
apex=ign(8)
tmx=ign(9)
tmy=ign(10)
tmc=ign(12)*pi2
qolstr=ign(13)
touch=i.getBool(3)

dest=((tx-sx)^2+(ty-sy)^2+(apex*2)^2)^0.5*1.2
sdist=((tx-sx)^2+(ty-sy)^2)^0.5
avgs=property.getNumber("Missile Average Speed")
test=dest/avgs

xvel=tmx-tmxold
tmxold=tmx
yvel=tmy-tmyold
tmyold=tmy
truevel=(xvel^2+yvel^2)^0.5

mdist1=((tmx-tx)^2+(tmy-ty)^2)^0.5

infoold=info1
info1=button(inputX, inputY, w-24, 2, 25, 6, touch)
infopulse=info1 and (not infoold)
if infopulse then
info=not info
end

dataold=data1
data1=button(inputX, inputY, w-24, 10, 25, 6, touch)
datapulse=data1 and (not dataold)
if datapulse then
data=not data
end

terminalold=terminal1
terminal1=button(inputX, inputY, w-24, 18+tervof, 25, 6, touch)
terminalpulse=terminal1 and (not terminalold)
if terminalpulse then
terminal=not terminal
end

vold=v
v=button(inputX, inputY, w-24, 18, 25, 6, touch)
vpulse=v and (not vold)
if vpulse then
viewtoggle=not viewtoggle and (not info)
end

if info1 and data then data=false viewtoggle=false end
if data1 and info then info=false end
if info then it=-1.5 else it=0 end
if data then dt=-1.5 else dt=0 viewtoggle=false end
if (not (qolstr>0)) and data then viewtoggle=false end
if terminal then tert=-1.5 else tert=0 end

osb(1, viewtoggle and (qolstr>0))
osb(32, terminal)

end
function onDraw()
w=s.getWidth()
h=s.getHeight()
ssc(150,150,150,55)
srf(-1, -1, w+1, h+1)

highlight(info) -- info
srf(w-21+iof, 2, 21, 7)
ssc(220, 220, 220, 240)
stt(w-20+iof, 3, "Info")
ssc(220, 220, 220, 240)
srf(w+iof, 2, 3, 7)

highlight(data) -- data
srf(w-21+dof, 10, 21, 7)
ssc(220, 220, 220, 240)
stt(w-20+dof, 11, "Data")
ssc(220, 220, 220, 240)
srf(w+dof, 10, 3, 7)

highlight(terminal) -- terminal
srf(w-21+terof, 18+tervof, 21, 7)
ssc(220, 220, 220, 240)
stt(w-20+terof, 19+tervof, "TRH") --terminal radar homing
ssc(220, 220, 220, 240)
srf(w+terof, 18+tervof, 3, 7)

iof1=it*0.3+iofo*0.7
iofo=iof1
dof1=dt*0.3+dofo*0.7
dofo=dof1
ter1=tert*0.3+terfo*0.7
terfo=ter1
terv1=tervt*0.6+tervo*0.4
tervo=terv1
dof=m.ceil(dof1)
iof=m.ceil(iof1)
terof=m.ceil(ter1)
tervof=clamp(m.floor(terv1), 0, 8)

if info then
ssc(3,3,3,228)
srf(0, 1, 41, 13)
ssc(220, 220, 220, 240)
stb(1, 2, 41, 5, fom("X%.0f", tx), -1, 0)
stb(1, 8, 41, 5, fom("Y%.0f", ty), -1, 0)

ssc(3,3,3,228)
srf(0, 15, 41, 7)
ssc(220, 220, 220, 240)
stb(1, 16, 41, 5, fom("EST:%.0fs", test), -1, 0)

ssc(3,3,3,228)
srf(0, 23, 41, 7)
ssc(220, 220, 220, 240)
stb(1, 24, 41, 5, fom("DST:%.0fKM", sdist/1000), -1, 0)
end
if data then
	if qolstr>0 then
	viewt=0.5
	tervt=9
	
		if viewtoggle then
		viewt=-0.5
		else
		viewt=0.5
		end

	ssc(3,3,3,228)
	srf(0, 1, 41, 13)
	ssc(220, 220, 220, 240)
	stb(1, 2, 41, 5, fom("X%.0f", tmx), -1, 0)
	stb(1, 8, 41, 5, fom("Y%.0f", tmy), -1, 0)
	
	ssc(3,3,3,228)
	srf(0, 15, 41, 7)
	ssc(220, 220, 220, 240)
	stb(1, 16, 41, 5, fom("EST %.0fS", m.min((mdist1/(truevel*60)), 999)), -1, 0)
	else
	viewt=22
	tervt=0
	
	ssc(3,3,3,228)
	srf(1, 2, 36, 7)
	ssc(220, 220, 220, 240)
	stb(2, 3, 48, 7, "No Data", -1, -1)
	end
else	
viewt=22
tervt=0
end

viewo1=viewt*0.3+viewold*0.7
viewold=viewo1
viewo=m.floor(viewo1)
	
ssc(4,4,4,228)
srf(w-21+viewo, 18, 21, 7)
ssc(220, 220, 220, 240)
stt(w-20+viewo, 19, "View")
ssc(220, 220, 220, 240)
srf(w+viewo, 18, 3, 7)
end
function highlight(high)
if high then ssc(9, 9, 9, 198) else ssc(4,4,4,228) end
end
function button(ix, iy, bx, by, bw, bh, touch)
return (ix>=bx) and (iy>=by) and (ix<=bx+bw) and (iy<=by+bh) and touch
end
function clamp(x, y, z)
return m.max(y, m.min(x, z))
end