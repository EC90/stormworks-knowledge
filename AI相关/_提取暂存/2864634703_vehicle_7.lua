-- source: steam id 2864634703 / vehicle.xml block#7
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
sc=screen
dL=sc.drawLine
function distV(V1,V2)
	_=0
	for i=1,3 do
		_=_+(V1[i]-V2[i])^2
	end
	_=_^0.5
	return _
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
function drawMarker(cx,cy,sh,size)
	s2=size/2
	ss=size/2^0.5
	s4=size/4
	if sh==1 then
		sc.drawCircleF(cx,cy,s2)
	elseif sh==2 or sh==3 or sh==4 or sh==5 or sh==6 then
		if sh==2 then
			lc=2
			np=m.ceil(pi2*s2/(4*lc))*4
			rp=s2
			q0=0
		elseif sh==3 or sh==4 then
			np=3
			rp=size*3^(-0.5)
			if sh==3 then q0=pi/2 else q0=-pi/2 end
		else
			np=4
			rp=size*2^(-0.5)
			if sh==5 then q0=pi/4 else q0=pi/2 end
		end
		qd=pi2/np
		for i=1,np do
			pt={}
			for j=1,2 do
				qi=q0+qd*(i+j-2)
				pt[j]={cx+rp*c(qi),cy-rp*s(qi)}
			end
			dL(pt[1][1],pt[1][2],pt[2][1],pt[2][2])
		end
	elseif sh==7 then
		dL(cx,cy-s2,cx,cy+s2)
		dL(cx-s2,cy,cx+s2,cy)
	elseif sh==8 then
		dL(cx-ss,cy-ss,cx+ss,cy+ss)
		dL(cx-ss,cy+ss,cx+ss,cy-ss)
	elseif sh==9 then
		dL(cx,cy-s2,cx,cy+s2)
		dL(cx-s4,cy+s2,cx+s4,cy+s2)
		dL(cx-s4,cy-s2,cx+s4,cy-s2)
	end
end

--Read Config
DMode=pN('Display Mode')
PC_L={pN('Local offset Right (m)'),pN('Local offset Up (m)'),pN('Local offset Front (m)')}--Offsets of Camera(Display mode)/Seat(HUD mode) from Physics Sensor
D_HUD=pN('Gap between HUD and Seat (m)')+0.187
R_Head=0.088
GMode=pN('Data Gating Mode')
t_aqc=pN('Data aqcuisition delay (tick)')
CalibMode=pB('Activate calibration mode')
OffW,OffH=pN('Monitor center horizontal offset (pxiel)'),pN('Monitor center vertical offset (pxiel)')
Shape={}
Color={}
Size={}
for i=1,6 do
    Shape[i]=pN('Marker '..i..' Shape')
    Size[i]=pN('Marker '..i..' Size')
    Color[i]={}
    for j,v in pairs({'R','G','B'}) do
        Color[i][j]=pN('Marker '..i..' Color '..v)
    end
end
--Initialize
PT_L={}
isActive={}
DEBUG_N={}
function onTick()
    PO={iN(1),iN(2),iN(3)}
    Eu={iN(4),iN(5),iN(6)}
    VO_L={iN(7)/60,iN(8)/60,iN(9)/60}
    FOV=iN(12)
    QL={iN(13)*pi2,iN(14)*pi2}
    VA=(0.025-2.2)*FOV+2.2
    Rot_GL=Eular2RotMat(Eu)
	Rot_LG=tM(Rot_GL)
    for k=1,6 do
        PT={}
        d_=0
        for i=1,3 do
            PT[i]=iN(11+3*k+i)
            d_=d_+PT[i]^2
        end
        if (GMode==1 and d_==0) or (GMode==2 and iB(k)==false) then
            isActive[k]=false
        else
            isActive[k]=true
        end
		for i=1,3 do
			PT[i]=PT[i]-PO[i]
		end
		PT_L[k]=Mv(Rot_GL,PT)
		for i=1,3 do
			PT_L[k][i]=PT_L[k][i]-PC_L[i]-VO_L[i]*t_aqc
		end
    end
	for i=1,3 do
		DEBUG_N[i]=iN(11+3*1+i)
	end
end

function onDraw()
	w,h=sc.getWidth(),sc.getHeight()
	w2,h2=w/2,h/2
    for k=1,6 do
        if isActive[k] then
            sc.setColor(Color[k][1],Color[k][2],Color[k][3])
			if DMode==0 then
				dr_x=w2+w2*PT_L[k][1]/PT_L[k][3]/t(VA/2)
				dr_y=h2-h2*PT_L[k][2]/PT_L[k][3]/t(VA/2)
			else
				x0,x1=R_Head*s(QL[1]),R_Head*c(QL[1])
				dr_x=w2+(x0+(PT_L[k][1]-x0)*(D_HUD-x1)/(PT_L[k][3]+D_HUD-x1))*128+OffW
				y0,y1=R_Head*s(QL[2]),R_Head*c(QL[2])
				dr_y=h2-(y0+(PT_L[k][2]-y0)*(D_HUD-y1)/(PT_L[k][3]+D_HUD-y1))*128+OffH
			end
			dr_x,dr_y=m.ceil(dr_x-0.5),m.ceil(dr_y-0.5)
			drawMarker(dr_x,dr_y,Shape[k],Size[k])
        end
    end
	if CalibMode then
		dL(0,h2+OffH,w,h2+OffH)
		dL(w2+OffW,0,w2+OffW,h)
	end
end