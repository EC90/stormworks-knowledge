-- source: steam id 3791754921 / vehicle.xml block#15
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
D=36
f={{"000000","I"},{"ggggg","H"},{"gggggggggg","G"},{"wwwww","V"},{"wwwwwwwwww","W"},{"xxx","Z"},{"xxxxx","Y"},{"xxxxxxxxxx","X"},{"ffffffff","g"},{"000000ff","w"},{"00000000","x"}}
H="mu!msmk15smnmnytQQLQQLALAtttyytLAm#mnmnAmnLmk15skFsmnllvm,9lmD3_,:;mu!msmFsmnAALAAmnAAkFsLLQQAAALttQQyLLtIsQAmnm#mnyLQmk00sllvm,9lmDmslmm,:;mu!me:mnAALALAmnLALAALQyALQQIsQIsQQyLtIsIsymnytmkksll~_,9lmDmslmm,:;mu!me:AAAQAAyyyAQAALQQIstQQLLtQLQALLm#ALtQllvm,:llvv~_slmm,:;mu!m,9AmnLQyQyyttQQIsttttAyLQLtllvm,:lmvv~fslm-fs;mu!m,9mnALQLLQLLQLQLLtttQQIstttLQQyQALllv3_,:lmvv3_sll-fe:;mu!m,:mnAAQLQLQyyLLQIsttttttQyQLllv3_sll-_sllv~_slm-fe:;mu!m,:AyLLAALAyLALIsIsttQQytQQyLQQllvv-fslmvvmslm-fe:;mu!-fsAyyyyLQQIsttQQLQLtQQyLAlmvv3_,:mmmslmv~_sM-fe:;mu!-fe:ALALAyLAyQIstQQLtQLLQLtyLLllvvmslm-fe:lmv3_sll-f,:;mu!-fe:mnAAQyyyLQQLLtQQyyLLQQyQM3_sMmsMmsMmslm-f,9ll~_sM-f,:;mu!-f,9AAQLQLALQQyytQQLQyyLQQLLQLlmm,9Mme:Mme:lm-f,9MmsMmsl3!ms;mu!m,=F15z=AQQLLAyyyQQLLQLQyyLQyQkkrskk15sllv~_,:mm-fsl3!m,9;muf-fe:FR5z=QLQyyyQLLQLLAQyAyykTrskT15sll~_,:m3!-fe:;mufm,:FRoz9yyLALQyLtyyLLF15z=kTrskTrskkrskk15sll3_,:m3!m,:;mufm,=FRoz=FR5sAyALAyLFR5z9kTrskTrskkrskk15sll-f,:mm-fe:;mufm,=FRoz=FRoz=FRoz=k15rskTrskTrskk15sOl-f,:mm-fs;mufm,:FRoz=FRoz=FR5e=kTrskTrskTrskkre=qlmsOl-f,:mmm,9;mufm,:FRoz=FRoz=F1oe=kk15sk15rskTrskTrskTrskk15z=llv-f,:mmms;muf-fe:FRoz=FRoz=F15z9kFe=kFskFsk15rskTrskTrskk1oz:llv3_sll-f,9;mu!me:FRoz=FRoz=F15z9kFsk15rskkrskkRoz9llvv3_sll-fs;mu!-f,=FRoz=FRoz=FRoskkke:llD~f,9;Umm-fe:kkkz=FRoz=FRoskkk,9llDvvme:;UUU;UUU;UUU;UUU;UUU;UUU;"
d={{"kn","A"},{"sbfbfE","B"},{"plsO","C"},{"vvv","D"},{"7f","E"},{"1515","F"},{"sqlmsql","J"},{"s9494","K"},{"k#","L"},{"lmmslm","M"},{"saaaaOs","N"},{"ksmkksmkk","P"},{"6a","O"},{"15#","Q"},{"1oz=15151","R"},{"s6a6ams","S"},{"krskkrskk","T"},{"mu!-f,:","U"},{"ls7f7fls","j"},{"2a","k"},{"55","l"},{"3f","m"},{"1500s","n"},{"6a55s6a6a","p"},{"5z=151515","o"},{"6a553fs6a","q"},{"15s2a2a15","r"},{"e9","s"},{"15#15#15#","t"},{"3!-f,:3f3","u"},{"~_e95555","v"},{"2a#2a#2a#","y"},{"e=151515e","z"},{"f-f,:3f3f","!"},{"9151515e9","="},{"3_e955553","~"},{"0000e9","#"},{"3f,:3f3f3","-"},{"fe955553f","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                