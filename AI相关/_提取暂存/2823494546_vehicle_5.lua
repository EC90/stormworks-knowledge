-- source: steam id 2823494546 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2823494546
s=string
M=math
S=screen
C=S.setColor
dF=S.drawRectF
dTx=S.drawText
dL=S.drawLine
dTxB=S.drawTextBox
dCF=S.drawCircleF
I=input
tU=table.unpack
F=string.format

function dS(x,y,w,h)dF(x+1,y,w-2,h)dF(x,y+1,1,h-2)dF(x+w-1,y+1,1,h-2)end
function d(x,y)dF(x,y,1,1)end

function onDraw()w=S.getWidth()h=S.getHeight()cw=w/2 ch=h/2 ssi=w*h

C(243,243,243)dF(0,0,w,h)
C(25,25,25)
dTx(cw-22-7-11,ch-3,"For ")
logo(cw-22-7+11,ch-4)


end


function logo(x,y) x=x-2 y=y-1
dF(x+2,y+1,1,3)dF(x+3,y+2,1,3)dF(x+6,y+1,1,3)dF(x+5,y+2,1,3)dF(x+3,y+3,4,1)dS(x+2,y+4,5,4)dF(x+10,y+4,1,4)d(x+11,y+5)dF(x+12,y+4,2,1)dF(x+15,y+5,3,1)dF(x+15,y+5,1,3)dF(x+15,y+7,2,1)dF(x+17,y+5,1,2)d(x+18,y+7)dF(x+20,y+2,1,6)d(x+21,y+5)d(x+21,y+7)d(x+22,y+6)dF(x+24,y+2,1,6)d(x+25,y+5)d(x+25,y+7)d(x+26,y+6)dF(x+28,y+6,1,2)d(x+28,y+4)dF(x+30,y+4,3,1)dF(x+31,y+2,1,6)dF(x+36,y+3,1,4)dF(x+37,y+2,3,1)dF(x+37,y+7,3,1)dF(x+40,y+3,1,4)dF(x+43,y+2,3,1)d(x+42,y+3)d(x+43,y+4)d(x+44,y+5)d(x+45,y+6)dF(x+42,y+7,3,1)dTx(x+48,y-1,"PRO")C(150,0,0)dF(x+2,y+10,11,1)C(0,50,0)dF(x+2+11,y+10,11,1)C(0,38,255)dF(x+2+11*2,y+10,11,1)C(75,75,0)dF(x+2+11*3,y+10,11,1)end
