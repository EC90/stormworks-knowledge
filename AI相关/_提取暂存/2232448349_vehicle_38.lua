-- source: steam id 2232448349 / vehicle.xml block#38
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
PATT = "          0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

function onTick()
	if input.getBool(1) then
		NICK = property.getText("Default Callsign")
		TXT = {"", "", "", ""}

		for i = 1, math.min(string.len(NICK), 12), 1 do
			CHR = string.find(PATT, string.sub(NICK, i, i))
			if CHR == nil then CHR = "00" end
			TXT[((i-1)%4)+1] = TXT[((i-1)%4)+1]..string.format("%02.0f", CHR)
		end

		
		output.setNumber(1, TXT[1])
		output.setNumber(2, TXT[2])
		output.setNumber(3, TXT[3])
		output.setNumber(4, TXT[4])
		output.setBool(1, true)
			
	else
		output.setNumber(1, 0)
		output.setNumber(2, 0)
		output.setNumber(3, 0)
		output.setNumber(4, 0)
		output.setBool(1, false)
	end
end
