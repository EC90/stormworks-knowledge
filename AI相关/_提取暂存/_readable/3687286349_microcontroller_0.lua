igN=input.getNumber
igB=input.getBool
osN=output.setNumber
osB=output.setBool
pgN=property.getNumber
ab=math.abs
mx=math.max
mn=math.min
tgp=2.0
lw=3.0
on=false
sk=0
sl=false
pt=false
pu=false
pd=false
ti=0
df=0
lo=0
pdist=0
rel=0
out=0
aCmd=0
v0f=0
vTf=0
sh=0
ss=0.01
tm=1.0
bm=0
cgp=0
tsn=0
tlk=0
tls=0
tsb=false
sm=0
pdistT={0,0,0,0,0,0,0}relT={0,0,0,0,0,0,0}buf=1.2
maxD=800
stc=46
sw=14
slt=22
mst=6
swn=10
onb=5.0
cLo=50
cHi=220
cMax=30
cMin=6
aW=3.0
eW=2.0
tW=8.0
al=0.35
hd=18
hz=60
ovTh=0.10
aMax=2.6
bcf=2.8
bhd=12.0
xMin=0.25
att=0.32
btb=0.17
jUp=1.5
jDn=3.0
jDnE=18.0
ou=0.04
ra=0.22
spd=0.35
v0a=0.18
sb=1.0
stm=1.5
ssi=15.0
so=25.0
rr=0.75
spk=0.72
tbk=2.0
db=10.0
oss=0.35
osh=1.5
obk=1.35
ubc=3.5
stt=12
plbF=0.30
plbN=0.10
ki=0.35
aqo=0.6
function cl(x,a,b)
	if x<a
	then
	return a
elseif x>b
then
return b
else
	return x
end
end
function ap(c,f,g)
	if c<f
	then
	c=c+g
	if c>f
	then
	c=f
end
else
	c=c-g
	if c<f
	then
	c=f
end
end
return c
end
function rth()
	for h=1,7
	do
	pdistT[h]=0
	relT[h]=0
end
end
function rst()ti=0
	df=0
	lo=0
	pdist=0
	rel=0
	aCmd=0
	sh=0
	sl=false
	vTf=0
	sm=0
	tm=1
	bm=0
	tsn=0
	tlk=0
	tls=0
	tsb=false
	rth()
end
function gch(vk)
	local i
	if vk<=cLo
	then
	i=cMax
elseif vk>=cHi
then
i=cMin
else
	i=cMax+(cMin-cMax)*(vk-cLo)/(cHi-cLo)
end
return i/360.0
end
function gct(d)
	if d<=0
	then
	return 0.01
end
j=lw*0.5
k=math.atan(j/d)l=k/(2.0*math.pi)
return cl(l,0.001,0.01)
end
function rt(h)b=(h-1)*4+1
	d=igN(b)a=igN(b+1)e=0
	rv=0
	if h~=8
	then
	e=igN(b+2)rv=igN(b+3)
end
return d,a,e,rv
end
function ic(a,e,m,n)
	return ab(a)<=m and ab(e)<=n
end
function gcl(h,d)p=pdistT[h]c=0
	if p>0 and d>0
	then
	c=(p-d)*hz
end
r=relT[h]r=r+(c-r)*ra
relT[h]=r
pdistT[h]=d
return r
end
function sc(d,a,e,cg)
	return d+ab(a)*aW+ab(e)*eW+ab(cg)*tW
end
function ok(d,a,e,ch,v,cg)
	if d<=0 or d>=maxD
	then
	return false,false
end
if not ic(a,e,ch,ch)
then
return false,false
end
o=cg>v+onb
if not o
then
return true,false
end
q=gct(d)
if ab(a)<=q and ab(e)<=q
then
return true,true
end
return false,false
end
function onTick()tgp=pgN("Time Gap (s)")lw=pgN("Lane Width (m)")lim=pgN("Speed Limiter (km/h)")
	if lw<=0
	then
	lw=3.0
end
if lim<=0
then
lim=220
end
tg=igB(30)up=igB(31)dn=igB(32)cgp=igN(30)drv=igN(31)v=igN(32)
if cgp~=0
then
tgp=cgp
end
if v<0
then
v=0
end
vk=v*3.6
sp=cl((vk-80)/120,0,1)ksn=0.24+0.24*sp
van=0.22+0.20*sp
twn=1.55+0.35*sp
thn=0.65+0.20*sp
odn=0.022+0.012*sp
odh=0.08+0.04*sp
cb=14.0
cvk=0.75-0.30*sp
cd=cb+v*cvk
ch=gch(vk)
if on and drv<-0.1
then
on=false
rst()
end
if tg and not pt
then
if on
then
on=false
rst()
else
	on=true
	sk=cl(math.floor((v*3.6+5)/10)*10,0,lim)aCmd=0
	sh=0
	v0f=sk/3.6
	vTf=v0f
	tsn=0
	tlk=0
	tls=0
	tsb=false
	sl=false
	sm=0
	rth()
