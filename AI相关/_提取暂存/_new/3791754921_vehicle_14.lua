-- source: steam id 3791754921 / vehicle.xml block#14
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
D=1
f={{"000000","I"},{"ggggg","H"},{"gggggggggg","G"},{"wwwww","V"},{"wwwwwwwwww","W"},{"xxx","Z"},{"xxxxx","Y"},{"xxxxxxxxxx","X"},{"ffffffff","g"},{"000000ff","w"},{"00000000","x"}}
H="UUU;UUU;UUU;UUU;UUU;UUmmme:lmv~_sqOmsOCCpv~_,:mmm,9llms;Umu!-f,9Mmslmv~_SOCOlsEOjECpvv3_slm~_s;Umu!m,9lm3_slmvv~fSOpjEEjEEjEElsEClDms;Umuf-fe:MD~fsqCOj94ElKlKlKlKjOpD3_s;Umufm,9lmD3_sqlmsOCplsEOjEElKlKOsaa94OKOKlsll-f,:mmme:OOmSOlvms;UmufmsMvv~fsqOmsOCOlsEOjEEls94ElKlKOKONaaaaONaaaaONmkPsmkPsmkPe:OCCO~_s;Umufmslmvv~fsqOmsOCOjEEj9494lKOsaa94ONaaaaOsbfaaEsbfaaEsaaaaO,9mkPsmkPsmkPe:EEjECp~fs;Umufme:lmvv~_sqCplsEOjEEjEEjEElsOOle:MmsmkPsmkPsmkPKlKOs94EjEplSOl3_s;Umuf-fe:lmDvvme:lm3_sd4d494sd4d494sd4d494BNaa94OKls94ElBNaa94OKjEElsOCO3_s;Umu!-fslmme:Mvv~fe:d4d4aasd4d4aasd4d4aasd4d494sd4bfEBNaa94Osd4bf94sd4bf94BNaaaaOKOs94EjEplSOlms;Um3!m,9MmslmDvv3_Jv~fe:ll3_SEElKOBsd4d494sd4bf94BsbfaaEN9494Os94EjEplSOlms;Um3!m,9MDvv3_Jmsqlv3_e:ll3_SEElKOBsd4d494sd4bf94BNaaaaOKOs94EjEplSOlms;Um3!m,:lmDv~fsqlmsqOmsqOmSOOmSqlmsql3_e:ll3_SEElKOBsd4d494sd4bf94BNaa94OKjEElsOCO3_s;Um3!m,9MDv~_sqlmSOOmSOOmSOOmJ3_e:ll3_SEElKOBsd4bf94BsbfaaEN9494Os94EjECOlsOl3_s;Um3!m,9MDv3_JmSOOmSOOmSOOmJmsOlme:ll3_SEElKOsbfaaEBBN9494OKjEElsOplSOl3_s;Um3!m,9MDv3_JmsqOmSOOmSOOmJ3_e:ll3_SEElKONbfbfEBN9494jEElsOplSOl~fs;Um3!m,:lmDv~fJmSOOmSOOmSqlmsql3_e:ll3_SEElKlNbfaaENaa94OKjEplSOl~_s;Um3!m,:MDv~fJmSOOmSOOmSqlmsOl3_e:ll3_SEOlKlNaaaaON9494OsEEjOClvms;Um3!m,:lmDv~_sqlmsqOmsqlmsqOmJmsOlme:ll3_SOOls94ElKONaa94OKjECOv3_s;Um3!m,:MDv~fJmJmsqlmsOl~fe:ll3_sqOj9494Osaa94OKOs94EjOClv3_s;Um3!m,:MDv~_JmJmsql~fe:ll~fsOOj9494lKlKjEElsOpv~fs;Um3!m,:MDvv~fJmsOlvme:ll~fsOOjEEls94Els94EjECOv~fs;Um3!-fsLALLmnmnm#mnm#mnmnlnmnlnllvv~fsqlv3_e:ll~fsOOlsEOjEEjEElsOClv3_slmms;Um3!msyQyQLLm#mnmnm#lnlnmnmnmnlnllD~_e:ll~fSOOjEEjECOv~fslmms;Umm-f,9LLQyLtQymnmnlnlnmnmnmnmk15slnllD~fe:ll~fSOOlsEOjEElsOCOv~fe:;mu!m,9kFsLAmnm1500,:mmme:kkksyyyLLALLQLLmnmnlk00smnmnm#mnlnllD3_e:ll~_sOplsECpmsOlv3_slmme:;mu!me:mkksLLQQLLkkk,=QAQLLQyQyLLQLQLLmnmnmnmnlnlnlnllDme:lm~_SOCCOv~fslmme:;mu!me:AALtLk1500,9QLQAQLtLQLtQyym#mnLmnmnlnlnllvv~_,9ll~fsqOmsOplSOlv3_slmm,9;mu!me:AALLtQk0000e:QLQLttttQyyLm#Lmnmnmnllvv~_,9ll~_SOOmSOOv~fslmm,9;mu!me:mnmnLLQLtQLQIstttQLQyQLLQym#mnmnmnm#llvv~f,9ll~_Jv~fslmm,9;"
d={{"kn","A"},{"sbfbfE","B"},{"plsO","C"},{"vvv","D"},{"7f","E"},{"1515","F"},{"sqlmsql","J"},{"s9494","K"},{"k#","L"},{"lmmslm","M"},{"saaaaOs","N"},{"ksmkksmkk","P"},{"6a","O"},{"15#","Q"},{"1oz=15151","R"},{"s6a6ams","S"},{"krskkrskk","T"},{"mu!-f,:","U"},{"ls7f7fls","j"},{"2a","k"},{"55","l"},{"3f","m"},{"1500s","n"},{"6a55s6a6a","p"},{"5z=151515","o"},{"6a553fs6a","q"},{"15s2a2a15","r"},{"e9","s"},{"15#15#15#","t"},{"3!-f,:3f3","u"},{"~_e95555","v"},{"2a#2a#2a#","y"},{"e=151515e","z"},{"f-f,:3f3f","!"},{"9151515e9","="},{"3_e955553","~"},{"0000e9","#"},{"3f,:3f3f3","-"},{"fe955553f","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                