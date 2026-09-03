-- source: steam id 3793581819 / vehicle.xml block#40
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
ign=input.getNumber
igb=input.getBool
osn=output.setNumber
osb=output.setBool
pgn=property.getNumber
tan=math.tan
rad=math.rad
pi=math.pi

tar=pgn("Max Target")
R=pgn("R")
G=pgn("G")
B=pgn("B")
rs=pgn("Rectangle Size")
set=pgn("Target Info")
ofx=pgn("Offset X")
ofy=pgn("Offset y")

w=0
h=0
min=0
zoom=0

ri={}
od={}

xavg={}
yavg={}
davg={}
iavg={}
isum={}

dis={}
xv={}
yv={}

x={}
y={}
s={}
d={}
v={}
la={}
lm={}
ms={}

td={}
ts={}
on={}

cmp={}
xyp={}
cmpx={}
cmpy={}
function Table(num)
	for i=1,num do
	xavg[i]=0
	yavg[i]=0
	davg[i]=0
	iavg[i]=0
	od[i]=0
	ri[i]={}
	cmp[i]={}
	cmpx[i]={}
	cmpy[i]={}
	xyp[i]=0
	end
end

Table(tar)

function clamp(min, max, value)
  return math.min(max, math.max(min, value))
end

fov=120
function onTick()

	camx=clamp(-1,1,ign(30))
	camy=clamp(-1,1,ign(31))
	zoom=clamp(0,1,ign(32))
	ang=math.max(fov*(1-zoom),1)
	zx=tan(ang*pi/180/2)/(1.82-0.15*(w/h-1))
	zy=tan(ang*pi/180/2)/1.82

	for i=1,tar do
	n=i+(i-1)*3
	dis[i]=ign(n)
	xv[i]=ign(n+1)
	yv[i]=ign(n+2)
	td[i]=igb(i)
	Cal(i)
	end

end

function Cal(num)

	v[num]=math.min(math.floor(dis[num])/1000,0.8)
	xavg[num]=xavg[num]*v[num]+xv[num]*(1-v[num])
	yavg[num]=yavg[num]*v[num]+yv[num]*(1-v[num])
	davg[num]=davg[num]*v[num]+dis[num]*(1-v[num])

	isum[num]=0
	ts[num]=math.min(math.floor(davg[num]/5),150)
	table.insert(ri[num],davg[num])
	if #ri[num]>ts[num] then
	table.remove(ri[num],1)
	end
	for i=1,#ri[num] do
	isum[num]=isum[num]+ri[num][i]
	end
	iavg[num]=isum[num]/#ri[num]

	a=math.floor(davg[num])
	b=1-(a/5000)
	c=1/(a/(5-(b*2.5)))

	xco=tan(rad(xavg[num]*360-camx*45))*(w/4/zx)*(h/w)+w/2
	yco=-tan(rad(yavg[num]*360-camy*45))*(h/4/zy)+h/2
	size=math.max(rs*c*(w/32),0)*(fov/ang)*(h/w)
	ms[num]=-math.floor(((iavg[num]-od[num])/0.016)//1)
	od[num]=iavg[num]

	lena=2-string.len(a)*2.5
	lenm=-2-string.len(ms[num])*2.5

	x[num]=xco
	y[num]=yco
	s[num]=size
	d[num]=a
	la[num]=lena
	lm[num]=lenm

	end

function onDraw()

	w=screen.getWidth()
	h=screen.getHeight()

	cx=w/2
	cy=h/2

	for i=1,tar do
	for j=1,tar do
	if not (i==j) then
	cmp[i][j]=math.abs(d[i]-d[j])
	cmpx[i][j]=math.abs(x[i]-x[j])
	cmpy[i][j]=math.abs(y[i]-y[j])
	end
	if ((cmp[i][j] or 16)<15 and (cmp[i][j] or -1)>=0) and (cmpx[i][j]<=s[i] and cmpy[i][j]<=s[i]) then
	td[j]=false
	end
	end

	xyp[i]=math.abs(cx-math.floor(x[i]))+math.abs(cy-math.floor(y[i]))
	min=xyp[i]
	for j=1,tar do
	if min>=xyp[j] and td[j] then
	min=xyp[j]
	end
	end

	if (min+h/32+0.5)>xyp[i] and td[i]==true then
	on[i]=true
	else
	on[i]=false
	end

	if td[i] then
	if on[i] then
	if set==1 or set==3 then
	screen.setColor(R,G,B,255)
	screen.drawText(x[i]+lm[i]+ofx,y[i]-s[i]/2-6+ofy,ms[i] .. "m/s")
	end
	if set==1 or set==2 then
	if d[i]>1000 then
	screen.drawText(x[i]+la[i]+ofx,y[i]+s[i]/2+3+ofy,string.format("%0.1f",d[i]/1000))
	else
	screen.drawText(x[i]+la[i]+ofx,y[i]+s[i]/2+3+ofy,d[i])
	end
	end
	else
	screen.setColor(R,G,B,200)
	end
	screen.drawRect(x[i]-s[i]/2+ofx,y[i]-s[i]/2+ofy,s[i],s[i])
	screen.setColor(R,G,B, 255)
	end
	end

end