-- source: steam id 2793900947 / vehicle.xml block#33
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
gn=input.getNumber
gb=input.getBool
charge_time=1-- how long to charge
discharge_time=300-- how long to discharge
function onTick()
r1c=gb(11)
r2c=gb(12)
r3c=gb(13)
r4c=gb(14)
detector=gb(15)
arm=gb(4)
mlc=gb(32)

	crl=r1c or r2c or r3c or r4c
	icm=detector and crl
	output.setBool(2,icm)
	icmP=icm and icm~=licm
	licm=icm
	mlcP=mlc and mlc~=lmlc
	lmlc=mlc
	launch=mlcP or icmP
	truelaunch=launch and arm
	output2=truelaunch and not a
	output.setBool(1,output2)
	a,b=capacitor(truelaunch,charge_time,discharge_time,a,b)
end

function capacitor(trigger,charge,discharge,toggle,ticker)
ticker=ticker or 0
toggle=toggle or false

ticker=ticker+(trigger and ticker<charge and 1 or 0)
    if (not trigger) and ticker<charge and (not toggle) then
    ticker=0
    end
    toggle=toggle or (ticker>=charge)
    if toggle and (not trigger) and ticker>charge-discharge then
    ticker=ticker-1
    end
    if toggle and ticker<=charge-discharge then toggle=false ticker=0 end

return toggle,ticker
end
