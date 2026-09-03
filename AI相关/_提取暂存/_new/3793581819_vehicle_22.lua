-- source: steam id 3793581819 / vehicle.xml block#22
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
-- Author: se-ssi
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/profiles/76561198040040549/myworkshopfiles/?appid=573090
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 622 (1000 with comment) chars

f=math
z=output.setNumber
_=input.getNumber
g=f.sqrt
b=f.atan
w=f.asin
y=f.sin
v=f.cos
function A(Q,J,O,P,M,N)a=2*f.pi
F=Q
G=J
C=O
j,l=v(F),y(F)q,i=v(G),y(G)h,k=v(C),y(C)m=q*h
p=-j*k+l*i*h
s=l*k+j*i*h
c=q*k
e=j*h+l*i*k
d=-l*h+j*i*k
r=-i
n=l*q
o=j*q
B=w(c)/a
D=w(e)/a
E=w(d)/a
B=b(c,g(m*m+r*r))/a
D=b(e,g(p*p+n*n))/a
E=b(d,g(s*s+o*o))/a
B=b(c,g(d*d+e*e))/a
D=b(e,g(c*c+d*d))/a
E=b(d,g(e*e+c*c))/a
S=b(m,r)/-a
X=b(p,n)/-a
U=b(s,o)/-a
u=P
x=M
t=N
R=m*u+c*x+r*t
K=p*u+e*x+n*t
H=s*u+d*x+o*t
return R,H,K
end
function onTick()Y,W,I=A(_(1),_(2),_(3),_(4),_(5),_(6))L,T,V=A(_(7),_(8),_(9),_(10),_(11),_(12))z(1,I*.8)z(2,L*.8)end
