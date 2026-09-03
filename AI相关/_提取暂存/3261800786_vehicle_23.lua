-- source: steam id 3261800786 / vehicle.xml block#23
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3261800786
--ztq15cmdf2
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.atan
Mb=M.abs
U=M.cos
Mf=M.floor
V=M.sin
Mr=M.sqrt
P=M.pi*2
function Mp(value,vmin,vmax)return math.max(math.min(vmax,value),vmin)end
function E2R(_)
local x,y,z=_[1],_[2],_[3] return {{U(y)*U(z),U(x)*U(y)*V(z)+V(x)*V(y),V(x)*U(y)*V(z)-U(x)*V(y)},{-V(z),U(x)*U(z),V(x)*U(z)},{V(y)*U(z),U(x)*V(y)*V(z)-V(x)*U(y),V(x)*V(y)*V(z)+U(x)*U(y)}}
end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function G2L(_) return Mv(E2R(Eu),{_[1],_[2],_[3]}) end
function G2CP(_) return Ma(_[1],_[2]),Ma(_[3],Mr(_[1]^2+_[2]^2)) end
function L2AE(_) return Ma(_[1],_[2]),Ma(_[3],_[2]) end
function CD(c,t) c,t=c%1,t%1 if (c-t)>0.5 then t=t+1 elseif (c-t)<-0.5 then t=t-1 end return (c-t) end
Is={} Ds={} Dss={}
function pid(id,v,s,p,i,d,plmt,ilmt) if not Is[id] then Is[id]=0 Ds[id]=0 Dss[id]={} end Is[id]=Mp(Is[id]+i*(s-v),-ilmt,ilmt) local o=Mp(p*(s-v),-plmt,plmt)+Is[id]+d*(s-v-Ds[id]) Ds[id]=s-v return o end
function dst(a,b) return Mr((a[1]-b[1])^2+(a[2]-b[2])^2+(a[3]-b[3])^2) end
WP={{rg=1000,lf=150,v0=1000,dg=0.98,dw=0.002},
{rg=1000,lf=120,v0=1600,dg=0.975,dw=0.0025}}
Ag={0,0,-0.5}
Y=0
Ox,Oy=0,0
Ta,Te=0,0
dP=0
eta=0
stbo=false
ilo=false
dPo=0
function onTick()
Sp={GN(1),GN(3),GN(2)}
Eu={GN(4),GN(6),GN(5)}
vW=Mv(tM(E2R(Eu)),{GN(7),GN(9),GN(8)})
sP=GN(15) gC=GN(16) sC=GN(17) gP=GN(19)
fov=GN(18)
zm=-45.9/((fov*2.175-2.2)/M.pi*180)
if GN(12)>9 then
    Tp={GN(31),GN(32),GN(20)}--dtlk
    Tv={0,0,0}
else
    Tp={GN(21),GN(22),GN(23)}
    Tv={GN(24),GN(25),GN(26)}
