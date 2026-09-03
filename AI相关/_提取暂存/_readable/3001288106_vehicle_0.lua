c_s={0.2,1,0.2}ux,uy=0,0
xm,ym=1,1
xr,yr=96,96
Xqm=96
Yqm=96
xs,ys=xm/xr,ym/yr
lxo=-xm
lyo=-ym
res="S"istep=1
g=0
w,h=96,96
qdr=-1
curr_q=1
w2,h2=96,96
miv,mav=0,0
m,n=1,1
lp=false
data={}
for i=1,96
do
data[i]={}
for j=1,96
do
data[i][j]=0
end
end
rng=false
srtd=false
ti=true
s=0
function getq(q)lX=math.sqrt((-xm-xm)^2)lY=math.sqrt((-ym-ym)^2)
	if q==1
	then
	a=-xm
	b=-ym
elseif q==2
then
a=-xm+lX/3
b=-ym
elseif q==3
then
a=-xm+2*lX/3
b=-ym
elseif q==4
then
a=-xm
b=-ym+lY/3
elseif q==5
then
a=-xm+lX/3
b=-ym+lY/3
elseif q==6
then
a=-xm+2*lX/3
b=-ym+lY/3
elseif q==7
then
a=-xm
b=-ym+2*lY/3
elseif q==8
then
a=-xm+lX/3
b=-ym+2*lY/3
elseif q==9
then
a=-xm+2*lX/3
b=-ym+2*lY/3
end
return a,b
end
function onTick()isP=input.getBool(1)inX=input.getNumber(3)inY=input.getNumber(4)wrt=false
	lx=input.getNumber(12)ly=input.getNumber(13)dst=input.getNumber(5)agl=math.atan(math.sqrt(lxo^2+lyo^2),1)dst=dst*math.cos(agl)
	if ti
	then
	if rng
	then
	mav=fmax(data)miv=fmin(data)lxo=lxo+xs*1.9*istep
	if res=="S"
	then
	if n>96
	then
	if m+3>Yqm
	then
	rng=false
	data[m][n]=dst
else
	lxo=-xm
	ti=false
	data[m][n]=dst
	n=0
	lyo=lyo+ys*1.9*istep
	m=m+istep
	wrt=true
end
end
if m<96 and n~=0
then
for c=0,2
do
for d=0,2
do
data[m+c][n+d]=dst
end
end
end
else
	if n>Xqm
	then
	ti=false
	lyo=lyo+ys*1.9
	data[m][n]=dst
	n=qdr-1
	lxo,_=getq(curr_q)m=m+istep
	wrt=true
	if m>Yqm-1
	then
	rng=false
end
end
end
if not wrt
then
data[m][n]=dst
end
if n==0
then
n=1
else
	n=n+istep
end
end
else
	s=s+1
	if s>=3
	then
	ti=true
	s=0
end
end
if btp(w*0.9,h*0.2,6,6)and rng==false
then
xm=xm*0.5
ym=ym*0.5
g=g+1
xr,yr=xr/2,yr/2
end
if btp(w*0.9,h*0.5,6,6)and rng==false
then
xm=xm*1/0.5
ym=ym*1/0.5
g=g-1
xr,yr=xr*2,yr*2
end
if btp(w*0.8-7.5,h-9,10,10)
then
rng=false
xr,yr=w2/3,h2/3
istep=3
res="S"rst()
end
if btp(w*0.2-7.5,h-9,10,10)
then
xr,yr=w2/3,h2/3
istep=3
rng=true
res="S"srtd=true
rst()
end
q=1
k=1
while k<=w
do
j=1
while j<=h
do
if btp(j,k,w/3,h/3)and rng==false
then
qdr=j
m,n=k,j-1
curr_q=q
lxo,lyo=getq(curr_q)Xqm=j+w/3
Yqm=k+h/3
xr,yr=w2,h2
rng=true
res="L"istep=1
end
j=j+h/3
q=q+1
end
k=k+w/3
end
output.setNumber(12,mav)output.setNumber(13,miv)output.setNumber(1,lxo)output.setNumber(2,lyo)output.setNumber(7,m)output.setNumber(8,n)output.setNumber(9,dst)
if res=="S"
then
output.setBool(10,true)
else
	output.setBool(10,false)
end
if not isP
then
lp=false
end
end
function onDraw()w,h=screen.getWidth(),screen.getHeight()
	for m,e in ipairs(data)
	do
	for n,f in ipairs(data[m])
	do
	scaled=sk(f,miv,mav)screen.setColor(c_s[1]*255*scaled,c_s[2]*255*scaled,c_s[3]*255*scaled)screen.drawRectF(n-1,m-1,1,1)
end
end
setC(255,255,255)screen.drawRectF(w*0.2-7.5,h-9,10,10)screen.drawRectF(w*0.9,h*0.5,6,6)screen.drawRectF(w*0.9,h*0.2,6,6)screen.drawRectF(w*0.8-7.5,h-9,10,10)setC(0,0,0)screen.drawTextBox(w*0.2-7.5,h-9,10,10,">",1,0)screen.drawTextBox(w*0.9,h*0.5,6,6,"-",0,0)screen.drawTextBox(w*0.9,h*0.2,6,6,"+",0,0)screen.drawTextBox(w*0.8-7.5,h-9,10,10,"X",1,0)o=0
i=1
while o<w
do
setC(200,200,200,100)screen.drawRect(0,o,w/3,h/3)i=i+1
screen.drawRect(w/3,o,w/3,h/3)i=i+1
screen.drawRect(2*w/3,o,2*h/3,h/3)o=o+h/3
i=i+1
end
if rng
then
setC(1,1,200)screen.drawTextBox(w*0.3+1,h*0.2+1,41,10,"Scanning")ux,uy=lx*48/0.25,ly*48/0.25
end
setC(2,2,255,100)screen.drawText(3,3,"x"..g)x,y=w/2+lx*48/0.25-ux,h/2+ly*48/0.25-uy
screen.drawCircle(x,y,5)
if res=="L"and rng
then
setC(0.2,255,0.2)screen.drawRect(Xqm-1-w/3,Yqm-1-h/3,w/3,h/3)
end
setC(0.2,255,0.2)
end
function fmax(g)max_m={}
	for i,e in ipairs(g)
	do
	table.insert(max_m,math.max(table.unpack(e)))
end
return math.max(table.unpack(max_m))
end
function fmin(l)
	local p=math.huge
	for i=1,#l
	do
	for j=1,#l[i]
	do
	local r=l[i][j]
	if r~=0 and r<p
	then
	p=r
	break
end
end
end
return p,i,j
end
function setC(s,t,b,a)
	if a==nil
	then
	a=255
end
screen.setColor(s,t,b,a)
end
function btp(x,y,w,h)
	if isP and not lp and inX>=x and inX<=x+w and inY>=y and inY<=y+h
	then
	lp=true
	return true
else
	return false
end
end
function rst()Yqm,Xqm=96,96
	lxo,lyo=-xm,-ym
	xs,ys=xm/96,ym/96
	m,n=1,1
end
function sk(u,v,l)
	return(u-v)/(l-v)
end