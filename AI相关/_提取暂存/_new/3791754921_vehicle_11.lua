-- source: steam id 3791754921 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3791754921

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
D=33
f={{"000000","I"},{"ggggg","H"},{"gggggggggg","G"},{"wwwww","V"},{"wwwwwwwwww","W"},{"xxx","Z"},{"xxxxx","Y"},{"xxxxxxxxxx","X"},{"ffffffff","g"},{"000000ff","w"},{"00000000","x"}}
H="n3u!-,Mzq~lv~lvMzq~lz0kKKKnj0Blv~lzBKml00knsnl00knl00knl00kmsnslsjz0kjz0_9mDerJJnpEnkJmtn_9Dn,9;n3u!-e:lzq~lzBlv9jv9jvMzqMzBnz0knz0knsnj0BjzBlv~lsnljknsnl00knljkKlslj0BIkjz0_9mm=fpnpnpnpt=fkDn,9;n3u!f,:llle~lv~lzq~O9O9O~lzq9nsjv9jzBlj0BlsnsnjjknljkKKlj0Bnj00,9mm=f_Qmt=fkDn,9;n3u!f,~jzBjv~lzBjv~jv9jv~lzBlv9O9jv9jv~lz0knsjv~FFlsnsnl00kKKlj0BmD,9DAnkmD,:;n3u!fe:lsjv9jzBjzq~jv9jv9jz0klslj0BFO9jv~Knljklj0Bnlje~lzBFFnjjknjjkKnljknsnjj_9mDkmD,9DAnkDn,:;n3u!fe:jv9jzBjzq~lv9jv9lj0Blv9lsjv9jv9jzBlj0q9lsjz0klsnslsnslj0BFlj0q9FnslsKnsnj00_9mm=f,9DAnkDn,:;n3u!fe:nllkjv9jzBjzq~jv9jv~Fjzq9lj0Blj0q9lj0Blslj0q~lzBlj0q~lz0kFFKnslslj00_9mm=-_9mmttn_9Dn,:;n3u!f,:jv9jv~lv9O9jvMzq~lj0q~lz0klj0q~lv~lz0klsnsFFnsnj00_9mm=-_9mmttnkD3-k;n3u!-kO9O9jv9jzq~lzq~jzq9Ikjv9jzBjzBlv~lz0klsnsFlj0Blsnslj00_9mDkmm3-_9mmtt3-e:;n3u!-kO9O~lj0qMz0klsnsjv~lzBlv~jzq9FlsKKlsnslz0_9mDkmm3-_9mmt=f_9D3-e:;n3u!-e~jv~O9jv9jv~lj0q~jzq9lj0q~lv~lzBlv~lz0klj0q9FlsKnslz0_9mDkmm3-kDttnkD3-e:;n3u!-kjv9jzBO9jv9jz0kIkIe~lj0q~lz0klj0Blj0q~lvMj0q9FlsKnslsnj00_9mDkmm3-kDt=f_9DnkD3-e:;n3u!-e~jzq~jz0kIkO9jv9jzq9lj0qMzBjv~lzBlj0Blj0BFFnj0Bnj00_9mD_9D3-e:Dt=-,:;n3u!-e:lv~lv9jv9jv9ljjeMvMj0q~lv9jv~lslj0BFFKlsnslsDnkDnkDnkD3-,9mm=f_9DnkD3-,:;n3u!-e:lllkjzBlv~lv~jzq~lzq~jv~jzq~jzBlv9jzBlslj0Blslj0q9nl00knsFlj00e:DnkDne:D3-,9DnkDnkDnkDnkD!fk;n3u!-kllly~jzq~jvMzq~lzq~jzq~jv9jzBFFlj0q9Flslljkllj_9mm=fkmm!fkD!f,9;n3u3-e:jj1oy#jjjy~lv9jz0klsjvMzq~FFjv~jv9jzq9FFnsFlj00y#jjjy#lljkllj,:nn!-,9;n3uny#jRy#lzq~jzqMzq~lzBjzBjv9jzBFFnsnj00y#jj1okllTkllTknnl,:nn!f,:;nn!-,#jRy#jj1oy#jjje#lzqMzq~lv~jz0y#jj1oy#jjjy9llTkllTkllT_9mm!-e:;nn!-e:jRy#jRy#jRy#jj1oe#ljTkllTkllTkllTe#JDerJm!-k;nn!-e:jRy#jRy#jRy#jjje#ljTkllTkllTkllTklljklljy9jjj_Qm!f,9;nn!-e:jRy#jRy#jRe#llTkllTkllTkllTkll1oy9jjje:mmt=-,:nnnk;nn!-e:llly#jRy#jRy#jj1oy9ljje#ljjkljjkljjklljkll1oy#jj1oe#jjj_9mmtt=-,9;n3uny#jRy#jRy#jRy#jj1okllle:mmAt3-k;n3u3-e:jRy#jRy#jR,9mmAAn,9;UjRy#jj1oe#jjj,:nnn,9mmAAttn_:;UUU;UUU;UUU;UUU;UUU;UUU;"
d={{"ttt","A"},{"0e~","B"},{"7f","C"},{"mn","D"},{"mpmp","E"},{"lsls","F"},{"6a","J"},{"nsns","K"},{"k9494","L"},{"~lzq~l","M"},{"lknllknll","N"},{"kaaaa6ak","P"},{"jv9jv9jv","O"},{"r6amner6a","Q"},{"j1oy#jj1o","R"},{"mk7f7fm","S"},{"jklljkllj","T"},{"n3u!-,:","U"},{"15","j"},{"e9","k"},{"2a","l"},{"55","m"},{"3f","n"},{"e96a6a","p"},{"5y#151515","o"},{"0e~2az0e","q"},{"96a553fe9","r"},{"1500e9","s"},{"=f_95555","t"},{"f!-,:3f3f","u"},{"z0e915z0e","v"},{"e#151515e","y"},{"000","z"},{"3-,:3f3f3","!"},{"3f_955553","="},{"92a0000e9","~"},{"9151515e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                