-- source: steam id 3603910667 / vehicle.xml block#106
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pN=property.getNumber
pB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
sqrt=M.sqrt
asin=M.asin
atan=M.atan
pi=M.pi
pi2=M.pi*2

tha=0
phy_buf = 0
turn = 0
asbuf={0,0}
count={0,0}
dcbuf = {0,0.25*pi2}

coff_lpitch={5,0.002,2}
coff_lyaw={5,0.002,2}
coff_spitch={0.3,0.01,0}
coff_syaw={0.5,0.01,0}
AT=pB("All round turrent")
pid_lpitch,pid_lyaw,pid_spitch,pid_syaw={0,0,0},{0,0,0},{0,0,0},{0,0,0}

function onTick()
Euler={GN(13),GN(15),GN(14)}
tgtt={}
xt=GN(1)-GN(10)
yt=GN(2)-GN(12)
zt=GN(3)-GN(11)
g=Mv(E2R(Euler),{xt,yt,zt})
xt,yt,zt=g[1],g[2],g[3]
if xt>0 and yt<0 then
phy=atan(xt/yt)+math.pi
else if xt<0 and yt<0 then
phy=atan(xt/yt)-math.pi
else
phy=atan(xt/yt)
end
end
tha=M.acos(zt/sqrt(xt^2+yt^2+zt^2))
phy=phy/pi2
tha = tha/pi2-0.25-0.01

phyc=GN(4)
thac=GN(5)
yallrst=not GB(1) or GB(3) or GN(16)<1
pitchrst=not GB(1) or GB(2) or GB(4) or GN(16)<1

tha0=thac>-0.01 and thac<0.01
phy0=phyc%1>-0.01 and phyc%1<0.01
if pitchrst then
tha=-0.249
end
if yallrst then
phy=0
end
rag1=pN('Limit Range 1')
rag2=pN('Limit Range 2')
lim1=pN('Limit 1')
lim2=pN('Limit 2')
ragf1=pN('Limit Range front 1')
limf1=pN('Limit front 1')
ragf2=pN('Limit Range front 2')
limf2=pN('Limit front 2')
tlim_up=-pN('Total Lim Up')
tlim_lo=pN('Total Lim Down')
tp=((phyc+0.5)%1)-0.5
lif=false
limit_lo,tp,lif=Limit(tp,tha,lim1,rag1,true)
limit_lo,tp,lif=Limit(tp,tha,lim2,rag2,true)
limit_lo,tp,lif=Limit(tp,tha,limf1,ragf1,false)
limit_lo,tp,lif=Limit(tp,tha,limf2,ragf2,false)
if tha>tlim_lo then
tha=tlim_lo
lif=true
end
if tha<tlim_up then
tha=tlim_up
lif=true
end

if phy~=phy or phy==math.huge or phy==-math.huge or phy==nil then
phy=phy_buf
end
if tha~=tha or tha==M.huge or tha==-M.huge or tha==nil then
tha=0
end
if AT then
if phy-phy_buf>0.95 and phy>=0.475 then
turn=turn-1
end
if phy-phy_buf<-0.95 and phy<=-0.475 then
turn=turn + 1
end
else
phy=clamp(phy,pN("All round lim1"),pN("All round lim2"))
end
phy_buf=phy
pbreak,tbreak=true,true
if 0*(phyc-asbuf[1])+phyc-phy-turn<0.001 and 0*(phyc-asbuf[1])+phyc-phy-turn>-0.001 then
if count[1]<10 then
pbreak=false
count[1]=count[1]+1
end
else
count[1]=0
end
if 0*(thac-asbuf[2])+thac-tha<0.001 and 0*(thac-asbuf[2])+thac-tha>-0.001 then
if count[2]<10 then
tbreak=false
count[2]=count[2]+1
end
else
count[2]=0
end
asbuf[1]=phyc
asbuf[2]=thac
SB(1,not (tha0 and pitchrst) and tbreak)
SB(3,not lif and not (phy0 and yallrst) and pbreak)

SB(2, not lif and not yallrst)
SB(4, not lif and not (tha0 and pitchrst))
SB(5, abs(thac-tha)<0.01 and abs(phyc-phy-turn)<0.01)
SB(6, lif)

SN(3,GN(4))
SN(4,phy+turn)

pid_lpitch[1],pid_lyaw[1]=GN(5),GN(4)

pid_lpitch,out_lpitch=pid(pid_lpitch,tha,coff_lpitch,not (tha0 and pitchrst) and tbreak,-0.3,0.3)
pid_lyaw,out_lyaw=pid(pid_lyaw,phy+turn,coff_lyaw,not (phy0 and yallrst) and pbreak,-0.3,0.3)

out_lpitch=clamp(out_lpitch,-1,1)
out_lyaw=clamp(out_lyaw,-1,1)
pid_spitch[1],pid_syaw[1]=GN(7),GN(6)
pid_spitch,out_spitch=pid(pid_spitch,out_lpitch,coff_spitch,not (tha0 and pitchrst) and tbreak,-0.3,0.3)
pid_syaw,out_syaw=pid(pid_syaw,out_lyaw,coff_syaw,not (phy0 and yallrst) and pbreak,-0.3,0.3)
	
SN(1,clamp(out_syaw+out_lyaw,-0.3,0.3))
SN(2,out_spitch+out_lpitch)
end
function pid(data,setpoint,coff,En,down,up)
if En then
data[2]=clamp(data[2]+setpoint-data[1],down,up)
local out=(setpoint-data[1])*coff[1]+(data[2])*coff[2]+(setpoint-data[1]-data[3])*coff[3]
data[3]=setpoint-data[1]
return data,out
else
data,out={0,0,0},0
return data,out
end
end
function clamp(x,a,b)
if x<a then x=a end
if x>b then x=b end
return x
end
function Limit(p,t,lim,rag,bak)
local flag=false
if bak then
flag=p>rag or p<-rag
else
rag=-rag
flag=p>rag and p<-rag
end
if flag then
tlim_lo=lim-0.001
end
return tlim_lo,p,lif
end
function E2R(_)
local cx,cy,cz,sx,sy,sz=cos(_[1]),cos(_[2]),cos(_[3]),sin(_[1]),sin(_[2]),sin(_[3]) return {{cy*cz,cx*cy*sz+sx*sy,sx*cy*sz-cx*sy},{-sz,cx*cz,sx*cz},{sy*cz,cx*sy*sz-sx*cy,sx*sy*sz+cx*cy}}
end
function Mv(M,v)
local t={}
for i=1,3 do
_=0
for j=1,3 do
_=_+M[j][i]*v[j]
end
t[i]=_
end
return t
end