-- source: steam id 2955284061 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2955284061
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
function Mp(x,l,h)
return M.min(M.max(x,l),h) end
function psa(x,y,z)
p=-Mas(Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y))
r=Mas(Ms(y)*Mc(z))
c=Ma(Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Mc(x)*Mc(z))
return p,r,c
end
function onTick()
D1,D2=GN(15),GN(16)
eH,eV=GN(17),GN(18)
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
SN(4,-rp/pi2)
SN(5,-rr/pi2)
SN(6,-rc/pi2)
end