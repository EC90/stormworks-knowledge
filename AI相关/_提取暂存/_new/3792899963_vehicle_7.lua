-- source: steam id 3792899963 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792899963
ay="2"
ax=""
aw="%02d"

x=tostring
af=pairs
o=tonumber
u=true
G=ipairs
ad=input
E=false
Z=property
ag=output
K=string
M=screen
Y=M.drawRectF
F=M.setColor
T=K.format
L=K.len
D=math.floor
B=ag.setBool
n=K.sub
P=ag.setNumber
Q=Z.getText
ac=Z.getNumber
j={}I={}g={}J={}q={}R={}v={}_={}a={}k=ax
ah=E
ae={}p=0
m="Unknown "
l=0
z=E
aj=ac("Number of Hardpoints")for d=1,aj do
R[d]={}j[d]={}end
function onTick()for d=1,32 do
g[d]=ad.getNumber(d)J[d]=ad.getBool(d)end
H=0
for d=1,aj do
av(d,g[d+2])end
t=Q("Internal Gun Name")an()ab=E
for w,b in G(_)do
if k==b[5]then ab=u end
end
if not ab then
k=ax
P(1,0)else
ao=o(n(_[a[k]][3],1,2))P(1,ao+0)end
P(2,H)for d=1,32 do
B(d,E)end
if J[3]and k~=ax then ar()end
if J[1]then
if not ah then
if g[1]>29 and g[2]<8 then z=E
elseif g[1]>29 and g[2]<16 then z=u
elseif g[1]>29 and g[2]>24 and p>4 and not z then
l=l+8
elseif g[1]>29 and g[2]>16 and p>4 and not z then
l=l-8
elseif not z and g[1]<28 then
r=1
for w,b in af(_)do
if g[2]>(r-1)*8-l and g[2]<(r-1)*8+8-l then
if k==b[5]then k=ax
else k=b[5]end
end
r=r+1
end
end
end
end
if l>=(p-4)*8 then l=(p-4)*8 end
if l<=0 then l=0 end
ah=J[1]ak=J[3]e={{},{},{},{}}for d=1,4 do
W=Q("Color Code "..x(D(d)))e[d].A,e[d].C,e[d].b=o(n(W,1,3)),o(n(W,5,7)),o(n(W,9,11))end
B(31,z)end
function ar()O=o(n(_[a[k]][2],1,1))X=o(n(_[a[k]][3],1,2))U=_[a[k]][4]if O==1 and U==1 and not ak then
B(X+0,u)elseif O==2 and U==1 and not ak then
B(X+15,u)elseif O==2 and U==2 then
y=_[a[k]][3]while y~=ax do
if L(y)>2 then
B(o(n(y,1,2))+15,u)y=n(y,3,L(y))else
B(o(y)+15,u)y=ax
end
end
B(X+15,u)end
end
function an()_={}a={}p=0
if g[31]>0 then
a[t]=p+1
_[a[t]]={}_[a[t]][1]=g[31]_[a[t]][2]=ay
_[a[t]][3]="17"
_[a[t]][4]=2
_[a[t]][5]=t
p=p+1
end
for i,c in G(I)do
al=u
for w,b in af(a)do
if c==w then al=E end
end
if al and j[i][1]>0 and j[i][1]<4 then
if not((j[i][1]==2 or j[i][1]==3)and q[i]<1)then
a[c]=p+1
_[a[c]]={}_[a[c]][1]=0
_[a[c]][2]=ax
_[a[c]][3]=ax
_[a[c]][5]=c
p=p+1
end
end
if j[i][1]==1 then
_[a[c]][1]=_[a[c]][1]+1
_[a[c]][2]=_[a[c]][2].."1"
_[a[c]][3]=_[a[c]][3]..T(aw,x(i))_[a[c]][4]=1
elseif j[i][1]==2 and q[i]>0 then
_[a[c]][1]=D(_[a[c]][1]+q[i])_[a[c]][2]=_[a[c]][2]..ay
_[a[c]][3]=_[a[c]][3]..T(aw,x(i))_[a[c]][4]=2
elseif j[i][1]==3 and q[i]>0 then
_[a[c]][1]=_[a[c]][1]+D(q[i])for d=1,q[i]do
_[a[c]][2]=_[a[c]][2]..ay
_[a[c]][3]=_[a[c]][3]..T(aw,x(i))end
_[a[c]][4]=1
end
end
for w,b in G(_)do
am=(L(b[5])+1+L(x(D(b[1]))))*4+15
if v[b[5]]==nil then v[b[5]]=0 end
if v[b[5]]>=am then v[b[5]]=0
else v[b[5]]=v[b[5]]+ac("Scroll Speed")end
ae[b[5]]=am
end
end
function av(f,h)if h>=1000000 then
N=x(D(h))j[f][1],j[f][2]=o(n(N,1,1)),o(n(N,2,2))at=o(n(N,6,7))R[f][at]=K.char(n(N,3,5)+0)q[f]=g[16+f]I[f]=ax
for w,b in G(R[f])do
I[f]=I[f]..b
end
if j[f][1]==5 and j[f][2]==1 then
H=H+q[f]end
else
q[f]=g[16+f]I[f],j[f][1],j[f][2]=ap(h,f)if h==2 then
H=H+g[16+f]end
end
end
function ap(h,f)if h==1 then
return m.."Utility",5,0
elseif h==2 then
return m.."Fuel",5,1
elseif h==3 then
return m.."Bomb",1,9
elseif h==4 then
return m.."LGB",1,7
elseif h==5 then
return m.."GPS Bomb",1,8
elseif h==6 then
return m.."Rocket",1,0
elseif h==7 then
q[f]=1
return m.."Rocket Pod",2,2
elseif h==8 then
return m.."LGM",1,4
elseif h==9 then
return m.."GPS Missile",1,5
elseif h==10 then
return m.."Radar Missile",1,3
elseif h==11 then
return m.."Torpedo",1,6
elseif h==12 then
return m.."Cannon",2,1
end
return "Empty",0,0
end
function onDraw()if not z then
F(e[1].A,e[1].C,e[1].b)M.drawClear()r=1
for w,b in G(_)do
F(e[1].A,e[1].C,e[1].b)if b[5]==k then
F(e[2].A,e[2].C,e[2].b)end
Y(0,(r-1)*8+1-l,32,8)F(e[2].A,e[2].C,e[2].b)if b[5]==k then
F(e[1].A,e[1].C,e[1].b)end
V=x(D(b[1])).."x "..b[5]if v[b[5]]>0 and ae[b[5]]>41 then
aa(1-v[b[5]],(r-1)*8+2-l,x(V.."   "..V))else
aa(1,(r-1)*8+2-l,V)end
r=r+1
end
F(e[3].A,e[3].C,e[3].b)for d=1,5 do
Y(0,((d-1)*8),64,1)end
end
end
local au=Q("f")function aa(as,aq,ai,A)for d=1,ai:len()do s=ai:sub(d,d):upper():byte()*4-127 if s>257 then s=s-104 end w="0x"..au:sub(s,s+3)for S=0,14 do if w&(1<<(14-S))>0 then b=as+S//5+(d-1)*4 s=aq+S%5 M.drawLine(b,s,b,s+1)end end end end
