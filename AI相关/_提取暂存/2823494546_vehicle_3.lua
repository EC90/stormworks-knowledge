-- source: steam id 2823494546 / vehicle.xml block#3
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
HELP=iP and iR(W/2+80,H-11,7,7)
STEAM=iP and iR(W/2+89,H-11,7,7)
if iP then TF=true end
oB(1,SP)
end

HP=false
SP=false
function onDraw()w=S.getWidth()h=S.getHeight()cw=w/2 ch=h/2

cp()dS(w-28,1,27,9)cp(2)dF(w-15,2,4,4)cp(4)dF(w-16,3,4,4)cp(2)dF(w-17,4,4,4)cp(4)dF(w-18,5,4,4)

cp()dS(1,1,27,9)dS(1,56,27,9)

C(150,0,0)dF(3,67,5,69)C(0,50,0)dF(9,67,5,69)C(0,38,65)dF(15,67,5,69)GradV(3,67,5,69,0,255)GradV(9,67,5,69,0,255)GradV(15,67,5,69,0,255)cp()dF(21,67,5,70)bl(21,67,69)GradV(21,67,5,69,255,0)oc(10,57)ga(3,R)ga(9,G)ga(15,B)ga(21,A)C(GF(R,G,B,A))dS(3,139,23,8)


cp(2)dF(4,h-8,4,4)cr(6,h-6)cp(4)dTx(11,h-8,"CLR")

cp(4)pr(w-27,h-8)dTx(w-20,h-8,"PREV")
pe(12,3)

cp(4)
d(w-13,h-15)d(w-12,h-14)d(w-11,h-15)
d(w-7,h-15)d(w-6,h-16)d(w-5,h-15)

if HELP then cp("cy")HP=true else cp("c1") end dS(cw+80,h-11,7,7)cp()dTx(cw+82,h-10,"?")
if STEAM then cp("cy")SP=true else cp("c1")end dS(cw+89,h-11,7,7)st(cw+90,h-10)

if iP and not HELP then HP=false end
if iP and not STEAM then SP=false end
cp(4)
if HP then
cp()dF(38,22,212,116)
cp(4)
dTx(35,3,"Shape Tools")dF(29,9,61,1)
dTx(35,58,"Colour Select")dF(29,64,70,1)
dTx(64,66,"R G B A")
dTx(39,119,"Preview")dF(34,125,40,1)dF(34,125,1,19)dF(29,143,6,1)
dTx(45,129,"Start Over")dF(29,154,12,1)dF(40,135,1,20)dF(40,135,54,1)
dTx(76,100,"Instruction Bar")dF(75,106,83,1)dF(157,106,1,38)
dTx(211,3,"History")dF(210,9,49,1)
dTx(182,99,"History Page")dF(181,105,72,1)dF(252,105,1,41)dF(252,145,7,1)
dTx(182,109,"Previous Step")dF(181,115,66,1)dF(246,115,1,40)dF(246,154,13,1)
dTx(206,119,"Steam")dF(205,125,32,1)dF(236,125,1,23)
dTx(193,129,"Help")dF(192,135,36,1)dF(227,135,1,13)
end

if t==1 then TEXT="Tap Start and End Points"end
if t==2 or t==3 then TEXT="Tap 2 corner Points"end
if t==4 or t==5 then TEXT="Tap centre of circle => radius"end
if t==6 or t==7 then TEXT="Tap 3 points"end
if t==8 then TEXT="Tap, type, Tap canvas to confirm"end
if not TF then
TEXT="Welcome to Whiteboard!     HELP>"
x=cw-94 y=h-11
cp(1)dF(x,y,7,7)
cp(4)dF(x,y,1,3)dF(x+1,y+1,1,2)dF(x+3,y+1,1,2)dF(x+4,y,1,3)dS(x,y+3,5,4)
end
dTx(cw-84,h-10,TEXT)
end
function cr(x,y)C(250,0,0)dL(x,y,x+3,y+3)dL(x,y+2,x+3,y-1)end
function pr(x,y)dF(x,y,1,3)dF(x+1,y+1,1,2)d(x+2,y+2)dF(x+2,y,2,1)dF(x+4,y+1,1,3)d(x+3,y+4)end
function pe(x,y)dF(x+3,y,2,2)dF(x+2,y+1,2,2)d(x+1,y+2)d(x+2,y+3)dF(x,y+3,1,2)d(x+1,y+4)end
function oc(x,y)C(GF(R,G,B,A))dF(x,y+1,1,5)dF(x+1,y,1,5)d(x+2,y+1)cp(4)dF(x+3,y+1,2,4)dF(x+2,y+2,4,2)d(x+4,y+5)d(x+5,y+4)d(x+6,y+3)end
function GradV(x,y,w,h,o1,o2)for i=0,h,1 do
C(0,0,0,o1+i*((o2-o1)/h))dF(x,y+i,w,1)end
end
function bl(x,y,h)cp(2)for i=0,h,1 do
if i%2==0 then d(x,y+i)d(x+2,y+i)d(x+4,y+i)else d(x+1,y+i)d(x+3,y+i)end
end
end
function ga(x,v)cp()dF(x,67+(1-v/255)*69,5,1)end
function st(x,y)cp("bk")dS(x,y,5,5)cp()d(x,y+2)d(x+1,y+3)dF(x+2,y+1,2,2)end