-- source: steam id 3789438208 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3789438208
S=screen
SC=S.setColor
DL=S.drawLine
DTX=S.drawText
i=input
slc=0

function onTick()

s= round(i.getNumber(1)*3.6,0)
cc= round(i.getNumber(2),0)
ccs= i.getNumber(3)

g=i.getNumber(4)
g1=round(i.getNumber(5),0)

rps=round(i.getNumber(6),0)
teng=round(i.getNumber(7),0)
fuel=round(i.getNumber(8),0)

min=round(i.getNumber(9),0)
rng=round(i.getNumber(10),0)
lkm=round(i.getNumber(16),0)

rain=round(i.getNumber(11)*100,0)
fog=round(i.getNumber(12)*100,0)
temp=round(i.getNumber(13),0)

gen=round(i.getNumber(14)*20,0)
batt=round(i.getNumber(15)*100,0)

nxt=i.getBool(1)
key=i.getBool(2)

if nxt then

slc = slc + 1 

elseif slc == 6 or not key then

slc = 0

end

end

function onDraw()

if slc == 0 or slc == 1 then

SC(34,34,34,255*ccs)

DL(21,21,22.25,20.25)
DL(22,22,22.25,22.25)
DL(24,21,25.25,20.25)
DL(25,22,25.25,22.25)

if cc >= 100 then
txt(9,19,cc)
elseif cc>= 10 then
txt(13,19,cc)
else
txt(17,19,cc)
end

end

if slc == 0 then

SC(255,255,255)
DL(21,12,21.25,13.25)
DL(21,11,21.25,11.25)
DL(22,12,22.25,12.25)
DL(23,13,23.25,13.25)
DL(23,11,23.25,11.25)
DL(21,15,21.25,17.25)
DL(23,16,23.25,16.25)
DL(23,15,23.25,17.25)
DL(21,16,23.25,16.25)


SC(255,255,255)
if s >= 100 then
DTX(6,12,s)
elseif s >=10 then
DTX(11,12,s)
else
DTX(16,12,s)
end

end

if slc == 1 then

SC(255,255,255)

if g == 1 then
DTX(12,11,"d")
elseif g== -1 then
DTX(12,11,"R")
else
DTX(12,11,"P")
end

SC(255,255,255)
txt(17,12,"s")
txt(21,12,g1+1)

end

if slc == 2 then

SC(255,255,255)
txt(7,9,"rps")
txt(3,14,"Temp")
txt(3,19,"fuel")
SC(34,34,34)
txt(20,9,rps)
txt(20,14,math.abs(teng))
if math.abs(teng) >= 10 then
DL(28,14,28.25,15.25)
DL(29,14,29.25,15.25)
if teng<0 then
DL(28,17,29.25,17.25)
end
else
DL(24,14,24.25,15.25)
DL(25,14,25.25,15.25)
if teng<0 then
DL(24,17,25.25,17.25)
end
end
txt(20,19,fuel)

end

if slc == 4 then

SC(255,255,255)
txt(7,14,"RNG")
SC(34,34,34)
txt(19,14,rng)
SC(255,255,255)
txt(3,19,"time")
SC(34,34,34)
if min>60 then 
txt(19,19,round(min/60,0))
if (min/60)>= 10 then
DL(27,19,27.25,22.25)
DL(27,22,27.25,22.25)
DL(28,21,28.25,21.25)
DL(29,22,29.25,22.25)
else
DL(23,19,23.25,22.25)
DL(24,21,25.25,22.25)
end
else
txt(19,19,min)
if min>= 10 then
DL(27,19,27.25,20.25)
else
DL(23,19,23.25,20.25)
end
end
SC(255,255,255)
txt(3,9,"l/km")
SC(34,34,34)
txt(19,9,lkm)
end

if slc == 5 then

SC(255,255,255)
txt(3,9,"temp")
txt(3,14,"rain")
txt(7,19,"fog")
SC(44,44,44)
txt(19,14,rain)
txt(19,19,fog)

txt(19,9,math.abs(temp))
if math.abs(temp) > 10 then
DL(27,9,27.25,10.25)
DL(28,9,28.25,10.25)
if temp < 0 then
DL(27,12,28.25,12.25)
end
else 
DL(23,9,23.25,10.25)
DL(24,9,24.25,10.25)
if temp < 0 then
DL(23,12,24.25,12.25)
end
end
end

if slc == 3 then

SC(255,255,255)
txt(3,11,"batt")
txt(7,17,"gen")
SC(34,34,34)
txt(19,11,batt)
txt(19,17,gen)

end

end
function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function txt(x,y,t)t=tostring(t)for i=1,t:len()do local c=t:sub(i,i):upper():byte()*3-95if c>193then c=c-78 end c="0x"..string.sub("0000D0808F6F5FAB6D5B7080690096525272120222010168F9F5F1BBD9DBE2FDDBFBB8BCFBFEAF0A01A025055505289C69D7A7FB6699F96FB9FA869BF2F9F921EF69F11FCFF8F696FA4F9EFA55BB8F8F1FE1EF3FD2DC3CBFDF9086109F4841118406F90F09F6642",c,c+2)for j=0,11 do if c&(1<<(11-j))>0then local b=x+j//4+i*4-4 DL(b,y+j%4,b,y+j%4+1)end end end end