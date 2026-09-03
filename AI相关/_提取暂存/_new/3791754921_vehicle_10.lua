-- source: steam id 3791754921 / vehicle.xml block#10
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
H="UUU;UUU;UUU;UUU;UUU;UUnnne:Dt=f_rJJnpEEmpt=fkmm3-,9mDk;Un3u!-,9DnkDnkDt=f_9JJnpEmkCJSkCJEmpttn_9D=f_9;Un3u!f,9Dn_9Dtt=fpnpmpSkCCSkCCSkCCmkCJmpmkJmAnk;Un3u3-e:DnkDA=ferJJESk94CmLmLmLmLSpmpAn_9;Un3un,9DAn_rJDpEmpmkCJSkCCmLmLJkaa94JLJLmkmm!fe:JJnpnkJmtnk;Un3unkDnkDtt=ferJJnpEmkCJSkCCmk94CmLmLJLJPaaaaJPaaaaJPnlNknlNknlNe:JJEE=f_9;Un3unkDtt=ferJJnpESkCCSLmLJkaa94JPaaaaJkbfaaCkbfaaCkaaaaJ,9nlNknlNknlNe:CCSkCJEmp=fk;Un3une:Dtt=f_rJJEmpmkCJSkCCSkCCSkCCmpme:DnkDnknlNknlNknlNLmLJk94CSkCJEnkJD_9;Un3u3-e:DAttne:Dn_9d4d494kd4d494kd4d494kbfbfCPaa94JLmk94CmkbfbfCPaa94JLSkCCEmpn_9;Un3u!-kDne:DnkDtt=fe:d4d4aakd4d4aakd4d4aakd4d494kd4bfCkbfbfCPaa94Jkd4bf94kd4bf94kbfbfCPaaaaJLJk94CSkCJEner;Unn!f,9DnkDnkDAttn_Qmt=fe:mD_9JJnkCCmLJkbfbfCkd4d494kd4bf94kbfbfCkbfaaCP9494Jk94CSkCJEner;Unn!f,9DnkDAttn_QDerJmtn_:mD_9JJnkCCmLJkbfbfCkd4d494kd4bf94kbfbfCPaaaaJLJk94CSkCJEner;Unn!f,:DAt=feQJnerJJnpnpnpneQD_:mD_9JJnkCCmLJkbfbfCkd4d494kd4bf94kbfbfCPaa94JLSkCCEmpn_9;Unn!f,9DnkDAt=f_rJDpnpnpnpnpnpneQD_:mD_9JJnkCCmLJkbfbfCkd4bf94kbfbfCkbfaaCP9494Jk94CSkCJEmkJD_9;Unn!f,9DnkDAtn_QDpnpnpnpnpnpneQDkJDe:mD_9JJnkCCmLJkbfaaCkbfbfCkbfbfCP9494JLSkCCEmpnkJD_9;Unn!f,9DnkDAtn_QDerJJnpnpnpnpneQD_:mD_9JJnkCCmLJPbfbfCkbfbfCP9494SkCCEmpnkJm=fk;Unn!f,:DAt=feQDpnpnpnpnpneQD_:mD_9JJnkCCmLmPbfaaCPaa94JLSkCJEnkJm=f_9;Unn!f,:DnkDAt=feQDpnpnpnpnpnerJDkJD_:mD_9JJnkCJmLmPaaaaJP9494JkCCSpmpmkJmtnk;Unn!f,:DAt=f_QJneQJneQDkJDe:mD_9JJnpmk94CmLJPaa94JLSkCJEtn_9;Unn!f,:DnkDAt=feQDeQDerJDkJm=fe:mD_rJJSLJkaa94JLJk94CSpmpmkJmtn_9;Unn!f,:DnkDAt=f_QDeQDerJm=fe:mm=fpSLmLmLSkCCEt=fk;Unn!f,:DnkDAtt=feQDkJmtne:mm=fpSkCCmk94Cmk94CSkCJEt=fk;Unn3-,~lzBnz0knzBnz0kKKKnsnj00_9mmA=ferJmtn_:mm=fpmkCJSkCCSkCCEmkJmtn_9Dnk;Unnn,Mzq~lz0knzq~lz0knzBKmsmsmsmj00_9mmAtn_:mm=fpnpSkCCSkCJEt=fkDnk;Unnne~nslsljjeMzq~lv~lz0kKnv9Kjz0kKmsmsJl00_9mmAn_:mm=fpnpmkCJSkCCEmpt=fe:;Ulz0klj0Bjzq~lzBjzqMzBnj0q~KKnsmsml00kmj00_9mD_9Jl00kml00kml00kJl00kml00kJljkCnjkJl00_9mD_:mm=f_9JJmpmkCJEmpnkJmtn_9Dne:;n3u!-,MzBjzqMzq~lzq9nz0kKKKKmsmsnj0q9nsnz0knsJl00kJl00kJl00kml00kmsmsJl00knsml00kjz0_9mDpnpEEt=fkDne:;"
d={{"ttt","A"},{"0e~","B"},{"7f","C"},{"mn","D"},{"mpmp","E"},{"lsls","F"},{"6a","J"},{"nsns","K"},{"k9494","L"},{"~lzq~l","M"},{"lknllknll","N"},{"kaaaa6ak","P"},{"jv9jv9jv","O"},{"r6amner6a","Q"},{"j1oy#jj1o","R"},{"mk7f7fm","S"},{"jklljkllj","T"},{"n3u!-,:","U"},{"15","j"},{"e9","k"},{"2a","l"},{"55","m"},{"3f","n"},{"e96a6a","p"},{"5y#151515","o"},{"0e~2az0e","q"},{"96a553fe9","r"},{"1500e9","s"},{"=f_95555","t"},{"f!-,:3f3f","u"},{"z0e915z0e","v"},{"e#151515e","y"},{"000","z"},{"3-,:3f3f3","!"},{"3f_955553","="},{"92a0000e9","~"},{"9151515e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                