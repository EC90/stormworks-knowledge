-- source: steam id 2089384177 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2089384177
-- this defines the available notes and their composite channel
-- e.g. "d_" is channel 1, "f" is channel e, ...
notes = {"d_","f","f#","g","g#","a","a#","c","d","d#"}

-- this defines the song
-- every note is defined by it's character and the length
-- to make it easier to read, the total length of all notes in one line is 1 length
-- a brake is a simple "-"
song = { 
	{"a",1/4},{"d",1/4},{"a",1/4},{"d",1/4},
	{"a",1/8},{"d",1/8},{"-",1/8},{"a",1/8},{"g#",1/4},{"a",1/4},
	{"a",1/8},{"g#",1/8},{"a",1/8},{"g",1/8},{"-",1/8},{"f#",1/8},{"g",1/8},{"-",1/8},
	{"f",1/2},{"d_",1/2},
	
	{"a",1/4},{"d",1/4},{"a",1/4},{"d",1/4},
	{"a",1/8},{"d",1/8},{"-",1/8},{"a",1/8},{"g#",1/4},{"a",1/4},
	{"g",1/4},{"g",3/8},{"f#",1/8}, {"g",1/8},{"-",1/8},
	{"c",1/8},{"a#",1/8},{"a",3/8},{"g",2/8},{"-",1/8},
	
	{"a",1/4},{"d",1/4},{"a",1/4},{"d",1/4},
	{"a",1/8},{"d",1/8},{"-",1/8},{"a",1/8},{"g#",1/4},{"a",1/4},
	{"c",1/8},{"c",3/8},{"-",1/8},{"a",1/8},{"g",1/8},{"-",1/8},
	{"f",1/4},{"d_",1/2},{"-",1/4},
	{"d_",1/2},{"f",1/2},
	{"a",1/2},{"c",1/2},
	{"d#",1/8},{"d",3/8},{"g#",1/4},{"a",1/4},
	{"f",1/2},{"-",1/2}
}

noteCounter = 1
tickCounter = 0

play = false
function onTick()
	play = input.getBool(1)
	if play then		
		oneNoteInTicks = input.getNumber(1)
		if oneNoteInTicks <= 0 then
			oneNoteInTicks = 20
		end
		
		for i=1,#notes do
			output.setBool(i, false)
		end
		
		for c,n in ipairs(notes) do
			if n == song[noteCounter][1] and tickCounter == 0 then
				output.setBool(c, true)
			end
		end
		
		if tickCounter > song[noteCounter][2] * oneNoteInTicks then
			noteCounter = noteCounter + 1
			tickCounter = 0
		else
			tickCounter = tickCounter + 1
		end
		
		if noteCounter > #song then
			noteCounter = 1
		end
	else
		noteCounter = 1
		tickCounter = 0
		
		for i=1,#notes do
			output.setBool(i, false)
		end
	end
end