-- source: steam id 3228447235 / vehicle.xml block#29
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228447235
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
m=math
pi=m.pi
pi2=2*pi
rads=pi/180
s=m.sin
c=m.cos
t=m.tan
as=m.asin
ac=m.acos
at=m.atan
pN=property.getNumber
--k_in=1/16
k2=1
llimit=1/2
Pr=pN("Roll Gain")
Pp=pN("Pitch Gain")
Py=pN("Yaw Gain")
Op=pN("Pitch offset (deg.)")
Oy=pN("Yaw offset (deg.)")

function sgn(x)
	if x==0 then
		return 1
	else
		return x/m.abs(x)
	end
end
function distV(V1,V2)
	_=0
	for i=1,3 do
		_=_+(V1[i]-V2[i])^2	
	end
	return _^0.5
end
function Eular2RotMat(E)
	qx,qy,qz=E[1],E[2],E[3]
	return {{c(qy)*c(qz),c(qx)*c(qy)*s(qz)+s(qx)*s(qy),s(qx)*c(qy)*s(qz)-c(qx)*s(qy)},{-s(qz),c(qx)*c(qz),s(qx)*c(qz)},{s(qy)*c(qz),c(qx)*s(qy)*s(qz)-s(qx)*c(qy),s(qx)*s(qy)*s(qz)+c(qx)*c(qy)}}
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
function Mv(M,v)
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
function PolToOrth(r,a,e)
	v={r*s(a)*c(e),r*c(a)*c(e),r*s(e)}
	return v
end
function OrthToPol(v)
	r=distV(v,{0,0,0})
	a=at(v[2],v[1])
	e=as(v[3]/r)
	return r,a,e
end
function inPro(u,v)
	_=0
	for i=1,3 do
		_=_+u[i]*v[i]
	end
	return _
end
function outPro(u,v)
	w={}
	w[1]=u[2]*v[3]-u[3]*v[2]
	w[2]=u[3]*v[1]-u[1]*v[3]
	w[3]=u[1]*v[2]-u[2]*v[1]
	return w
end
function angdif(a,b)
	return at(s(a-b),c(a-b))
end
function ControlIntegral(integral,ctrl,sensitivity)
	if m.abs(ctrl)>0.01 then
		integral=integral+sgn(ctrl)*sensitivity
	elseif integral>0 then
		integral=m.max(m.abs(integral)-sensitivity,0)
	elseif integral<0 then
		integral=-m.min(m.abs(integral)-sensitivity,0)
	end
	return integral
end

--r_i,p_i,y_i=0,0,0
r_s,p_s,y_s=0.01,0.01,0.01
function onTick()
	E={iN(4),iN(6),iN(5)}
	qp,qr,qc=iN(15)*pi2,-iN(16)*pi2,-iN(17)*pi2
	if iN(18)==1 then isActive=true	else isActive=false	end
	lx,ly=m.max(m.min(iN(19),llimit),-llimit)*pi2,m.max(m.min(iN(20),llimit),-llimit)*pi2
	inr,inp,iny,inc=iN(21)*pi2,-iN(22)*pi2,iN(23)*pi2,iN(24)*pi2
	qrG_r,qpG_r,qyG_r=iN(25),iN(26),iN(27)
	r_i,p_i,y_i=iN(28),iN(29),iN(30)

	if isActive then
		R_GL=Eular2RotMat(E)
		R_LG=tM(R_GL)

		--yaw,pitch
		qc_t=lx+Oy*rads
		qp_t=ly+Op*rads
		vLy=PolToOrth(1,qc_t,qp_t)
		vGy=Mv(R_LG,vLy)
		qcG_t=at(vGy[1],vGy[2])
		qpG_t=as(vGy[3])

		--roll
		hg1x,hg1y=R_LG[1][1],R_LG[1][2]
		hg1d=(hg1x^2+hg1y^2)^0.5
		R_HG1={hg1x/hg1d,hg1y/hg1d,0}
		R_HG3={0,0,1}
		R_HG2=outPro(R_HG3,R_HG1)
		R_HG={R_HG1,R_HG2,R_HG3}
		R_GH=tM(R_HG)
		vH=Mv(R_GH,Mv(R_LG,vLy))
		hx,hz=vH[1],vH[2]
		qrG_t=at(hx,hz)
		--qrG_t=qrG_t*math.max(0,1-k2*math.exp(-(hx^2+hz^2)))
	else
		qrG_t,qpG_t,qcG_t=qrG_r,qpG_r,qyG_r
	end
	
	r_i=ControlIntegral(r_i,inr,r_s)
	p_i=ControlIntegral(p_i,inp,p_s)
	y_i=ControlIntegral(y_i,iny,y_s)

	difr=angdif(qrG_t+r_i,qr)
	difp=angdif(qpG_t+p_i,qp)
	dify=angdif(qcG_t+y_i,qc)

	oN(1,difr*Pr)
	oN(2,difp*Pp)
	oN(3,dify*Py)
	oN(5,difr)
	oN(6,difp)
	oN(7,dify)
	oN(8,r_i)
	oN(9,p_i)
	oN(10,y_i)
	oN(11,qrG_t)
	oN(12,qpG_t)
	oN(13,qcG_t)
	oN(32,qc)
end