-- source: steam id 3791754921 / vehicle.xml block#27
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
D=34
f={{"000000","I"},{"ggggg","H"},{"gggggggggg","G"},{"wwwww","V"},{"wwwwwwwwww","W"},{"xxx","Z"},{"xxxxx","Y"},{"xxxxxxxxxx","X"},{"ffffffff","g"},{"000000ff","w"},{"00000000","x"}}
H="o3v=-,9snnD~nnnDusDRusDRC~UMCuoEsTossTEsMksksRRC~yRRCRusDuITITsnDusDuITsDuITITsDusDuNNt!fTKo,9;o3v=-,9snnnnDusDuITsyRCCMsToEsToUMsTEs~UksRky~yksCusDCRRusDCCD_9mKeQmt!fTKo,9;o3v=fe:EDCD,9snnnnnDuITITEsCRuoUMMsTossTosCMCCMCuoEsTEsRCMsTEskDusyC~nyRDe:KAoTmK,:;o3v=fTED~nnyC~URCRuITITEDCM~UMuoEuoUuoEsToUCMksks~yRRusyRCCumK,9KAoTKo,:;o3v=fTEsusDusDRuoEsTEDkDCuoEsTos~yRuITEDRC~UuoEsTossTosuoEsTosMC~UMM~yC~yRRMMumsCD_9mm!f,9KAoTKo,:;o3v=fTsDusyRCRRC~yRCR~nDRCMsTosCsTEsMsToskD~UMMCRCCMRMMCumEMRMRD_9mm!f,:mmtt!f_9Ko,:;o3v=fe:syRRusyC~yR~nyCCMsTEsCMCRks~UMuoEsTEUCRRMCRCMRMCD_9mKTmK,:KttoTKo_9K3-T;o3v=f,9EDRCRusyRuITsnnDRusDRksCCMCMCM~UMMCsTEURRCRMRCMRMCD_9mKTmK,:Kttoe:K3-e:;o3v=f,:oEETEyRC~yusnDusyksksks~yuoDMMCCuoEsTEDM~yRC~yMCumERD_9mm3-_9mmt!-,:;o3v=-e:EyRC~yusDusD~nDksC~UCCM~UMMuoECMC~y~yC~yRuoDMD_9mm3-TKt!fTmm3-,:;o3v=-e:syRRknDusDuITEykDRkUMkUks~yRC~yRRCRD_9mm3-TKt!fTmm3-,:;o3v=-e:Ey~yR~nDusyksRRkUuoUuoU~U~y~y~yRksD_9K3-e:Kt!-,:;o3v=-e:EDusDC~yR~nDusDRC~ykskD~UuoUMRCMkDC~yRRCRCuKoTKoTK3-,9mm!f_9KoTK3-,:;o3v=-,9EyRusD~nny~yksCRkUMMRksksCRC~yRRuKoTKoe:K3-,9KoTKoTKoTKoTK=fT;o3v3-,:q#EyR~nnDusy~yksCR~UMksCCMksC~yCMD_9mmt=fTK=f,9;o3voe:q#q#ED~nnDusy~yRRksR~UCRksRksRCRRC~STESTES_9mK_9mm=-,:oooe:;oo=-,:q#q#sssz#Es~nDusy~yRRkskskDkDMRCRRCCDz#ssse#EssTESTESTES_9mm=-,:;oo=-,FsDDz#ssse#Eyks~UksRCRRCDz#q#sssz9ESTESTEEsTmm=-e:;oo=-,Fq#sssz#EsksksDz#q#sssz9EEsz#sssz#ESTNm=-T;oo=-,FqFssse#ESTESTESTESe#NKerNm=f,9;o3vozFq#q#sssz#ssse#EssTESTESTESTESTESTEEsz#sssTsss_9mm!fTmm=fT;o3vo,Fq#q#sssz9EssTESTESTESTEEsz#q9sss_9mmt!-,9;o3v3-,:qFq#q#q:mmto_9mm=fe:;o3v=-,9EEEzFq#sssz#sssTsss,9mmA!fTK3-e:;joo=-,9EEEz#q9EEE,:oo3-e:mmAA!fe:;jjj;jjj;jjj;jjj;jjj;jjj;"
d={{"ttt","A"},{"7f","B"},{"~s","C"},{"00","D"},{"2a","E"},{"#q#q#q#","F"},{"9494","J"},{"mo","K"},{"mpmp","L"},{"uos","M"},{"6a","N"},{"Taaaa6aT","P"},{"a2aTo2a2a","O"},{"r6amoer6a","Q"},{"~00","R"},{"2asT2a2as","S"},{"e9","T"},{"suosuos","U"},{"o3v=-,:","j"},{"~s~s~","k"},{"e97f7fme9","l"},{"55","m"},{"00us00us","n"},{"e96a6a","p"},{"3f","o"},{"sssz#sssz","q"},{"96a553fe9","r"},{"15","s"},{"!f_95555","t"},{"00e9","u"},{"f=-,:3f3f","v"},{"00~00~00","y"},{"e#151515e","z"},{"3f_955553","!"},{"3-,:3f3f3","="},{"00e92a","~"},{"9151515e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                