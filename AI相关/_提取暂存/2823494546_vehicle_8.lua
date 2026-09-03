-- source: steam id 2823494546 / vehicle.xml block#8
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
function cp(s)C(243,243,243)if s==1 then C(125,125,125)end
if s==2 then C(75,75,75)end
if s==3 then C(45,45,45)end
if s==4 then C(25,25,25)end
end

function iR(rX,rY,rW,rH)return X>rX-1 and Y>rY-1 and X<rX-1+rW+1 and Y<rY-1+rH+1 end
function dS(x,y,w,h)dF(x+1,y,w-2,h)dF(x,y+1,1,h-2)dF(x+w-1,y+1,1,h-2)end
function gB(...)local a={}for b,c in ipairs({...})do a[b]=I.getBool(c)end;return tU(a)end
function gN(...)local a={}for b,c in ipairs({...})do a[b]=I.getNumber(c)end;return tU(a)end

t=1

R=20
G=20
B=20
A=255

function onTick()
W,H,X,Y=gN(1,2,3,4)iP=gB(1)Q=W/2 cw=W/2 ch=H/2



if iP and iR(cw-35,1,7,7)then t=1 end if iP and iR(cw-26,1,7,7)then t=8 end
if iP and iR(cw-17,1,7,7)then t=2 end if iP and iR(cw-8 ,1,7,7)then t=3 end
if iP and iR(cw+1 ,1,7,7)then t=4 end if iP and iR(cw+10,1,7,7)then t=5 end
if iP and iR(cw+18,1,7,7)then t=6 end if iP and iR(cw+27,1,7,7)then t=7 end

if iP and iR(2,20,4,63)then R=255-(Y-20)/63*255 end
if iP and iR(7,20,4,63)then G=255-(Y-20)/63*255 end
if iP and iR(12,20,4,63)then B=255-(Y-20)/63*255 end
if iP and iR(17,20,4,63)then A=255-(Y-20)/63*255 end

oN(7,t)
oN(8,R)
oN(9,G)
oN(10,B)
oN(11,A)

end

function onDraw()w=S.getWidth()h=S.getHeight()cw=w/2 ch=h/2
cp()dF(0,0,w,h)
cp(1)dF(0,0,w,9)cp()dS(-1,0,10,9)
end