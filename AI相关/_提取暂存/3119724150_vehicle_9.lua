-- source: steam id 3119724150 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3119724150
local tg={}
w,h,W,H,p,pp,o,Tr,lt=48,96,90,84,360,1,1000,1,false
K,M,V=-o,-o,-o
I=input
O=output
P=property
PN=P.getNumber
IN=I.getNumber
ON=O.setNumber
IB=I.getBool
OB=O.setBool
Mt=math
pi=Mt.pi*2
Mf=Mt.floor
Ma=Mt.abs
Mc=Mt.cos
Ms=Mt.sin
S=screen
Sc=S.setColor
Sl=S.drawLine
Sr=S.drawRect
Scf=S.drawCircleF
function onTick()
 Mod=IB(9)
 M1=IB(10)
 M2=IB(11)
 M3=IB(12)
 M4=IB(13)
 M5=IB(14)
 pr=IB(15)
 tr=IB(16)
 lc=IB(17)and not ls
 ls=IB(17)
 if lc then lt=not lt end
 r1=PN("Scan Radar Range")
 R2=PN("Static Radar Range")
 Y1=(p*PN("Scan Radar Fov Y"))
 X1=p*PN("Scan Radar Fov X")/2
 S1=p*(PN("Scan Radar Sweep")*2)+X1
 SP=p*PN("Scan Radar Pitch angle")
 Y2=(p*PN("Static Radar Fov Y"))
 X2=(p*PN("Static Radar Fov X"))
 S2=p*PN("Static Radar Pitch angle")
 if tr then Tr=Tr+1 if Tr==9 then Tr=1 end end
 if pr then pp=pp+1 if pp==8 then pp=1 end end
 R1=r1/pp
 for i=1,8 do --Radar Data
     local Rng,Azm,Ele,TSD=IN(i*4-3),IN(i*4-2),IN(i*4-1),IN(i*4)
     local qp,pq,fazm=(Rng/(R1/w))*Mc(Ele*pi),(Rng/(R2/W))*Mc(Ele*pi),Azm+(-0.25)
     if(not Mod)and Rng>0 and TSD==0 and R1>Rng then
         X,D,Px,Py=Mf((h/S1)*Azm*p),Mf(Rng/(R1/H)),qp*Mc(fazm*pi),qp*Ms(fazm*pi)
         if M1 then Y=Mf((H/Y1)*Ele*p)else Y=Mf((h/Y1)*Ele*p)end
         table.insert(tg,{X=X,Y=Y,D=D,l=120,T=TSD,Px=Px,Py=Py,r=Rng,x=Azm,y=Ele})
     elseif Mod and Rng>0 and TSD==0 and R2>Rng then
         X,D,Px,Py=Mf((h/X2)*Azm*p),Mf(Rng/(R2/h)),pq*Mc(fazm*pi),pq*Ms(fazm*pi)
         if M1 then Y=Mf((H/Y2)*Ele*p)else Y=Mf((h/Y2)*Ele*p)end
         tg[i]={X=X,Y=Y,D=D,l=120,T=TSD,Px=Px,Py=Py,r=Rng,x=Azm,y=Ele}
     end
 end
 for i=#tg,1,-1 do
     tg[i].l=tg[i].l-1
     if tg[i].l<=0 then
         table.remove(tg,i)
     end
 end
 if lt and #tg>0 and k==0 then
     local t=tg[Tr]
     k,m,v,K,M,V=t.r,t.x,t.y,W-t.D,w+t.X,w-t.Y
 elseif not lt then
     k,m,v,K,M,V=0,0,0,-o,-o,-o
 end
 ON(1,k)
 ON(2,m)
 ON(3,v)
 OB(2,Mod)
 if(M1 or M2 or M3)then OB(1,true)else OB(1,false)end
end
function onDraw()
 Sc(0,255,0)
 for i=1,#tg do
     local t=tg[i]
     local x,y,d,px,py=w+t.X,w-t.Y,W-t.D,t.Px,t.Py
     if M1 then--C
         Sl(x+4,y,x-4,y)
         if Tr==i and not lc then
             Sl(x+6,y+2,x+6,y-2)
             Sl(x-6,y+2,x-6,y-2)
         end
         Sr(M-6,V-2,12,4)
         S.drawText(M-5,V+4,Mf(k/100)/10)
     elseif M2 then--B
         Sl(x+4,d,x-4,d)
         if Tr==i and not lc then
             Sl(x+6,d+2,x+6,d-2)
             Sl(x-6,d+2,x-6,d-2)
         end
         Sr(M-6,K-2,12,4)
         S.drawText(M-5,K+4,Mf(k/100)/10)
     elseif M3 then--E
         Sl(y+4,d,y-4,d)
     elseif M4 or M5 then--SPPI & PPI
         if Mod and M5 then Scf(px+w,py+w,1)
         elseif Mod then Scf(px+w,py+W,1)
         else Scf(px+w,py+w,1)end
     end
 end
end