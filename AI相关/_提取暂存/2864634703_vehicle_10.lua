-- source: steam id 2864634703 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2864634703
--Functions
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
pB=property.getBool
pN=property.getNumber
m=math
pi=m.pi
pi2=2*pi
s=m.sin
c=m.cos
t=m.tan
as=m.asin
ac=m.acos
at=m.atan
function Mv(M,v)
	V={}
	for i=1,3 do
		_=0
		for j=1,3 do
			_=_+M[j][i]*v[j]
		end
		V[i]=_
	end
	return V
end
function tM(M)
	N={{},{},{}}
	for i=1,3 do
		for j=1,3 do
			N[i][j]=M[j][i]
		end
	end
	return N
end
function Eular2RotMat(E)
	qx,qy,qz=E[1],E[2],E[3]
	return {{c(qy)*c(qz),s(qx)*s(qy)*c(qz)-c(qx)*s(qz),c(qx)*s(qy)*c(qz)+s(qx)*s(qz)},{c(qy)*s(qz),s(qx)*s(qy)*s(qz)+c(qx)*c(qz),c(qx)*s(qy)*s(qz)-s(qx)*c(qz)},{-s(qy),s(qx)*c(qy),c(qx)*c(qy)}}
end
function distV(V1,V2)
	_=0
	for i=1,3 do
		_=_+(V1[i]-V2[i])^2
	end
	return _^0.5
end
function OrthToPol(v)
	r=distV(v,{0,0,0})
	a=at(v[1],v[3])
	e=as(v[2]/r)
	return {r,a,e}
end


--Read Config
PC_L={pN('Local offset Right (m)'),pN('Local offset Up (m)'),pN('Local offset Front (m)')}--Offsets of pivot from Physics Sensor installed in a merge same as the cannon
t_d=pN('Processing delay (tick)')
Type=pN('Target Coordinate Type')
OM={1,2/pi,2/pi}

function onTick()
    PT,Eu,VO_L={},{},{}
    for i=1,3 do
        if Type==0 then
            PT[i]=iN(i)-iN(i+3)
        else
            PT[i]=iN(i)
        end
        Eu[i]=iN(i+6)
        VO_L[i]=iN(i+9)/60
    end
    Rot_GL=Eular2RotMat(Eu)
    PT_L=Mv(Rot_GL,PT)
    for i=1,3 do
        PT_L[i]=PT_L[i]-PC_L[i]-VO_L[i]*t_d
    end
    if distV(PT_L,{0,0,0})~=0 and PT_L[3]>0 then
        PT_P=OrthToPol(PT_L)
        PT_P[2]=m.min(m.max(PT_P[2]*OM[2],-1),1)
        PT_P[3]=m.min(m.max(PT_P[3]*OM[3],-1),0)
		if PT_P[1]>1 then
        	for i=1,3 do
        	    oN(i,PT_P[i])
        	    oN(i+3,PT_L[i])
        	end
		end
    else
        for i=1,3 do
            --oN(i,0)
        end
    end
end