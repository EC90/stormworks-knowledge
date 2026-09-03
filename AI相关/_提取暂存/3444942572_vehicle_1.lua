-- source: steam id 3444942572 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3444942572
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 6901 (7261 with comment) chars
co="%d+"
cn="Sky"
cm="Bar Text"
cl="0x"
ck="Text Background"
cj="Altitude Indicator Outline"
ci="Compass Outline"
ch="Bar"
cg="Ground"
cf="%"
ce="%02d"
cd="Speed Wheel Text"
cc="Vertical Speed Background"
cb="Velocity Vector"
ca="Horizon Line"
c_="Altitude Text"
bZ="Compass Wheel"
bY="Wheel Background"
bX="Speed Indicator Outline"
bW="Steering Bar"
bV="Altitude Wheel Text"
bU="Vertical Speed"
bT="Compass Text"
bS=" Color"
bR="Speed Text"

B=150
u=255
s=tostring
bb=tonumber
aF=ipairs
aB=property
aV=input
aT=output
t=math
aC=string
x=screen
at=x.drawRect
bf=aC.format
aU=aC.sub
p=x.drawRectF
n=x.drawLine
y=t.abs
aX=x.getWidth
E=t.tan
aw=aT.setNumber
aE=aT.setBool
I=aV.getBool
f=t.floor
q=t.pi
aA=t.sqrt
N=t.atan
C=t.sin
W=t.cos
r=aV.getNumber
J=x.setColor
av=table.insert
bg=aC.gmatch
H=aB.getBool
G=aB.getNumber
aH=aB.getText
bq={{{-11,0,-4,0},{11,0,4,0},{-1,0,2,0},{-4,0,-4,2},{4,0,4,2}},{{-9,0,-4,0},{-4,1,-2,3},{-3,2,0,-1},{0,-1,3,2},{3,2,5,0},{5,0,10,0}},{{-6,-6,-2,-2},{6,-6,2,-2},{-6,6,-2,2},{6,6,2,2}}}function v(a,aW,bh)if a<aW then return aW elseif a>bh then return bh else return a end
end
local au,aG,_=aH("f"),{},1
while _<#au do
_=_+1
ay={}for aY=1,cl..au:sub(_-1,_-1)do
ah=cl..au:sub(_,_+2)ay[#ay+1]={ah>>8,(ah>>3)&7,(ah>>6)&3,ah&7}_=_+3
end
aG[#aG+1]=ay
end
aZ=0
bL=0
an=G("Speed Units")ag=1
T=""
if an==1 then
ag=1.94384
T="KN"
elseif an==2 then
ag=2.23694
T="MPH"
elseif an==3 then
ag=3.6
T="KMH"
elseif an==4 then
T="m/s"
end
bo={{{4,8},{5,1},{3,7},{6,2},{5,29},{7,31},{6,10},{14,18},{22,26},{8,12},{16,20},{24,28}},{{5,29},{7,31},{6,10},{14,18},{22,26},{8,12},{16,20},{24,28}},{{31,25},{30,34},{36,32},{5,29},{7,31},{6,10},{14,18},{22,26},{8,12},{16,20},{24,28}},{{31,25},{30,34},{36,32},{4,8},{5,1},{3,7},{6,2},{5,29},{7,31},{6,10},{14,18},{22,26},{8,12},{16,20},{24,28}}}bA={{15,3},{15,0},{12,0},{11,0},{9,0},{8,0},{5,0},{4,0},{1,0},{21,1},{20,6},{20,-6}}k,g=64,64
b=G("Font")bH=bo[G("Bar Style")]bO=G("Show Angle Text")bs=bq[G("Steering Bar Style")]bD=G("Altitude Units")bF=H("Vertical Speed Dynamic Color")bv=G("Vertical Speed Factor")bQ=H("Compass Wheel Fade")bN=H(ca)bu=H("Outline Speed Indicator")bz=H("Outline Altitude Indicator")bi=H("Outline Compass")bx={cn,cg,cm,bR,cd,c_,bV,bT,bZ,bW,ch,bY,ck,cc,bU,cb,ca,bX,cj,ci}aN={}for ad,e in aF(bx)do
aq={}for aD in bg(aH(e..bS),co)do
av(aq,v(bb(aD),0,u))end
if#aq<3 then aq={u,0,u}end
al={}for aD in bg(aH("Night "..e..bS),co)do
av(al,v(bb(aD),0,u))end
if#al<3 then al={u,0,u}end
aN[e]={aq,al}end
function setColor(bt,ab)w=aN[bt]if bE then
w=w[2]else
w=w[1]end
bM=ab or u
if not ab then
if#w>=4 then
ab=w[4]else
ab=u
end
end
J(w[1],w[2],w[3],ab)end
z=.1
function onTick()o=r(2)bE=false
a=r(4)d=r(5)bc=r(6)U,S=W(a),C(a)ae,Y=W(d),C(d)ac,Z=W(bc),C(bc)bJ=S*Z+U*Y*ac
bw=N(ae*Z,aA((ae*ac)^2+Y^2))/q*2
bm=N(U*ac+S*Y*Z,aA((-U*Z+S*Y*ac)^2+(S*ae)^2))/q*2
R=-N(-S*ac+U*Y*Z,aA(bJ^2+(U*ae)^2))Q=N(C(bw),C(bm))+q/2
az=(r(17)*q*-2)*(180/q)%360
bB=r(7)bp=r(8)bd=r(9)ba=r(13)V=ba*ag
as=(aZ-o)*bv*-60
aZ=o
l=-1
if bD==1 then
o=o*3.28084+.5
af=f(o)ai="ft"
if o>7500 then
ai="fl"
af=f(o/100)end
else
ai="M"
af=f(o+.5)end
aJ=I(3)bn=I(7)by=I(1)bj=I(2)br=I(5)b_=I(4)aQ=r(14)bK=r(20)aE(1,aJ)aE(2,br)aE(3,bn and aJ)if by then
z=v((z+.025),0,1)elseif bj then
z=v((z-.025),0,1)end
aw(3,z)bG=z*(.025-2.2)+2.2
O=E((z*(.025-2.2)+2.2)/2)aw(2,0)P=0
if b_ then
aw(2,R/q/2*8)P=v(R,-q/4,q/4)end
L=1
if t.deg(bG)<45 then
L=.5
end
c={}ao=W(Q)ap=C(Q)ar=W(-Q)aj=C(-Q)for _=L,9,L do
c[_]={}for ad,e in aF(bA)do
aO=-g/2*(E(-_*(q/18)+(R-P))/O)aS=-g/2*(E(_*(q/18)+(R-P))/O)for F=-1,1,2 do
aL=t.max(F,0)c[_][(ad-1)*4+2+F]={a=f(k/2-1+(ao*(aS+e[2]))+aj*-F*e[1]+aL),d=f(g/2-1+(ap*(aS+e[2]))+ar*-F*e[1])}c[_][(ad-1)*4+3+F]={a=f(k/2-1+(ao*(aO-e[2]))+aj*-F*e[1]+aL),d=f(g/2-1+(ap*(aO-e[2]))+ar*-F*e[1])}end
end
end
end
function onDraw()if aX()~=0 then
k,g=aX(),x.getHeight()end
h=k/2-1
i=((g)/2)m={{},{}}am=-g/2*(E(R-P)/O)m[1].d=i+(ap*(am))+ar*15
m[2].d=i+(ap*(am))+ar*-15
m[1].a=h+(ao*(am))+aj*15
m[2].a=h+(ao*(am))+aj*-15
aR=(m[2].d-m[1].d)/(m[2].a-m[1].a)e=((h-m[1].a)*aR)+m[1].d
aI=1
if y(Q-q/2)>q/2 then aI=-1 end
for _=0,k-1 do
aP=aR*(_-h)+e
setColor(cn)n(_,aP,_,-1000*aI)setColor(cg)n(_,aP,_,1000*aI)end
setColor(ch)n(m[1].a,m[1].d,m[2].a,m[2].d)if L>0 then
bI={}for _=L,9,L do
av(bI,_)if _%9~=0 then
for ad,e in aF(bH)do
n(c[_][e[1]].a,c[_][e[1]].d,c[_][e[2]].a,c[_][e[2]].d)end
if(_%1)==0 then
aa=s(y(f(-y(-_+9)+9)))setColor(cm)aM=aa:len()j(c[_][37].a-(aM-1)*b,c[_][37].d-2,aa)j(c[_][38].a-(aM-1)*b,c[_][38].d-2,aa)j(c[_][39].a-3,c[_][39].d-2,aa)j(c[_][40].a-3,c[_][40].d-2,aa)end
elseif _==9 then
n(c[_][41].a,c[_][41].d,c[_][47].a,c[_][47].d)n(c[_][42].a,c[_][42].d,c[_][48].a,c[_][48].d)n(c[_][43].a,c[_][43].d,c[_][45].a,c[_][45].d)n(c[_][44].a,c[_][44].d,c[_][46].a,c[_][46].d)end
end
end
D=g/2*(E(N(bB,bd))/O)A=g/2*(E(-N(bp,bd)+P)/O)setColor(cb)if ba>1 then
x.drawCircle(h+D-1,i+A,3)n(h-4+D,i+A,h-7+D,i+A)n(h+D-1,i-3+A,h+D-1,i-5+A)n(h+2+D,i+A,h+5+D,i+A)end
setColor(bW)for ad,e in pairs(bs)do
aK=-g/2*(E(-P)/O)n(h+e[1],i+aK+e[2],h+e[3],i+aK+e[4])end
setColor(bY)p(0,6,b*2+1,g-12)p(k-(b*2)-1+l,6,(b*2)+1-l,g-12)p((b*2)+1,0,k-((b*2)+1)*2+l,7)p(0,g-6,(b*2)+1,6)p(k-(b*2)-1+l,g-6,(b*2)+1-l,6)p(0,0,(b*2)+1,6)p(k-(b*2)-1+l,0,(b*2)+1-l,6)for _=f((V-(g/32*20))/10)*10,f((V+(g/32*20))/10)*10,10 do
ax=v(((y(1/(_-V))*(g/64))^1.5*6000-20),0,u)setColor(cd,ax)bl=aU(bf(ce,f(_)),1,2)if _>=0 then j(1,(i-2+(V-_)),s(bl))end
end
for _=f((o-(g/32*20))/10)*10,f((o+(g/32*20))/10)*10,10 do
ax=v(((y(1/(_-o))*(g/64))^1.5*6000-20),0,u)setColor(bV,ax)bP=aU(bf(ce,f(_)),1,2)if _>=0 then j(k-(b*2)+l,(i-2+(o-_)),s(_))end
end
for _=-360,720,10 do
K=_-az
setColor(bZ)if _==0 or _==360 then
j(h+K-(b-3),0,"N")elseif _==90 then
j(h+K-(b-3),0,"E")elseif _==180 then
j(h+K-(b-3),0,"S")elseif _==270 then
j(h+K-(b-3),0,"W")else
n(h+K,6,h+K,0)end
end
setColor(ck)p(0,i-6,1+(b*3),13)if bu then
setColor(bX)at(-1,i-7,2+(b*3),14)end
setColor(bR)j(1,i-5,s(f(V)))j(1,i+1,T)setColor(ck)p(k-(1+(b*4))+l,i-6,(1+(b*4))-l,13)if bz then
setColor(cj)at(k-(2+(b*4))+l,i-7,(2+(b*4))-l,14)end
bC=s(f(af)):len()setColor(c_)j(k-(bC*b)+l,i-5,s(af))j(k-(b*ai:len())+l,i+1,s(ai))setColor(ck)p(h-f(((b*3)/2))-(b-4),0,(b*3)+1,7)if bi then
setColor(ci)at(h-f(((b*3)/2))-(b-3),-1,(b*3)+2,8)end
setColor(bT)bk=s(f(az+.5)):len()j(h-(bk*(b/2))+1,1,s(f(az+.5)))setColor(cc)p(k-1,0,1,g)if y(as)>1 then
setColor(bU)if bF then
J(v(y(as)*2-30,0,B),B-v(y(as)*2-30,0,B),0)end
p(k-1,i,1,-as/3*(g/64))end
J(0,B,0)be="OFF"
if b_ then
be="ON"
end
j(12,12,"Stabilizer:"..be)j(12,18,"Battery:"..(f(aQ*1000)/10)..cf)j(12,24,"Signal:"..(f(bK*10)/10)..cf)if aJ then
J(0,B,0)j(12,30,"Armed")else
J(0,B,0,100)j(12,30,"Not Armed")end
if aQ<.15 then
J(0,B,0)j(h-14,g-30,"LAND NOW")at(h-16,g-32,34,8)end
end
function j(a,d,X)a,d=f(a),f(d)X=s(X)if b==4 then
for _=1,#X do
M=X:sub(_,_):upper():byte()-31
M=aG[M>65 and M-26 or M]for aY=1,#M do
ak=M[aY]n(a+ak[1],d+ak[2],a+ak[3],d+ak[4])end
a=a+4
end
elseif b==5 then
x.drawText(a,d,X)end
end
