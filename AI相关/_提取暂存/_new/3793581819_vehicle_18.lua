-- source: steam id 3793581819 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819

l=false
aT=output
I=screen
m=math
aO=m.floor
be=m.tan
n=m.ceil
at=I.drawRect
M=I.setColor
av=I.drawTextBox
bf=m.fmod
Q=m.abs
_=input.getNumber
c=aT.setNumber
D=m.pi
aZ=m.min
L=m.max
H=m.sin
P=m.cos
function h(bw,br,bA)return{f=bw or 0,e=br or 0,i=bA or 0}end
function bk(af,ag,ar)return{aF=af,O=ag,ab=ar}end
function x(b,d)return h(b.f+d.f,b.e+d.e,b.i+d.i)end
function v(b,X)return h(b.f*X,b.e*X,b.i*X)end
function ax(b,d)return x(b,v(d,-1))end
function an(a)return m.sqrt(a.f*a.f+a.e*a.e+a.i*a.i)end
function bs(a,X)return v(a,1/X)end
function bj(a)return bs(a,an(a))end
function V(b,d)return b.f*d.f+b.e*d.e+b.i*d.i
end
function aW(b,d)return h(b.e*d.i-b.i*d.e,b.i*d.f-b.f*d.i,b.f*d.e-b.e*d.f)end
function aG(a,G)return h(V(G.aF,a),V(G.O,a),V(G.ab,a))end
function aL(a,G)return x(x(v(G.aF,a.f),v(G.O,a.e)),v(G.ab,a.i))end
function am(a)return an(a),m.atan(a.f,a.e),m.asin(a.i/an(a))end
function bd(b,d,ay)return x(x(v(b,P(ay)),v((aW(d,b)),H(ay))),v((v(d,V(d,b))),1-P(ay)))end
function aV(by,bB,bp)aP,aR,aU=by,bB,bp
aw,as,aJ=P(aP),P(aR),P(aU)bh,au,aE=H(aP),H(aR),H(aU)af=h(as*aJ,-au,as*aE)ag=h(bh*aE+aw*au*aJ,aw*as,-bh*aJ+aw*au*aE)ar=aW(af,ag)return bk(af,ag,ar)end
function bm(aB,bq,bt)return L(bq,aZ(bt,aB))end
function N(aB,bb)return L(-bb,aZ(bb,aB))end
k=D*2
aI=h(0,.675,0)ba=.02
aK=.001
s=0
r=0
W=0
T=0
t=h()w=1
C=h()y=h()aA=4
ac=0
aH=l
o=l
q=l
Y=l
function aj()t=x(aL(h(0,al,0),z),C)aM()end
function aM()j,g=U(t,h(.25,.675,0))c(14,8*j/k)c(15,8*g/k)j,g=U(t,aI)c(16,8*j/k)c(17,8*g/k)end
function U(B,bv)R,j,g=am(ax(aG(ax(B,C),z),bv))return j,g
end
function ah(bn)u=bj(ax(bn,C))end
function Z(j,g)c(11,j+_(28))c(12,g-_(29))end
function ai(aD)c(1,aD.f)c(2,aD.e)c(3,aD.i)end
function aC(j,g)R=V(ae.ab,u)g=R>.95 and-.01 or g
g=R<-.95 and .01 or g
u=bd(u,ae.ab,j)u=bd(u,z.aF,g)R,j,g=am(aG(u,z))Z(-j,g)end
function onTick()z=aV(_(4),_(5),_(6))ae=aV(_(14),_(15),_(16))R,bx,bz=am(aG(z.O,ae))if aA>0 then
u=z.O
aA=aA-1
end
if _(21)>0 then
A=L(1,_(7))F=A>5
aX=A*_(24)if F then
ac=ac+1
else
ac=0
end
if ac>30 then
ak=_(8)ao=_(9)bg=aX^.33
else
ak=0
ao=0
bg=0
F=l
end
al=L(1,_(22))if(y.f~=_(25)or y.e~=_(26)or y.i~=_(27))then
Y=l
o=q
y=h(_(25),_(26),_(27))t=y
B=y
ah(y)end
y=h(_(25),_(26),_(27))s=N(s-_(10)*aK*(Q(s)+1),ba*w)if _(10)==0 then
s=Q(s)<.0003 and 0 or s*.7
end
r=N(r+_(11)*aK*(Q(r)+1),ba*w)if _(11)==0 then
r=Q(r)<.0003 and 0 or r*.7
end
aq=Q(s)>0 or Q(r)>0
if _(17)>0
then
o=not o
end
if _(18)>0
then
q=not q
end
if _(19)>0
then
Y=not Y
end
if _(20)>0
then
aH=not aH
end
w=bm(w-_(23)*.02*w^.5,.01,1)K=1-w
c(13,K)C=h(_(1),_(3),_(2))if aH and F and o and q==l then
W=N(W-s*(w+.1),.1)T=N(T+r*(w+.1),.1)else
W=0
T=0
end
b_=(ak+W)*k
bc=(ao+T)*k
B=x(C,aL(x(h(H(b_)*A,((P(bc)*A)^2-(H(b_)*A)^2)^.5,H(bc)*A),h(.5,.25,.25)),z))bl,bi=U(B,aI)if Y then
Z((bf((bx-_(12)*k)+D*3,k)-D)*.7,(bf((-bz+_(13)*k)+D*3,k)-D)*.7)aj()u=z.O
elseif q then
aM()if aq or o==l then
aC(s,r)aj()else
j,g=U(t,h())Z(-j,g)ah(t)end
else
if F and o then
ah(B)t=B
Z(-ak*4,ao*4)c(16,8*bl/k)c(17,8*bi/k)else
aC(s,r)aj()end
end
aT.setBool(1,(q==l and F and o)or(q and o))c(4,0)if q==l and F then
ai(B)c(4,aX)elseif q then
if o and aq==l then
ai(t)c(4,500)elseif o==l then
ai(t)end
end
else
u=ae.O
aC(0,0)end
c(5,C.f)c(6,C.e)c(7,C.i)c(8,_(4))c(9,_(5))c(10,_(6))end
function S(bo)av(0,2,az,6,bo,0,0)end
function aY(aN,aQ,aS)M(aN,aQ,aS,150)at(J-1,E-1,1,1)M(aN,aQ,aS,230)I.drawLine(J,E-1.5,J-1.5,E)end
function ap()at(f-n(p/2),e-n(p/2),p,p)av(f-16,N(e+p/2+2,ad-9),32,6,bu,0,0)end
function onDraw()az=I.getWidth()ad=I.getHeight()J=n(az/2)E=n(ad/2)if q then
M(140,50,180,180)p=n(L(7,500*be(K*D/2)/al))if o and aq==l then
at(J-n(p/2),E-n(p/2),p,p)av(0,N(E+p/2+2,ad-9),az,6,n(al),0,0)S("locked")else
S("unlocked")end
aY(140,50,180)else
if F then
bu=n(A)aa=ad*(12.36*K^1.75+190.96*K^65.06+44.86*K^11.26+1.8)j,g=U(B,aI)f=n(J+(j/k)*aa)e=aO(E-(g/k)*aa)p=n(L(7,50*be(K*D/2)*bg/A))if o then
M(255,10,10,200)if Y then
ap()else
f=n(J-W*aa)e=aO(E+T*aa)ap()end
aY(255,10,10)S("tracking")else
M(50,255,20,200)ap()S("target found")end
else
M(50,255,20,200)S("searching")end
end
end
