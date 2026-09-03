-- source: steam id 3261800786 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3261800786
--datalink3RcvRC&UAV
--output signals for UAVs
--Bool:
--3=atk,Weapon Trigger,push-like signal,output one pulse.
--4=rtb,Return to Base,toggle
--5=cv,Land at Carrier Vessel
--Number: **Using Main Send Composite**
--30=Way Point X
--31=Way Point Y
--32=Way Point Alt
--26=Way Point Radius
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
M=math
Mb=M.abs
Ma=M.atan
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
P=M.pi*2
T=1
Rcv={}
Call={1,0}
cur={}
Slf={}
slavef=0
slave=false
cv=false
rtb=false
drone=property.getNumber('Self Vehicle Type')==10
wayx,wayy=0,0
timer=0
function onTick()
	order=GN(21)
	selfID=GN(22)
	SLID=GN(23)
	page=GN(26)
	freq=GN(29)
	j=#Rcv+1
	add=false
	del=false
	atk=false
	if timer>120 then slave=false end
	if GN(1)~=0 then
		if #Rcv>0 then
			for i=1,#Rcv do
				if GN(1)==Rcv[i].id then
					j=i
					break
				end
			end
		end
		if j>#Rcv then
			Rcv[j]={j={},w={}}
		end
		Rcv[j].id=GN(1)
		Rcv[j].ts=GN(8)
		Rcv[j].t=0
		Rcv[j].rc=GB(6)
		if mF(GN(16)/1e4)==selfID then
			slave=true
			timer=0
			slavef=GN(1)
			if drone then
				add=GB(29)
				del=GB(30)
				atk=GB(31)
				rtb=GB(7)
				cv=GB(8)
				wayx=GN(13)
				wayy=GN(14)
				wayz=mF(GN(16)%1e2)
				wayr=mF(GN(16)%1e4/1e2)
			end
		end
	end
	timer=timer+1
	if #Rcv>0 then
		uavs={}
		rcs={}
		for i=1,#Rcv do
			Rcv[i].t=Rcv[i].t+1
			if Rcv[i].t>300 then
				table.remove(Rcv,i)
				break
			end
		end
		for i=1,#Rcv do
			if Rcv[i].rc then table.insert(rcs,Rcv[i].id) end
			if Rcv[i].ts==10 then table.insert(uavs,Rcv[i].id) end
		end
		odredt=Mf((order-5)/4)
		if page==3 then cur=uavs elseif page==4 then cur=rcs else cur={} end
		if #cur>0 then
			if order~=0 then
				Call[1]=M.max(M.min(Call[1]+odredt,#cur),1)
				if cur[Call[1]]~=Call[2] then
					for i=1,#cur do
						if cur[i]==Call[2] then
							Call[1]=i
							break
						end
					end
				end
			end
			Call[2]=cur[Call[1]]
		end
	end
	if slave then
		rtf=freq+slavef
		rtRadio=false
	elseif SLID~=0 and page==1 then
		rtf=freq+SLID
		rtRadio=false
	else
		rtf=freq+selfID
		rtRadio=true
	end
	vf=freq+selfID
	SN(1,rtf)
	SN(2,Call[2])
	SN(3,vf)
	SB(1,slave)
	SB(2,rtRadio)
	for i=21,32 do
		SN(i,0)
		SB(i,false)
	end
	if drone then
		SN(23,wayz)
		SN(25,wayr)
		SN(26,2)
		SN(27,wayx)
		SN(28,wayy)
		SB(21,add)
		SB(22,del)
		SB(3,atk)
		SB(4,rtb)
		SB(5,cv)
	end
end