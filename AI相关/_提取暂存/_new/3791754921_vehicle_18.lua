-- source: steam id 3791754921 / vehicle.xml block#18
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
H="jjj;jjj;jjj;jjj;jjj;jjllle:slP~_q6alkJJskP~_,:lll,9ssly;jlu!-f,9KlyslP~_klkJsyE6aTyE6aJskB3_ysl~_y;jlu!l,9sl3_yslB~fklkskTyEETyEETyEEsyE6asksy6asBPly;jluf-fe:KBP~fq6aJTy94EsLsLsLsLTkskBP3_y;jlufl,9slBP3_qslkJsksyE6aTyEEsLsL6ayaa946aL6aLsyss-f,:llle:6a6alkly6asPly;jluflyKB~fq6alkJsyE6aTyEEsy94EsLsL6aL6aOaaaa6aOaaaa6aOl2Qyl2Qyl2Qyl2Qyl2a2ae:6a6aJJ~_y;jluflyslB~fq6alkJTyEETLsL6ayaa946aOaaaa6aybfaaEybfaaEyaaaa6a,9l2Qyl2Qyl2Qyl2Qyl2a2ae:EETyE6aJsk~fy;jlufle:slB~_q6aJsksyE6aTyEETyEETyEEskse:Klyl2Qyl2Qyl2Qyl2Qyl2a2aLsL6ay94ETyE6aJly6as3_y;jluf-fe:slBBPle:sl3_yd4d494yd4d494yd4d494ybfbfEOaa946aLsy94EsybfbfEOaa946aLTyEEJsk3_y;jlu!-fyslle:KB~fe:d4d4aayd4d4aayd4d4aayd4d494yd4bfEybfbfEOaa946ayd4bf94yd4bf94ybfbfEOaaaa6aL6ay94ETyE6aJly6asly;jl3!l,9KlyslBBP3_qslqsP~fe:ss3_klyEEsL6aybfbfEyd4d494yd4bf94ybfbfEybfaaEO94946ay94ETyE6aJly6asly;jl3!l,9KBBP3_qslqslqsP3_e:ss3_klyEEsL6aybfbfEyd4d494yd4bf94ybfbfEOaaaa6aL6ay94ETyE6aJly6asly;jl3!l,:slBB~fqslq6alq6aCqslqs3_e:ss3_klyEEsL6aybfbfEyd4d494yd4bf94ybfbfEOaa946aLTyEEJsk3_y;jl3!l,9KBB~_qsCklklklqslqs3_e:ss3_klyEEsL6aybfbfEyd4bf94ybfbfEybfaaEO94946ay94ETyE6aJsy6as3_y;jl3!l,9KBB3_qslqsCklklklqslqsly6asle:ss3_klyEEsL6aybfaaEybfbfEybfbfEO94946aLTyEEJskly6as3_y;jl3!l,9KBB3_qslqslq6aCklqslqs3_e:ss3_klyEEsL6aObfbfEybfbfEO9494TyEEJskly6as~fy;jl3!l,:slBB~fqslqsCklklqslqs3_e:ss3_klyEEsLsObfaaEOaa946aLTyE6aJly6as~_y;jl3!l,:KBB~fqslqsCklklqsly6as3_e:ss3_klyE6asLsOaaaa6aO94946ayEETksksy6asPly;jl3!l,:slBB~_qslq6alqslq6alqslqsly6asle:ss3_klksy94EsL6aOaa946aLTyE6aJP3_y;jl3!l,:KBB~fqslqslqslqslqsly6as~fe:ss3_q6aTL6ayaa946aL6ay94ETksksy6asP3_y;jl3!l,:KBB~_qslqslqslqslqs~fe:ss~fkTLsLsLTyEEJP~fy;jl3!l,:KBBP~fqslqsly6asPle:ss~fkTyEEsy94Esy94ETyE6aJP~fy;jl3!-fe:2a1515tyNANRlzRlzRlzys2a00oP~fqsP3_e:ss~fksyE6aTyEETyEEJsy6asP3_yslly;jl3!ltttyMyNttttyl0000yszRl0000Rs2a15oB3_e:ss~fklkTyEETyE6aJP~fyslly;jlll,:2a0000tAMpttAMtAMttyl0000yl0000yl0000yl0000yl0000yl0000RszoP~_e:ss~fklksyE6aTyEEJskP~fe:;luf-f,#2a0000AMttylztttppyMtpttttttRl0000yl0000RszyszyszoP~fe:ss~_ksksyE6aJskly6asP3_yslle:;"
d={{"e#","A"},{"~_o","B"},{"lklklkl","C"},{"U15yU15y","D"},{"7f","E"},{"1Smve=151","F"},{"sksk","J"},{"sllysl","K"},{"y9494","L"},{"z00","M"},{"2az","N"},{"~_yss","P"},{"yaaaa6ay","O"},{"a2ayl2a2a","Q"},{"ylzy","R"},{"5mve=1515","S"},{"sy7f7fs","T"},{"2ar15y2ar","U"},{"lu!-f,:","j"},{"y6a6a","k"},{"3f","l"},{"1ve=15151","m"},{"2azy2az","n"},{"yz00yz00","p"},{"yss~_yss","o"},{"y6as3fy6a","q"},{"2a15y2a2a","r"},{"55","s"},{"e#2a0000","t"},{"3!-f,:3f3","u"},{"5e=151515","v"},{"e9","y"},{"1500","z"},{"f-f,:3f3f","!"},{"9151515e9","="},{"3_e955553","~"},{"92a0000e9","#"},{"3f,:3f3f3","-"},{"fe955553f","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                