-- source: steam id 2823494546 / vehicle.xml block#1
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
if s==3 then C(45,45,45)end
if s==4 then C(25,25,25)end
end
function iR(rX,rY,rW,rH)return X>rX-1 and Y>rY-1 and X<rX-1+rW+1 and Y<rY-1+rH+1 end
function gN(...)local a={}for b,c in ipairs({...})do a[b]=I.getNumber(c)end;return tU(a)end
function dS(x,y,w,h)w=w or 9 h=h or 9 dF(x+1,y,w-2,h)dF(x,y+1,1,h-2)dF(x+w-1,y+1,1,h-2)end
function d(x,y)dF(x,y,1,1)end
function GF(r,g,b,a)r=r^2.2/255^2.2*r
g=g^2.2/255^2.2*g
b=b^2.2/255^2.2*b
return r,g,b,a
end
wl={0,0,1,2,3,4,5,6,7,8,9,0,"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"," ",",","."}
function re()X1=-1
Y1=-1
X2=-1
Y2=-1
X3=-1
Y3=-1
pg=M.floor((#l-1)/13)+1 if pg<1 then pg=1 end
end
R=0
G=0
B=0
A=0
l={}pc=0
pg=1
re()t=1
TE=""q=0
function onTick()W,H,X,Y,t,R,G,B,A,KP,kp=gN(1,2,3,4,7,8,9,10,11,12,13)iP=I.getBool(1)V=pc==1
if iP then pc=pc+1 else pc=0 end
if iP and pc==1 and iR(38,22,212,116)then
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
pd=iP and iR(W-8,H-18,5,7)if pd and V and pg>1 then pg=pg-1 end
pu=iP and iR(W-14,H-18,5,7)if pu and V then pg=pg+1 end
pr=iP and iR(W-28,150,27,9)if pr and V then table.remove(l,#l)re()end
cl=iP and iR(1,150,27,9)if cl then l={}pg=1 end
end
function onDraw()w=S.getWidth()h=S.getHeight()cw=w/2 ch=h/2
cp()dF(38,22,w,h)for i=1,#l do
k,x1,y1,x2,y2,x3,y3,r1,g1,b1,a1,te=tU(l[i])C(GF(r1,g1,b1,a1))if k==1 then dL(x1,y1,x2,y2)elseif k==2 then dR(x1,y1,x2-x1,y2-y1)elseif k==3 then dF(x1,y1,x2-x1,y2-y1)elseif k==4 then dC(x1,y1,M.sqrt((x2-x1)^2+(y2-y1)^2))elseif k==5 then dCF(x1,y1,M.sqrt((x2-x1)^2+(y2-y1)^2))elseif k==6 then dT(x1,y1,x2,y2,x3,y3)elseif k==7 then dTF(x1,y1,x2,y2,x3,y3)elseif k==8 then dTx(x1,y1-2,te)end
end
cp(2)dF(0,0,38,160)dF(250,0,38,160)dF(0,0,w,22)dF(0,0,w,22)dF(0,138,w,22)cp(3)dF(39,138,212,1)dF(250,23,1,115)cp(1)dS(1,1,27,54)dS(1,56,27,93)dS(w-28,1,27,158)cp(2)
if t==1 then dS(4,13)end if t==8 then dS(16,13)end
if t==2 then dS(4,23)end if t==3 then dS(16,23)end
if t==4 then dS(4,33)end if t==5 then dS(16,33)end
if t==6 then dS(4,43)end if t==7 then dS(16,43)end
cp(4)ty(5,14,1)ty(5,24,2)ty(17,24,3)ty(5,34,4)ty(17,34,5)ty(5,44,6)ty(17,44,7)ty(17,14,8)ps(cl,3,0)dS(1,150,27,9)ps(pr,3,0)dS(w-28,150,27,9)ps(pu,3,2)dS(w-14,h-18,5,7)ps(pd,3,2)dS(w-8,h-18,5,7)
if pg>99 then pgd="#"else pgd=pg end
cp(4)dTx(w-26,h-17,pgd)lr=1+((pg-1)*13)ur=13+((pg-1)*13)a=0
for i=1,#l do
if i>=lr and i<=ur then
x,y=w-26,12+a
cp(2)dS(x,y,23,9)cp(4)ty(x+3,y+1,l[i][1])
if i>99 then id="~~" else id=i end
dTx(x+12,y+3,id)a=a+10
end
end
if X1>0 and Y1>0 then dP(X1,Y1)if t==8 then C(GF(R,G,B,A))dTx(X1,Y1-2,TE)end end
if X2>0 and Y2>0 then dP(X2,Y2)end
if X3>0 and Y3>0 then dP(X3,Y3)end
cp(1)dS(cw-98,h-15,198,16)cp(4)ty(cw-94,h-11,t)end
function ps(f,a,b)if f then cp(a)else cp(b)end end
function dP(x,y)C(185,39,0)dC(x,y,5.7)dC(x,y,0.9)end
function tr(x,y)dF(x,y+6,7,1)dF(x,y+5,1,2)dF(x+1,y+3,1,2)dF(x+2,y+1,1,2)dF(x+3,y,1,1)dF(x+4,y+1,1,2)dF(x+5,y+3,1,2)dF(x+6,y+5,1,2)end
function ty(x,y,t)if t==1 then dF(x,y+5,2,2)d(x+2,y+4)d(x+3,y+3)d(x+4,y+2)dF(x+5,y,2,2)end
if t==2 then dR(x,y,6,6)end
if t==3 then dF(x,y,7,7)end
if t==4 then dC(x+3,y+3,3.3)end
if t==5 then dCF(x+3,y+3,3.5)end
if t==6 then tr(x,y)end
if t==7 then tr(x,y)dF(x+2,y+1,3,5)dF(x+1,y+4,5,2)end
if t==8 then dF(x,y,2,1)dF(x,y,1,2)dF(x+5,y+6,2,1)dF(x+6,y+5,1,2)dF(x+2,y+2,1,3)d(x+3,y+1)d(x+3,y+3)dF(x+4,y+2,1,3)end
end
