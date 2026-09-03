-- source: steam id 2430109317 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2430109317
song = {
	0,
	05,0,0,0,11,0,0,0,0,07,0,12,0,11,0,05,0,03,0,06,0,0,0,0,0,0,04,0,0,0,0,
	06,0,12,0,0,0,0,11,0,07,0,06,0,05,0,04,0,03,0,0,0,0,0,0,
	05,0,0,0,11,0,0,0,0,07,0,12,0,11,0,05,0,03,0,06,0,0,0,0,0,0,04,0,0,0,0,
	06,0,12,0,11,0,07,0,0,0,12,0,0,0,14,0,0,0,07,0,0,0,11,0,0,0,0,0,0,
	13,0,12,0,07,0,0,0,0,06,0,07,0,11,0,06,0,07,0,0,0,0,05,0,
	05,0,04,0,05,0,06,0,0,0,0,06,0,12,0,0,0,0,11,0,07,0,0,0,0,0,0,
	12,0,0,0,12,0,0,0,0,07,0,05,0,05,0,04,0,05,0,13,0,0,0,0,0,11,0,
	06,0,07,0,11,0,07,0,0,0,12,0,0,0,11,0,0,0,06,0,0,0,05,0,0,0,0,0,0,
	13,0,12,0,11,0,0,0,0,0,05,0,0,0,0,03,0,06,0,0,0,0,0,04,0,0,0,
	12,0,0,11,07,0,0,0,0,0,06,0,0,0,05,0,0,0,05,0,0,0,0,0,0,0,
	05,0,0,0,13,0,0,0,0,12,0,0,0,05,0,0,0,11,0,0,0,0,0,07,0,0,0,0,07,0,06,0,0,0,0,05,0,06,0,0,0,12,0,0,0,12,0,0,0,0,0,0,
	13,0,12,0,11,0,0,0,0,0,05,0,0,0,0,03,0,06,0,0,0,0,0,04,0,0,0,
	12,0,0,11,07,0,0,0,0,0,06,0,0,0,05,0,0,0,13,0,0,0,0,0,0,0,
	13,0,0,0,15,0,0,0,0,0,14,0,0,0,13,0,0,0,12,0,0,0,0,13,0,14,0,0,0,0,14,0,13,0,0,0,0,13,0,12,0,0,0,0,12,0,11,0,0,0,0,0,0
}
timeTable = {}
sameNoteTable = {}

sameSignale = false
release = false
releaseTime = 0
playIndex = 0
lastPlay = 0

function getNote(playIndex)
	tmp = song[playIndex+1]
	tmp = math.floor(tmp/10)*7+tmp%10
	return tmp
end

function onTick()
	GB = input.getBool
	timeSignal = GB(1)
	isCycle = GB(2)
	reset = GB(3)
	if reset then
		playIndex = 0
	end

	if timeSignal and sameSignal == false then
		release = true
	end
	if timeSignal then
		sameSignal = true
	else
		sameSignal = false
	end

	if release then
		note=getNote(playIndex+1)
		playIndex = (playIndex+1)%(#song)
		if playIndex == #song-1 and isCycle then
			playIndex = 0
		end
		release = false
		releaseTime = property.getNumber("ReleaseTime")
		
		
		-- same note repeat situation
		if timeTable[note] and timeTable[note] > 0 then
			sameNoteTable[note] = true
		end
		-- regist play note
		timeTable[note] = releaseTime
		output.setNumber(1, playIndex+1)
		output.setNumber(3, #song)
	end

	for n, v in pairs(timeTable) do
    	if v > 0 and not sameNoteTable[n] then
			output.setNumber(2, n)
			output.setBool(n, true)
			timeTable[n] = v - 1
		else
			output.setBool(n, false)
			sameNoteTable[n] = false
		end
	end
end

function onDraw()
	screen.drawText(2,2,tostring(timeSignal))
	screen.drawText(2,8,tostring(sameSignal))
	screen.drawText(2,14,playIndex)
end