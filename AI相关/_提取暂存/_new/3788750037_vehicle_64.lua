-- source: steam id 3788750037 / vehicle.xml block#64
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
pi2=math.pi*2
cache={}
precision=10000
function onTick()
	on=iB(32)
	if not on then
		cache={}
	else
		for i=1,16 do
			if iB(i) then
				ta=iN(i*2-1)
				te=iN(i*2)
				table.insert(cache,{ta,te})
				if #cache>32 then
					table.remove(cache,1)
				end
			end
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