-- source: steam id 2836937357 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
-- SETTINGS --

globalBackGroundColor = function() screen.setColor(20, 20, 20) end

btns={
	{"btn_1",
	display=true,
	pos={x=34, y=13, w=25, h=9},
	borderAndTextColor=function() screen.setColor(0, 0, 0) end,
	backgroundColor=function() screen.setColor(255, 255, 255) end,
	text="Open",
	outputChannel=1,
	defaultState=true},
	{"btn_2",
	display=true,
	pos={x=34, y=28, w=25, h=9},
	borderAndTextColor=function() screen.setColor(0, 0, 0) end,
	backgroundColor=function() screen.setColor(255, 255, 255) end,
	text="DIM",
	outputChannel=2,
	defaultState=false},
	{"btn_3",
	display=true,
	pos={x=34, y=38, w=25, h=9},
	borderAndTextColor=function() screen.setColor(0, 0, 0) end,
	backgroundColor=function() screen.setColor(255, 255, 255) end,
	text="NT.M",
	outputChannel=3,
	defaultState=false},

}

-- DO NOT TOUCH BELLOW--
bC=1
states={}
function init()
	process=true
	while process == true do
		if btns[bC] ~= nil then
			states[bC]={active=true, count=0, state=btns[bC].defaultState}
			bC=bC+1
		else 
			process=false
			bC=bC-1
		end
	end
end
init()

function outputVal()
	for i=1, bC do
		output.setBool(btns[i].outputChannel, states[i].state)
	end
end

function cooldown()
	for i=1, bC do
		if states[i].active == false then
			states[i].count=states[i].count+1
		end
		if states[i].count >= 30 then
			states[i].active=true states[i].count=0
		end
	end
end

function touchPad(tX, tY, tZ)
	if tZ == true then
		for i=1, bC do
			if btns[i].display == true and states[i].active == true then
				if tX >= btns[i].pos.x and tX <= btns[i].pos.x+btns[i].pos.w and tY >= btns[i].pos.y and tY <= btns[i].pos.y+btns[i].pos.h then
					if btns[i].cB ~= nil then btns[i].cB() end
					states[i].state=not states[i].state states[i].active=false
				end
			end
		end
	end
end

function onTick()
	tX = input.getNumber(3)
	tY = input.getNumber(4)
	tZ = input.getBool(1)
	touchPad(tX, tY, tZ) cooldown() outputVal()
end

function onDraw()


	w = screen.getWidth()
	h = screen.getHeight()
	
	
	globalBackGroundColor() screen.drawRectF(0, 0, w, h)
	
	
	for i=1, bC do
		if btns[i].display == true then
			if states[i].state == false then btns[i].borderAndTextColor() else btns[i].backgroundColor() end
			screen.drawRectF(btns[i].pos.x, btns[i].pos.y, btns[i].pos.w, btns[i].pos.h)
			if states[i].state == false then btns[i].backgroundColor() else btns[i].borderAndTextColor() end
			screen.drawRectF(btns[i].pos.x+1, btns[i].pos.y+1, btns[i].pos.w-2, btns[i].pos.h-2)
			if states[i].state == false then btns[i].borderAndTextColor() else btns[i].backgroundColor() end
    		screen.drawTextBox(btns[i].pos.x+1, btns[i].pos.y+1, btns[i].pos.w-2, btns[i].pos.h-2, btns[i].text, 0, 0)
		end
	end
end