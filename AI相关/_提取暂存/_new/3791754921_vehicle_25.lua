-- source: steam id 3791754921 / vehicle.xml block#25
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
H="jppp,#Ee#pysospKsosEe#Elv9y00e#UsUsEsUsUsIsUsy00v#Ee#UsUsy00sOOO_9mM_9rPpsPnmRmtp_9Mp,9;jppp,#EQpysEspysososElv#osUsy00sIsUsIsIsUe#Uv#EsUsIsUe:mm=f_9PPpRPpsPPt=fsMp,9;p3u!f,:E,:pppe:y00sEspKQpyQpysoe#ole#ososEe#IsIsy00e#EsUe#Usy00v#UsO0000_9Ie:mm=f_9rMsrmt=fsMp,9;p3u!f,:Esy00e#O0000,9y00QpO15sospO15QpysEe#osEle#ov9Ev9pysmO00QpysUsUsy00l_9mM,9MDpsmM,:;p3u!f,:y00sEspO15sEsUe#pyspO15QpysososEe#Ee#Ele#Ulv9pysmO00e#pylsy00v#ppO_9mM,9MDpsMp,:;p3u!f,:osEe#EsIe#EsOKsEspO15spysoQpyv#ov#y00le#Ee#Ee#pyv#pyv9oso_9mMsmM,9MDpsMp,:;p3u!f,:O0000v9EsUsosospye#pyQpysospO15e#EspyllsEv#Espyle#Ev9pysppO_9mMsmM,:mmtt=f_9Mp,:;p3u!-le:Espysosososp0000QpyspysEspyllv9Ee#Ee#Ev#Ee#Ee#o_9mm=f,:Mtt=fsM3-s;p3u!-le:osEspKsEspyspye#pyspyspO15sEe#pyspyv9Ev9Ev9Elv9Ele#osE_9mm=f,:Mtt=-e:;p3u!-e:ElsospysosEsp0000spysosospyv#Ellv9Ulv#EsO0000_9mm=-_9mmt=f_9M3-e:;p3u!-e:O0000sEsUe#EQpyspysEQpyspO00spysEspylllle#pylv9E_9mm=-sMttpsM3-e:;p3u!-,#Esy00e#y00e#oQoQpysElllsEle#Elv9E_9mm=-sMt=f_9MpsM3-e:;p3u!-,#Ue#UsosEQpyQEspysEle#Elle#EllsE_9mM_9M3-e:Mt=-,:;p3u!-,9UsUe#Ue#oQpyspysEe#pysEllle#osElv9osMpsMpsMpsM3-,9mm=f_9MpsM3-,:;jUsy00e#y00v9osEQpysososEllsEv9osolv9O0000e:MpsMpe:M3-,9MpsMpsMpsMpsM!fs;p3u!fz~K1qsy00e#y00lsoQpyv9pyQolsElv#Ev9oe#E_9mmt!fsM!f,9;p3up,:KTqe~Usy00z#Ee#ospysEe#ososEv#ElsospysEv9Ev9EB_9mm=fsmm!-,:pppe:;p3upe:A15sy00z~K15e~osEe#ososElsoe#Ev9pyQElsEBBsppO_9mMsmm!-,:;p3upe:AT5spysososEv9Ev#Ee#Ee#osEv9Ez~K15e~O15SBBsPm=-,:pp3-e:;p3upe:AT5e~osososososoe#O15Tqe~OOSBsOOSsOO15Cm!-s;p3upe:ATqz~A1qBBsOO15CMsrm!f,9;p3up,~ATqz~A15z9O15SBz9K15_9mmt=-,:ppps;p3u3-z~ATqz~A1qz9K15_9mmtt3-,9;p3u!fz~ATqz~A15sK15_9mmD3-s;p3u!-e:ATqz~KT5z9K15e:mmDt=f,9;jpp3-,~AT5sK15,:ppp,:mmDttp_:;jjj;jjj;jjj;jjj;jjj;jjj;"
d={{"KTqz~K","A"},{"sOOSsOOS","B"},{"srMsr","C"},{"ttt","D"},{"Oy","E"},{"7f","F"},{"s9494","J"},{"1515","K"},{"saaaaPs","L"},{"mp","M"},{"OspOOspOO","N"},{"6a","P"},{"2a","O"},{"spyspys","Q"},{"s6a6aps6a","R"},{"15s2a2a15","S"},{"1qz~15151","T"},{"y00sy00","U"},{"p3u!-,:","j"},{"ms7f7fms","k"},{"v#2a0000","l"},{"55","m"},{"6a55s6a6a","n"},{"3f","p"},{"2ays2ay","o"},{"5z~151515","q"},{"6a553fs6a","r"},{"e9","s"},{"=f_95555","t"},{"f!-,:3f3f","u"},{"e#2a0000e","v"},{"1500","y"},{"e~151515e","z"},{"3-,:3f3f3","!"},{"3f_955553","="},{"9151515e9","~"},{"92a0000e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                