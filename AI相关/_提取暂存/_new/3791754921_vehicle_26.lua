-- source: steam id 3791754921 / vehicle.xml block#26
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
H="jjj;jjj;jjj;jjj;jjj;jjoooe:Kt!f_rNNopLLmpt!fTmm3-,9mKT;jo3v=-,9KoTKoTKt!f_9NNopLmTBNmlBNLmptto_9K!f_9;jo3v=f,9Ko_9Ktt!fpopmpmlBBmlBBmlBBmTBNmpmTNmAoT;jo3v3-e:KoTKA!ferNNLml94BmTJmTJmTJmTJmTBBLAo_9;jo3vo,9KAo_rNKpLmpmTBNmlBBmTJmTJNTaa94NTJNTJmTmm=fe:NNopoTNmtoT;jo3voTKoTKtt!ferNNopLmTBNmlBBmT94BmTJmTJNTJNPaaaaNPaaaaNPo2OTo2OTo2OTo2OToEEe:NNLL!f_9;jo3voTKtt!ferNNopLmlBBmlJmTJNTaa94NPaaaaNTbfaaBTbfaaBTaaaaN,9o2OTo2OTo2OTo2OToEEe:BBmlBNLmp!fT;jo3voe:Ktt!f_rNNLmpmTBNmlBBmlBBmlBBmpme:KoTKoTo2OTo2OTo2OTo2OToEETJmTJNT94BmlBNLoTNK_9;jo3v3-e:KAttoe:Ko_9d4d494Td4d494Td4d494TbfbfBPaa94NTJmT94BmTbfbfBPaa94NTJmlBBLmpo_9;jo3v=-TKoe:KoTKtt!fe:d4d4aaTd4d4aaTd4d4aaTd4d494Td4bfBTbfbfBPaa94NTd4bf94Td4bf94TbfbfBPaaaaNTJNT94BmlBNLoer;joo=f,9KoTKoTKAtto_Qmt!fe:mK_9NNolJNTbfbfBTd4d494Td4bf94TbfbfBTbfaaBPJNT94BmlBNLoer;joo=f,9KoTKAtto_QKerNmto_:mK_9NNolJNTbfbfBTd4d494Td4bf94TbfbfBPaaaaNTJNT94BmlBNLoer;joo=f,:KAt!feQNoerNNopopopoeQK_:mK_9NNolJNTbfbfBTd4d494Td4bf94TbfbfBPaa94NTJmlBBLmpo_9;joo=f,9KoTKAt!f_rNKpopopopopopoeQK_:mK_9NNolJNTbfbfBTd4bf94TbfbfBTbfaaBPJNT94BmlBNLmTNK_9;joo=f,9KoTKAto_QKpopopopopopoeQKTNKe:mK_9NNolJNTbfaaBTbfbfBTbfbfBPJNTJmlBBLmpoTNK_9;joo=f,9KoTKAto_QKerNNopopopopoeQK_:mK_9NNolJNPbfbfBTbfbfBPJmlBBLmpoTNm!fT;joo=f,:KAt!feQKpopopopopoeQK_:mK_9NNolJmPbfaaBPaa94NTJmlBNLoTNm!f_9;joo=f,:KoTKAt!feQKpopopopopoerNKTNK_:mK_9NNoTBNmTJmPaaaaNPJNlBBLmTNmtoT;joo=f,:KAt!f_QNoeQNoeQKTNKe:mK_9NNopmT94BmTJNPaa94NTJmlBNLto_9;joo=f,:KoTKAt!feQKeQKerNKTNm!fe:mK_rNNmlJNTaa94NTJNT94BmTBBLmTNmto_9;joo=f,:KoTKAt!f_QKeQKerNm!fe:mm!fpmlJmTJmTJmlBBLt!fT;joo=f,:KoTKAtt!feQKTNmtoe:mm!fpmlBBmT94BmT94BmlBNLt!fT;joo3-,9Ey~y~yRRMD_9mmAto_rNmto_:mm!fpmTBNmlBBmlBBLmTNmto_9KoT;jooo,:EyusyRusyRRky~UumsumEs_9mmAto_:mm!fpopmlBBmlBNLt!fTKoT;joooe:Ey~ny~nDuITEnDusy~y~yuoUumsD_9mmAo_:mm!fpopmTBNmlBBLmpt!fe:;joooTsDRusyRusyuITsDusy~yRRC~yM~UkDksCRumsumsumEuNEumsuNEuNED_9mKe:oEETsDD_9mKerNNmTBNLmpoTNmto_9Koe:;jEyRusy~yRusDRusDRusy~yMMRMkD~nDRusDCRC~yRusDRuoDMusnnDCusDusDCusDuNNmpt!fTKoe:;jsDRusDRuITEnnnnnDusDRCMCM~UMksRRM~yR~nnnDCusDussuITITsDuITEsusnDuNNoTNmto_9Ko,9;"
d={{"ttt","A"},{"7f","B"},{"~s","C"},{"00","D"},{"2a","E"},{"#q#q#q#","F"},{"9494","J"},{"mo","K"},{"mpmp","L"},{"uos","M"},{"6a","N"},{"Taaaa6aT","P"},{"a2aTo2a2a","O"},{"r6amoer6a","Q"},{"~00","R"},{"2asT2a2as","S"},{"e9","T"},{"suosuos","U"},{"o3v=-,:","j"},{"~s~s~","k"},{"e97f7fme9","l"},{"55","m"},{"00us00us","n"},{"e96a6a","p"},{"3f","o"},{"sssz#sssz","q"},{"96a553fe9","r"},{"15","s"},{"!f_95555","t"},{"00e9","u"},{"f=-,:3f3f","v"},{"00~00~00","y"},{"e#151515e","z"},{"3f_955553","!"},{"3-,:3f3f3","="},{"00e92a","~"},{"9151515e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                