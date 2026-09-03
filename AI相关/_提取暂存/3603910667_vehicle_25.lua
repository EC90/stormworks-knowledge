-- source: steam id 3603910667 / vehicle.xml block#25
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
--datalink3SRCradar
M=math
Ma=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P2=M.pi*2

GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
T=table
R={}
maxlife=300
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3]*P2)*Ms(r[2]*P2),r[1]*Mc(r[3]*P2)*Mc(r[2]*P2),r[1]*Ms(r[3]*P2)}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function onTick()
sp={GN(11),GN(12),GN(13)} Eu={GN(14),GN(15),GN(16)}
SN(1,0)
SN(2,0)
    if GN(1)>25 then
        Tg=R2G({GN(1),GN(2),GN(3)})
        SN(1,Tg[1])
        SN(2,Tg[2])
    end
end