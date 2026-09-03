-- source: steam id 3097129660 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
Mf=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P2=pi*2
T=table
SF=string.format
chf=0
--chaff total
chft=38
dpl=-1
seat3o=false
function onTick()
	seat3=GB(3) or GB(15)
	rB,rL,rR=GB(11),GB(12),GB(13)
	rwr=GB(14)
	alt=rB or rL or rR
	if alt then dpl=dpl+1 else dpl=-1 end
	if seat3 and not seat3o then dpl=0 end
	seat3o=seat3
	if dpl%60==0 and chf<chft then chf=chf+1 end
	SB(Mf((chf-1)/15)+1,dpl%60==0)
	SB(11,alt)
end
S=screen
SC=S.setColor
DTB=S.drawTextBox
DL=S.drawLine
function DB(x,y,d,l)
	DL(x,y,x+l*Ms(d*P2/360),y-l*Mc(d*P2/360))
end
function onDraw()
	w=32 h=32
	SC(3,3,3) S.drawClear()
	SC(22,222,22)
	DTB(0,1,w,6,'chaff',0,0)
	DTB(0,7,w,6,chft-chf,0,0)
	if rwr then
		SC(22,222,22)
	else
		SC(11,22,11)
	end
	for i=90,270,3 do
		DB(w/2,h/2,i,15)
	end
	SC(5,11,5)
	for i=90,270,3 do
		DB(w/2,h/2,i,14)
	end
	SC(222,22,22)
	if rR then
		for i=93,147,3 do
			DB(w/2,h/2,i,14)
		end
	end
	if rB then
		for i=153,207,3 do
			DB(w/2,h/2,i,14)
		end
	end
	if rL then
		for i=213,267,3 do
			DB(w/2,h/2,i,14)
		end
	end
	if rwr then
		SC(22,222,22)
	else
		SC(11,22,11)
	end
	for i=90,270,60 do
		DB(w/2,h/2,i,14)
	end
end