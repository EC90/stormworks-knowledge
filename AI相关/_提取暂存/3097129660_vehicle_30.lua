-- source: steam id 3097129660 / vehicle.xml block#30
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
iB=input.getBool
iN=input.getNumber
pN=property.getNumber
oN=output.setNumber
oB=output.setBool
m=math
T=table
pi=m.pi
pi2=2*pi
s=m.sin
c=m.cos
as=m.asin
Ma=m.atan
Mf=m.floor
Mr=m.sqrt
count=0
count2=0
dao,deo=0,0
pda,pde=0,0
t1,t2,t3={},{},{}
txo,tyo,tzo=0,0,0
dtx,dty,dtz=0,0,0
dsto=0
etao=0
vzo=0
dstmo=0
tlxo,tlyo,tlzo=0,0,0
function Mp(x,min,max)
	return m.max(min,m.min(x,max))
end
function Av(n,v,t)
	t=m.max(Mf(t),1) T.insert(n,v) local s=0
	if #n>t then for i=1,#n-t do T.remove(n,1) end end
	for i=1,#n do s=s+n[i] end return s/#n end
function Eular2RotMat(E)--Calculate Basis
	qx,qy,qz=E[1],E[2],E[3]
	return {{c(qy)*c(qz),c(qx)*c(qy)*s(qz)+s(qx)*s(qy),s(qx)*c(qy)*s(qz)-c(qx)*s(qy)},{-s(qz),c(qx)*c(qz),s(qx)*c(qz)},{s(qy)*c(qz),c(qx)*s(qy)*s(qz)-s(qx)*c(qy),s(qx)*s(qy)*s(qz)+c(qx)*c(qy)}}
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
safe=0
function onTick()
	--Input
	PO={iN(1),iN(3),iN(2)}--Self position (global)
	Eu={iN(4),iN(6),iN(5)}--Eular angles
	tx,ty,tz=iN(11),iN(12),iN(13)
	vx,vy,vz=iN(7),iN(8),iN(9)
	if tx~=0 then
	dtx,dty,dtz=Av(t1,tx-txo,30),Av(t2,ty-tyo,30),Av(t3,tz-tzo,30)
	end
	if tx==0 and txo~=0 then tx=txo ty=tyo tz=tzo count=count+1 else count=0 end 
	txo,tyo,tzo=tx,ty,tz
	if iN(14)==0 then
	safe=safe+1
	dx,dy,dz=tx-PO[1],ty-PO[2],tz-PO[3]
	dst=Mr(dx^2+dy^2+dz^2)
	ddst=dst-dsto
	dsto=dst
	eta=Mp((count-dst/ddst+pN('Lead offset')),0,pN('Max Lead'))
	etao=eta
	vzo=vz
	if tz<pN('path target height') then zofst=Mp((dst-pN('path min distance'))/pN('path min distance'),0,1)*pN('path height') else zofst=0 end
	PT={tx+(eta+count)*dtx,ty+(eta+count)*dty,tz+(eta+count)*dtz+zofst}
	B=Eular2RotMat(Eu)
	PN={}
	for i=1,3 do PN[i]=PT[i]-PO[i] end
	PN=Mv(B,PN)
	tlx=PN[1]
	tly=PN[2]
	tlz=PN[3]
	dtlx,dtly,dtlz=tlx-tlxo,tly-tlyo,tlz-tlzo
	tlxo,tlyo,tlzo=tlx,tly,tlz
	da=Ma(tlx+dtlx,tly+dtly)/pi2-Ma(vx,vz)/pi2
	de=Ma(tlz+dtlz,tly+dtly)/pi2-Ma(vy,vz)/pi2
	dda=da-dao
	dde=de-deo
	dao,deo=da,de
	Kv=Mp(vz/60,0,1)
	sd=pN('Start Delay')
	Ksf=Mp((safe-0.5*sd)/sd,0,1)
	K=pN('K')*Kv*Ksf
	pda=Mp((pda+da)*pN('I')*K,-0.2,0.2)
	pde=Mp((pde+de)*pN('I')*K,-0.2,0.2)
	ao=-Mp(0.6*(pN('P')*da*K+dda*pN('D')*K+pda),-1,1)
	eo=Mp(pN('P')*de*K+dde*pN('D')*K+pde,-1,1)
	Krd=pN('Krd')
	if iN(17)~=0 and iN(18)~=0 then
		ao=-Krd*0.6*iN(17)
		eo=Krd*iN(18)
	end
else
	ao,eo=0,0
end
	oN(1,ao)
	oN(2,eo)
end