-- source: steam id 3228447235 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228447235
--Display config
GridN1=4
GridN2=4
FrameC={0,31,0,255}
GridC={0,15,0,255}
TextC={31,31,31,255}
TgtC={0,255,0,255}
--Process config
MargeDist=10
MaxTGT=32
HoldTick=180

iB=input.getBool
iN=input.getNumber
m=math
pi=m.pi
pi2=2*pi
s=m.sin
c=m.cos
t=m.tan
as=m.asin
ac=m.acos
at=m.atan
rads=pi/180
sc=screen
sC=sc.setColor
dT=sc.drawText
dL=sc.drawLine
dC=sc.drawCircle
dR=sc.drawRect
fo=string.format
tb=table
tI=tb.insert
tR=tb.remove
pN=property.getNumber
pB=property.getBool
Marge=pB("Marge close targets")
dHUD=pN("Distance between HUD and center of seat (m)")+0.066
OffW=pN("Monitor center horizontal offset (pxiel)")
OffH=pN("Monitor center vertical offset (pxiel)")
function distV(V1,V2)
	_=0
	for i=1,3 do
		_=_+(V1[i]-V2[i])^2	
	end
	return _^0.5
end
function outPro(u,v)
	w={}
	w[1]=u[2]*v[3]-u[3]*v[2]
	w[2]=u[3]*v[1]-u[1]*v[3]
	w[3]=u[1]*v[2]-u[2]*v[1]
	return w
end
function AngleToBasis(Q)
	ex={c(Q[1])*s(-Q[2]),c(Q[1])*c(-Q[2]),s(Q[1])}
	ey={c(Q[3])*s(-Q[4]),c(Q[3])*c(-Q[4]),s(Q[3])}
	ez=outPro(ex,ey)
	return {ex,ey,ez}
end
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
function RegisterTGT(tgtV)
	tgtV[4]=0
	tI(TGTD,tgtV)
	if #TGTD>MaxTGT then
		tR(TGTD,1)
	end
end
function OrthToPol(VO)
	VP={}
	VP[1]=distV(VO,{0,0,0})
	VP[2]=at(VO[1],VO[2])
	VP[3]=as(VO[3]/VP[1])
	return VP
end
function dC2(x,y,r,dn)
	for i=1,dn do
		qs,qe=(i-1)*pi2/dn,i*pi2/dn
		dL(x+r*c(qs),y-r*s(qs),x+r*c(qe),y-r*s(qe))
	end
end
function sC2(T)
	sC(T[1],T[2],T[3],T[4])
end
function Rot2D(x,y,q)
	return x*c(q)-y*s(q),x*s(q)+y*c(q)
end
TGTS={}
TGTD={}
w,h=8
RngN=1
isPrO=false
vl=20
ll=3
ldmin=3
RHead=0.088

function onTick()
	if MapStyle~=0 then
		PO={iN(4),iN(8),iN(12)}
		QO={iN(16)*pi2,iN(20)*pi2,iN(24)*pi2,iN(28)*pi2}
		es=AngleToBasis(QO)
		Es=tM(es)
		look=iN(32)
		lx=look%10^3
		ly=(look-lx)/10^3
		lx,ly=(lx/999-0.5)*pi2,(ly/999-0.5)*pi2
		hsx,hcx=RHead*s(lx),RHead*c(lx)
		hsy,hcy=RHead*s(ly),RHead*c(ly)

		--Input
		for i=1,8 do
			det=iB(i)
			if det then
				for j=1,3 do
					TGTS[i][j]=iN(i*4-(4-j))
				end
				if #TGTD>0 then
					dist,km=distV(TGTD[1],TGTS[i]),1
					for k=1,#TGTD do
						distk=distV(TGTD[k],TGTS[i])
						if distk<dist then
							dist=distk
							km=k
						end
					end
					if dist<MargeDist then
						for j=1,3 do
							TGTD[km][j]=TGTS[i][j]
						end
						TGTD[km][4]=0
					else
						RegisterTGT(TGTS[i])
					end
				else
					RegisterTGT(TGTS[i])
				end
			else
				TGTS[i]={0,0,0}
			end
		end
		--Range setting
		if isPr and not isPrO then
			for i=1,#Rng do
				RngN=(RngN)%#Rng+1
				if Rng[RngN]>0 then break end
			end
		end
		isPrO=isPr

		--Target data tick update
		if #TGTD>0 then
			for k=#TGTD,1,-1 do
				TGTD[k][4]=TGTD[k][4]+1
				if TGTD[k][4]>HoldTick then
					tR(TGTD,k)
				end
			end
		end

		--
		if #TGTD>0 then
			for k=1,#TGTD do
				_={}
				for j=1,3 do
					_[j]=TGTD[k][j]-PO[j]
				end
				_=Mv(Es,_)
				for j=1,3 do
					TGTD[k][4+j]=_[j]
				end
			end
		end

	end
end

function onDraw()
	if MapStyle~=0 then
		w=sc.getWidth()
		h=sc.getHeight()
		
		if #TGTD>0 then
			for k=1,#TGTD do
				if TGTD[k][6]>0 then
					TgtCk={TgtC[1],TgtC[2],TgtC[3],TgtC[4]*(1-TGTD[k][4]/HoldTick)}
					sC2(TgtCk)
					dx,dy=(hsx+(dHUD-hcx)*(TGTD[k][5]-hsx)/(TGTD[k][6]-hcx))*128,(-hsy-(dHUD-hcy)*(TGTD[k][7]-hsy)/(TGTD[k][6]-hcy))*128
					cx,cy=w/2+OffW+dx,h/2+OffH+dy
					ld=m.max(ldmin,vl*dHUD/TGTD[k][6]*128)
					for j=0,3 do
						lq=pi/2*j
						fx0,fy0=Rot2D(ld,ld,lq)
						fx1,fy1=Rot2D(ld-ll,ld,lq)
						fx2,fy2=Rot2D(ld,ld-ll,lq)
						dL(cx+fx0,cy+fy0,cx+fx1,cy+fy1)
						dL(cx+fx0,cy+fy0,cx+fx2,cy+fy2)
					end
				end
			end
		end
	end
end