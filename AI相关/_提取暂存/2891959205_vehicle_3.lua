-- source: steam id 2891959205 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891959205
igb=input.getBool
ign=input.getNumber
pi=math.pi
osn=output.setNumber
tgte=0
sve=0
stab,stabo=false,false
locko=false
mouseo=false
function onTick()
cps=ign(10)
cec=ign(12)
rdra,rdre=ign(14),ign(15)
lock=igb(30)
if lock then
	sva=rdra
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
	tgte=rdre
	sve=tgte
	pve=cec
else
	if locko then
		sva=0
		pva=0
		tgte=-cec
		sve=tgte
		pve=-cec
	else
		sva=0
		pva=0
		tgte=tgte
		sve=tgte
		pve=cec
	end
end
locko=lock
osn(1,sva)
osn(2,pva)
osn(3,sve)
osn(4,pve)
end
function onDraw()
--screen.setColor(222,22,22)
--screen.drawText(7,21,cps)
--screen.drawText(7,28,cec)
end