end
il=Tp[1]~=0 and Tp[2]~=0
mA=GN(28)
lr=Mf(mA/100000)/50-1
ud=Mf(mA%100000/1000)/50-1
if mA%1000>99 then sA=0.2/zm else sA=1/zm end
rdr=mA%100>9
stb=mA%10>0
ovr=GN(12)%10
--13
sr=GN(27)
gr=GN(30)
rst=GN(14)
if stb then Sx=-GN(10)*1.6 Sy=-GN(11)*0.05 else Sx=0 Sy=0 end
CPMin=PN('-')/360
CPMax=PN('+')/360
wp=GN(29)
if il then
D=dst(Tp,Sp)
arm=D<WP[wp].rg
if arm then
eta=1.56+0.0695*D+9.53E-06*D^2
dP=-1.06E-03-2.08E-05*D-4.21E-09*D^2
for h=1,4 do
A={Tp[1]+Tv[1]*eta,Tp[2]+Tv[2]*eta,Tp[3]+Tv[3]*eta}
A0=A
D=dst(A,Sp) B={GN(1),GN(3),GN(2)}
Aa,Ae=G2CP({A[1]-Sp[1],A[2]-Sp[2],A[3]-Sp[3]})
bZ=WP[wp].v0*V(Ae-dP) bH=WP[wp].v0*U(Ae-dP) bX=bH*V(Aa) bY=bH*U(Aa)
Bv={vW[1]+bX,vW[2]+bY,vW[3]+bZ}
for i=1,WP[wp].lf do
for j=1,3 do B[j]=B[j]+Bv[j]/60
Bv[j]=Bv[j]*WP[wp].dg+Ag[j]
end
PD=dst(B,Sp)
if PD>D then
err=Ma(B[3]-Tp[3],D)
dP=dP+err
eta=i
A={A[1]-(B[1]-A0[1]),A[2]-(B[2]-A0[2]),A[3]-(B[3]-A0[3])}
break
end
end
end
else
dP=0
eta=0
A={Tp[1],Tp[2],Tp[3]}
end
if il then
Ox,Oy=Ox+lr*sA*0.005,Oy+ud*sA*0.005
Ta,Te=G2CP({A[1]-Sp[1],A[2]-Sp[2],A[3]-Sp[3]})
Xg=pid(3,CD(-gC,(Ta+Ox)/P)*P,0,2,0.002,3,0.5,0.05)
Yg=pid(4,gP,(Te+Oy-dP)/P,0,0.2,0.2,0.5,0.25)
Ta,Te=L2AE(G2L({Tp[1]-Sp[1],Tp[2]-Sp[2],Tp[3]-Sp[3]}))
X=-pid(1,(Ta+Ox),0,2,0.002,3,0.5,0.05)
Y=(Te+Oy)/P
elseif not ilo then Te=Y-(dP-dPo)/P*4 Y=Te X=0 end
else
Ox,Oy=0,0
D=0
if stb then
if (not stbo) or ilo then
Ta=-sC Te=gP+dP/P
else
Ta=Ta+lr*sA*0.002 Te=Te+ud*sA*0.001
end
Xg=pid(3,CD(-gC,Ta)*P,0,2,0.002,3,0.5,0.05)
Yg=pid(4,gP,Te,0,0.2,0.2,0.5,0.25)
X=pid(1,CD(-sC,Ta)*P,0,2,0.002,3,0.5,0.05)
Y=(Te-sP)
else
if stbo or ilo then
Ta=sr
Te=Y
else
Ta=(Ta+lr*sA*0.002)*rst Te=Mp(Te+ud*sA*0.001,CPMin,CPMax)*rst
end
Xg=pid(3,CD(gr,Ta)*P,0,2,0.002,3,0.5,0.05)
Yg=Te
X=pid(1,CD(sr,Ta)*P,0,2,0.002,3,0.5,0.05)
Y=Te
end
end
SN(1,0)
SN(2,Y*8)
SN(3,X+Sx)
SN(4,Y*4)
SN(6,Xg+Sx)
SN(7,Mp(Yg*4+Sy,CPMin*4,CPMax*4))
SN(5,500000+Mp(Mf((8*Y+1)*500+0.5),0,999))
SN(11,Tp[1]*ovr)
SN(12,Tp[2]*ovr)
SN(13,Tp[3]*ovr)
SN(14,Tv[1]*ovr)
SN(15,Tv[2]*ovr)
SN(16,Tv[3]*ovr)
SN(21,Tp[1])
SN(22,Tp[2])
SN(23,Tp[3])
stbo=stb
ilo=il
dPo=dP
SB(13,wp>1.5)
end
S=screen
SC=S.setColor
DT=S.drawText
DTB=S.drawTextBox
DL=S.drawLine
function onDraw()
w=S.getWidth() h=S.getHeight()
SC(22,222,22)
DL(w/2-2,h/2,w/2-4,h/2)
DL(w/2+2,h/2,w/2+4,h/2)
DL(w/2,h/2-2,w/2,h/2-4)
DL(w/2,h/2+2,w/2,h/2+4)
DT(19,h-6,string.format('%4.0f',D)..'m')
end