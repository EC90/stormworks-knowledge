-- source: steam id 2823494546 / vehicle.xml block#10
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
dTxB=S.drawTextBox
I=input
O=output
oB=O.setBool
tI=table.insert
tU=table.unpack
function cp(s)C(243,243,243)
if s==1 then C(125,125,125)end
if s==2 then C(75,75,75)end
if s==3 then C(45,45,45)end
if s==4 then C(25,25,25)end
if s=="cy"then C(0,85,85)end
if s=="c1"then C(0,50,50)end
if s=="bk"then C(0,0,0)end
end

function iR(rX,rY,rW,rH)return X>rX-1 and Y>rY-1 and X<rX-1+rW+1 and Y<rY-1+rH+1 end
function gN(...)local a={}for b,c in ipairs({...})do a[b]=I.getNumber(c)end;return tU(a)end
function dS(x,y,w,h)dF(x+1,y,w-2,h)dF(x,y+1,1,h-2)dF(x+w-1,y+1,1,h-2)end
function d(x,y)dF(x,y,1,1)end

function onDraw()w=S.getWidth()h=S.getHeight()cw=w/2 ch=h/2 

if w*h<15360 then cp(4)dF(0,0,w,h)cp()dTxB(0,0+3,w,h,"Display Size Not supported",0,0)pe(cw-3,ch-15)end


end

function pe(x,y)dF(x+3,y,2,2)dF(x+2,y+1,2,2)d(x+1,y+2)d(x+2,y+3)dF(x,y+3,1,2)d(x+1,y+4)end