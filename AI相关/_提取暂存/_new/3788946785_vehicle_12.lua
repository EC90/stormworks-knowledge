-- source: steam id 3788946785 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785
s=screen
sc=s.setColor
iN=input.getNumber
iB=input.getBool
ms=math.sin
mc=math.cos
pi=math.pi
pi2=pi*2
S={}
--passive sonar
function onTick()
	S={}
	on=iB(32)
	ba=iN(2)*pi2
	mm=iN(4)
	sT=iN(6)
	w=iN(8)cx=w/2-.5
	h=iN(10)cy=h/2
	if sT==1 then
		for i=1,16 do
			if iB(i) then
				ta=iN(i*2-1)*pi2
				table.insert(S,{a=-ta-pi+ba})
			end
		end
	end
end
function onDraw()
	if mm<3 then ba=0 end
	if sT==1 then
		for i,v in pairs(S) do
			sc(0,0,200,100)
			x1=cx+(cy+10)*ms(v.a-ba)
			y1=cy-.5+(cy+10)*mc(v.a-ba)
			x2=cx+(cy-2)*ms(v.a-ba)
			y2=cy-.5+(cy-2)*mc(v.a-ba)
			s.drawLine(x1,y1,x2,y2)
		end
	end
end