-- source: steam id 2885633937 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2885633937
igb=input.getBool
ign=input.getNumber
pi=math.pi
osn=output.setNumber
tgte=0
sva=0
sve=0
stab,stabo=false,false
locko=false
mouseo=false
function onTick()
ud,lr=ign(4),ign(3)
ca,cec,cet=ign(5),ign(6),ign(7)
maxe,mine=ign(11),ign(12)
lookx,looky=ign(9),ign(10)
lock=igb(1) or igb(2)
rdrd,rdra,rdre=ign(13),ign(14),ign(15)
cps=ign(26)
slowaim=igb(4)
stab=igb(6)
mouse=igb(23)
if slowaim then slow=0.05 else slow=1 end
if math.abs(math.sin(ca*pi))>0.92 then mine=-2 end
if lock then
	if not locko then
		ofsta=0
		ofste=0
	end
	ofsta=ofsta-0.0002*lr*slow
	ofste=ofste-0.0002*ud*slow
	sva=rdra+ofsta
	if sva>0 then
		sva=(sva+0.5)%1-0.5
	else
		sva=(sva-0.5)%1+0.5
	end
	if sva-cps>0.5 then
		pva=cps+1
	elseif sva-cps<-0.5 then
		pva=cps-1
	else
		pva=cps
	end
	tgte=-rdre+ofste
	sve=math.min(math.max(tgte,-cet-maxe/360),-cet-mine/360)
	pve=-cec
else
	ofsta=0
	ofste=0
	if stab then
		if mouse then
			tgte=0
			sve=math.min(math.max(tgte,-cet-maxe/360),-cet-mine/360)
			pve=-cec
			sva=-lookx
			if ca>0.5 then
				pva=(ca+0.5)%1-0.5
			elseif ca<-0.5 then
				pva=(ca-0.5)%1+0.5
			else
				pva=ca
			end
			if sva-pva>0.5 then
				pva=pva+1
			elseif sva-pva<-0.5 then
				pva=pva-1
			end
		else
			if locko or mouseo or not stabo then
				sva=cps
				pva=cps
				tgte=-cec
				pve=-cec
			else
				if sva>0 then
					sva=(sva-0.0015*lr*slow+0.5)%1-0.5
				else
					sva=(sva-0.0015*lr*slow-0.5)%1+0.5
				end
				if sva-cps>0.5 then
					pva=cps+1
				elseif sva-cps<-0.5 then
					pva=cps-1
				else
					pva=cps
				end
				tgte=tgte-0.0005*ud*slow
				sve=math.min(math.max(tgte,-cet-maxe/360),-cet-mine/360)
				pve=-cec
			end
		end
	else
		if stabo or locko then
			sva=ca
			pva=ca
			tgte=cet-cec
			sve=tgte
			pve=cet-cec
		else
			sva=sva-0.0015*lr*slow
			pva=ca
			tgte=0
			sve=math.min(math.max(sve-0.00025*ud*slow,-maxe/360),-mine/360)
			pve=cet-cec
		end
	end
end
stabo=stab
locko=lock
mouseo=mouse
osn(1,sva)
osn(2,pva)
osn(3,sve)
osn(4,pve)
end
function onDraw()
w,h=screen.getWidth(),screen.getHeight()
if slowaim then
screen.setColor(0,0,0,200)
screen.drawRectF(w/2-13,h-6,21,5)
screen.setColor(15,233,15,180)
screen.drawText(w/2-12,h-6,"SLOW") end
--hull trt angle
hx=w-8
hy=h-9
trtx=hx+9*math.sin(-ca*2*pi)
trty=hy-9*math.cos(-ca*2*pi)
screen.setColor(0,0,0,200)
screen.drawRectF(hx-7,hy-6,16,18)
if not stab then
	screen.setColor(222,111,11)
else
	screen.setColor(15,233,15)
end
screen.drawRect(hx-5,hy-5,10,12)
screen.drawCircle(hx,hy,3)
screen.drawLine(hx,hy,trtx,trty)
end