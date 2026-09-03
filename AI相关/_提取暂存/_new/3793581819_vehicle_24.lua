-- source: steam id 3793581819 / vehicle.xml block#24
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
-- Author: se-ssi
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/profiles/76561198040040549/myworkshopfiles/?appid=573090
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1266 (1646 with comment) chars

b=false
u=true
h=math
N=output
I=N.setNumber
q=h.pi
_=input.getNumber
v=h.sin
C=h.cos
function o(ad,U,ab)return{f=ad or 0,e=U or 0,g=ab or 0}end
function ag(m,n,z)return{Y=m,F=n,aj=z}end
function K(a)return h.sqrt(a.f*a.f+a.e*a.e+a.g*a.g)end
function G(c,d)return c.f*d.f+c.e*d.e+c.g*d.g
end
function ai(c,d)return o(c.e*d.g-c.g*d.e,c.g*d.f-c.f*d.g,c.f*d.e-c.e*d.f)end
function S(a,D)return o(G(D.Y,a),G(D.F,a),G(D.aj,a))end
function J(a)return K(a),h.atan(a.f,a.e),h.asin(a.g/K(a))end
function H(X,ap,af)P,R,T=X,ap,af
r,t,E=C(P),C(R),C(T)Q,x,B=v(P),v(R),v(T)m=o(t*E,-x,t*B)n=o(Q*B+r*x*E,r*t,-Q*E+r*x*B)z=ai(m,n)return ag(m,n,z)end
M=u
w=10
k=0
i=0
function onTick()if w>0 then w=w-1 else
if M then
p=_(7)Z=-_(8)*(q/180)an=_(9)*(q/180)A=_(10)W=-_(11)*(q/180)aq=_(12)*(q/180)M=b
end
O=_(13)>0
ae=_(14)>0
l=_(18)>0
s=_(15)>0
am=_(16)>0
y=_(17)>0
ah=H(_(19),_(20),_(21))ao=H(_(1),_(2),_(3))L=H(_(4),_(5),_(6))ak,V,al=J(S(ao.F,L))ak,aa,ac=J(S(ah.F,L))k=9
i=9
j=ae and am
if l==u and(y==b or s==b)and A==2 then
k=V
i=al
j=b
elseif l==u and(y==b or s==b)and A==1 then
k=aa
i=ac
j=b
elseif l==b or(y==b or s==b)and A==3 then
k=W
i=aq
j=b
end
if O and(p==1 or p==3)then
k=Z
j=b
end
if O and(p==2 or p==3)then
i=an
j=b
end
I(1,k)I(2,i)I(3,l and 1 or 0)N.setBool(1,j)end
end
