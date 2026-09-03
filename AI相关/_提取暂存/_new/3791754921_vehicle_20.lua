-- source: steam id 3791754921 / vehicle.xml block#20
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
H="TTT;TTT;TTT;TTT;TTT;TTpppe:upP#_qCpmKKumP#_,:ppp,9uupy;Tpt!-f,9LpyupP#_mpmKuyECSyECKumru3_yup#_y;Tpt!p,9up3_yupru#fmpmumSyEESyEESyEEuyECumuyCuruPpy;Tptf-fe:LruP#fqCKSy94EuMuMuMuMSmumruP3_y;Tptfp,9upruP3_qupmKumuyECSyEEuMuMCyaa94CMCMuyuu-f,:pppe:CCpmpyCuPpy;TptfpyLru#fqCpmKuyECSyEEuy94EuMuMCMCOaaaaCOaaaaCOp2Qyp2Qyp2Qyp2Qyp2a2ae:CCKK#_y;Tptfpyupru#fqCpmKSyEESMuMCyaa94COaaaaCybfaaEybfaaEyaaaaC,9p2Qyp2Qyp2Qyp2Qyp2a2ae:EESyECKum#fy;Tptfpe:upru#_qCKumuyECSyEESyEESyEEumue:Lpyp2Qyp2Qyp2Qyp2Qyp2a2aMuMCy94ESyECKpyCu3_y;Tptf-fe:upruruPpe:up3_yd4d494yd4d494yd4d494ybfbfEOaa94CMuy94EuybfbfEOaa94CMSyEEKum3_y;Tpt!-fyuppe:Lru#fe:d4d4aayd4d4aayd4d4aayd4d494yd4bfEybfbfEOaa94Cyd4bf94yd4bf94ybfbfEOaaaaCMCy94ESyECKpyCupy;Tp3!p,9LpyupruruP3_AP#fe:uu3_mpyEEuMCybfbfEyd4d494yd4bf94ybfbfEybfaaEO9494Cy94ESyECKpyCupy;Tp3!p,9LruruP3_ApquP3_e:uu3_mpyEEuMCybfbfEyd4d494yd4bf94ybfbfEOaaaaCMCy94ESyECKpyCupy;Tp3!p,:upruru#fqupqCpqCDA3_e:uu3_mpyEEuMCybfbfEyd4d494yd4bf94ybfbfEOaa94CMSyEEKum3_y;Tp3!p,9Lruru#_quDmpmpmpA3_e:uu3_mpyEEuMCybfbfEyd4bf94ybfbfEybfaaEO9494Cy94ESyECKuyCu3_y;Tp3!p,9Lruru3_ADmpmpmpApyCupe:uu3_mpyEEuMCybfaaEybfbfEybfbfEO9494CMSyEEKumpyCu3_y;Tp3!p,9Lruru3_ApqCDmpA3_e:uu3_mpyEEuMCObfbfEybfbfEO9494SyEEKumpyCu#fy;Tp3!p,:upruru#fADmpmpA3_e:uu3_mpyEEuMuObfaaEOaa94CMSyECKpyCu#_y;Tp3!p,:Lruru#fADmpmpqupyCu3_e:uu3_mpyECuMuOaaaaCO9494CyEESmumuyCuPpy;Tp3!p,:upruru#_qupqCpqupqCpApyCupe:uu3_mpmuy94EuMCOaa94CMSyECKP3_y;Tp3!p,:Lruru#fApApqupyCu#fe:uu3_qCSMCyaa94CMCy94ESmumuyCuP3_y;Tp3!p,:Lruru#_ApApqu#fe:uu#fmSMuMuMSyEEKP#fy;Tp3!p,:LruruP#fApyCuPpe:uu#fmSyEEuy94Euy94ESyECKP#fy;Tp3!-fy2aoBjsFkNpokBNusNusNuuru#fquP3_e:uu#fmuyECSyEESyEEKuyCuP3_yuppy;Tpp-f,:2av~v~vjokJJNpoBNpoJNusNusNuuruP#fe:uu#fmpmSyEESyECKP#fyuppy;Tppp,9p2asy2aoF~v~vJJUv~vJNpoNpoJBNpoNpoNusNusNusNusNuuruPpe:uu#fmpmuyECSyEEKumP#fe:;p3!-f,92ass,:soo,:2avJJ~2a2ay2aoF~v~vNsvNsvBJJF~v~v~vJkJkNusNusBNuuru#_e:uu#_mumuyECKumpyCuP3_yuppe:;p3!-fysoUoUoUoUoNsvUoUoNsoFUoJNsoJNsvjoFkBFJjvF~vJJNpoNpoBNusNusNusNC2aNuuru#fe:up#_mpmKKP#fyuppe:;"
d={{"qupqu","A"},{"Nps","B"},{"6a","C"},{"pmpmpmp","D"},{"7f","E"},{"~s","F"},{"~o","J"},{"umum","K"},{"uppyup","L"},{"y9494","M"},{"oy","N"},{"#_yuu","P"},{"yaaaa6ay","O"},{"a2ayp2a2a","Q"},{"y2any2any","R"},{"uy7f7fu","S"},{"pt!-f,:","T"},{"oysooys","U"},{"~s~s~","j"},{"oypsoyps","k"},{"=sssz=sss","l"},{"y6a6a","m"},{"2asy2a2as","n"},{"3f","p"},{"00","o"},{"y6au3fy6a","q"},{"#_yuu#_yu","r"},{"15","s"},{"3!-f,:3f3","t"},{"55","u"},{"00~00~00","v"},{"e9","y"},{"e=151515e","z"},{"f-f,:3f3f","!"},{"9151515e9","="},{"00e92a","~"},{"3_e955553","#"},{"3f,:3f3f3","-"},{"fe955553f","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                