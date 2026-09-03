-- source: steam id 1962616298 / vehicle.xml block#22
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
btn={}
gen={}
genn=property.getNumber("Number of Generators")
stby=property.getBool("Include Standby Battery")
for i=1, genn do
	table.insert(gen, #gen+1, true)
end
btnx={}
btny={}
btnw={}
btnh={}

function onTick()
go=input.getBool(32)
if go then
	if stby then
		sby=2
	else
		sby=1
	end
	w=input.getNumber(1)
	h=input.getNumber(2)
	a=h/2
	b=w/2
	touchX=input.getNumber(3) -- touchscreen pixel coords
	touchY=input.getNumber(4)
	press=input.getBool(1)
	if press then -- pulses the screen press to prevent flickering
		if x==0 then
			pulse=true
			x=1
		else
			pulse=false
		end
	else
		x=0
		pulse=false
	end
	cx={0, 0, 0, 0}
	cy={0, 0, 0, 0}
	lf=w/4
	rt=3*w/4
	tp=7
	bt=21
	if gen[4] then -- defines center points for each generator
		cx[1]=lf
		cx[2]=rt
		cx[3]=lf
		cx[4]=rt
		cy[1]=tp
		cy[2]=tp
		cy[3]=bt
		cy[4]=bt
		for i=1, 4 do
			btnx[i]=(cx[i])-w/4
			btny[i]=(cy[i])-h/4
			btnw[i]=b
			btnh[i]=a
		end
	elseif gen[3] then
		cx[1]=lf
		cx[2]=b
		cx[3]=rt
		cy[1]=tp
		cy[2]=bt
		cy[3]=tp
		for i=1, 3 do
			btnx[i]=(cx[i])-w/4
			btny[i]=(cy[i])-h/4
			btnw[i]=b
			btnh[i]=a
		end
	elseif gen[2] then
		cx[1]=lf
		cx[2]=rt
		cy[1]=tp
		cy[2]=tp
		for i=1, 2 do
			btnx[i]=(cx[i])-w/4
			btny[i]=(cy[i])-h/4
			btnw[i]=b
			btnh[i]=a
		end
	elseif gen[1] then
		cx[1]=b
		cy[1]=tp
	end
	for i=1, 4 do
		output.setNumber(i, cx[i])
		output.setNumber(i+4, cy[i])
	end
	if btn[1] or btn[2] then
		if pulse and inRect(touchX, touchY, -1, -1, 12, 13) then -- reset button for detailed view
			for i=1, 2 do
				btn[i]=false
			end
		end
	else -- selects a battery for detailed view
		if pulse and inRect(touchX, touchY, 0, 8+math.max(cy[1], cy[2], cy[3]), h/sby, h-(math.max(cy[1], cy[2], cy[3])+8)) then
			btn[1]=true
		elseif pulse and inRect(touchX, touchY, b, 8+math.max(cy[1], cy[2], cy[3]), b, h-(math.max(cy[1], cy[2], cy[3])+8)) and stby then
			btn[2]=true
		end
	end
	for i=1, sby do
		if btn[i] then
			output.setNumber(9, i) -- outputs value of detailed battery
		elseif btn[1] or btn[2] then -- spacer
		else
			output.setNumber(9, 0) -- resets to main screen
		end
	end
end
end
	
function inRect(x, y, rectx, recty, rectw, recth) -- checks if click is inside button
	return x>rectx and y>recty and x<rectw+rectx and y<recth+recty
end