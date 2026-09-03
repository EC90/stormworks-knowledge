-- source: steam id 2823494546 / vehicle.xml block#9
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
function GF(r,g,b,a)r=r^2.2/255^2.2*r
g=g^2.2/255^2.2*g
b=b^2.2/255^2.2*b
return r,g,b,a
end
R=0
G=0
B=0
A=0
TEXT=""
TF=false
function onTick()
W,H,X,Y,t,R,G,B,A=gN(1,2,3,4,7,8,9,10,11)iP=I.getBool(1)
oB(1,SP)
end

function onDraw()w=S.getWidth()h=S.getHeight()cw=w/2 ch=h/2 sd=w*h==46080

if sd then
cp(3)dF(231,23,1,116)dF(58,138,174,1)
else
cp(3)dF(33,79,96,1)dF(128,16,1,64)
end

if not sd then
cp()dS(w-24,10,23,9)cp(2)dF(w-13,11,4,4)cp(4)dF(w-14,12,4,4)cp(2)dF(w-15,13,4,4)cp(4)dF(w-16,14,4,4)

cp()dS(1,10,21,9)


C(150,0,0)dF(2,20,4,62+1)GradV(2,20,4,62,0,255)
C(0,50,0)dF(7,20,4,62+1)GradV(7,20,4,62,0,255)
C(0,38,65)dF(12,20,4,62+1)GradV(12,20,4,62,0,255)
cp()dF(17,20,4,62+1)bl(17,20,62)GradV(17,20,4,62,255,0)
ga(2,R)ga(7,G)ga(12,B)ga(17,A)

C(GF(R,G,B,A))oc(8,11)
else
cp(4)dTx(11,2,"Display Only")
end


cp(4)pe(2,2)



if not sd then
cp(2)dF(12,2,4,4)cr(14,4)
cp(4)pr(20,2)

cp(4)
d(w-13,80)d(w-12,81)d(w-11,80)
d(w-7,80)d(w-6,79)d(w-5,80)
end


end
function cr(x,y)C(250,0,0)dL(x,y,x+3,y+3)dL(x,y+2,x+3,y-1)end
function pr(x,y)dF(x,y,1,3)dF(x+1,y+1,1,2)d(x+2,y+2)dF(x+2,y,2,1)dF(x+4,y+1,1,3)d(x+3,y+4)end
function pe(x,y)dF(x+3,y,2,2)dF(x+2,y+1,2,2)d(x+1,y+2)d(x+2,y+3)dF(x,y+3,1,2)d(x+1,y+4)end
function oc(x,y)C(GF(R,G,B,A))dF(x,y+1,1,5)dF(x+1,y,1,5)d(x+2,y+1)cp(4)dF(x+3,y+1,2,4)dF(x+2,y+2,4,2)d(x+4,y+5)d(x+5,y+4)d(x+6,y+3)end
function GradV(x,y,w,h,o1,o2)for i=0,h,1 do
C(0,0,0,o1+i*((o2-o1)/h))dF(x,y+i,w,1)end
end
function bl(x,y,h)cp(2)for i=0,h,1 do
if i%2==0 then d(x,y+i)d(x+2,y+i)else d(x+1,y+i)d(x+3,y+i)end
end
end
function ga(x,v)cp()dF(x,20+(1-v/255)*63,4,1)end