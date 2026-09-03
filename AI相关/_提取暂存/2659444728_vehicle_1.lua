-- source: steam id 2659444728 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2659444728
buttonOpen = {x=2, y=15, w=45, h=20, text="Open\n\nKeyboard"}
buttonClose = {x=49, y=15, w=45, h=20, text="Close\n\nKeyboard"}

message = "abcdes"

function onTick()
	keyboard = parseKeyboard(input.getNumber(31))
	
	-- by default, do not send anything to the keyboard
	output.setBool(31, false)
	output.setBool(32, false)
	
	if keyboard.click and not keyboard.keyboardShown then
		if keyboard.x >= buttonOpen.x and keyboard.x <= buttonOpen.x+buttonOpen.w and keyboard.y >= buttonOpen.y and keyboard.y <= buttonOpen.y+buttonOpen.h then					
			output.setBool(31, true) -- request keyboard to open
		end
		
		if keyboard.x >= buttonClose.x and keyboard.x <= buttonClose.x+buttonClose.w and keyboard.y >= buttonClose.y and keyboard.y <= buttonClose.y+buttonClose.h then
			output.setBool(32, true) -- request keyboard to close
		end
	end
	
	if keyboard.DEL then
		message = string.sub(message, 1, string.len(message) - 1)
	elseif keyboard.char then
		message = message .. keyboard.char	
	end
end

function onDraw()
	screen.setColor(50,50,50)
	screen.drawClear()
	
	for i,btn in pairs({buttonOpen, buttonClose}) do
		screen.setColor(20,20,20)
		screen.drawRectF(btn.x, btn.y, btn.w, btn.h)
		screen.setColor(255,255,255)
		screen.drawTextBox(btn.x, btn.y, btn.w, btn.h, btn.text, 0,0)
	end
	
	screen.setColor(255,255,255)
	screen.drawTextBox(2,2, screen.getWidth()-4, 12, message, 0,0)
end


-- bit 1 = type
-- bit 2 = keyboard is shown

-- if type==true
-- bits 3-13 = x
-- bits 14-24 = y

-- if type==false
-- bits 2-8 = charcode
function parseKeyboard(numb)
	local fl = math.floor(numb)
	local type = (numb & 1) == 1
	local keyboardShown = (numb & 2) == 2
	
	local ret = {
		type = type,
		keyboardShown = keyboardShown,
		click = false,
		x = 0,
		y = 0,
		key = 0,
		char = ""
	}
	if type then
		ret.click=true
		ret.x=(fl >> 2) & 2047
		ret.y=(fl >> 13) & 2047
	else
		local charc = ((fl >> 2) & 127)
			ret.key = charc
		if charc > 31 and charc < 127 then
			ret.char = string.char(ret.key)
		else
			ret.key = charc
			if charc == 4 then
				ret.CONFIRM = true
			elseif charc == 127 then
				ret.DEL = true
			end
		end
	end
	return ret
end

