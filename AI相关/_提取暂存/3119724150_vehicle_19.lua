-- source: steam id 3119724150 / vehicle.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3119724150
local w,h,H,p,b,W,X,Y,N=48,96,84,360,0,45,1,1,255
I=input
O=output
P=property
PN=P.getNumber
IN=I.getNumber
ON=O.setNumber
IB=I.getBool
OB=O.setBool
M=math
pi=M.pi*2
Pi=M.pi/2
Mf=M.floor
Mm=M.fmod
Mc=M.cos
Ms=M.sin
Mr=M.rad
S=screen
Sc=S.setColor
Sl=S.drawLine
St=S.drawText
SC=S.drawCircle
Sr=S.drawRect
SR=S.drawRectF
ST=S.drawTriangleF
function onTick()
    a=IN(1)*p
    A=IN(1)*pi % (pi)
    m=IN(2)
    R1=IN(3)
    trg=IN(4)
    Mod=IB(1)
    M1=IB(2)
    M2=IB(3)
    M3=IB(4)
    M4=IB(5)
    M5=IB(6)
    G=IB(7)
    Dp=PN("Radar Display")
    R2=PN("Static Radar Range")
    Y1=(p*PN("Scan Radar Fov Y"))
    X1=p*PN("Scan Radar Fov X")/2
    S1=p*(PN("Scan Radar Sweep")*2)+X1
    SP=p*PN("Scan Radar Pitch angle")
    Y2=(p*PN("Static Radar Fov Y"))
    X2=(p*PN("Static Radar Fov X"))
    S2=p*PN("Static Radar Pitch angle")
    if not Mod then Ta=S1/2 else Ta=X2/2 end
    if M1 or M2 or M3 then
        if Mod then K,B,C=h/(X2/3),(Y2*2)/3,H/(R2/500)
        else K,B,C=h/(S1/10),(Y1)/10,m end
        if M1 then X,Y=K,H/B
        elseif M2 then X,Y=K,C
        elseif M3 then X,Y=h/B,C end
        if Mm(h,X)>0 then
            if Mm(h,Mf(X)-1)==0 then x=Mf(X)-1
            else for i=0,12 do if Mm(h,Mf(X)+i)==0 then x=Mf(X)+i break end end end
        else x=X end
        if Mm(h,Y)>0 then
            if Mm(h,Mf(Y)-1)==0 then y=Mf(Y)-1
            else for i=0,12 do if Mm(h,Mf(Y)+i)==0 then y=Mf(Y)+i break end end end 
        else y=Y end
    end
    if a>b then b=a end c=(w/b)*a
    k,l=w+(W)*Mc(A-(Pi)),w+(W)*Ms(A-(Pi))
end
function onDraw()
 local AL,NA,j,o,z,e,n=M1 or M2 or M3,(M4 or M5),"/",1000,91,22,90
 Sc(0,N,0)
 if M1 then St(e,0,"C")
 elseif M2 then St(e,0,"B")
 elseif M3 then St(e,0,"E")end
 if M4 then
     local tX,tY=Mr(270-Ta),Mr(270+Ta)
     if Mod then for i=0,2 do Sc(0,N,0,100)SC(w,h,n-22*i)end
     else for i=0,2 do Sc(0,N,0,100)SC(w,w,46-22*i)end end
     Sc(0,0,0)
     if not Mod then
     local X1,Y1,X2,Y2=w+W*Mc(tX),w+W*Ms(tX),w+W*Mc(tY),w+W*Ms(tY)
     local x1,y1,x2,y2=w+H*Mc(tX),w+H*Ms(tX),w+H*Mc(tY),w+H*Ms(tY)
     if Ta<90 then
         ST(0,0,x1,y1,0,w)
         ST(h,0,x2,y2,h,w)
         ST(0,w,x1,y1,w,w)
         ST(w,w,x2,y2,h,w)
         SR(0,w,h,w)
     else
         ST(0,h,x1,y2,w,h)
         ST(w,h,x2,y2,h,h)
         ST(x1,y1,w,h,w,w)
         ST(w,w,w,h,x2,y2)
         Sl(w,w,w,h)
     end
     Sc(0,N,0,50)
     Sl(w,w,X1,Y1)
     Sl(w,w,X2,Y2)
     Sc(0,N,0,155)
     Sl(w,w,k,l)
     else
     local x1,y1,x2,y2=w+n*Mc(tX),h+n*Ms(tX),w+n*Mc(tY),h+n*Ms(tY)
     ST(0,h,x1,y1,w,h)
     ST(h,h,x2,y2,w,h)
     ST(0,0,0,h,x1,y1)
     ST(h,0,h,h,x2,y2)
     Sc(0,N,0,50)
     Sl(w,h,x1,y1)
     Sl(w,h,x2,y2)
     end
     Sc(0,N,0)
     St(1,0,"S. PPI")
 end
 if M5 then
     Sc(0,N,0,155)
     Sl(w,w,k,l)
     Sc(0,N,0)
     St(1,0,"M. PPI")
     for i=0,2 do
         Sc(0,N,0,100)
         SC(w,w,46-22*i)
     end
 end
 if not Mod and AL then
     Sc(0,N,0,155)
     Sl(w+c,6,w+c,n)
 end
 Sc(0,n,0,n)
 if G and AL then
     for i=0,h-x do
         if Mm(i,x)==0 then
             Sl(i,6,i,n)
         end
     end
     for i=6,n do
         if Mm(i,y)==0 then
             Sl(0,i,h,i)
         end
     end
 elseif AL then
     for i=6,n do
         if Mm(i,y)==0 then
             Sc(0,N,0)
             Sl(0,i,4,i)
             Sl(92,i,h,i)
             Sc(0,h,0,h)
             Sl(4,i,92,i)
         end
     end
 end
 Sc(0,N,0)
 St(70,0,"Rng")
 if Mod then
     St(77,z,"trg")
     St(92,z,trg)
     f,F,v,s=Mf(X2/2),Mf(Y2/2),Mf(R2/o),S2
 else
     f,F,v,s=Mf(Ta),Mf(Y1/2),Mf(R1/o),SP
 end
 if not NA then
     St(1,0,"Mode")
     Sr(0,6,95,H)
     St(86,0,v)
     St(46,0,j)
     St(14,z,j)
     St(50,0,f)
     St(31,0,-f)
     St(-1,z,Mf(-F+s))
     St(18,z,Mf(F+s))
 else
     St(86,0,v)
 end
end