-- source: steam id 3228433002 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228433002
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
function PolToOrth(v)
	x=v[1]*s(v[2])*c(v[3])
	y=v[1]*s(v[3])
	z=v[1]*c(v[2])*c(v[3])
	return {x,y,z}
end
PC_L={0,0,0}
function onTick()
	ActSeaker=iB(3)
	HPID=m.max(iN(1),1)
	PT_P={iN(8+(HPID-1)*3+1),iN(8+(HPID-1)*3+2)*pi2,iN(8+(HPID-1)*3+3)*pi2}
    PO={iN(2),iN(3),iN(4)}
    Eu={iN(5),iN(6),iN(7)}
    Rot_GL=Eular2RotMat(Eu)
	Rot_LG=tM(Rot_GL)
	PT_L=PolToOrth(PT_P)
	if PT_P[1]~=0 or PT_P[2]~=0 or PT_P[3]~=0 then
		for i=1,3 do
			PT_L[i]=PT_L[i]-PC_L[i]
		end
		PT_R=Mv(Rot_LG,PT_L)
		PT={}
		for i=1,3 do
			PT[i]=PT_R[i]+PO[i]
		end
		isDET=true
	else
		PT={0,0,0}
		isDET=false
	end
	
	Searching=ActSeaker and not isDET
	for i=1,3 do
		oN(i,PT[i])
		oN(i+3,PO[i]+Rot_LG[3][i]*1000)
	end
	oB(1,isDET)
	oB(2,Searching)
end