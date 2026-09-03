-- source: steam id 3791754921 / vehicle.xml block#19
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
D=32
f={{"000000","I"},{"ggggg","H"},{"gggggggggg","G"},{"wwwww","V"},{"wwwwwwwwww","W"},{"xxx","Z"},{"xxxxx","Y"},{"xxxxxxxxxx","X"},{"ffffffff","g"},{"000000ff","w"},{"00000000","x"}}
H="l3!l,:ll2appyIpyMtAMttANRlzyNttAMAMtyMttpAMyMtttyl0000tRlzyszyszoP3_e:sl~_klkJJP~fyslle:;l3!l,:MyMyIyMyNpyMAMtynyNy2a1515yNy2a1515RNylzAnAlztAMtAItptpyMtyMtttyl0000RszyszoPl,9ss~fq6alkJly6asP3_ysll,9;l3!l,:2a2a2apyIyMyIynttAnRNyl1515y2a1515y2a1515yl1515ynynyntttppppppptANtAlzyszyszo~_,9ss~_klklklkP~fysll,9;lufle:nyNtynynynRNRNRnyNRnttyMAMpppppppttAl0000Rszo~_,9ss~_qslqsP~fysll,9;lufl,:2a0000yNtynyNyl2a00RNyl2a00ynyl1515RlzRlzRlzynttpyIppppppptyNANylzo~_,9slBP3_,:;luf-fe:2a0000ANtRNRlzyNyl1515yl2a15RnynynttAlzyIyMtyl1515ynyNyl2a15A2a2a15tAMpyMANtylzo~f,9slBPlysll,:;lu!lynyNRl2a15RlzRl1515yl2a15RlzynANyl1515tAMA2a1515tANR2a1515ylzANANANtANAMyNyMyNyMo3_,9slBPlysll,:;lu!lAlzyl2a15RlzynynynRnyNyl2a15yNtAMttANtttttttAMAMyl2a2ao3_,:ssB~_ysll,:;lu!lyNylzAl2a15RNANRNRlzynynyntAMyMANtyNtAMtAMttAMpyMo~f,:slB~fysl-fy;luf-f,:2a0000AlzynylzAlzRlzyNRlzynAntyMtAIyIyIyMyIpyMyIANpANAMttylzo~f,:slB3_yss-fe:;luf-fe:NtAlzyl2a00RnANAnynynAnAMtAMppyMtttyMtAMyMAMAlzo3_yss-_o~_ysl-fe:;luf-fe:2a0000ANyMANRlzRlzynRlzRlzRnynyNAMtpyMttttyNttAMpyl0000AssP3_yss-fyslBlysl-fe:;luf-f,#2a0000tRlzRnRlzylzANtAnttyMtAMyMANttANtAIppyl0000o~_,:lllyslP~_yK-fe:;luf-f,:nynRlzynyNRlzynynyNtyNtttyMyNANpttyNtpyMtto~fysl-fe:slP3_yss-f,:;luf-f,:nyNRlzyNRlzRlzynynyNAnANttpyMtAMAMyMtyNttAMyMAsslyKlyKlyKlysl-f,9ss~_yK-f,:;lu!lynylzANAlzRlzynynAnynAMtppyMAMpyNtAMyMtAMyMy2a0000,9Kle:Kle:sl-f,9KlyKlys3!ly;lu!le:nANRlzyNRlzRnynynyNtANppppyMttANtyMAU15y2ar15e:ss~_,:ll-fys3!l,9;lufl,:1515mvy151515AnyNAnyNtynyNtttpptptyNtttyDU15y2ar15y2a2a15,:l3!-fe:;lufle=151S1ve=nyNAnyNAnAMttppyMAMttAne=1515m5e=DU15yU15,:l3!le:;l3!-f,=15F515ynyNttttyMAMyNpttANe=151S15e=DD2a2a15,:l3!ly;l3!-f,=15FSmve=15F515yDDU2a,:ll-f,:;l3!-f,=15FSmve=151S1vyDDU15y2ar1ve=2a2a2ay6as-f,:lll,9;l3!-f,:15FSmve=15F515yD2armve=151515e=ss~_,:ll-fy;lufl,=15FSmve=151S1vy2aF515y151515e:ssP~_,:lll,9;luf-f,:15FSmve=15F51vy151515,9ssBP3_,:llly;jllle=15FSmve=151515y151515,:ssBBP~f,9;jlu!l,:ssBBBB~fe:;jjj;jjj;jjj;jjj;jjj;jjj;"
d={{"e#","A"},{"~_o","B"},{"lklklkl","C"},{"U15yU15y","D"},{"7f","E"},{"1Smve=151","F"},{"sksk","J"},{"sllysl","K"},{"y9494","L"},{"z00","M"},{"2az","N"},{"~_yss","P"},{"yaaaa6ay","O"},{"a2ayl2a2a","Q"},{"ylzy","R"},{"5mve=1515","S"},{"sy7f7fs","T"},{"2ar15y2ar","U"},{"lu!-f,:","j"},{"y6a6a","k"},{"3f","l"},{"1ve=15151","m"},{"2azy2az","n"},{"yz00yz00","p"},{"yss~_yss","o"},{"y6as3fy6a","q"},{"2a15y2a2a","r"},{"55","s"},{"e#2a0000","t"},{"3!-f,:3f3","u"},{"5e=151515","v"},{"e9","y"},{"1500","z"},{"f-f,:3f3f","!"},{"9151515e9","="},{"3_e955553","~"},{"92a0000e9","#"},{"3f,:3f3f3","-"},{"fe955553f","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                