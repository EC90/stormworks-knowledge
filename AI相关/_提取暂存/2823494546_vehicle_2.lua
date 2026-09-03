-- source: steam id 2823494546 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2823494546
M=math
S=screen
C=S.setColor
dL=S.drawLine
dC=S.drawCircle
dCF=S.drawCircleF
dR=S.drawRect
dF=S.drawRectF
dT=S.drawTriangle
dTF=S.drawTriangleF
dTx=S.drawText
I=input
O=output
oN=O.setNumber
tI=table.insert
tU=table.unpack
T=true
F=false


function iR(rX,rY,rW,rH)return X>rX-1 and Y>rY-1 and X<rX-1+rW+1 and Y<rY-1+rH+1 end
function gB(...)local a={}for b,c in ipairs({...})do a[b]=I.getBool(c)end;return tU(a)end
function gN(...)local a={}for b,c in ipairs({...})do a[b]=I.getNumber(c)end;return tU(a)end

t=1

R=10
G=10
B=10
A=255

function onTick()
W,H,X,Y=gN(1,2,3,4)iP=gB(1)Q=W/2


if iP and iR(4,13,9,9)then t=1 end if iP and iR(16,13,9,9)then t=8 end
if iP and iR(4,23,9,9)then t=2 end if iP and iR(16,23,9,9)then t=3 end
if iP and iR(4,33,9,9)then t=4 end if iP and iR(16,33,9,9)then t=5 end
if iP and iR(4,43,9,9)then t=6 end if iP and iR(16,43,9,9)then t=7 end

if iP and iR(3,67,5,70)then R=255-(Y-67)/69*255 end
if iP and iR(9,67,5,70)then G=255-(Y-67)/69*255 end
if iP and iR(15,67,5,70)then B=255-(Y-67)/69*255 end
if iP and iR(21,67,5,70)then A=255-(Y-67)/69*255 end

oN(7,t)
oN(8,R)
oN(9,G)
oN(10,B)
oN(11,A)

end