-- source: steam id 3464467373 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3464467373
--datalink3camera
J=true
K=false
U=233
V=15
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
touchx,touchy=0,0
toucho=K
M=math
Mf=M.floor
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DT=S.drawText
DTB=S.drawTextBox
function PB(bx,by,bw,bh) if touch and tx>bx and tx<bx+bw and ty>by and ty<by+bh then return J else return K end end
function onTick()
	w=GN(1)
	h=GN(2)
	tx=GN(3)
	ty=GN(4)
	touch=input.getBool(1)
	if PB(0,0,21,6) and not toucho then quit=1 else quit=0 end
	SN(1,quit)
	toucho=touch
end
function onDraw()
	sC(V,V,V,128)
	DRF(0,0,21,7)
	sC(V,U,V)
	DT(1,1,'quit')
end