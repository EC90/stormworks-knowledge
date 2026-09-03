-- source: steam id 3791754921 / vehicle.xml block#8
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
H="UUU;UUU;UUU;UUU;UUU;UUpppe:mp!!!-qSSpvSAAn!!!-_,9mmpv;Up3u=_,9Dpvmp!!!-fvSSpvSASmvFSkFAn!!!!-fvmp!-fv;Up3u=f,9mp-fvmplpvSSpvSnkFFkFFkFFmvFAml!pv;Up3u3_e:Dl!!3qSASk94FmLmLmLmLkSnl!-fv;Up3up,9mpl!-qSmpvSAnmvFSkFFmLmLSvaa94SLSLmvmm=fe:SSpvSSpvSm!!pv;Up3upvDl3qSSpvSASmvFSkFFmv94FmLmLSLSMaaaaSMaaaaSMpRNvpRNvpRNe:SAAS!-fv;Up3upvmpl3qSSpvSASkFFk9494mLSvaa94SMaaaaSvbfaaFvbfaaFvaaaaS,9pRNvpRNvpRNe:FFkFAn!pv;Up3upe:mpl-qSAnmvFSkFFkFFkFFmvSSme:DpvpRNvpRNvpRNLmLSv94FkFASpvSm-fv;Up3u3_e:mpllpe:mp-fvd4d494vd4d494vd4d494vbfbfFMaa94SLmv94FmvbfbfFMaa94SLkFFmvSAS-fv;Up3u=_vmppe:Dlpe:d4d4aavd4d4aavd4d4aavd4d494vd4bfFvbfbfFMaa94Svd4bf94vd4bf94vbfbfFMaaaaSLSv94FkFAS3q;Upp=f,9Dpvmpll-K!!!pe:mm-fvSSpvFFmLSvbfbfFvd4d494vd4bf94vbfbfFvbfaaFM9494Sv94FkFAS3q;Upp=f,9Dll-K3qSm!!-fe:mm-fvSSpvFFmLSvbfbfFvd4d494vd4bf94vbfbfFMaaaaSLSv94FkFAS3q;Upp=f,:mpl!!!!3qSm3qSS3qSSOpvSS3K-fe:mm-fvSSpvFFmLSvbfbfFvd4d494vd4bf94vbfbfFMaa94SLkFFmvSAS-fv;Upp=f,9Dl!!!!-qSmOOO3K-fe:mm-fvSSpvFFmLSvbfbfFvd4bf94vbfbfFvbfaaFM9494Sv94FkFASmvSm-fv;Upp=f,9Dl!!!-KOOO3KpvSmpe:mm-fvSSpvFFmLSvbfaaFvbfbfFvbfbfFM9494SLkFFmvSASpvSm-fv;Upp=f,9Dl!!!-K3qSSOO3K-fe:mm-fvSSpvFFmLSMbfbfFvbfbfFM9494kFFmvSASpvSm!pv;Upp=f,:mpl!!!!3KOOpvSS3K-fe:mm-fvSSpvFFmLmMbfaaFMaa94SLkFASpvSm!-fv;Upp=f,:Dl!!!!3KOOpvSS3qSmpvSm-fe:mm-fvSSpvFSmLmMaaaaSM9494SvFFkSAm!!pv;Upp=f,:mpl!!!!-qSm3qSS3qSm3qSS3KpvSmpe:mm-fvSSpvSSmv94FmLSMaa94SLkFAS!!-fv;Upp=f,:Dl!!!!3K3K3qSmpvSm!pe:mm-qSSk9494Svaa94SLSv94FkSAm!!-fv;Upp=f,:Dl!!!!-K3K3qSm!pe:mm!pvSSk9494mLmLkFFmvSn!!!pv;Upp=f,:Dll!3KpvSm!!pe:mm!pvSSkFFmv94Fmv94FkFAS!!!pv;Upp3_e:R0000tBpzjpzvp0000vp0000vp0000BRzjmml!!!3qSm!!-fe:mm!pvSSmvFSkFFkFFmvSAm!!-fvmppv;Uppp,~R0000Bstvz00tttvp0000jpzvpR15jpzvpzvmpl!!!!pe:mm!OkFFkFAS!!!pvmppv;UpppvRRRvz00tttvsttBIvsCBz00vpztvp0000jmzvmzvSR00vmml!-fe:mm!OmvFSkFFmvSAS!!!pe:;UR0000Bsttttvz00BsBz00Bottvp0000jpzjpzCjpzvpzvmzvmzjmzvmR00vmm-fe:mm!-fvSnmvFAnpvSm!!-fvmppe:;p3u=_,~z00ttttttttttttBsvz00tBpzvpzvovotCBpzjpzjz00jsvSAS!!!pvmppe:;p3u=_e:R0000tEBsvsvIvz00ttttBsBz00Bz00BRzvpzCjRzvpR15CvpPCttBsvsv15zv15zvIvz00vIvSSpvSm!!-fvmpp,9;"
d={{"nmvS","A"},{"e~","B"},{"vRz","C"},{"mppvmp","D"},{"vsvsvs","E"},{"7f","F"},{"PTry#PTry","J"},{"qSm3qSm","K"},{"v9494","L"},{"vaaaaSv","M"},{"RvpRRvpRR","N"},{"1515","P"},{"pvSSpvSS","O"},{"RR15vRR15","Q"},{"2a","R"},{"6a","S"},{"1ry#15151","T"},{"p3u=_,:","U"},{"vpzvpzv","j"},{"mv7f7fmv","k"},{"!!!!!","l"},{"55","m"},{"6a55v6a6a","n"},{"3f","p"},{"2azv2az","o"},{"fv6a553fv","q"},{"5y#151515","r"},{"z00vz00","s"},{"e~2a0000","t"},{"f=_,:3f3f","u"},{"e9","v"},{"e#151515e","y"},{"1500","z"},{"-fe95555","!"},{"3_,:3f3f3","="},{"92a0000e9","~"},{"9151515e9","#"},{"3fe955553","-"},{"f,:3f3f3f","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                