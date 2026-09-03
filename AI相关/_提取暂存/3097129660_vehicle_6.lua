-- source: steam id 3097129660 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
M=math
Ma=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P2=M.pi*2
T=table
R={}
function onTick()
if GN(5)~=0 then T.insert(R,{GN(1),0}) end
for i=1,#R do
	R[i][2]=R[i][2]+1
	if R[i][2]>300 then T.remove(R,i) break end
end
jamP=GB(1)
jamT=GB(2)
arad=GB(3)
ss=GN(11)
jf=GN(12)
end
S=screen
SC=S.setColor
DC=S.drawCircle
L=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
DR=S.drawRect
DRF=S.drawRectF
function onDraw()
w,h=S.getWidth(),S.getHeight()
SC(3,3,3) S.drawClear()
if jamP then
	if jamT then
		SC(222,22,22) msg='jaming'
	else
		SC(22,22+ss*200,22) msg='listen'
	end
	msg2=string.format('%0.0f',jf)
else
	SC(22,22,22) msg='antena'
	msg2='off'
end
DTB(0,1,w,6,msg,0,0)
DTB(0,7,w,6,msg2,0,0)
if arad then
msg='' SC(22,222,22)
for i=1,#R do msg=msg..string.format('%0.0f',R[i][1])..',' end
DTB(0,14,w,h-14,msg,-1,-1)
else
	SC(22,22,22)
	msg='search'
	msg2='off'
	DTB(0,15,w,6,msg,0,0)
	DTB(0,21,w,6,msg2,0,0)
end
SC(11,11,11)
DR(0,0,w-1,12)
end