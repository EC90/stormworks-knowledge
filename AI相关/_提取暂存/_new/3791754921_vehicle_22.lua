-- source: steam id 3791754921 / vehicle.xml block#22
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
H="TTT;TTT;TTT;TTT;TTT;TTllle:mlA_sSSlrSCCpArmm3-,9mmlr;Tl3u!-,9KlrmlA_9SSlrSCSmrESjECpyyl_9ml#f_9;Tl3u!f,9mll_9mlyArSSlrSpjEEjEEjEEmrECmDlr;Tl3u3-e:KD#fesSCSj94EmJmJmJmJjSpDl_9;Tl3ul,9mlDl_sSmlrSCpmrESjEEmJmJSraa94SJSJmrmm!fe:SSlrSSlrSmylr;Tl3ulrKyAesSSlrSCSmrESjEEmr94EmJmJSJSLaaaaSLaaaaSLl2Prl2Prl2Prl2Prl2a2ae:SCCS#f_9;Tl3ulrmlyAesSSlrSCSjEEj9494mJSraa94SLaaaaSrbfaaErbfaaEraaaaS,9l2Prl2Prl2Prl2Prl2a2ae:EEjECp#fr;Tl3ule:mlyA_sSCpmrESjEEjEEjEEmrSSme:Klrl2Prl2Prl2Prl2Prl2a2aJmJSr94EjECSlrSml_9;Tl3u3-e:mlDyyle:mll_9d4d494rd4d494rd4d494rbfbfELaa94SJmr94EmrbfbfELaa94SJjEEmrSCSl_9;Tl3u!-rmlle:KyAe:d4d4aard4d4aard4d4aard4d494rd4bfErbfbfELaa94Srd4bf94rd4bf94rbfbfELaaaaSJSr94EjECSles;Tll!f,9KlrmlDyyl_NAe:mml_9SSlrEEmJSrbfbfErd4d494rd4bf94rbfbfErbfaaEL9494Sr94EjECSles;Tll!f,9KDyyl_NlesSmyl_:mml_9SSlrEEmJSrbfbfErd4d494rd4bf94rbfbfELaaaaSJSr94EjECSles;Tll!f,:mlDAesSmlesSSlesSSOrSSleNl_:mml_9SSlrEEmJSrbfbfErd4d494rd4bf94rbfbfELaa94SJjEEmrSCSl_9;Tll!f,9KDA_sSmOrSSOrSSleNl_:mml_9SSlrEEmJSrbfbfErd4bf94rbfbfErbfaaEL9494Sr94EjECSmrSml_9;Tll!f,9KDyl_NOrSSOrSSleNlrSmle:mml_9SSlrEEmJSrbfaaErbfbfErbfbfEL9494SJjEEmrSCSlrSml_9;Tll!f,9KDyl_NlesSSOrSSlrSSleNl_:mml_9SSlrEEmJSLbfbfErbfbfEL9494jEEmrSCSlrSm#fr;Tll!f,:mlDAeNOrSSOeNl_:mml_9SSlrEEmJmLbfaaELaa94SJjECSlrSm#f_9;Tll!f,:KDAeNOrSSOesSmlrSml_:mml_9SSlrESmJmLaaaaSL9494SrEEjSCmylr;Tll!f,:mlDA_sSmlesSSlesSmlesSSleNlrSmle:mml_9SSlrSSmr94EmJSLaa94SJjECSyl_9;Tll!f,:KDAeNleNlesSmlrSm#fe:mml_sSSj9494Sraa94SJSr94EjSCmyl_9;Tll!f,:KDA_NleNlesSm#fe:mm#frSSj9494mJmJjEEmrSpAr;Tll!f,:KDyAeNlrSmyle:mm#frSSjEEmr94Emr94EjECSAr;Tll!f,:2akBBt~oBkrmok_9mmyA_sSmyl_:mm#frSSmrESjEEjEEmrSCmyl_9mllr;Tll!fr2ao~FUFUFUk~oBtkrlktk_9mmDyle:mm#frSSlrSSjEEjECSArmllr;Tll3-e:2avoUo~vvvkBtkrmottk_9mmD#fe:mm#frSSlrSSmrESjEEmrSCSAe:;l3u3-,9okke:2avo~k~ok,:okkrokke:2akUvkUkUvoUkUvkBkrmokrmok_9mmDl_:mm#f_9SpmrECplrSmyl_9mlle:;l3ul,:okkrIrokkroFUkUoUo~k~QQQF~QkkrovvvFUF~oBttk_9mmDle:ml#f_9SSlrSCCSArmlle:;l3ul,:oQQFtUkUk~QQQkkrok~okroQkkroFkrovvkUkUo~otUo~kBk_9mmyArmml,9mm#fesSSlrSCSlrSmyl_9mll,9;"
d={{"y#f","A"},{"ttt","B"},{"pmrS","C"},{"yyy","D"},{"7f","E"},{"k~k","F"},{"r9494","J"},{"mllrml","K"},{"raaaaSr","L"},{"=9on=9on","M"},{"sSmlesSm","N"},{"a2arl2a2a","P"},{"lrSSlrSSl","O"},{"kkrokkro","Q"},{"q2aorq2ao","R"},{"6a","S"},{"l3u!-,:","T"},{"~o~","U"},{"mr7f7fmr","j"},{"00","k"},{"3f","l"},{"55","m"},{"o1z=9oo1z","n"},{"6a55r6a6a","p"},{"15","o"},{"2a2a15r2a","q"},{"e9","r"},{"96a553fe9","s"},{"00e93f15","t"},{"f!-,:3f3f","u"},{"00~00~00~","v"},{"#f_95555","y"},{"5=9151515","z"},{"3-,:3f3f3","!"},{"e9151515e","="},{"00e92a","~"},{"3f_955553","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                