end
end
pt=tg
if on
then
if up and not pu
then
sk=sk+10
end
if dn and not pd
then
sk=sk-10
end
sk=cl(sk,0,lim)
end
pu=up
pd=dn
osB(1,on)
if not on
then
sk=0
sm=0
out=ap(out,0,ou)
if ab(out)<0.001
then
out=0
end
osN(1,out)osN(2,0)
return
end
v0f=v0f+(sk/3.6-v0f)*v0a
v0=v0f
bi=0
bs=1e9
curOk=false
curS=1e9
curOnc=false
if tlk>0
then
tlk=tlk-1
end
if ti>=1 and ti<=7 and igB(ti)
then
d,a,e,rv=rt(ti)cg=gcl(ti,d)s,t=ok(d,a,e,ch,v,cg)
if s
then
curOk=true
curOnc=t
curS=sc(d,a,e,cg)-stc
if t
then
curS=curS+200
end
bi=ti
bs=curS
end
end
for h=1,7
do
if igB(h)
then
d,a,e,rv=rt(h)cg=gcl(h,d)s,t=ok(d,a,e,ch,v,cg)
if s
then
g=sc(d,a,e,cg)
if t
then
g=g+200
end
if tlk<=0 or not curOk
then
if curOk
then
if g<bs-sw-swn
then
bs=g
bi=h
curOnc=t
end
else
	if g<bs-sw
	then
	bs=g
	bi=h
	curOnc=t
end
end
end
end
end
end
if bi~=ti
then
if curOk and bi~=0
then
tlk=slt
end
ti=bi
end
if ti~=0
then
if ti==tls
then
tsn=tsn+1
else
	tsn=0
	tls=ti
end
else
	tsn=0
	tls=0
end
tsb=tsn>=mst
if ti~=0
then
lo=0
d,a,e,rv=rt(ti)
if df<=0
then
df=d
else
	df=df+(d-df)*al
end
rel=gcl(ti,d)pdist=d
else
	lo=lo+1
	if lo>hd
	then
	df=0
	pdist=0
	rel=0
end
end
has=df>0
dd=buf+v*tgp
rx=1e9
x=1e9
cg=0
ttc=99
rd=0
pcd=0
if has
then
rd=df
pcd=df-db
if pcd<0
then
pcd=0
end
rx=pcd-dd
x=rx
if x<xMin
then
x=xMin
end
cg=mx(rel,0)
if cg>0.1
then
ttc=rd/cg
end
end
vl=has and mx(v-rel,0)or v0
pbF=has and plbF*dd or 0
pbN=has and plbN*dd or 0
ge=0
if has
then
local w=0.25*dd
local y=0.50*dd
if has
then
if rx>y
then
ge=(rx-y)*2.5+y
elseif rx>w
then
local t=(rx-w)/(y-w)ge=rx*(0.4+0.6*t)
elseif rx<-y
then
ge=(rx+y)*2.5-y
elseif rx<-w
then
local t=(-rx-w)/(y-w)ge=rx*(0.4+0.6*t)
else
	ge=rx*0.25
end
end
end
vtg=v0
if has
then
vtg=cl(vl+ge/mx(tgp,0.1),0,v0)
end
vTf=vTf+(vtg-vTf)*van
vT=vTf
rls=false
if has
then
if sl
then
if rd>=so
then
sl=false
rls=true
end
else
	if vtg<=stm and rd<=ssi
	then
	sl=true
end
end
if sl
then
tm=0
bm=cl(bm+ss,0,1)
else
	tm=cl(tm+ss,0,1)bm=0
end
else
	sl=false
	tm=1
	bm=0
end
if rls
then
sh=0
aCmd=0
vTf=mn(vTf,rr)
end
bc=bcf
if has
then
ce=cl(-rx/cd,0,1)tr=0
if cg>0.1
then
tr=cl((twn-ttc)/twn,0,1)
end
rk=mx(ce,tr)bc=bcf+(bhd-bcf)*rk^3.0
end
aq=0
if has and cg>0.1
then
sd=pcd-buf
if sd<0.5
then
sd=0.5
end
aq=cg*cg/(2*sd)
if aq>bc
then
bc=mn(aq,bhd)
end
end
if has and not tsb and rx>2.0 and aq<bcf
then
bc=mn(bc,ubc)
end
ohb=0
if has and curOnc
then
if ttc<thn
then
bc=bhd
u=cl((thn-ttc)/thn,0,1)ohb=bhd*u
end
end
ad=0
if has
then
st=cl(tsn/stt,0,1)ac=ksn*(vT-v)ad=ac
if ad<0 and(rx>-pbN or rel<0)
then
ad=ad*st
end
else
	ve=vT-v
	ad=ve*spk
	if ab(ve)<spd
	then
	ad=0
end
if ve<0
then
ad=0
end
end
if has and aq>aqo
then
ad=mn(ad,-aq)
end
if has and cg>0.1 and ttc<thn
then
ad=ad-(thn-ttc)*tbk
end
if ohb>0
then
ad=mn(ad,-ohb)
end
ov=v-v0
if ov>oss
then
ad=mn(ad,0)
end
if ov>osh
then
ad=mn(ad,-(ov-osh)*obk)
end
ad=cl(ad,-bc,aMax)ju=jUp/hz
emg=has and aq>bcf or has and cg>0.1 and ttc<thn
jd=(emg and jDnE or jDn)/hz
if ad>aCmd
then
aCmd=ap(aCmd,ad,ju)
else
	aCmd=ap(aCmd,ad,jd)
end
thr=0
br=0
if aCmd>=0
then
thr=cl(aCmd*att,0,1)
else
	br=cl(-aCmd*btb,0,1)br=br^0.82
end
thr=thr*tm
br=mx(br,sb*bm)
if v>v0+oss
then
thr=0
end
if v>v0+osh
then
br=mx(br,cl((v-(v0+osh))*0.25,0,1))
end
des=thr-br
if drv>ovTh
then
des=mx(des,cl(drv,0,1))
end
r=ou
if des<out
then
r=odn
if br>0.82
then
r=odh
end
if has and rx<1.5
then
r=odh
end
if has and cg>10.0
then
r=odh
end
if ohb>0
then
r=odh
end
end
out=ap(out,des,r)
if ab(out)<0.001
then
out=0
end
osN(1,cl(out,-1,1))osN(2,sk)
end