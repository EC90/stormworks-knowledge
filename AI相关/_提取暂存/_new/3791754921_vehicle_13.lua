-- source: steam id 3791754921 / vehicle.xml block#13
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
D=35
f={{"000000","I"},{"ggggg","H"},{"gggggggggg","G"},{"wwwww","V"},{"wwwwwwwwww","W"},{"xxx","Z"},{"xxxxx","Y"},{"xxxxxxxxxx","X"},{"ffffffff","g"},{"000000ff","w"},{"00000000","x"}}
H="UzjLO#zj#O#zzzzzj#jlnlnO00_9O#zDmj00sNO_9mmvn,9mm~f_9Bmv~fsNn,9;n3u!fe:j0000e:O#O#zztO#O#zj#O#zzzjlzO#jlnlj#OLjlj#nlmj00smjOsNO_9mmvn,9NEnsmN,:;n3u!fsj#jlj#jljljlOLtO#Isj#O#O#zj#tj#OLj#O#O#znOOsj#OLnlj#njOsmjOsnj00snjOsDmjOsmjO_9mmvn,9NEnsNn,:;n3u!fstOLj#O#OLtIsOLj#O#ztO#OLO#zO#jlj#OLDjljljljljLnlnjOsnnj_9mmvn,9NEnsNn,:;n3u!fe:tjLOLO#OLj#OLtzO#IstO#OLj#jljlO#jlDjljljljLjljLnlnjOsnO00_9mmvn,:mmvv~f_9Nn,:;n3u!fe:tttOLOLtjLttO#IstO#O#zzjlO#OLj#jlnlnO00_9mmvn,:Nvv~fsN3-s;n3u!f,9jLOLttj#O#OLO#OLttttO#zj#OLj#OLj#jljlnO00_9mmvnsmN,:Nvv~-e:;n3u!f,:zj#tttttttO#zjLjljljLOLj#O#jljlnO00_9mmvnsmm3-_9mmv~f_9N3-e:;n3u!-szOLj#tttttO#IsIsO#OLj#jlzjljlzjLjO00_9mmv~-sNvvnsN3-e:;n3u!-e:j#O#OLOLttj#ttttjLjlj#jljlzj#jljlj#jO00_9mmv~-sNv~f_9C3-e:;n3u!-e:tOLttj#tIstOLj#tOLj#jlzjljLjljljO00_9mmv~fsN3-e:Nv~-,:;n3u!-,9O#zztzj#IstO#O#zzzjlj#jljlOLjlCn_9CnsCnsCnsN3-,9mm~f_9C3-,:;n3u!-,9j#O#O#zjLO#zjLtOLO#zzO#OLjlj#OLj#jlnnjsNn,9Cne:Cne:N3-,9CnsCnsN!fs;n3u!-e:OOO=9zzj#O#zjLO#zzzO#zzj#O#jO00=9jRq_9mm~fsmm!fsN!f,9;n3u3-,:O1TO=9zzzO#zO#zzzzj#OLO#OO1ysjRqsjjqsjjO_9mNsmm!-,:nnne:;n3un,:JOO=9zzjLOLO#zzzzO#O#OO1y=9jRqsjRq_9mm!-,:;n3un=9JOoy=9zzzj#O1T1y=9jOqsjRqsjRqsjjqsQm~-,:nn3-e:;nn!-,:J1Toy=9O1ToysjRqsjRqsjjqsjjq=9Bm!-s;nn!-,:J1Toy=9O1T1ysjRqsjRqsjROsjj1y=9BNsrm!f,9;nn!-,:J1Toy=9OOoysjOOsjOOsjOqsjOqsjRqsjRqsjjo5sOOO_9Qmv~fsmm!fs;n3un=9J1Toy=9OOoysjOO=9jOOsjOOsjOqsjRoy=9OOO=:mmvv~fsmm3-,9;n3une:J1Toy=9JOoy=:mmEv3-s;n3u3-sjjj=9J1Toy=9O1Toye:mmEvv~f,9;n3u!f,9J1Toy=9OO1ysOOO,:mmEEvne:;UUU;UUU;UUU;UUU;UUU;UUU;"
d={{"pmsQ","A"},{"rNsr","B"},{"NnsN","C"},{"nlnl","D"},{"vvv","E"},{"7f","F"},{"O1Toy=9O","J"},{"s9494","K"},{"#j#","L"},{"saaaaQs","M"},{"mn","N"},{"jsnjjsnjj","P"},{"15","O"},{"6a","Q"},{"jqsjjqsjj","R"},{"s6a6ans6a","S"},{"5oy=91515","T"},{"n3u!-,:","U"},{"2a","j"},{"ms7f7fms","k"},{"1500s","l"},{"55","m"},{"3f","n"},{"6a55s6a6a","p"},{"1y=915151","o"},{"15s2a2a15","q"},{"6a553fs6a","r"},{"e9","s"},{"15#15#15#","t"},{"f!-,:3f3f","u"},{"~f_95555","v"},{"5=9151515","y"},{"2a#2a#2a#","z"},{"3-,:3f3f3","!"},{"e9151515e","="},{"3f_955553","~"},{"0000e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                