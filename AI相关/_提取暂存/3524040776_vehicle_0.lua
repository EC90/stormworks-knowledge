-- source: steam id 3524040776 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P=pi*2
T=table
TS=T.insert
function Mp(x,min,max)
	return M.max(min,M.min(x,max))
end
set=26.5
sys=false
function onTick()
	temp=GN(11)
	--sys=GB(11)
	tx,ty=GN(3),GN(4)
	tc=GB(1)
	--
	if sys then
		if temp>set+3 then mode=1
		elseif temp<set-3 then mode=2
		end
		if mode==1 then
			if temp>set+0.5 then cooling=true end
			if temp<set-0.5 then cooling=false end
			heating=false
		elseif mode==2 then
			if temp>set+0.5 then heating=false end
			if temp<set-0.5 then heating=true end
			cooling=false
		end
	end
	if tc and not tcd then
		if ty>23 then
			if tx<16 then
				set=M.max(set-0.5,16)
			else
				set=M.min(set+0.5,32)
			end
		elseif ty<9 then
			sys=not sys
		end
	end
	--
	tcd=tc
    SB(1,sys and cooling)
    SB(2,sys and heating)
	SN(1,set)
end
S=screen

function onDraw()
	if sys then
		S.setColor(32,64,32)
	else
		S.setColor(22,33,22)
	end
	S.drawClear()
	S.setColor(16,16,16)
	S.drawRect(1,1,29,8)
	if not sys then
		S.drawTextBox(0,2,32,8,'off',0,0)
	elseif mode==1 then
		S.drawTextBox(0,2,32,8,'cool',0,0)
	elseif mode==2 then
		S.drawTextBox(0,2,32,8,'heat',0,0)
    else
		S.drawTextBox(0,2,32,8,'idle',0,0)
	end
	S.drawRect(1,24,29,6)
	if sys then
		S.drawText(1,11,'c'..string.format("%2.1f",temp)..'C')
		S.drawText(1,18,'s'..string.format("%2.1f",set)..'C')
		S.drawTextBox(0,24,32,8,'- | +',0,0)
	end
end