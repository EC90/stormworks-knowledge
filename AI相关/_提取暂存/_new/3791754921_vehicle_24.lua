-- source: steam id 3791754921 / vehicle.xml block#24
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
H="jjj;jjj;jjj;jjj;jjj;jjpppe:Mt=f_9rPpsPnmsPnmsPnt=fsmm3-,9mMs;jp3u!-,9MpsMpsMt=f_9PPpsPnmsPPmsFPkFnmsPnttp_9M=f_9;jp3u!f,9Mp_9Mtt=fRnkFFkFFkFFmsFnmsPmDps;jp3u3-e:MpsMD=fsrnmsPPk94FmJmJmJmJkPnDp_9;jp3up,9MDp_9rMsPnmsPnmsFPkFFmJmJPsaa94PJPJmsmm!fe:PPpRmtps;jp3upsMpsMtt=fsrPpsPnmsPPmsFPkFFms94FmJmJPJPLaaaaPLaaaaPLpONspONspONe:PnmsPnmsPP=f_9;jp3upsMtt=fsrPpsPnmsPPkFFk9494mJPsaa94PLaaaaPsbfaaFsbfaaFsaaaaP,9pONspONspONe:FFkFnmsPn=fs;jp3upe:Mtt=f_9rnmsPnmsFPkFFkFFkFFmsPPme:MpsMpspONspONspONJmJPs94FkFnmRM_9;jp3u3-e:MDttpe:Mp_9d4d494sd4d494sd4d494sbfbfFLaa94PJms94FmsbfbfFLaa94PJkFFmsPnmsPPp_9;jp3u!-sMpe:MpsMtt=fe:d4d4aasd4d4aasd4d4aasd4d494sd4bfFsbfbfFLaa94Psd4bf94sd4bf94sbfbfFLaaaaPJPs94FkFnmRMs;jpp!f,9MpsMpsMDttp_9rMsrmt=fe:mM_9PPpsFFmJPsbfbfFsd4d494sd4bf94sbfbfFsbfaaFL9494Ps94FkFnmRMs;jpp!f,9MpsMDttp_9rMCmtp_:mM_9PPpsFFmJPsbfbfFsd4d494sd4bf94sbfbfFLaaaaPJPs94FkFnmRMs;jpp!f,:MDt=fCPpsrPpRPpsPPpCM_:mM_9PPpsFFmJPsbfbfFsd4d494sd4bf94sbfbfFLaa94PJkFFmsPnmsPPp_9;jpp!f,9MpsMDt=f_9rMRPpRPpRPpCM_:mM_9PPpsFFmJPsbfbfFsd4bf94sbfbfFsbfaaFL9494Ps94FkFnmsPPmsPM_9;jpp!f,9MpsMDtp_9rMsrMRPpRPpRPpCMsPMe:mM_9PPpsFFmJPsbfaaFsbfbfFsbfbfFL9494PJkFFmsPnmRM_9;jpp!f,9MpsMDtp_9rMCPpRPpRPpCM_:mM_9PPpsFFmJPLbfbfFsbfbfFL9494kFFmsPnmRm=fs;jpp!f,:MDt=fCMRPpRPpsPPpCM_:mM_9PPpsFFmJmLbfaaFLaa94PJkFnmRm=f_9;jpp!f,:MpsMDt=fCMRPpRPpsPPpsrMsPM_:mM_9PPpsFPmJmLaaaaPL9494PsFFkPnmsPmtps;jpp!f,:MDt=f_9rMsrPpCPpCMsPMe:mM_9PPpsPPms94FmJPLaa94PJkFnmsPPtp_9;jpp!f,:MpsMDt=fCMCMsrMsPm=fe:mM_9rPk9494Psaa94PJPs94FkPnmsPmtp_9;jpp!f,:MpsMDt=f_9rMCMCm=fe:mm=fsPPk9494mJmJkFFmsPnt=fs;jpp!f,:MpsMDtt=fCMsPmtpe:mm=fsPPkFFms94Fms94FkFnmsPPt=fs;jpp!fv#y00v#pyQpy_9mmDtpsrmtp_:mm=fsPPmsFPkFFkFFmsPnmsPmtp_9Mps;jpp3-,9Usy00v9olv9pyspysp0000e#pyspy_9mmDtp_:mm=fRPkFFkFnmsPPt=fsMps;jpp3-sy00v9UsIsy00sIe#y00le#y00v9pyQp0000spy_9mmD=f_:mm=fRPmsFPkFFmsPnmsPPt=fe:;jppp,:O0000sy00lv#osolv9pysp0000sp0000e#p0000spysmy_9U_9mMv9Ee#EspysMO_9y00_:mm=f_9PnmsFnmsPnpsPmtp_9Mpe:;jppp,9OKv#EspysosElsy00sEv#y00e#Usy00sEe#UsUsUsy00le#Esy00e#UsU_9mM_9PPpsPnmsPnmsPPt=fsMpe:;"
d={{"KTqz~K","A"},{"sOOSsOOS","B"},{"srMsr","C"},{"ttt","D"},{"Oy","E"},{"7f","F"},{"s9494","J"},{"1515","K"},{"saaaaPs","L"},{"mp","M"},{"OspOOspOO","N"},{"6a","P"},{"2a","O"},{"spyspys","Q"},{"s6a6aps6a","R"},{"15s2a2a15","S"},{"1qz~15151","T"},{"y00sy00","U"},{"p3u!-,:","j"},{"ms7f7fms","k"},{"v#2a0000","l"},{"55","m"},{"6a55s6a6a","n"},{"3f","p"},{"2ays2ay","o"},{"5z~151515","q"},{"6a553fs6a","r"},{"e9","s"},{"=f_95555","t"},{"f!-,:3f3f","u"},{"e#2a0000e","v"},{"1500","y"},{"e~151515e","z"},{"3-,:3f3f3","!"},{"3f_955553","="},{"9151515e9","~"},{"92a0000e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                