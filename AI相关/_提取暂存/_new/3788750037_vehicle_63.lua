-- source: steam id 3788750037 / vehicle.xml block#63
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
pi=math.pi
pi2=pi*2
cache={}
function onTick()
	for i=1,8 do
		if iB(i) then
			td=iN(i*4-3)
			ta=iN(i*4-2)
			te=iN(i*4-1)
			tt=iN(i*4)
			table.insert(cache,{td,ta,te,tt})
		end
	end
	if cache[1] then
		for i,v in pairs(cache[1]) do
			oN(i,v)
		end
		oB(1,true)
		table.remove(cache,1)
	else
		oB(1,false)
	end
end