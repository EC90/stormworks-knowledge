-- source: steam id 3385047558 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3385047558
--datalink3RC
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
function onTick()
	for i=1,6 do
		SN(i,GN(20+i))
		SB(i,GB(20+i))
	end
	SB(31,GB(27))
	SB(32,GB(28))
end