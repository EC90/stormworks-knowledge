-- source: steam id 3262317900 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3262317900
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
M=math
Ma=M.atan
Mas=M.asin
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
Mx=M.max
pi=M.pi
pi2=pi*2
to=0
rd,ra,re=0,0,0
txo,tyo,tzo=0,0,0
function Mp(x,l,h)
return M.min(M.max(x,l),h) end
function psa(x,y,z)
p=-Mas(Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y))
r=Mas(Ms(y)*Mc(z))
c=Ma(Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Mc(x)*Mc(z))
return p,r,c
end
function onTick()
--Hd,Vd,He,Ve=GN(17),GN(18),GN(19)*Mc(GN(20)*P2),-GN(20)/Mc(GN(19)*P2)
D1,D2=GN(15),GN(16)
eH=GN(17)*Mc(GN(17)*pi2)
eV=GN(18)/Mc(GN(18)*pi2)
if Mb((D2-D1))/D2<0.005 and D2>10 then
    rd=D1 ra=-eV*pi2 re=eH*pi2
    to=0
elseif to<15 then
    rd=rd ra=ra re=re
    to=to+1
else
    rd=0 ra=0 re=0
end
sx,sy,sz=GN(1),GN(3),GN(2)
rp,rr,rc=psa(GN(4),GN(6),GN(5))
if rd>10 then
xr,yr,zr=rd*Mc(re)*Ms(ra),rd*Mc(re)*Mc(ra),rd*Ms(re)
src,crc,srp,crp,srr,crr=Ms(rc),Mc(rc),Ms(rp),Mc(rp),Ms(rr),Mc(rr)
dx=(yr*src*crp+xr*(src*srp*srr+crc*crr)+zr*(src*srp*crr-crc*srr))
dy=(yr*crc*crp+xr*(crc*srp*srr-src*crr)+zr*(crc*srp*crr+src*srr))
dz=(yr*(-srp)+xr*(crp*srr)+zr*(crp*crr))
tx,ty,tz=dx+sx,dy+sy,dz+sz
else
dx,dy,dz=0,0,0
tx,ty,tz=0,0,0
end
SN(1,tx)
SN(2,ty)
SN(3,tz)
SN(4,Mp(tx-txo,-5,5))
SN(5,Mp(ty-tyo,-5,5))
SN(6,Mp(tz-tzo,-5,5))
SN(7,-rp/pi2)
SN(8,-rr/pi2)
SN(9,-rc/pi2)
txo,tyo,tzo=tx,ty,tz
end