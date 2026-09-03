-- source: steam id 3119724150 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3119724150
mD,w,h,gR,H,pp,o,Tr,t1,mL=1,48,96,0,84,1,1000,1,false,0
local ModK={}
I=input
O=output
P=property
PN=P.getNumber
PB=P.getBool
IN=I.getNumber
ON=O.setNumber
IB=I.getBool
OB=O.setBool
ModK[1]=PB("Mode C")
ModK[2]=PB("Mode B")
ModK[3]=PB("Mode E")
ModK[4]=PB("Sector PPI")
ModK[5]=PB("PPI")
for i=1,5 do 
    if not ModK[mD] then mD=mD+1 else break end
end
function iP(x,y,rX,rY,rW,rH)
return x>rX and y>rY and x<rX+rW and y<rY+rH end
function onTick()
    i1=IB(3)and not d1
    d1=IB(3)
    i2=IB(4)and not d2
    d1=IB(4)
    x=IN(3)
	y=IN(4)
    X=IN(5)
	Y=IN(6)
    D=PN("Radar Display")
    r=PN("Scan Radar Range")
    local A,a,b,c,d,e,f,F=i1 or i2,26/D,6/D+1,H/D,70/D,h/D,91/D,4/D
    md=A and(iP(x,y,0,0,a,b)or iP(X,Y,0,0,a,b))
    gr=A and(iP(x,y,0,b,e,c)or iP(X,Y,0,b,e,c))
    cr=A and(iP(x,y,d,0,a,b)or iP(X,Y,d,0,a,b))
    tr=A and(iP(x,y,f,f,F,b)or iP(X,Y,f,f,F,b))
    if tr then
        Tr=Tr+1
        if Tr==9 then Tr=1 end
    end
    if cr then
        pp=pp+1
        if pp==8 then pp=1 end
    end
    R=r/pp
    if md then
        mD=mD+1
        for i=1,5 do
            if not ModK[mD] then mD=mD+1 else break end
        end
        if mD>=6 then
            for i=1,5 do
                if ModK[i] then mD=i break end
            end
        end
    end
    if gr and gR then
        gR=false
    elseif gr then gR=true end
    for i=1,5 do
        if i==mD then OB(i,true)else OB(i,false)end
    end
    if (R/12)<o then
        if (R/8)>=o then m=12
        elseif (R/6)>=o then m=16
        else m=24 end
        else m=8
    end
    ON(1,m)
    ON(2,R)
    ON(3,Tr)
    OB(6,gR)
    OB(7,cr)
    OB(8,tr)
end