-- source: steam id 2046605849 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2046605849
--SETTINGS--
enableNightVision="1" -- For disable nightvision, write a number higther then 1 / For activate : write  1
isGimble="1" -- for disable movement buttons, write a number highter then 1
enableResetBtn="1" -- for disable reset button, write a number highter then 1

presetPitch={val=0, min=-1, max=1}
presetRot={val=0, min=-0.5, max=0.5}
presetZoom={val=0, min=0, max=1}

--DO NOT TOUCH--
pitch=0
rot=0
zoom=0
nv=false

dG="0"

buttonsCount=10
btn={
	{name="showMenu",
	grp="0",
	toggle=true,
	pos={x=1, y=1, w=11, h=11}, 
	c=function() screen.drawCircle(6, 6, 3) end, 
	cB=function() dG="1" states[2].active=false end},
	{name="hideMenu",
	grp="1",
	toggle=true,
	pos={x=1, y=1, w=11, h=11}, 
	c=function() screen.drawCircle(6, 6, 3) screen.drawLine(11, 1, 1, 11) end, 
	cB=function() dG="0" states[1].active=false end},
	{name="leftMove",
	grp=isGimble,
	toggle=false,
	pos={x=13, y=1, w=10, h=10}, 
	c=function() screen.drawTriangleF(21, 3, 21, 9, 15, 6) end, 
	cB=function() rot=rot+0.01 end},
	{name="rightMove",
	grp=isGimble,
	toggle=false,
	pos={x=22, y=1, w=10, h=10}, 
	c=function() screen.drawTriangleF(24, 3, 24, 9, 30, 6) end, 
	cB=function() rot=rot-0.01 end},
	{name="upMove",
	grp=isGimble,
	toggle=false,
	pos={x=31, y=1, w=10, h=10}, 
	c=function() screen.drawTriangleF(33, 9, 39, 9, 36, 3) end, 
	cB=function() pitch=pitch+0.01 end},
	{name="downMove",
	grp=isGimble,
	toggle=false,
	pos={x=40, y=1, w=10, h=10}, 
	c=function() screen.drawTriangleF(41, 3, 48, 3, 45, 9) end, 
	cB=function() pitch=pitch-0.01 end},
	{name="resetPos",
	grp=isGimble,
	toggle=false,
	pos={x=49, y=1, w=10, h=10}, 
	c=function() screen.drawTextBox(50, 2, 8, 8, "R", 0, 0) end, 
	cB=function() pitch=presetPitch.val rot=presetRot.val zoom=presetZoom.val end},
	{name="upZoom",
	grp="1",
	toggle=false,
	pos={x=1, y=13, w=10, h=10}, 
	c=function() screen.drawTextBox(2, 14, 8, 8, "+", 0, 0) end, 
	cB=function() zoom=zoom+0.01 end},
	{name="downZoom",
	grp="1",
	toggle=false,
	pos={x=1, y=22, w=10, h=10}, 
	c=function() screen.drawTextBox(2, 23, 8, 8, "-", 0, 0) end, 
	cB=function() zoom=zoom-0.01 end},
	{name="nightVision",
	toggle=true,
	grp=enableNightVision,
	pos={x=1, y=40, w=10, h=10}, 
	c=function() screen.drawTextBox(2, 41, 8, 8, "N", 0, 0) end, 
	cB=function() nv=not nv end}
}
states={}
function init()
	pitch=presetPitch.val
	rot=presetRot.val
	zoom=presetZoom.val
	for i=1, buttonsCount do
		states[i] = {active=true, count=0}
	end
end
init()
function cooldown()
	for i=1, buttonsCount do
		if states[i].active == false then
			states[i].count=states[i].count+1
		end
		if states[i].count >= 30 then
			states[i].active=true
			states[i].count=0
		end
	end
end
function touchPad(tX, tY, tZ)
	if tZ == true then
		for i=1, buttonsCount do
			if btn[i].grp == dG and states[i].active == true then
				if tX >= btn[i].pos.x and tX <= btn[i].pos.x+btn[i].pos.w then
					if tY >= btn[i].pos.y and tY <= btn[i].pos.y+btn[i].pos.h then
						btn[i].cB()
						if btn[i].toggle == true then
							states[i].active=false
						end
					end
				end
			end
		end
	end
end
function onTick()
	tX = input.getNumber(3)
	tY = input.getNumber(4)
	tZ = input.getBool(1)
	touchPad(tX, tY, tZ)
	output.setNumber(1, pitch)
	output.setNumber(2, rot)
	output.setNumber(3, zoom)
	output.setBool(4, nv)
	cooldown()
	if pitch <= presetPitch.min then
		pitch=presetPitch.min
	elseif pitch >= presetPitch.max then
		pitch=presetPitch.max
	elseif rot <= presetRot.min then
		rot=presetRot.min
	elseif rot >= presetRot.max then
		rot=presetRot.max
	elseif zoom <= presetZoom.min then
		zoom=presetZoom.min
	elseif zoom >= presetZoom.max then
		zoom=presetZoom.max
	end
end
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	for i=1, buttonsCount do
		if btn[i].grp == dG then
			screen.setColor(0, 0, 0)
			screen.drawRectF(btn[i].pos.x, btn[i].pos.y, btn[i].pos.w, btn[i].pos.h)
			screen.setColor(255, 255, 255)
			screen.drawRectF(btn[i].pos.x+1, btn[i].pos.y+1, btn[i].pos.w-2, btn[i].pos.h-2)
			screen.setColor(0, 0, 0)
    		btn[i].c()
		end
	end
end