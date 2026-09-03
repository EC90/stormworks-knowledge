-- source: steam id 2851230589 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2851230589
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

function onTick()
phy=GN(1)
thaout=GN(2)
phycurrent=GN(3)
thacurrent=GN(4)
yallrst=GB(1) or GB(3)
pitchrst=GB(2) or GB(4)

tha0=thacurrent>-0.01 and thacurrent<0.01
phy0=phycurrent>-0.01 and phycurrent<0.01
if pitchrst then
	tha = 0
end
if yallrst then
	phy = 0
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
tp=((GN(3)+0.5)%1)-0.5
lif=false
limit_lo,tp,lif=Limit(tp,thaout,lim1,rag1,true)
limit_lo,tp,lif=Limit(tp,thaout,lim2,rag2,true)
limit_lo,tp,lif=Limit(tp,thaout,limf1,ragf1,false)
limit_lo,tp,lif=Limit(tp,thaout,limf2,ragf2,false)
if thaout>tlim_lo then
	thaout=tlim_lo
end
if thaout<tlim_up then
	thaout=tlim_up
end

if phy~=phy or phy==math.huge or phy==-math.huge or phy==nil then
	phy=phy_buf
end
if tha~=tha or tha==math.huge or tha==-math.huge or tha==nil then
	tha=0
end
if phy-phy_buf>0.95 and phy>=0.475 then
	turn=turn-1
end
if phy-phy_buf<-0.95 and phy<=-0.475 then
	turn=turn + 1
end
phy_buf=phy
pbreak,tbreak=true,true
if 6*(phycurrent-asbuf[1])+phycurrent-phy-turn<0.001 and 6*(phycurrent-asbuf[1])+phycurrent-phy-turn>-0.001 then
	if count[1]<10 then
		pbreak=false
		count[1]=count[1]+1
	end
else
	count[1]=0
end
if 5*(thacurrent-asbuf[2])+thacurrent-thaout<0.001 and 5*(thacurrent-asbuf[2])+thacurrent-thaout>-0.001 then
	if count[2]<10 then
		tbreak=false
		count[2]=count[2]+1
	end
else
	count[2]=0
end
asbuf[1]=phycurrent
asbuf[2]=thacurrent

SN(1, phy+turn)
SN(2, thaout)
SN(3, GN(3))
SN(4, GN(4))
SB(1, not lif and not (phy0 and yallrst) and pbreak)
SB(2, not lif and not yallrst)
SB(3, not (tha0 and pitchrst) and tbreak)
SB(4, not lif and not (tha0 and pitchrst))
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