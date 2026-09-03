-- source: steam id 3228447235 / vehicle.xml block#30
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228447235
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
function angdif(a,b)
	return at(s(a-b),c(a-b))
end

--Read Config
PC_L={pN('Local offset Right (m)'),pN('Local offset Up (m)'),pN('Local offset Front (m)')}--Offsets of pivot from Physics Sensor installed in a merge same as the cannon
t_d=pN('Processing delay (tick)')
Type=pN('Target Coordinate Type')
VSens_A=pN('Velocity Pivot Sensitivity (1/rad)')
OM={1,2/pi,2/pi}

function onTick()
    PT,Eu,VO_L,Eu_t={},{},{},{}
    for i=1,3 do
        if Type==0 then
            PT[i]=iN(i)-iN(i+3)
        else
            PT[i]=iN(i)
        end
        Eu[i]=iN(i+6)
        VO_L[i]=iN(i+9)/60
		Eu_t[i]=iN(i+15)
    end
    Rot_GL=Eular2RotMat(Eu)
    PT_L=Mv(Rot_GL,PT)

	Rot_GLt=Eular2RotMat(Eu_t)
	Rot_LtG=tM(Rot_GLt)
	t3_G=Rot_LtG[3]
	t3_L=Mv(Rot_GL,t3_G)
	t_a=at(t3_L[1],t3_L[3])--current turret azimuth angle
	
    for i=1,3 do
        PT_L[i]=PT_L[i]+PC_L[i]-VO_L[i]*t_d
    end
    if distV(PT_L,{0,0,0})~=0 and PT_L[3]>0 then
        PT_P=OrthToPol(PT_L)
		u_a=angdif(PT_P[2],t_a)*VSens_A
        PT_P[2]=m.min(m.max(PT_P[2]*OM[2],-1),1)
        PT_P[3]=m.min(m.max(PT_P[3]*OM[3],-1),0)
		if PT_P[1]>1 then
        	for i=1,3 do
        	    oN(i,PT_P[i])
        	end
			oN(4,u_a)
		else
			oN(4,0)
		end
    else
        for i=1,3 do
            --oN(i,0)
        end
		oN(4,0)
    end
	oN(11,t_a)
end