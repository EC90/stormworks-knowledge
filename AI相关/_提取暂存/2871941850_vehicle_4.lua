-- source: steam id 2871941850 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2871941850

aw=.5
aP=9E5
cw=true
ab=nil
t=false
cc=table
ci=math
cP=input
aA=screen
de=aA.setColor
be=cP.getNumber
bg=cP.getBool
cL=ci.min
cu=ci.max
cK=property.getText
az=cc.unpack
function br(ay,an,z)an={}ay.an=an
function ay.aL(dM)z=#an>0 and cc.remove(an)or#ay[1]+1
for _=1,#ay do
ay[_][z]=dM[_]end
return z
end
function ay.bw(bP)an[#an+1]=bP
end
return ay
end
function cS(j)for _=1,j[1]do j[_]={}end
return az(j)end
function bR(cm,j)j=j or{}for ah in cK(cm):gmatch"[+%w.-]+" do
j[#j+1]=tonumber(ah)end
return j
end
function cH(cm,j)j=j or{}for ah in cK(cm):gmatch"[^!]+" do
bR(ah,j)end
return j
end
cY=function(X,aa,Z)local D,aF,I,bz,E,B,C,r,v,af,G,x,ag,u,bn,bA,bt,bD,dp,as,cl,c,e,d,P,y,W,i,f,o,g,k,h,N,ba,a={X,aa,Z},{t,t,0,0,0,0,{},t,1},cS{11}u=br{v,af,E,B,C,r,G,x,ag}u.aL(aF)D.dv=u
D.aN=1
as=function(a,c,e,d)P=E[a]-c
y=B[a]-e
W=C[a]-d
return P*P+y*y+W*W
end
cl=function(a,c,e,d)c=X[a]-c
e=aa[a]-e
d=Z[a]-d
return c*c+e*e+d*d
end
bn=function(M,ai,bu,bp,bY)if r[M]>r[ai]then
M,ai=ai,M
end
k=as(ai,E[M],B[M],C[M])^aw
bu=r[M]bp=r[ai]if k+bu<=bp then
return bp,E[ai],B[ai],C[ai]else
bY=(bu+k+bp)/2
k=(bY-bu)/k
return bY,P*k+E[M],y*k+B[M],W*k+C[M]end
end
bA=function(a,bU)while a do
i=v[a]f=af[a]o=ag[a]ag[a]=cu(ag[i],ag[f])+1
if bU then
if o==ag[a]then
break
end
else
r[a],E[a],B[a],C[a]=bn(i,f)bU=r[a]==I[4]end
c=x[a]if c then
e=x[c]if e then
i=v[c]==a and 2 or 1
d=u[i][c]f=v[e]==c and 2 or 1
o=u[f][e]if bn(o,d,I)/(bU and r[a]or bn(a,d))+ag[o]/ag[a]*aw<1.5 then
x[o]=c
x[a]=e
u[i%2+1][c]=o
u[f][e]=a
bU=t
end
end
end
a=c
end
end
bt=function(h,g,c,e,d)N=0
for _=1,g do
_=h[_]g=cl(_,c,e,d)if g>N then
ba=_
N=g
end
end
return ba,N
end
bD=function(a)h=G[a]g=#h
c=0
e=0
d=0
for b=1,g do
b=h[b]c=c+X[b]e=e+aa[b]d=d+Z[b]end
c=c/g
e=e/g
d=d/g
E[a]=c
B[a]=e
C[a]=d
eb,k=bt(h,g,c,e,d)r[a]=k^aw
end
dp=function(dH,dR)return I[dH]<I[dR]end
D.da=function(z)a=D.aN
h=G[a]c=X[z]e=aa[z]d=Z[z]if h then
if#h==0 then
E[a]=c
B[a]=e
C[a]=d
r[a]=0
end
else
repeat
i=v[a]f=af[a]a=as(i,c,e,d)<as(f,c,e,d)and i or f
h=G[a]until h
end
g=#h+1
h[g]=z
if g==8 then
i=bt(h,7,c,e,d)P=X[i]y=aa[i]W=Z[i]f=bt(h,8,P,y,W)P=P-X[f]y=y-aa[f]W=W-Z[f]for _=1,8 do
_=h[_]I[_]=P*X[_]+y*aa[_]+W*Z[_]end
cc.sort(h,dp)for _=1,8 do
I[h[_]]=ab
end
aF[7]={}for _=5,8 do
aF[7][_-4]=h[_]h[_]=ab
end
i=u.aL(aF)aF[7]=t
f=u.aL(aF)o=x[a]v[f]=a
af[f]=i
x[a]=f
x[i]=f
if o then
x[f]=o
u[v[o]==a and 1 or 2][o]=f
else
D.aN=f
end
bD(a)bD(i)bA(f)else
k=as(a,c,e,d)^aw
if r[a]<k then
r[a]=k
bD(a)bA(x[a])end
end
end
D.dC=function(z)D.dm(X[z],aa[z],Z[z])a=o
h=G[a]g=#h
if g==1 then
i=x[a]if i then
u.bw(a)u.bw(i)G[a]=t
f=x[i]o=u[v[i]==a and 2 or 1][i]x[o]=f
if f then
u[v[f]==i and 1 or 2][f]=o
bA(f)else
D.aN=o
end
end
else
for _=1,g-1 do
if h[_]==z then
h[_]=h[g]end
end
end
h[g]=ab
end
D.dm=function(c,e,d,H,bQ)I[1]=D.aN
bz[1]=0
g=1
N=1e300
ba=-1
while g>0 do
a=I[g]k=bz[g]g=g-1
::dN::
h=G[a]H=N+r[a]if k<H*H then
if h then
for _=1,#h do
_=h[_]H=cl(_,c,e,d)^aw
if H<N then
ba=_
N=H
o=a
end
end
else
i=v[a]f=af[a]g=g+1
H=as(i,c,e,d)bQ=as(f,c,e,d)if H<bQ then
a=i
k=H
I[g]=f
bz[g]=bQ
else
a=f
k=bQ
I[g]=i
bz[g]=H
end
goto dN
end
end
end
return N,ba
end
return D
end
local F,w,J,aQ,aB,aH,df,bN,bF,bK,ca,cn,by,bJ,bH,cv,bW,cy,ct,cz,bd,bv,A,V,aK,aT,aM,aS,R,bl,q,T,bi,bV,bB,bT,bX,cr,ar,cB,v,af,E,B,C,r,G,n,l,m
aJ,S,cf,L,ds,dy=cH "S",cH "O",bR "HMD",{0,0,0},bR "W",bR "G"
function T(di,ak)return F[di]-F[ak],J[di]-J[ak]end
function bi(c,e,d,al)bd[1]=c
bd[2]=e
bd[3]=d
al=ct.aL(bd)cz.da(al)return al
end
function bV(n,l,m,au,av,ao,ax,bZ)au,av=T(n,m)ao,ax=T(l,m)bZ=au*ax-av*ao<0
aT[1]=bZ and n or l
aT[2]=bZ and l or n
aT[3]=m
return V.aL(aT)end
function cE()F,w,J,aQ,aB,aH,df,bN,bF,bK,ca,cn,by,bJ,bH,cv,bW,cy,bO,bL,cg,cN,dl,cd,bS,bC,bM,bx,cO,dd,dg,cD,ck,bc,aU,bk,aO,bj,bh,aS,ce,cJ,aI,cx,bl,q=cS{47}ar={bc,aU,bk,aO,bj,bh}ct=br{F,w,J,aQ,aB,aH,df,bN,bF}cz=cY(F,w,J)bd={0,0,0,1,0,0,0,t,0}bv=br{bK,ca,cn,by,bJ,bH,cv,bW,cy}A={0,0,0,0,0,0,0,0,0}V=br{bO,bL,cg,cN,dl,cd,bS,bC,bM}aK={cN,dl,cd}aT={0,0,0,t,t,t,t,t,t}aV=0
aR=0
ae=0
bf=0
dk=0
dU=0
aW=0
cj=0
bq=0
bi(-aP,0,-aP)bi(aP,0,-aP)bi(0,0,aP)bV(1,2,3)aM=cY(cv,bW,cy)v,af,E,B,C,r,G=az(aM.dv)function dQ(a,am,aq,at,ad,ak,k)while R>0 and bG<cj do
bG=bG+1
a=aS[R]R=R-1
am=E[a]aq=B[a]at=C[a]ad=-r[a]k=am*bj[1]+aq*bj[2]+at*bj[3]+bj[4]if not((k<ad)or(am*bc[1]+aq*bc[2]+at*bc[3]+bc[4]<ad)or(am*aU[1]+aq*aU[2]+at*aU[3]+aU[4]<ad)or(am*bk[1]+aq*bk[2]+at*bk[3]+bk[4]<ad)or(am*aO[1]+aq*aO[2]+at*aO[3]+aO[4]<ad)or(am*bh[1]+aq*bh[2]+at*bh[3]+bh[4]<ad))then
ak=G[a]if ak then
for _=1,cL(#ak,ci.ceil(cB*ad/k/S[6]*#ak))do
aW=aW+1
cx[aW]=ak[_]end
else
R=R+2
aS[R-1]=v[a]aS[R]=af[a]end
end
end
end
end
cE()function dW(n,l,m,cb)au,av=T(n,cb)ao,ax=T(l,cb)Y,U=T(m,cb)return(au*au+av*av)*(ao*U-Y*ax)+(ao*ao+ax*ax)*(Y*av-au*U)+(Y*Y+U*U)*(au*ax-ao*av)end
function dJ(n,l,m)d_,cX=T(l,n)cI,cC=T(m,l)cU,cQ=T(n,m)ac=d_*d_+cX*cX
Q=cI*cI+cC*cC
aj=cU*cU+cQ*cQ
A[1]=ac
A[2]=Q
A[3]=aj
bE=(ac>=Q and ac>=aj)and 1 or(Q>=ac and Q>=aj)and 2 or 3
return(A[bE]>A[bE%3+1]+A[(bE+1)%3+1])and(A[bE]/4)or(ac*Q*aj/(2*(ac*(Q+aj)+Q*aj)-ac*ac-Q*Q-aj*aj))end
function dD(aE,dI)local al,p,aC,aX,bI,s,O,bm,aZ,aD,ap
bx[1]=aQ[aE]bS[bx[1]]=aV
bm=1
aZ=1
aD=0
al=bi(az(dI))repeat
s=bx[bm]if dW(bO[s],bL[s],cg[s],al)<=0 then
bC[s]=cw
aD=aD+1
cO[aD]=s
end
if bC[s]or aD==0 then
for _=1,3 do
O=aK[_][s]if O and(bS[O]~=aV)then
aZ=aZ+1
bx[aZ]=O
bS[O]=aV
end
end
end
bm=bm+1
until aZ<bm
ap=0
for _=1,aD do
s=cO[_]for b=1,3 do
O=aK[b][s]if not(O and bC[O])then
ap=ap+1
dd[ap]=O
dg[ap]=V[b%3+1][s]cD[ap]=V[(b+1)%3+1][s]end
end
if bM[s]then
_=bM[s]bf=bf+1
ce[bf]=_
if aI[_]then
aI[_]=ab
else
aI[_]=t
end
end
V.bw(s)end
for _=1,ap do
p=bV(dg[_],cD[_],al)aC=dd[_]cd[p]=aC
if aC then
for b=1,3 do
if not(bO[p]==V[b][aC]or bL[p]==V[b][aC])then
aK[b][aC]=p
break
end
end
end
for b=1,2 do
aX=V[b][p]bI=ck[aX]if bI then
aK[b%2+1][p]=bI
aK[b][bI]=p
ck[aX]=ab
else
ck[aX]=p
aQ[aX]=p
end
end
n=bO[p]l=bL[p]m=cg[p]if dJ(n,l,m)<S[3]then
ch=(w[n]+w[l]+w[m])<0 and ds or dy
dc=F[n]-F[l]cV=w[n]-w[l]cW=J[n]-J[l]dq=F[l]-F[m]db=w[l]-w[m]dh=J[l]-J[m]Y=cV*dh-cW*db
U=cW*dq-dc*dh
cF=dc*db-cV*dq
bo=(Y*Y+U*U+cF*cF)^aw
j=cL(U/bo,.99)*(#ch/3-1)dt=(Y*.28+U*.96)/bo
_=j//1
j=(j-_)^2
dA=1-j
for b=1,3 do
A[b]=V[b][p]bP=3*_+b
A[b+3]=(ch[bP]*dA+ch[bP+3]*j)*dt//1
c_=ct[b]A[b+6]=(c_[n]+c_[l]+c_[m])/3
end
j=bv.aL(A)aI[j]=cw
bM[p]=j
end
end
aQ[al]=p
aV=aV+1
end
dY=function()local dZ,dP,dz,ea,dr,dX,dT,du,dS,dF,dG,dw,dx,e_,dE,dK,cZ,K,aG,_,d,ah,b_,aY,bb=az(bl)_=1
while _<=ae do
cZ=q[_]aG=cw
for b=1,3 do
K=bv[b][cZ]if bF[K]~=aR then
bF[K]=aR
b_=F[K]aY=w[K]bb=J[K]d=dz*b_+dT*aY+dG*bb+dE
ah=ea*b_+du*aY+dw*bb+dK
aG=0<=d and d<=ah
bN[K]=aG
if aG then
aB[K]=(dZ*b_+dr*aY+dS*bb+dx)/ah*bB+bX
aH[K]=(dP*b_+dX*aY+dF*bb+e_)/ah*bT+cr
else
break
end
elseif not bN[K]then
aG=t
break
end
end
if aG then
_=_+1
else
q[_]=q[ae]q[ae]=ab
ae=ae-1
end
end
_=S[1]if _<#q then
for b=1,(#q-_)//2,2 do
q[b%_]=q[_+b*2]end
for b=_+1,#q do
q[b]=ab
end
end
ae=#q
end
cG=S[2]<2 and 1 or S[2]-1
function onTick()bs=bg(1)if bg(3)then
cE()end
dV=bg(4)cp=bg(5)if cp then
cR,cs,bB,bT,bX,cr,cB=az(cf)else
cR=aJ[1]cs=aJ[2]bB=cR/2
bT=cs/2
bX=bB+aJ[9]cr=bT+aJ[10]cB=-(aJ[3]+.635)/aJ[6]*cs
end
dL=bg(6)if bs then
for _=1,16 do
bl[_]=be(_)end
for _=1,6 do
for b=1,4 do
ar[_][b]=bl[b*4]+bl[(b-1)*4+(_+1)//2]*(_%2*2-1)end
bo=(ar[_][1]^2+ar[_][2]^2+ar[_][3]^2)^aw
for b=1,4 do
ar[_][b]=ar[_][b]/bo
end
end
dO=be(32)end
for _=17,29,3 do
L[1]=be(_)L[2]=cu(be(_+1),S[7])L[3]=be(_+2)if L[1]~=0 and L[2]~=0 then
k,aE=cz.dm(az(L))y=L[2]-w[aE]y=y^2+1
if k>cu(S[4],(w[aE]>0 and 0>L[2]or L[2]>0 and 0>w[aE])and 0 or S[5]-y^2)then
dD(aE,L)end
end
end
dj=aR%S[2]==0
if dj then
for _=1,dk do
bv.bw(cJ[_])end
cJ=ce
dk=bf
ce={}bf=0
for cq,dB in pairs(aI)do
if dB then
aM.da(cq)else
aM.dC(cq)end
aI[cq]=ab
end
cT=bs
end
if bs and(dj or not cT)then
q=cx
ae=aW
dU=#q
cx={}aW=0
R=1
aS[1]=aM.aN
cj=9+(cT and(.3*cj+.7*bq//cG)or(#v//cG))//1
bq=0
end
aR=aR+1
end
function onDraw(dn,cA,co)cM=aA.getWidth()==cf[1]and aA.getHeight()==cf[2]if bs and(dL or(cp and cM)or not cp and not cM)then
bG=0
dQ()bq=bq+bG
co=0
dn=dV and aA.drawTriangle or aA.drawTriangleF
dY()for _=1,ae do
_=q[_]n=bK[_]l=ca[_]m=cn[_]cA=(by[_]&15)<<16|(bJ[_]&15)<<8|bH[_]&15
if co~=cA then
co=cA
de(by[_],bJ[_],bH[_],dO)end
dn(aB[n],aH[n],aB[l],aH[l],aB[m],aH[m])end
de(0,255,0)aA.drawText(2,2,#bK.."/"..#q)end
end
