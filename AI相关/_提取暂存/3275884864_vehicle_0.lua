-- source: steam id 3275884864 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
--Crew Manager
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.atan
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P=M.pi*2
gnrpwro=false
cmdpwro=false
power=false
sl=0
slao=false
slmo=false
function onTick()
	cmdad=GN(1)
	cmdws=GN(2)
	gnrad=GN(11)
	gnrws=GN(12)
	cmdadd=GB(11)
	cmdonly=GB(12)
	if cmdonly then
		outad=cmdad
		outws=cmdws
	elseif cmdadd then
		outad=cmdad+gnrad
		outws=cmdws+gnrws
	else
		outad=gnrad
		outws=gnrws
	end
	SN(1,outad)
	SN(2,outws)
	SN(3,GN(21)+GN(22)+GN(23))
	gnrpwr=GB(21)
	cmdpwr=GB(22)
	if (gnrpwr and not gnrpwro) or (cmdpwr and not cmdpwro) then power=true end
	if power and cmdpwro and not cmdpwr then power=false end
	if power and gnrpwro and not gnrpwr then power=false end
	SB(1,power)
	gnrpwro=gnrpwr
	cmdpwro=cmdpwr
	sls=GB(30)
	slm=GB(31)
	sla=GB(32)
	if sla and not slao then sl=M.min(sl+10,100) end
	if slm and not slmo then sl=M.max(sl-10,-10) end
	if sl==100 then sl=0 end
	if sl==-10 then sl=90 end
	slao=sla
	slmo=slm
	if sls then
		SN(11,sl)
	else
		SN(11,0)
	end
	SN(12,Mf(sl/10))
	SN(13,sl%10)
	SB(23,GB(23))
	SB(24,GB(24))
end