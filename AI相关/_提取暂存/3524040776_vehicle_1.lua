-- source: steam id 3524040776 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--PYOs ANTICAUSAL FCS Slave Manager
--input your turret draw coord here
--first line is for CMD
TrtData={
	{0.75,0.38},
	{0.75,0.18},
	{0.75,0.52},
	{0.75,0.69},
	{0.75,0.86},
}
--input line coord to draw hull shape
Lines={
	{15,1},
	{9,10},
	{5,26},
	{5,46},
	{6,56},
	{9,63},
	{23,63},
	{26,56},
	{27,46},
	{27,26},
	{23,10},
	{17,1},
	{15,1},
}
--
for i=1,#TrtData do
	TrtData[i][3]=0
	TrtData[i][4]=0--aiming
	TrtData[i][5]=false
end
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
MathAtan=M.atan
Ma=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mq=M.sqrt
P=M.pi
P2=P*2
w=32
h=32
function mF(x)
	return Mf(x+0.5)
end
function onTick()
	HullCps=-GN(10)
	for i=1,#TrtData do
		TrtData[i][3]=-GN(i+10)
		TrtData[i][4]=Mf(GN(i+20))
		TrtData[i][6]=GN(i+20)%1
		SB(i-1,TrtData[i][5])
		if TrtData[i][5] then
			SN(i-1,1)
		else
			SN(i-1,0)
		end
	end
	if GB(1) and not tc then
		for i=1,#TrtData do
			dcx=mF(TrtData[i][1]*w)
			dcy=mF(TrtData[i][2]*h)
			if GN(3)>dcx-(dcr+2) and GN(3)<dcx+(dcr+2) and GN(4)>dcy-(dcr+2) and GN(4)<dcy+(dcr+2) then
				TrtData[i][5]=not TrtData[i][5]
			end
		end
	end
	tc=GB(1)
end
dcr=PN('Draw Circle Radius')
S=screen
SC=S.setColor
DTB=S.drawTextBox
DL=S.drawLine
DC=S.drawCircle
function DB(x,y,d,l)--turn
	local x1,y1=Ms(d*P2)*l,-Mc(d*P2)*l
	DL(x,y,x1+x,y1+y)
end
function onDraw()
	w,h=S.getWidth(),S.getHeight()
	SC(8,8,8)
	S.drawClear()
	SC(44,44,44)
	for i=1,#Lines-1 do
		DL(Lines[i][1]+32,Lines[i][2],Lines[i+1][1]+32,Lines[i+1][2])
	end
	for i=1,#TrtData do
		dcx=mF(TrtData[i][1]*w)
		dcy=mF(TrtData[i][2]*h)
		if i==1 then
			SC(22,66,222)
		else
			if TrtData[i][5] then
				if TrtData[i][6]<0.01 then
					SC(222,22,22)
				elseif TrtData[i][4]>0.5 then
					SC(22,222,22)
				else
					SC(222,222,22)
				end
			else
				SC(22,22,22)
			end
		end
		DC(dcx,dcy,dcr)
		--if i>1 then blen=dcr+2 else blen=dcr+4 end
		DB(dcx,dcy,TrtData[i][3]-HullCps,dcr+2)
		if i>1 then
			SC(222,22,22)
			DL(dcx-dcr-3,dcy+dcr+3,dcx+dcr+3,dcy+dcr+3)
			SC(22,222,22)
			DL(dcx-dcr-3,dcy+dcr+3,dcx-dcr-3+(2*dcr+6)*TrtData[i][6],dcy+dcr+3)
		end
	end
end