-- source: steam id 3794647482 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
m=math
si=m.sin
co=m.cos
as=m.asin
pi=m.pi
pi=math.pi
pi2 = pi*2
atan = m.atan
timer = 100
iN=input.getNumber
pN=property.getNumber
pB=property.getBool
S = true
snx = 0
sny = 0
snz = 0
function math.clamp(x, min, max)
    if x ~= x then x=min end -- explicit nan handling
    if x < min then x=min end
    if x > max then x=max end
    return x
end
function world2local(lsx,lsy,lsz,lsex,lsey,lsez,ltx0,lty0,ltz0)
lTx=ltx0-lsx
lTy=lty0-lsy
lTz=ltz0-lsz
lc1=co(lsez)
lc2=co(lsey)
lc3=co(lsex)
ls1=si(lsez)
ls2=si(lsey)
ls3=si(lsex)
lTM={lc1*lc2 , lc1*ls2*ls3-lc3*ls1 , ls1*ls3+lc1*lc3*ls2 , lc2*ls1 , lc1*lc3+ls1*ls2*ls3 , lc3*ls1*ls2-lc1*ls3 , -ls2 , lc2*ls3 , lc2*lc3}
lnx=lTM[1]*lTx+lTM[4]*lTy+lTM[7]*lTz
lny=lTM[2]*lTx+lTM[5]*lTy+lTM[8]*lTz
lnz=lTM[3]*lTx+lTM[6]*lTy+lTM[9]*lTz
--new Target position xyz(right,up,front)
return  lnx, lny, lnz
end	
function local2world(wsx,wsy,wsz,wsex,wsey,wsez,wtx0,wty0,wtz0)
wTx=wtx0
wTy=wty0
wTz=wtz0
wc1=co(wsez)
wc2=co(wsey)
wc3=co(wsex)
ws1=si(wsez)
ws2=si(wsey)
ws3=si(wsex)
wTM={wc1*wc2 , wc2*ws1 , -ws2 , wc1*ws2*ws3-wc3*ws1 , wc1*wc3+ws1*ws2*ws3 , wc2*ws3 , ws1*ws3+wc1*wc3*ws2 , wc3*ws1*ws2-wc1*ws3 , wc2*wc3}
wnx=wTM[1]*wTx+wTM[4]*wTy+wTM[7]*wTz
wny=wTM[2]*wTx+wTM[5]*wTy+wTM[8]*wTz
wnz=wTM[3]*wTx+wTM[6]*wTy+wTM[9]*wTz
wnx=wnx+wsx
wny=wny+wsy
wnz=wnz+wsz
--new Target position xyz(right,up,front)
return wnx,wny,wnz
end
EX,EY,EZ=0,0,0
function onTick()
distance = iN(1)	
Horizon = iN(2)*pi2
Vertical = iN(3)*pi2
FX = iN(4)
FY = iN(5)
FZ = iN(6)
GPSX = iN(7)
GPSY = iN(8)
GPSZ = iN(9)
R = input.getBool(1)
output.setBool(1,R)
if R then
EX = distance * math.cos(Vertical) * math.sin(Horizon)
EZ = distance * math.cos(Vertical) * math.cos(Horizon)
EY = distance * math.sin(Vertical)
end
if R then
nx,ny,nz = world2local(0,0,0,FX,FY,FZ,GPSX,GPSY,GPSZ)
nx=nx+EX
ny=ny+EY
nz=nz+EZ
snx,sny,snz = local2world(0,0,0,FX,FY,FZ,nx,ny,nz)
if iN(10)<=0 then
output.setNumber(1,0)
output.setNumber(2,0)
output.setNumber(3,0)
else
output.setNumber(1,snx)
output.setNumber(2,snz)
output.setNumber(3,sny)
end
end
end