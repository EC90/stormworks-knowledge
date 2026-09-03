-- source: steam id 2935030957 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2935030957
iB=input.getBool
iN=input.getNumber
oN=output.setNumber
oB=output.setBool
m=math
pi=m.pi
pi2=2*pi
s=m.sin
c=m.cos
as=m.asin
at=m.atan
CalMode=property.getBool("Calculation Mode")

function Eular2RotMat(E)--Calculate Basis
	qx,qy,qz=E[1],E[2],E[3]
	return {{c(qy)*c(qz),c(qx)*c(qy)*s(qz)+s(qx)*s(qy),s(qx)*c(qy)*s(qz)-c(qx)*s(qy)},{-s(qz),c(qx)*c(qz),s(qx)*c(qz)},{s(qy)*c(qz),c(qx)*s(qy)*s(qz)-s(qx)*c(qy),s(qx)*s(qy)*s(qz)+c(qx)*c(qy)}}
end
function tM(M)--Transpose matrix
	N={{},{},{}}
	for i=1,3 do
		for j=1,3 do
			N[i][j]=M[j][i]
		end
	end
	return N
end
function Mv(M,v)--Multiply matrix and vector
	u={}
	for i=1,3 do
		_=0
		for j=1,3 do
			_=_+M[j][i]*v[j]
		end
		u[i]=_
	end
	return u
end
function inPro(u,v)--Inner production
	_=0
	for i=1,3 do
		_=_+u[i]*v[i]
	end
	return _
end

function onTick()
	--Input
	PO={iN(1),iN(3),iN(2)}--Self position (global)
	Eu={iN(4),iN(6),iN(5)}--Eular angles
	PT={iN(15),iN(16),iN(17)}--Target position (global/local)
	
	--Calculate rotation matrix
	B=Eular2RotMat(Eu)--Basis (Global to Local)
	b=tM(B)--Basis (Local to Global)
	
	PN={}
	if CalMode then--Global to local
		for i=1,3 do
			PN[i]=PT[i]-PO[i]
		end
		PN=Mv(B,PN)--Calculate local coordinate
	else--Local to global
		PN=Mv(b,PT)--Calculate global coordinate
		for i=1,3 do
			PN[i]=PN[i]+PO[i]
		end
	end
	
	--Calculate vehicle attitude
	rol=as(inPro(b[1],{0,0,1}))/pi2
	pit=as(inPro(b[2],{0,0,1}))/pi2
	yaw=-at(b[2][1],b[2][2])/pi2

	--Output transformed coordinate
	oN(1,PN[1])
	oN(2,PN[2])
	oN(3,PN[3])
	
	--Output vehicle attitude values
	oN(4,rol)
	oN(5,pit)
	oN(6,yaw)
	
	--Output basis components for graph view
	for i=1,3 do
		for j=1,3 do
			oN(11+3*(i-1)+(j-1),b[i][j])
		end
	end
end