-- source: steam id 2936211577 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2936211577
c=math
p=c.asin
h=c.sin
j=c.cos
pi=c.pi
function onTick()_={}for d=1,14 do
_[d]=input.getNumber(d)end
n=_[4]o=_[5]l=_[6]f,m,g=j(n),j(o),j(l)i,k,e=h(n),h(o),h(l)q=f*k*e-i*g
r=p(q)a=c.atan(f*m,f*k*g+i*e)a=-a+pi/2
if a>pi then
a=a-2*pi
end
b=p(-m*e/c.sqrt(1-q^2))if i*k*e+f*g<0 then
b=pi-b
end
if b>pi then
b=b-2*pi
end
_[4]=r
_[5]=a
_[6]=b
for d=1,14 do
output.setNumber(d,_[d])end
end
