-- source: steam id 2409700748 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2409700748


e=string
p=tonumber
x=screen
--yyy--
function a(b)
c=1
while d[c]do
b=e.gsub(b,d[c][2],d[c][1])
c=c+1 
end
c=1
while f[c]do
b=e.gsub(b,f[c][2],f[c][1])
c=c+1 
end
g={}
h=1
i=0
j=e.find(b,";"
)
while j do
g[h]={}
k=e.sub(b,i+1,j)
l=1
m=0
while m< e.len(k)do
n=e.sub(k,m+1,m+1)
o=e.sub(k,m+1,m+8)
if not(o==";"
)then
c=p("0x"
..e.sub(o,1,2))
q=p("0x"
..e.sub(o,3,4))
r=p("0x"
..e.sub(o,5,6))
s=p("0x"
..e.sub(o,7,8))
if s==0 then
g[h][l]=false else g[h][l]={}g[h][l][1]=c
g[h][l][2]=q
g[h][l][3]=r
g[h][l][4]=s 
end
end
m=m+8
l=l+1 
end
i=j
j=e.find(b,";"
,j+1)
h=h+1 
end
return g 
end
t=0.4
function u(v,w,c,q,r,s)
if not c then
c=0
end
if not q then
q=0
end
if not r then
r=0
end
if not s then
s=0
end
x.setColor(c*t,q*t,r*t,s)
x.drawRectF(v-1,w-1,1,1)
end
y=0
z=0
function onDraw()
A=x.getWidth()
B=x.getHeight()
if not C then
return 
end
k=1
while not(C[k]==nil)do
o=1
while not(C[k][o]==nil)do
if not C[k][o]==false then
u(y+o,z+D-1+k,C[k][o][1],C[k][o][2],C[k][o][3],C[k][o][4]*E)
end
o=o+1 
end
k=k+1 
end
end
E=1
function onTick()
--E=input.getNumber(1)
end
D=1
f={{"000000","I"},{"ggggg","H"},{"gggggggggg","G"},{"wwwww","V"},{"wwwwwwwwww","W"},{"xxx","Z"},{"xxxxx","Y"},{"xxxxxxxxxx","X"},{"ffffffff","g"},{"000000ff","w"},{"00000000","x"}}
H="-;-;-;-;-;-;-;z;r;z;t;q;u;A;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;;"
d={{"B","A"},{"C","B"},{"D","C"},{"E","D"},{"F","E"},{"J","F"},{"K","J"},{"L","K"},{"M","L"},{"N","M"},{"P","N"},{"O","P"},{"Q","O"},{"R","Q"},{"S","R"},{"T","S"},{"U","T"},{"j","U"},{"k","j"},{"l","k"},{"m","l"},{"n","m"},{"p","n"},{"o","p"},{"s","o"},{"Y~Yv","q"},{"Z!:,fY","r"},{"Y_#~xy","s"},{"XZx=efXY","t"},{"Y!:e:~Yx","u"},{"Z=efYZ~Yx","v"},{"x=#~xx~Yx","y"},{"XY~XYx","z"},{",:,:,","!"},{"e:e:ef","="},{"_ef","~"},{"efxx_efxx","#"},{"XXXxx","-"},{"efefef","_"},{"e:e:e:e:e",","},{"fefefefef",":"}}
C=a(H)
                