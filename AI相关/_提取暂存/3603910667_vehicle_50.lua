-- source: steam id 3603910667 / vehicle.xml block#50
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
unitLen=10
brightness=100
---
TI=table.insert
TU=table.unpack
TR=table.remove
sC=screen.setColor
dT=screen.drawText
dR=screen.drawRect
dRF=screen.drawRectF
gN=input.getNumber
sB=output.setBool
sequence=1
letterNo=1
tick=0
nW={}
sPad={}
que={}
message={}
Topkey={"Q"
,"W"
,"E"
,"R"
,"T"
,"Y"
,"U"
,"I"
,"O"
,"P"
}
Midkey={"+"
,"A"
,"S"
,"D"
,"F"
,"G"
,"H"
,"J"
,"K"
,"L"
}
Botkey={"Z"
,"X"
,"C"
,"V"
,"B"
,"N"
,"M"
}
Digits={"0"
,"1"
,"2"
,"3"
,"4"
,"5"
,"6"
,"7"
,"8"
,"9"
}
A=".-"
B="-..."
C="-.-."
D="-.."
E="."
F="..-."
G="--."
H="...."
I=".."
J=".---"
K="-.-"
L=".-.."
M="--"
N="-."
O="---"
P=".--."
Q="--.-"
R=".-."
S="..."
T="-"
U="..-"
V="...-"
W=".--"
X="-..-"
Y="-.--"
Z="--.."
_0="-----"
_1=".----"
_2="..---"
_3="...--"
_4="....-"
_5="....."
_6="-...."
_7="--..."
_8="---.."
_9="----."
SOS="...---..."
function CM(a,b)
if key==a then
TI(nW,b)
end
end

function drawkey(c,d,...)
arg={...}sC(255,255,255)
if isPressed1 then
for e=1,#arg do
if X>c+6*e-7 and X<c+6*e and Y>d and Y<d+7 then
dRF(c+6*e-6,d,5,7)
key=arg[e]if not ib1 then
if key=="+"
then
keyswitch=not
keyswitch else CM("A"
,A)
CM("B"
,B)
CM("C"
,C)
CM("D"
,D)
CM("E"
,E)
CM("F"
,F)
CM("G"
,G)
CM("H"
,H)
CM("I"
,I)
CM("J"
,J)
CM("K"
,K)
CM("L"
,L)
CM("M"
,M)
CM("N"
,N)
CM("O"
,O)
CM("P"
,P)
CM("Q"
,Q)
CM("R"
,R)
CM("S"
,S)
CM("T"
,T)
CM("U"
,U)
CM("V"
,V)
CM("W"
,W)
CM("X"
,X)
CM("Y"
,Y)
CM("Z"
,Z)
CM("0"
,_0)
CM("1"
,_1)
CM("2"
,_2)
CM("3"
,_3)
CM("4"
,_4)
CM("5"
,_5)
CM("6"
,_6)
CM("7"
,_7)
CM("8"
,_8)
CM("9"
,_9)
TI(sPad,key)
end
ib1=true
end
end
end
else ib1=false
end
for f,g in ipairs(arg)do
sC(255,255,255)
dR(c+f*6-6,d,5,7)
sC(0,255,0)
dT(c+f*6-5,d+1,g)
end
end

function determineSignal()
if message[1]then
if string.find(message[1][letterNo],"-"
,sequence)==sequence then
transmitDash()
elseif string.find(message[1][letterNo],"."
,sequence)==sequence then
transmitDot()
elseif message[1][letterNo+1]then
if tick<unitLen*3 then
tick=tick+1 else letterNo=letterNo+1
sequence=1
tick=0
end
elseif tick<unitLen*7 then
tick=tick+1 else sequence=1
tick=0
letterNo=1
TR(message,1)
TR(que,1)
end
else transmit=false
end
end

function onTick()
sB(1,false)
isPressed1=input.getBool(1)
X=gN(3)
Y=gN(4)
function transmitDash()
tick=tick+1
if tick<=unitLen*3 then
sB(1,true)
elseif tick==unitLen*3+unitLen then
sB(1,false)
sequence=sequence+1
tick=0
end
end

function transmitDot()
tick=tick+1
if tick<=unitLen then
sB(1,true)
elseif tick==unitLen*2 then
sB(1,false)
sequence=sequence+1
tick=0
end
end
if transmit then
determineSignal()
end
end

function onDraw()
w=screen.getWidth()/2
h=screen.getHeight()/2
sC(255,255,255)
dR(w+10,h-4,21,7)
if isPressed1 and X>w+10 and X<w+31 and Y>h-4 and Y<h+3 then
dRF(w+10,h-4,21,7)
if not ib2 and#sPad>0 then
TI(message,nW)
TI(que,sPad)
sPad={}
nW={}
transmit=true
ib2=true
end
else ib2=false
end
dR(w-30,h+23,17,7)
if isPressed1 and X>w-30 and X<w-15 and Y>h+23 and Y<h+28 then
dRF(w-30,h+23,17,7)
if not ib3 then
TR(sPad)
TR(nW)
ib3=true
end
else ib3=false
end
dR(w-31,h-4,40,7)
for f,g in ipairs(sPad)do
local c
c=f-#sPad+7
if c>0 then
dT(w-30+c*5-5*#g,h-3,g)
end
end
if not keyswitch then
drawkey(w-30,h+5,TU(Topkey))
drawkey(w-30,h+14,TU(Midkey))
drawkey(w-12,h+23,TU(Botkey))else drawkey(w-30,h+5,TU(Digits))
drawkey(w-30,h+14,"+"
)
sC(255,255,255)
dR(w+12,h+23,17,7)
if isPressed1 then
if X>w+14 and X<w+29 and Y>h+23 and Y<h+28 then
dRF(w+13,h+23,16,7)
if not ib4 then
TI(nW,SOS)
TI(sPad,"SOS"
)
ib4=true
end
end
else ib4=false
end
sC(0,255,0)
dT(w+13,h+24,"SOS"
)
end
dT(w+11,h-3,"SEND"
)
dT(w-29,h+24,"CLR"
)
sC(150,0,0,100)
dR(w+25,h-30,6,25)
if isPressed1 and X>w+25 and X<w+31 and Y>h-30 and Y<h-6 then
dRF(w+25,h-30,6,25)
que={}
transmit=false
message={}
sequence=1
letterNo=1
tick=0
end
sC(255,0,0)
dT(w+26,h-29,"S"
)
dT(w+26,h-23,"T"
)
dT(w+26,h-17,"O"
)
dT(w+26,h-11,"P"
)
sC(255,255,255)
dR(w-31,h-30,54,25)
for f,g in ipairs(que)do
if f<4 then
if f==1 then
sC(255,255,0)else sC(255,255,255)
end
for i,j in ipairs(g)do
if i<11 then
dT(w-29+i*5-5,h-13-7*f+7,j)
end
end
end
end
sC(0,0,0,255-brightness)
dRF(w-32,h-32,w*2,h*2)
end