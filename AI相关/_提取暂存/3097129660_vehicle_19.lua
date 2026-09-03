-- source: steam id 3097129660 / vehicle.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
--radar denoise II SRC
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
function Mf(x) return M.floor(x+0.5) end
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P2=pi*2
T=table
function Mp(x,min,max) return M.max(min,M.min(x,max)) end
function Av(n,v,t) if n==nil then n={0} end t=M.max(Mf(t),1) table.insert(n,v) local s=0 if #n>t then for i=1,#n-t do table.remove(n,1) end end for i=1,#n do s=s+n[i] end return s/#n end
function D2T(d,w) return M.atan(w,d)/P2 end
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3]*P2)*Ms(r[2]*P2),r[1]*Mc(r[3]*P2)*Mc(r[2]*P2),r[1]*Ms(r[3]*P2)}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function G2L(l) return Mv(E2R(Eu),{l[1]-sp[1],l[2]-sp[2],l[3]-sp[3]}) end
function L2AE(l) local x,y,z=l[1],l[2],l[3] return M.atan(x,y),M.atan(z,y) end
R={}
maxlife=300
function onTick()
    sp={GN(1),GN(3),GN(2)} Eu={GN(4),GN(6),GN(5)}
    fx0,fy0=1.38*GN(24),-1.38*GN(25)-0.0439
    if GN(21)>2500 then
        T.insert(R,{R2G({GN(21),GN(22),GN(23)}),0})
    end
    if #R>1 then
        for i=1,#R do
            R[i][2]=R[i][2]+1
        end
        for i=1,#R do
            if R[i][2]>maxlife then T.remove(R,i) break end
        end
    end
    Ax,Ay,Az=GN(26),GN(27),GN(30)
    Ex,Ey,Ez=GN(28),GN(29),GN(31)
end
fov=1.1125
S=screen
SC=S.setColor
DR=S.drawRect
DRF=S.drawRectF
DT=S.drawText
DL=S.drawLine
function onDraw()
w=S.getWidth() h=S.getHeight()
fx,fy=w*(fx0/(fov*w/h)),h*(fy0/fov)
dcx,dcy=0,0
if #R>0 then
    for i=1,#R do
        dcxr,dcyr=L2AE(G2L(R[i][1]))
        dcx,dcy=Mf(w/2+w*(dcxr/(fov*w/h))+fx),Mf(h/2-h*(dcyr/fov)+fy)
        SC(22,222,22,111*(1-R[i][2]/maxlife))
        S.drawCircleF(dcx,dcy,2)
    end
end
if Ax~=0 and Ay~=0 then
    SC(22,222,22,111)
    dcxr,dcyr=L2AE(G2L({Ax,Ay,Az}))
    dcx,dcy=Mf(w/2+w*(dcxr/(fov*w/h))+fx),Mf(h/2-h*(dcyr/fov)+fy)
    DL(dcx-2,dcy-2,dcx+3,dcy+3)
    DL(dcx+2,dcy-2,dcx-3,dcy+3)
end
if Ex~=0 and Ey~=0 then
    SC(222,22,22,111)
    dcxr,dcyr=L2AE(G2L({Ex,Ey,Ez}))
    dcx,dcy=Mf(w/2+w*(dcxr/(fov*w/h))+fx),Mf(h/2-h*(dcyr/fov)+fy)
    DL(dcx-2,dcy-2,dcx+3,dcy+3)
    DL(dcx+2,dcy-2,dcx-3,dcy+3)
end
end