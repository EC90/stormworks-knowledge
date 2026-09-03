-- source: steam id 3086718568 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3086718568
s,i,o,p,m=self,input,output,property,math
pgn,pgb,gn,gb,sn,sb=p.getNumber,p.getBool,i.getNumber,i.getBool,o.setNumber,o.setBool
pi2,abs,sqrt=m.pi*2,m.abs,m.sqrt
t,f=true,false

t1,t2,t3,t4,altOld=0,0,0,0,0
fwd,land,fall=f,f,f

function clamp(x,min,max)
return m.max(m.min(x,m.max(max,min)),m.min(min,max))
end
function lerp(min,max,t)
local t=clamp(t,0,1)
return min*(1-t)+max*t
end
function pid(p,i,d)
return{p=p,i=i,d=d,err=0,dif=0,int=0,
run=function(s,sp,pv,min,max,minI,maxI,res)
local res=res or f
local minI,maxI=minI or min,maxI or max
local err,dif,out
err=sp-pv
dif=err-s.err
s.err=err
s.dif=dif
out=err*s.p+s.int+dif*s.d
if res then
s.int=0
elseif out>min and out<max then
s.int=clamp(s.int+err*s.i,minI,maxI)
end
return clamp(err*s.p+s.int+dif*s.d,min,max)
end}
end

landP=not pgb("Autoland if no pilot in seat")
arrP=pgb("Pitch axis")
arrR=pgb("Roll axis")
slowMax=pgn("Slow mode multiplier")
liftMax=pgn("Lift max speed")*0.02
pitMax=pgn("Pitch max tilt")*0.015
pitT=pgn("Pitch trim")*0.05
rolMax=pgn("Roll max tilt")*0.015
yawMax=pgn("Yaw max speed")*0.02
yawTurn=pgn("Yaw turn by Roll")*0.1
del=pgn("Position hold delay")*60+1

pidC=pid(10,0.1,10)
pidP=pid(5,0,100)
pidR=pid(3,0,100)
pidY=pid(2,0,0)

pidHR=pid(0.05,0.001,0)
pidHP=pid(0.05,0.001,0)

tic={}
rcs={}
pwm={}
for i=1,32 do
rcs[i]=0
pwm[i]=0
tic[i]=1
end

function onTick()
	alt=gn(2)
	x=gn(4)
	y=gn(5)
	z=gn(6)
	ax=gn(10)
	ay=gn(11)
	az=gn(12)
	tiltP=gn(15)
	tiltR=gn(16)
	spP=gn(9)
	spR=gn(7)
	spA=gn(13)

	ad=arrR and gn(23) or gn(21)
	ws=arrP and gn(24) or gn(22)
	lr=arrR and gn(21) or gn(23)
	ud=arrP and gn(22) or gn(24)

	on=gb(1)
	slow=gb(2)
	fwdP=gb(3) and not fwdH
	fwdH=gb(3)
	hold=gb(4)
	seat=gb(5)

	cx,sx=m.cos(x),m.sin(x)
	cy,sy=m.cos(y),m.sin(y)
	cz,sz=m.cos(z),m.sin(z)

	m01=-cx*sz+sx*sy*cz
	m11=cx*cz+sx*sy*sz
	m21=sx*cy
	ang=m01*ax+m11*ay+m21*az
	vec=cx*cz+sx*sy*sz

	t1=(landP and on and not seat and abs(spP)<3 and abs(spR)<3 and not fall) and m.min(t1+0.002,1) or 0
	land=t1>=1

	if fwdP and not fwd and on and not slow then fwd=t
	elseif fwd and fwdP or not on or slow or hold or not seat or land or ws<-0.1 or fall then fwd=f
	end
	t2=clamp(t2+(fwd and 0.01 or -0.01),0,1)
	ws=lerp(ws,1,t2)

	if on and not fall and not fwd and (hold or abs(ad)<0.1 and abs(ws)<0.1 and abs(lr)<0.1) then
		if hold then t3,ad,ws=del,0,0
		elseif slow then t3=del
		else t3=m.min(t3+1,del)
		end
	else t3=0
	end

	if t3>=del then
		phM=hold and clamp(spA*0.1,0.2,0.5) or 0.2
		holdP=pidHP:run(0,spP,-phM,phM)
		holdR=pidHR:run(0,spR,-phM,phM)
	else
		holdP=pidHP:run(0,0,0,0,0,0,t)
		holdR=pidHR:run(0,0,0,0,0,0,t)
	end

	slowM=slow and slowMax or 1

	if on then
		col=pidC:run((land and clamp(0.1*(2.5-alt), -0.2, 0.2) or ud*slowM)*(0.12+liftMax), alt-altOld, 0, 1)
		pit=pidP:run((ws*slowM+holdP)*(0.1+pitMax)*sqrt(1-abs(ad)*0.5),-tiltP,-1,1)+pitT+(seat and 0 or 0.2)
		rol=pidR:run((ad*slowM+holdR+lr*ws*yawTurn)*(0.08+rolMax)*sqrt(1-abs(ws)*0.5),-tiltR,-1,1)
		yaw=pidY:run((lr+ad*ws*yawTurn)*(0.16+yawMax),ang,-0.5,0.5)

		if vec<0.3 then fall=t
		elseif vec>0.9 then fall=f
		end
		if fall then
			sb(13,f)
			pit,col=0,1
			pitF=clamp(tiltP*(vec<0 and 1000 or 1),-0.25,0.25)*(tiltP>0 and 4.5 or 5)
			rolF=4.5*tiltR
		else
			sb(13,t)
			pitF=0
			rolF=0
		end

		rcs[1]=col-rol-pit
		rcs[2]=col+rol-pit
		rcs[3]=col-rol+pit
		rcs[4]=col+rol+pit
		rcs[5]=pitF+rolF
		rcs[6]=-pitF+rolF
		rcs[7]=-pitF-rolF
		rcs[8]=pitF-rolF
		rcs[9]=pitF+rolF+yaw
		rcs[10]=-pitF+rolF-yaw
		rcs[11]=-pitF-rolF+yaw
		rcs[12]=pitF-rolF-yaw
		
		for i=10,12 do tic[i]=tic[9]
		end
		
		for i=1,4 do
			if tic[i]==1 then pwm[i]=m.floor(0.001+10*clamp(rcs[i],0,1))+3
			end
			if pwm[i]==13 then sb(i,f)
			else sb(i,tic[i]<=2)
			end
			tic[i]=tic[i]<pwm[i] and m.min(tic[i]+1,pwm[i]) or 1
		end

		for i=5,12 do
			if tic[i]==1 then pwm[i]=13-m.floor(0.001+10*clamp(rcs[i],0,1))
			end
			if pwm[i]==13 then sb(i,f)
			else sb(i,tic[i]<=2)
			end
			tic[i]=tic[i]<pwm[i] and m.min(tic[i]+1,pwm[i]) or 1
		end
	else
		col=pidC:run(0,0,0,0,0,0,t)
		for i=1,13 do sb(i,f)
		end
	end
	altOld=alt
end
