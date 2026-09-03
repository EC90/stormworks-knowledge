-- source: steam id 1962616298 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
btn={}
eng={}
engn=property.getNumber("Number of Engines")
for i=1, engn do
	table.insert(eng, #eng+1, true)
end
btnx={}
btny={}
btnw={}
btnh={}

function onTick()
go=input.getBool(32)
if go then
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
	cx={cx1, cx2, cx3, cx4}
	cy={cy1, cy2, cy3, cy4}
	lf=w/4
	rt=3*w/4
	tp=h/4
	bt=3*h/4
	if eng[4] then -- defines center points for each engine
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
	elseif eng[3] then
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
	elseif eng[2] then
		cx[1]=lf
		cx[2]=rt
		cy[1]=a
		cy[2]=a
		for i=1, 2 do
			btnx[i]=(cx[i])-w/4
			btny[i]=(cy[i])-h/4
			btnw[i]=b
			btnh[i]=a
		end
	end
	if btn[1] or btn[2] or btn[3] or btn[4] then
		if pulse and inRect(touchX, touchY, -1, -1, 12, 13) then -- resets selected engine
			for i=1, 4 do
				btn[i]=false
			end
		end
	else
		if engn>1 then -- selects engine for details
			for i=1, engn do
				if pulse and inRect(touchX, touchY, btnx[i], btny[i], btnw[i], btnh[i]) then
					btn[i]=true
				end
			end
		end
	end
	for i=1, 4 do
		output.setNumber(i, cx[i])
		output.setNumber(i+4, cy[i])
		if btn[i] then
			output.setNumber(9, i) -- sets engine number for detailed view
		elseif btn[1] or btn[2] or btn[3] or btn[4] then -- spacer
		else
			output.setNumber(9, 0)
		end
	end
end
end
	
function inRect(x, y, rectx, recty, rectw, recth) -- checks if click is inside button
	return x>rectx and y>recty and x<rectw+rectx and y<recth+recty
end