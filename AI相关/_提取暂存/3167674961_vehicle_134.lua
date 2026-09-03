-- source: steam id 3167674961 / vehicle.xml block#134
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
J=true
am=input
X=output
ad=X.setBool
h=X.setNumber
c=am.getNumber
g=property.getNumber
j,W,A,z,x,T,H,V,ao,aS,ab,Q,C,av,aq,M,l,aL,i,E,an,aF,au,N,Z=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
e=math
atan=e.atan
sin=e.sin
asin=e.asin
cos=e.cos
sqrt=e.sqrt
pi=e.pi
abs=e.abs
max=e.max
min=e.min
t=2*pi
aE=g("Terminal Yaw Sensitivity")ax=g("Cruise Yaw Sensitivity")I=g("Minimum Distance [M]")ah=g("Guidance Delay [S]")aH=g("Default Scan Speed")aC=g("Default Target Depth [M]")aO=g("Default Scan FOV")aa=g("Guidance Type")V=g("PN Terminal Multiplier")function U(P,O,K,aD,aQ)return((P+atan(O-K,aD-aQ)/t+.5)%1-.5)end
function v(P,O,K)return min(max(P,O),K)end
function onTick()local d={_=c(1),a=c(3),b=c(2)}local ai,at,ak=c(4),c(5),c(6)local k,p=cos(ai),sin(ai)local s,o=cos(at),sin(at)local m,q=cos(ak),sin(ak)local r={_=s*m,a=-o,b=s*q}local n={_=p*q+k*o*m,a=k*s,b=-p*m+k*o*q}local S={_=-k*q+p*o*m,a=p*s,b=k*m+p*o*q}aw=am.getBool(1)D=c(10)B=c(11)ap=c(12)u=c(13)W=c(14)aF=c(15)au=c(16)ao=c(17)ay=c(18)w=((atan(n.b,sqrt((n._^2)+(n.a^2)))/t))*10
ae=((atan(r.b,sqrt((r._^2)+(r.a^2)))/t))*-1
ar=abs(ae)aA=sqrt((D-d._)^2+(B-d.a)^2)y=atan(p*q+k*o*m,k*s)/-t
if aw then
al=-aC
if ap<0 and aR then
al=ap
end
G=(al)-d.b
aB=G*.08
aN=(G-av)*3.3
av=G
aI=aB+aN
F=-ae
aK=F*-2.1
M=M+F*-.075
az=(F-aq)*-4.5
aq=F
aP=aK+M+az
if d.b<0 then
Q=v(Q+(1/60),0,ah)if D+B==0 then
Y=y*-t
aJ=d._
aG=d.a
D=sin(Y)*15000+aJ
B=cos(Y)*15000+aG
aM=J
end
if Q==ah then
af=J
end
end
if(((I>=aA)or aM)and af)and aa~=2 then
ac=aE
j=v(j+T,z,A)if j>=A then
j=z
i=e.huge
aL=l
l=0
else
if(u<=i and u<I)and ar<.01 then
i=u
l=W
f={_=i*cos(w)*sin(-l),a=i*cos(w)*cos(-l),b=i*sin(w)}ag={_=d._+r._*f._+n._*f.a+S._*f.b,a=d.a+r.a*f._+n.a*f.a+S.a*f.b,b=d.b+r.b*f._+n.b*f.a+S.b*f.b}R=ag._
L=ag.a
end
end
else
R=D
L=B
aj=false
ac=ax
end
x,T=aO,aH
if aa==0 then
N=(U(y,R,d._,L,d.a)*-4)-H
if I<u then
C=v(C+1,0,100)else
C=0
end
if C~=100 then
x,T=.05,.02
end
if j==z or j==A then
as=l+y
E=as-an
an=au
Z=E-ab
ab=ao
end
end
z,A=N-x,N+x
H=U(y,R,d._,L,d.a)*(ac*(1-v(ar*15,0,1)))+((E-Z)*V)
end
h(1,H)h(2,aI)h(3,aP)h(4,j)h(5,w)h(6,as)h(7,l)h(8,E)ad(1,aw and d.b<0 and c(9)<10)ad(2,(u<1 or (abs(ay)>.4  and abs(H)<1)) and i~=0) end
