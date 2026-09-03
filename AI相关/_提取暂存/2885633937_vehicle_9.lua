-- source: steam id 2885633937 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2885633937
rdxa=0.12
rdya=0.08
igb=input.getBool
ign=input.getNumber
osn=output.setNumber
osb=output.setBool
sdt=screen.drawText
pi=math.pi
ct=0
tgtao,tgteo,tgtdo=0,0,0
CurD,CurA,CurE={},{},{}
AD,AA,AE={},{},{}
OD,OA,OE={},{},{}
ADD,ADA,ADE={},{},{}
acctal,acctbl={},{}
cda,cde={},{}
for i=1,8 do
OD[i]=0
OA[i]=0
OE[i]=0
cda[i],cde[i]={},{}
CurD[i],CurA[i],CurE[i]={},{},{}
end
ilo=false
locked=false
csv=1000
go=-0.75
--ticks to average
ta=30
--compare dict contents
function cmpr(a,b)
return math.abs(a.a)+math.abs(a.e)<math.abs(b.a)+math.abs(b.e)
end
--clamp
function clp(v,a,b)
return math.min(math.max(v,a),b)
end
--math.floor
function flr(v,a)
return math.floor(v*10^a)/10^a
end
function avg(n,v,t)
table.insert(n,v)
if #n>t then table.remove(n,1) end
sum=0
for i=1,#n do sum=sum+n[i] end
return sum/#n
end
function onTick()
	il=igb(1)
	ir=igb(2)
	fov=ign(12)
	fovr=2.2-(2.2-0.025)*fov
	fovt=fovr/(math.pi*2)
	dcps=ign(16)
	aima,aime=ign(20),ign(24)
	--prepare for auto chaff
	accta,acctb=0,0
	aclr=0
	acr=false
	acdc=false
	aclc=false
	--prepare base data
for i=1,8 do
	if ign(-3+4*i)>0 then
		AD[i]=avg(CurD[i],ign(-3+4*i),ta)
		AA[i]=avg(CurA[i],ign(-2+4*i),ta)
		AE[i]=avg(CurE[i],ign(-1+4*i),ta)
	else
		AD[i]=0
		AA[i]=0
		AE[i]=0
	end
	ADD[i]=AD[i]-OD[i]
	ADA[i]=AA[i]-OA[i]
	ADE[i]=AE[i]-OE[i]
	OD[i]=AD[i]
	OA[i]=AA[i]
	OE[i]=AE[i]
	--auto chaff judge
	if ADD[i]<-0.6 and ADD[i]>-10 and AD[i]>150 and AD[i]<700 and math.abs(ADA[i]-math.min(math.max(dcps,-0.003),0.003))<10/62 and math.abs(ADE[i])<10/62 then 
		accta=accta+1
		if AD[i]/-ADD[i]<3*62 and AD[i]/-ADD[i]>0.5*62 and AD[i]<600 then
			acctb=acctb+1
			aclr=aclr+AA[i]
		end
	end	
end
--calculate auto chaff and expt auto chaff result
acctaa=avg(acctal,accta,30)
acctba=avg(acctbl,acctb,15)
if acctaa>0.5 then acdc=true end
if aclr>0 then acr=true end
if acctba>0.5 and ct>180 then aclc=true ct=0 end
if ir then ct=ct+1 end
osb(2,acdc)
osb(3,aclc)
osb(4,acr)
aclr=0
--expt rst
for i=1,#AD do
    osn(-3+4*i,AD[i])
    osn(-2+4*i,AA[i])
    osn(-1+4*i,AE[i])
end
--merge same signals
Rs={}
for i=1,8 do
mark=0
if AD[i]>0 then
if #Rs>0 then
for j=1,#Rs do
a=math.abs(AD[i]-Rs[j].sd/Rs[j].cts)
b=math.abs(AA[i]-Rs[j].sa/Rs[j].cts)
if a<ign(4) and b<ign(8) then
Rs[j].sd=Rs[j].sd+AD[i]
Rs[j].sa=Rs[j].sa+ign(-2+4*i)
Rs[j].se=Rs[j].se+ign(-1+4*i)
Rs[j].cts=Rs[j].cts+1
Rs[j].asa=Rs[j].sa+AA[i]
Rs[j].ase=Rs[j].se+AE[i]
mark=0
break
else
mark=mark+1
end
end
if mark>0 then
table.insert(Rs,{d=AD[i],a=ign(-2+4*i),e=ign(-1+4*i),sd=AD[i],sa=ign(-2+4*i),se=ign(-1+4*i),cts=1,asa=AA[i],ase=AE[i]})
end
else
table.insert(Rs,{d=AD[i],a=ign(-2+4*i),e=ign(-1+4*i),sd=AD[i],sa=ign(-2+4*i),se=ign(-1+4*i),cts=1,asa=AA[i],ase=AE[i]})
end
end
end
if #Rs>0 then
	for i=1,#Rs do
		Rs[i].d=Rs[i].sd/Rs[i].cts
		Rs[i].a=Rs[i].sa/Rs[i].cts
		Rs[i].e=Rs[i].se/Rs[i].cts
		Rs[i].aa=Rs[i].asa/Rs[i].cts
		Rs[i].ae=Rs[i].ase/Rs[i].cts
	end
	table.sort(Rs,cmpr)
end
	if locked then
		if #Rs==0 or (ilo and not il) then
			locked=false
		end
	else
		if #Rs>0 and ilo and not il then
			locked=true
		end
	end
	if #Rs>0 then
		if math.abs(Rs[1].a-tgtao)>0.005 and ilo then
			tgta,tgte,tgtd=0,0,0
		else
		tgta=Rs[1].a
		tgte=Rs[1].e
		tgtd=Rs[1].d
		end
	else
		tgta,tgte,tgtd=0,0,0
	end
	ilo=il
	tgtao,tgteo,tgtdo=tgta,tgte,tgtd
	osb(1,locked)
	osn(4,tgtd)
	osn(8,tgta)
	osn(12,tgte)
end
function onDraw()
	w,h=screen.getWidth(),screen.getHeight()
	se=math.min(w/2,h/2)
	if ir then
	screen.setColor(0,0,0,200)
	screen.drawRectF(1,9,14,5)
		screen.setColor(15,233,15)
		sdt(1,9,"RDR")
		screen.setColor(15,233,15,90)
		screen.drawRect(w/2-se*rdxa/fovt,h/2-se*rdya/fovt,2*se*rdxa/fovt,2*se*rdya/fovt)
	end
	if #Rs>0 then
	for i=1,#Rs do
	x=w/2+se*(Rs[i].aa/(0.5*fovt))
	y=h/2-se*(Rs[i].ae/(0.5*fovt))
	if i==1 and locked then
		screen.setColor(200,15,15,160)
		aimx=w/2+se*(aima/(0.5*fovt))
		aimy=h/2-se*(aime/(0.5*fovt))
		screen.drawLine(x,y,aimx,aimy)
		screen.drawCircle(aimx,aimy,2)
	else
		screen.setColor(15,233,15,160)
	end
	screen.drawRect(x-4,y-4,8,8)
	sdt(x-6,y+6,math.floor(Rs[i].d))
	end
	end
end