-- source: steam id 3791754921 / vehicle.xml block#12
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
H="UUU;UUU;UUU;UUU;UUU;UUnnne:Nv~f_9rQnsQAApv~fsmm3-,9mNs;Un3u!-,9CnsNv~f_9QQnsQAQmsFQkFApvvn_9N~f_9;Un3u!f,9Nn_9Nvv~fSpkFFkFFkFFmsFAmEns;Un3u3-e:CE~fsrAQk94FmKmKmKmKkQpEn_9;Un3un,9NEn_9rNsQApmsFQkFFmKmKQsaa94QKQKmsmm!fe:QQnSmvns;Un3unsCvv~fsrQnsQAQmsFQkFFms94FmKmKQKQMaaaaQMaaaaQMnjPsnjPsnjPe:QAAQ~f_9;Un3unsNvv~fsrQnsQAQkFFk9494mKQsaa94QMaaaaQsbfaaFsbfaaFsaaaaQ,9njPsnjPsnjPe:FFkFAp~fs;Un3une:Nvv~f_9rApmsFQkFFkFFkFFmsQQme:CnsnjPsnjPsnjPKmKQs94FkFpmSN_9;Un3u3-e:NEvvne:Nn_9d4d494sd4d494sd4d494sbfbfFMaa94QKms94FmsbfbfFMaa94QKkFFmsQAQn_9;Un3u!-sNne:Cvv~fe:d4d4aasd4d4aasd4d4aasd4d494sd4bfFsbfbfFMaa94Qsd4bf94sd4bf94sbfbfFMaaaaQKQs94FkFpmSNs;Unn!f,9CnsNEvvn_9Bmv~fe:mN_9QQnsFFmKQsbfbfFsd4d494sd4bf94sbfbfFsbfaaFM9494Qs94FkFpmSNs;Unn!f,9CEvvn_9BNsrmvn_:mN_9QQnsFFmKQsbfbfFsd4d494sd4bf94sbfbfFMaaaaQKQs94FkFpmSNs;Unn!f,:NEv~fsBQnsrQnSQnsQQnsBN_:mN_9QQnsFFmKQsbfbfFsd4d494sd4bf94sbfbfFMaa94QKkFFmsQAQn_9;Unn!f,9CEv~f_9rNSQnSQnSQnsBN_:mN_9QQnsFFmKQsbfbfFsd4bf94sbfbfFsbfaaFM9494Qs94FkFAQmsQN_9;Unn!f,9CEvn_9BNSQnSQnSQnsBNsQNe:mN_9QQnsFFmKQsbfaaFsbfbfFsbfbfFM9494QKkFFmsQpmSN_9;Unn!f,9CEvn_9BNsrQnSQnSQnsBN_:mN_9QQnsFFmKQMbfbfFsbfbfFM9494kFFmsQpmSm~fs;Unn!f,:NEv~fsBNSQnSQnsQQnsBN_:mN_9QQnsFFmKmMbfaaFMaa94QKkFpmSm~f_9;Unn!f,:CEv~fsBNSQnSQnsQQnsrNsQN_:mN_9QQnsFQmKmMaaaaQM9494QsFFkQAmvns;Unn!f,:NEv~f_9BQnsBQnsBNsQNe:mN_9QQnsQQms94FmKQMaa94QKkFAQvn_9;Unn!f,:CEv~fsBNsBNsrNsQm~fe:mN_9rQk9494Qsaa94QKQs94FkQAmvn_9;Unn!f,:CEv~f_9BNsBNsrm~fe:mm~fsQQk9494mKmKkFFmsQpv~fs;Unn!f,:CEvv~fsBNsQmvne:mm~fsQQkFFms94Fms94FkFAQv~fs;Unn3-,9njjsjLjlnlnLDDnlmlmlmO00_9mmE~fsrmvn_:mm~fsQQmsFQkFFkFFmsQAmvn_9Nns;Unn3-sj#nlj#nLnlzjLn#n#nlj#DnlmO00_9mmEv~f_:mm~fSQkFFkFAQv~fsNns;Unnn,9jlj#jlnljlzjlzj#n#n#n#Djlmlmljlmj00smjO_9mmEvne:mm~fSQmsFQkFFmsQAQv~fe:;Unnne:zzzzzOLDDDjlmj00sQj00_9mmvnsQnOsFj00sQO00_9mmv~fe:mm~f_9QpmsFApnsQmvn_9Nne:;Unnnsjlj#IszzjLO#zjLn#n#n#DDnlmlmlmO00_9mm~fsmlmj00smj00smlQlQn00_9mmvne:N~f_9QQnsQAAQv~fsNne:;UnnnszzO#zzzj#O#zDjlDmlmO00_9mN_9DDmlQj00sQnO_9mmvn,9mm~fsrQnsQpmSmvn_9Nn,9;UO#zOLj#OLO#zj#O#O#zjlzDDnlmlnO00_9jlnLDnlmj00sQnO_9mmvn,9mm~f_9QQnSQnsQQv~fsNn,9;"
d={{"pmsQ","A"},{"rNsr","B"},{"NnsN","C"},{"nlnl","D"},{"vvv","E"},{"7f","F"},{"O1Toy=9O","J"},{"s9494","K"},{"#j#","L"},{"saaaaQs","M"},{"mn","N"},{"jsnjjsnjj","P"},{"15","O"},{"6a","Q"},{"jqsjjqsjj","R"},{"s6a6ans6a","S"},{"5oy=91515","T"},{"n3u!-,:","U"},{"2a","j"},{"ms7f7fms","k"},{"1500s","l"},{"55","m"},{"3f","n"},{"6a55s6a6a","p"},{"1y=915151","o"},{"15s2a2a15","q"},{"6a553fs6a","r"},{"e9","s"},{"15#15#15#","t"},{"f!-,:3f3f","u"},{"~f_95555","v"},{"5=9151515","y"},{"2a#2a#2a#","z"},{"3-,:3f3f3","!"},{"e9151515e","="},{"3f_955553","~"},{"0000e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                