-- source: steam id 3415220818 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3415220818
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 7738 (8098 with comment) chars
cn="Bar Text"
cm="Horizon Line"
cl="Compass Wheel"
ck="Text Background"
cj="Speed Text"
ci="Velocity Vector"
ch="0x"
cg="Ground"
cf="Speed Wheel Text"
ce="Altitude Text"
cd="Altitude Wheel Text"
cc="Sky"
cb="%02d"
ca="Bar"
c_="Wheel Background"
bZ="Vertical Speed Background"
bY="Speed Indicator Outline"
bX="Compass Text"
bW="Compass Outline"
bV="Altitude Indicator Outline"
bU=" Color"
bT="%d+"
bS="Steering Bar"
bR="Vertical Speed"
bQ=""

Q=220
t=150
s=255
p=tostring
ba=tonumber
aG=ipairs
aN=property
bb=input
G=math
aH=string
F=screen
R=F.drawRect
b_=aH.format
bc=aH.sub
m=F.drawRectF
r=F.drawLine
o=G.abs
aQ=F.getWidth
f=G.floor
w=G.pi
aJ=G.sqrt
P=G.atan
O=G.sin
ae=G.cos
A=bb.getNumber
aA=F.setColor
aY=table.insert
aZ=aH.gmatch
l=aN.getBool
y=aN.getNumber
aC=aN.getText
bH={{{-11,0,-4,0},{11,0,4,0},{-1,0,2,0},{-4,0,-4,2},{4,0,4,2}},{{-9,0,-4,0},{-4,1,-2,3},{-3,2,0,-1},{0,-1,3,2},{3,2,5,0},{5,0,10,0}}}function x(b,bd,bh)if b<bd then return bd elseif b>bh then return bh else return b end
end
local aI,aE,_=aC("f"),{},1
while _<#aI do
_=_+1
aF={}for aW=1,ch..aI:sub(_-1,_-1)do
aw=ch..aI:sub(_,_+2)aF[#aF+1]={aw>>8,(aw>>3)&7,(aw>>6)&3,aw&7}_=_+3
end
aE[#aE+1]=aF
end
aR=0
bN=0
ar=y("Speed Units")ax=1
ag=bQ
if ar==1 then
ax=1.94384
ag="KN"
elseif ar==2 then
ax=2.23694
ag="MPH"
elseif ar==3 then
ax=3.6
ag="KMH"
elseif ar==4 then
ag="m/s"
end
bK={{{4,8},{5,1},{3,7},{6,2},{5,29},{7,31},{6,10},{14,18},{22,26},{8,12},{16,20},{24,28}},{{5,29},{7,31},{6,10},{14,18},{22,26},{8,12},{16,20},{24,28}},{{31,25},{30,34},{36,32},{5,29},{7,31},{6,10},{14,18},{22,26},{8,12},{16,20},{24,28}},{{31,25},{30,34},{36,32},{4,08},{5,01},{3,07},{6,02},{5,29},{7,31},{6,10},{14,18},{22,26},{08,12},{16,20},{24,28}}}bF={{15,3},{15,0},{12,0},{11,0},{9,0},{8,0},{5,0},{4,0},{1,0},{21,1},{20,6},{20,-6}}j,h=64,64
a=y("Font")bv=bK[y("Bar Style")]ad=y("Draw Bars")aV=y("Show Angle Text")bE=bH[y("Steering Bar Style")]bt=y("Altitude Units")bi=l("Vertical Speed Indicator")bo=l("Vertical Speed Dynamic Color")bA=l(ci)bL=l("Bar Fade")bw=l("Compass")S=l(cl)as=l("Altitude Wheel")an=l("Speed Wheel")v=y("Bottom Padding (px)")z=y("Top Padding (px)")bI=y("Vertical Speed Factor")aL=l("Speed Indicator")az=l("Altitude Indicator")bD=l("Speed Wheel Fade")bJ=l("Altitude Wheel Fade")bC=l("Compass Wheel Fade")bx=l(cm)aD=l("Show Speed Units")aB=l("Show Altitude Units")D=l("Compass Position")bu=l("Outline Speed Indicator")bm=l("Outline Altitude Indicator")bG=l("Outline Compass")bq={cc,cg,cn,cj,cf,ce,cd,bX,cl,bS,ca,c_,ck,bZ,bR,ci,cm,bY,bV,bW}bf={}for W,i in aG(bq)do
ao={}for aM in aZ(aC(i..bU),bT)do
aY(ao,x(ba(aM),0,s))end
if#ao<3 then ao={s,0,s}end
au={}for aM in aZ(aC("Night "..i..bU),bT)do
aY(au,x(ba(aM),0,s))end
if#au<3 then au={s,0,s}end
bf[i]={ao,au}end
function setColor(bz,U)C=bf[bz]if br then
C=C[2]else
C=C[1]end
bO=U or s
if not U then
if#C>=4 then
U=C[4]else
U=s
end
end
aA(C[1],C[2],C[3],U)end
function onTick()u=A(2)br=bb.getBool(1)b=A(4)d=A(5)aT=A(6)af,ac=ae(b),O(b)ap,aa=ae(d),O(d)ab,Y=ae(aT),O(aT)bM=ac*Y+af*aa*ab
by=P(ap*Y,aJ((ap*ab)^2+aa^2))/w*2
bs=P(af*ab+ac*aa*Y,aJ((-af*Y+ac*aa*ab)^2+(ac*ap)^2))/w*2
H=-P(-ac*ab+af*aa*Y,aJ(bM^2+(af*ap)^2))V=P(O(by),O(bs))+w/2
av=(A(17)*w*-2)*(180/w)%360
bB=A(7)bp=A(8)be=A(9)B=A(13)bl=B
B=B*ax
ai=(aR-u)*bI*-60
aR=u
if bi then
k=-1
else k=0 end
if bt==1 then
u=u*3.28084+.5
ah=f(u)at="ft"
if u>7500 then
at="fl"
ah=f(u/100)end
else
at="M"
ah=f(u+.5)end
c={}ay=ae(V)aj=O(V)al=ae(-V)aq=O(-V)for _=ad,18,ad do
c[_]={}for W,i in aG(bF)do
bk=(_*(w/18)-H)*t
aU=(-_*(w/18)-H)*t
for K=-1,1,2 do
bg=G.max(K,0)c[_][(W-1)*4+2+K]={b=f(j/2-1+(ay*(aU+i[2]))+aq*-K*i[1]+bg),d=f(h/2+(aj*(aU+i[2]))+al*-K*i[1])}c[_][(W-1)*4+3+K]={b=f(j/2-1+(ay*(bk-i[2]))+aq*-K*i[1]+bg),d=f(h/2+(aj*(bk-i[2]))+al*-K*i[1])}end
end
end
end
function onDraw()if aQ()~=0 then
j,h=aQ(),F.getHeight()end
g=j/2-1
e=(z/2)+((h-v)/2)q={{},{}}q[1].d=e+(aj*(-H*t))+al*200
q[2].d=e+(aj*(-H*t))+al*-200
q[1].b=g+(ay*(-H*t))+aq*200
q[2].b=g+(ay*(-H*t))+aq*-200
aX=(q[2].d-q[1].d)/(q[2].b-q[1].b)i=((g-q[1].b)*aX)+q[1].d
aK=1
if o(V-w/2)>w/2 then aK=-1 end
for _=0,j-1 do
aP=aX*(_-g)+i
setColor(cc)r(_,aP,_,-1000*aK)setColor(cg)r(_,aP,_,1000*aK)end
if bx then
setColor(cm)r(q[1].b,q[1].d,q[2].b,q[2].d)end
if ad>0 then
for _=ad,18,ad do
if _~=9 then
if bL then
Z=o((o(_)*(w/18)-o(H))*t)*1.5
else
Z=0
end
setColor(ca,x(Q-Z,0,Q))for W,i in aG(bv)do
r(c[_][i[1]].b,c[_][i[1]].d,c[_][i[2]].b,c[_][i[2]].d)end
if aV>0 then
M=bQ
if(_%1)==0 then
M=p(o(f(-o(-_+9)+9)))end
if aV==2 then
M=p(o(f((-o(-_+9)+9)*10)))end
setColor(cn,x(Q-Z,0,Q))aS=M:len()n(c[_][37].b-(aS-1)*a,c[_][37].d-2,M)n(c[_][38].b-(aS-1)*a,c[_][38].d-2,M)n(c[_][39].b-3,c[_][39].d-2,M)n(c[_][40].b-3,c[_][40].d-2,M)end
elseif _==9 then
Z=o((o(_)*(w/18)-o(H))*t)*1.5
setColor(ca,x(Q-Z,0,Q))r(c[_][41].b,c[_][41].d,c[_][47].b,c[_][47].d)r(c[_][42].b,c[_][42].d,c[_][48].b,c[_][48].d)r(c[_][43].b,c[_][43].d,c[_][45].b,c[_][45].d)r(c[_][44].b,c[_][44].d,c[_][46].b,c[_][46].d)end
end
end
if bA then
N=P(bB,be)*h
I=-P(bp,be)*h
setColor(ci)if bl>1 then
F.drawCircle(g+N-1,e+I,3)r(g-4+N,e+I,g-7+N,e+I)r(g+N-1,e-3+I,g+N-1,e-5+I)r(g+2+N,e+I,g+5+N,e+I)end
end
setColor(bS)for W,i in pairs(bE)do
r(g+i[1],e+i[2],g+i[3],e+i[4])end
setColor(c_)if an and aL then
m(0,6,a*2+1,h-12-v)end
if as and az then
m(j-(a*2)-1+k,6,(a*2)+1-k,h-12)end
if S then
if D then
m((a*2)+1,z,j-((a*2)+1)*2+k,6)else
m((a*2)+1,h-6-v,j-((a*2)+1)*2+k,6)end
end
if(S and not D)or an then
m(0,h-6-v,(a*2)+1,6)end
if(S and not D)or as then
m(j-(a*2)-1+k,h-6-v,(a*2)+1-k,6)end
if(S and D)or an then
m(0,z,(a*2)+1,6)end
if(S and D)or as then
m(j-(a*2)-1+k,z,(a*2)+1-k,6)end
if an and aL then
for _=f((B-(h/32*20))/10)*10,f((B+(h/32*20))/10)*10,10 do
E=x(((o(1/(_-B))*(h/64))^1.5*6000-20),0,s)if not bD then
E=s
end
setColor(cf,E)bn=bc(b_(cb,f(_)),1,2)if _>=0 then n(1,(e-2+(B-_)),p(bn))end
end
end
if as and az then
for _=f((u-(h/32*20))/10)*10,f((u+(h/32*20))/10)*10,10 do
E=x(((o(1/(_-u))*(h/64))^1.5*6000-20),0,s)if not bJ then
E=s
end
setColor(cd,E)bP=bc(b_(cb,f(_)),1,2)if _>=0 then n(j-(a*2)+k,(e-2+(u-_)),p(_))end
end
end
if S then
for _=-360,720,10 do
L=_-av
E=x(t-(o(L)*4.5/(j/64)),0,t)if not bC then
E=s
end
setColor(cl,E)J=h-6-v
if D then
J=z
end
if _==0 or _==360 then
n(g+L-(a-3),J,"N")elseif _==90 then
n(g+L-(a-3),J,"E")elseif _==180 then
n(g+L-(a-3),J,"S")elseif _==270 then
n(g+L-(a-3),J,"W")else
r(g+L,J+6,g+L,J)end
end
end
if aL then
setColor(ck)if aD then
m(0,e-6,1+(a*3),13)else
m(0,e-3,1+(a*3),7)end
if bu then
setColor(bY)if aD then
R(-1,e-7,2+(a*3),14)else
R(-1,e-4,2+(a*3),8)end
end
setColor(cj)if aD then
n(1,e-5,p(f(B)))n(1,e+1,ag)else
n(1,e-2,p(f(B)))end
end
if az then
setColor(ck)if aB then
m(j-(1+(a*4))+k,e-6,(1+(a*4))-k,13)else
m(j-(1+(a*4))+k,e-3,(1+(a*4))-k,7)end
if bm then
setColor(bV)if aB then
R(j-(2+(a*4))+k,e-7,(2+(a*4))-k,14)else
R(j-(2+(a*4))+k,e-4,(2+(a*4))-k,8)end
end
bj=p(f(ah)):len()setColor(ce)if aB then
n(j-(bj*a)+k,e-5,p(ah))n(j-(a*at:len())+k,e+1,p(at))else
n(j-(bj*a)+k,e-2,p(ah))end
end
if bw then
setColor(ck)am=0
if D then
m(g-f(((a*3)/2))-(a-4)+am,z,(a*3)+1,7)else
m(g-f(((a*3)/2))-(a-4)+am,h-7-v,(a*3)+1,7)end
if bG then
setColor(bW)if D then
R(g-f(((a*3)/2))-(a-3)+am,z-1,(a*3)+2,8)else
R(g-f(((a*3)/2))-(a-3)+am,h-8-v,(a*3)+2,8)end
end
setColor(bX)aO=p(f(av+.5)):len()if D then
n(g-(aO*(a/2))+1,z+1,p(f(av+.5)))else
n(g-(aO*(a/2))+1,h-6-v,p(f(av+.5)))end
end
if bi then
setColor(bZ)m(j-1,0,1,h)if o(ai)>1 then
setColor(bR)if bo then
aA(x(o(ai)*2-30,0,t),t-x(o(ai)*2-30,0,t),0)end
m(j-1,e,1,-ai/3*(h/64))end
end
aA(0,0,0)m(0,h-v,j,v)m(0,0,j,z)end
function n(b,d,X)b,d=f(b),f(d)X=p(X)if a==4 then
for _=1,#X do
T=X:sub(_,_):upper():byte()-31
T=aE[T>65 and T-26 or T]for aW=1,#T do
ak=T[aW]r(b+ak[1],d+ak[2],b+ak[3],d+ak[4])end
b=b+4
end
elseif a==5 then
F.drawText(b,d,X)end
end
