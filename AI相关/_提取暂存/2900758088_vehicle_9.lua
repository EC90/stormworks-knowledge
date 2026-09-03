-- source: steam id 2900758088 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088
fmt,m=string.format,math abs,fl,rd,co,si,mod,pi=m.abs,m.floor,m.rad,m.cos,m.sin,m.fmod,m.pi r_d={0} r_s={0} r_a={0} r_y={0} r_k={0} tik,A,B,J,K=0,0,0,0,0
function onTick()
i,t=input,table gN,gB,ti,tr=i.getNumber,i.getBool,t.insert,t.remove
tx,ty,X,Y,z,p,q,r1,g1,b1,r2,g2,b2,r3,g3,b3,r4,g4,b4,sx,r5,g5,b5=gN(3),gN(4),gN(7),gN(8),gN(14),gN(15),gN(16),gN(17),gN(18),gN(19),gN(20),gN(21),gN(22),gN(23),gN(24),gN(25),gN(26),gN(27),gN(28),gN(29),gN(30),gN(31),gN(32)
act,vt,iv,sg,dp,scl,ow,NZ,L,tik,fy,cx=gB(4),gB(5),gB(6),gB(7),gB(8),gB(9),gB(10),gB(11),gB(12),tik+1,rd(mod(abs(gN(13)-0.5+gN(9)*-1-1.25),1)*360-7.2),mod((gN(9)*-1)+0.75,1)*2*pi
if gB(3) then ti(r_d,1,gN(10)) ti(r_s,1,gN(11)) ti(r_a,1,gN(12)) ti(r_y,1,fy) ti(r_k,1,tik) end
if #r_d>25then tr(r_d)end
if #r_s>25then tr(r_s)end
if #r_a>25then tr(r_a)end
if #r_y>25then tr(r_y)end
if #r_k>25then tr(r_k)end
th=m.atan(gN(2)/2-ty,tx-gN(1)/2) J=co(th)*z*15 K=si(th)*z*10
if gB(1) and L and not tch(tx,ty,2+p,3+q,7,7) and not ((vt and tch(tx,ty,2+p,11+q,7,7)) or (not vt and tch(tx,ty,10+p,3+q,7,7))) then
if tch(tx,ty,d,0,d,h) then A=A+J B=B+K
elseif tch(tx,ty,0,0,d,h) then A=A+J B=B+K end
if tch(tx,ty,w-7,0,7,7) then A=0 B=0 J=0 K=0 end
end
end
function tch(x,y,RX,RY,RW,RH) return tx>=RX and ty>=RY and tx<=RX+RW and ty<=RY+RH end
function onDraw()
s,R=screen,property
PN=R.getNumber dRF,dL,dT,dC,sC,dCF,m2s,W,Z,w,h,sx,M,H,C,D=s.drawRectF,s.drawLine,s.drawText,s.drawCircle,s.setColor,s.drawCircleF,map.mapToScreen,255,200,s.getWidth(),s.getHeight(),PN("distance scale X"),PN("map color"),PN("map alpha"),X+A,Y+B
d,r=w/2,h/2
local x2,y2=m2s(C,D,z,w,h,X,Y)
local mz,zk=(5*w/h*r)/z,z*1000
Or,Og,Ob,Sr,Sg,Sb,Lr,Lg,Lb,Gr,Gg,Gb,Dr,Dg,Db,Nr,Ng,Nb={12,0,0,9,119,38,29,0},{12,26,0,13,81,94,4,4},{12,26,0,17,47,W,0,55},{30,15,0,17,119,115,68,9},{30,61,12,21,77,187,17,13},{30,73,0,34,47,217,0,9},{78,82,0,208,85,140,W,0},{78,82,40,85,51,81,81,64},{78,81,0,64,26,60,34,13},{40,60,0,26,Z,55,128,0},{40,75,76,47,136,153,47,43},{40,37,0,43,85,68,17,13},{90,123,0,119,111,242,98,128},{90,116,W,43,51,97,0,89},{90,40,0,55,34,63,0,0},{Z,Z,0,Z,Z,Z,Z,Z},{Z,Z,W,Z,Z,Z,Z,Z},{Z,Z,0,Z,Z,Z,Z,Z}
s.drawMap(C,D,z)
s.setMapColorOcean(Or[M],Og[M],Ob[M],H)
s.setMapColorShallows(Sr[M],Sg[M],Sb[M],H)
s.setMapColorLand(Lr[M],Lg[M],Lb[M],H)
s.setMapColorGrass(Gr[M],Gg[M],Gb[M],H)
s.setMapColorSand(Dr[M],Dg[M],Db[M],H)
s.setMapColorSnow(Nr[M],Ng[M],Nb[M],H)
if sg and z>0 then
sC(W,W,W,15) local g=2^(fl(m.log(z/0.1953125,2)))*31.25 local xt,yt=fl(C/g),fl(D/g)
for G=xt-6,xt+6 do
local O,P=m2s(C,D,z,w,h,g*G,g*G) dL(O,0,O,h) end
for H=yt-6,yt+6 do
local O,P=m2s(C,D,z,w,h,g*H,g*H) dL(0,P,w,P) end
end
if act then
sC(r2,g2,b2,160)
dL(x2,y2,x2+mz*co(cx),y2+mz*si(cx))
else
sC(r2,g2,b2)
dL(x2,y2,x2+co(cx)*7,y2+si(cx)*7)
dC(x2,y2,3)
end
local rdx,rdy,rdx2,rdy2=x2+mz*co(fy),y2+mz*si(fy),x2+mz*co(fy-0.23),y2+mz*si(fy-0.23)
if act then
sC(r1,g1,b1,100)
for a=0,360 do
local j,k=rd(a),rd(a+1)
dL(x2+mz*co(j),y2+mz*si(j),x2+mz*co(k),y2+mz*si(k))
end
dL(x2,y2,rdx,rdy)
sC(r1,g1,b1,10)
s.drawTriangleF(x2,y2,rdx,rdy,rdx2,rdy2)
for l=1,#r_d do
local ms,D,cf,sf,dc=fl((r_d[l]*r_s[l])+0.5),w*(co(r_a[l]*pi*2)*r_d[l])/zk,co(r_y[l]),si(r_y[l]),m.max(W-(1*(tik-r_k[l])),0)
sC(r4,g4,b4,dc)
if (ms==25or ms==13or ms==12) and dp then
dT(x2+D*cf-1,y2+D*sf-2,R.getText("person symbol alphabet"))
elseif (ms==25 or ms==13 or ms==12) and not dp then
dCF(x2+D*cf,y2+D*sf,3)
else
sC(r3,g3,b3,dc)
if ow then
dT(x2+D*cf-2,y2+D*sf-2,ms)
else
dCF(x2+D*cf,y2+D*sf,3)
end
end
end
end
if scl and h>50 then
sC(r5,g5,b5)
dL(2+sx,h-4,w/5+2+sx,h-4)
dL(2+sx,h-4,2+sx,h-7)
dL(w/5+2+sx,h-4,w/5+2+sx,h-7)
if (z/5)<1 then
dT(w/5+4.5+sx,h-7,fmt("%3.0fm",z*Z))
else
dT(w/5+4.5+sx,h-7,fmt("%3.1fkm",z/5))
end
end
sC(0,0,0,100)
dRF(2+p,3+q,7,7)
if vt then
dRF(2+p,11+q,7,7)
else
dRF(10+p,3+q,7,7)
end
if A~=0 or B~=0 then dRF(w-7,0,7,7) end
sC(W,W,W)
dL(4+p,6+q,7+p,6+q)
if vt then
dL(4+p,14+q,7+p,14+q)
else
dL(12+p,6+q,15+p,6+q)
end
if iv and vt then
dL(5+p,13+q,5+p,16+q)
elseif iv then
dL(13+p,5+q,13+p,8+q)
else
dL(5+p,5+q,5+p,8+q)
end
if A~=0 or B~=0 then dL(w-7,0,w,7) dL(w-7,6,w,-1) end
end