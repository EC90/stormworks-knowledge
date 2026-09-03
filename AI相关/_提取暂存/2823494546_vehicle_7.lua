-- source: steam id 2823494546 / vehicle.xml block#7
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
tI=table.insert
tU=table.unpack
function cp(s)C(243,243,243)if s==1 then C(125,125,125)end
if s==2 then C(75,75,75)end
if s==4 then C(25,25,25)end
end
function iR(rX,rY,rW,rH)return X>rX-1 and Y>rY-1 and X<rX-1+rW+1 and Y<rY-1+rH+1 end
function gN(...)local a={}for b,c in ipairs({...})do a[b]=I.getNumber(c)end;return tU(a)end
function dS(x,y,w,h)w=w or 7 h=h or 7 dF(x+1,y,w-2,h)dF(x,y+1,1,h-2)dF(x+w-1,y+1,1,h-2)end
function d(x,y)dF(x,y,1,1)end
function GF(r,g,b,a)r=r^2.2/255^2.2*r
g=g^2.2/255^2.2*g
b=b^2.2/255^2.2*b
return r,g,b,a
end
wl={0,0,1,2,3,4,5,6,7,8,9,0,"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"," ",",","."}function re()X1=-1
Y1=-1
X2=-1
Y2=-1
X3=-1
Y3=-1
pg=M.floor((#l-1)/7)+1 if pg<1 then pg=1 end
end
R=0
G=0
B=0
A=0
l={}pc=0
pg=1
re()t=1
TE=""q=0
function onTick()W,H,X,Y,t,R,G,B,A,KP,kp=gN(1,2,3,4,7,8,9,10,11,12,13)iP=I.getBool(1)V=pc==1 SD=W*H==46080
if W*H==46080 then ss=13 else ss=7 end
if iP then pc=pc+1 else pc=0 end
if not SD then AR=iR(32,15,96,64)end
if iP and pc==1 and AR then
if t>=1 and t<=5 then
if q==0 then X1=X Y1=Y q=q+1
elseif q==1 then X2=X Y2=Y q=0 tI(l,{t,X1,Y1,X2,Y2,-1,-1,R,G,B,A,""})re()end
elseif t>=6 and t<=7 then
if q==0 then X1=X Y1=Y q=q+1
elseif q==1 then X2=X Y2=Y q=q+1
elseif q==2 then X3=X Y3=Y q=0 tI(l,{t,X1,Y1,X2,Y2,X3,Y3,R,G,B,A,""})re()end
elseif t==8 then
if q==0 then X1=X Y1=Y TE="" q=q+1
elseif q==1 then q=0 tI(l,{t,X1,Y1,X2,Y2,X3,Y3,R,G,B,A,TE})re()end
end
end
if kp==1 then
if KP>1 then TE=TE..wl[KP]end
if KP==1 then TE=TE:sub(1,-2)end
end
pd=iP and iR(W-8,77,5,7)if pd and V and pg>1 then pg=pg-1 end
pu=iP and iR(W-14,77,5,7)if pu and V then pg=pg+1 end
pr=iP and iR(19,1,7,7)if pr and V then table.remove(l,#l)re()end
cl=iP and iR(11,1,7,7)if cl then l={}pg=1 end
end
function onDraw()w=S.getWidth()h=S.getHeight()cw=w/2 ch=h/2 sd=w*h==46080 b=1.8125
for i=1,#l do
k,x1,y1,x2,y2,x3,y3,r1,g1,b1,a1,te=tU(l[i])C(GF(r1,g1,b1,a1))if sd then x1,y1,x2,y2,x3,y3=x1*b-1,y1*b-5,x2*b-1,y2*b-5,x3*b-1,y3*b-5 end
if k==1 then dL(x1,y1,x2,y2)elseif k==2 then dR(x1,y1,x2-x1,y2-y1)elseif k==3 then dF(x1,y1,x2-x1,y2-y1)elseif k==4 then dC(x1,y1,M.sqrt((x2-x1)^2+(y2-y1)^2))elseif k==5 then dCF(x1,y1,M.sqrt((x2-x1)^2+(y2-y1)^2))elseif k==6 then dT(x1,y1,x2,y2,x3,y3)elseif k==7 then dTF(x1,y1,x2,y2,x3,y3)elseif k==8 then dTx(x1,y1-2,te)end
end
cp(2)if sd then
dF(0,9,57,h)dF(0,9,w,13)dF(231,9,57,h)dF(0,138,w,22)else
dF(0,9,32,h)dF(128,9,38,h)dF(0,9,w,6)dF(0,79,w,17)end
if not sd then
cp(1)dS(1,10,21,75)dS(w-24,10,23,75)
cp(2)if t==1 then dS(cw-35,1)end if t==8 then dS(cw-26,1)end
if t==2 then dS(cw-17,1)end if t==3 then dS(cw-8,1)end
if t==4 then dS(cw+1,1)end if t==5 then dS(cw+10,1)end
if t==6 then dS(cw+18,1)end if t==7 then dS(cw+27,1)end
cp(4)ty(cw-34,2,1)ty(cw-16,2,2)ty(cw-7,2,3)ty(cw+2,2,4)ty(cw+11,2,5)ty(cw+19,2,6)ty(cw+28,2,7)ty(cw-25,2,8)ps(cl,3,0)dS(11,1,7,7)ps(pr,3,0)dS(19,1,7,7)ps(pu,3,2)dS(w-14,77,5,7)ps(pd,3,2)dS(w-8,77,5,7)if pg>9 then pgd="#"else pgd=pg end
cp(4)dTx(w-21,78,pgd)lr=1+((pg-1)*7)ur=7+((pg-1)*7)a=0
for i=1,#l do
if i>=lr and i<=ur then
x,y=w-22,21+a
cp(2)dS(x,y,19,7)cp(4)ty(x+2,y+1,l[i][1])if i>99 then id="~~"else id=i end
dTx(x+8,y+1,id)a=a+8
end
end
if X1>0 and Y1>0 then dP(X1,Y1)if t==8 then C(GF(R,G,B,A))dTx(X1,Y1-2,TE)end end
if X2>0 and Y2>0 then dP(X2,Y2)end
if X3>0 and Y3>0 then dP(X3,Y3)end
end
end
function ps(f,a,b)if f then cp(a)else cp(b)end end
function dP(x,y)C(185,39,0)dC(x,y,5.7)dC(x,y,0.9)end
function tr(x,y)d(x+2,y)dF(x+1,y+1,1,2)dF(x+3,y+1,1,2)dF(x,y+3,1,2)dF(x+4,y+3,1,2)dF(x,y+4,5,1)end
function ty(x,y,t)if t==1 then dL(x,y+4,x+5,y-1)end
if t==2 then dR(x,y,4,4)end
if t==3 then dF(x,y,5,5)end
if t==4 then dC(x+2,y+2,2.3)end
if t==5 then dCF(x+2,y+2,2.5)end
if t==6 then tr(x,y)end
if t==7 then tr(x,y)dF(x+1,y+1,3,2)dF(x,y+3,5,2)end
if t==8 then d(x+2,y)d(x+2,y+2)dF(x+1,y+1,1,4)dF(x+3,y+1,1,4)end
end