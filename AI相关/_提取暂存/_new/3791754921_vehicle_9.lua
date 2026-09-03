-- source: steam id 3791754921 / vehicle.xml block#9
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
H="p3u=_tvsvsvz00BsEvsvsvz00ttvz00tBRzBRzjpzvpzvpR15CBovovottvovIvz00vIvsvppRvSS!!!pvmpp,9;p3u=_tEEEvsvstBRzBovpPvpR15jpzjpzvpzvovpzvoBRzBoBmm!!3qSm!!!pvmpp,9;p3u=f,:pRRBz00BRzBsEEvIvIvsvz00BoCBpzvpzCvpzvpPvpPvovpzvovovoCttCvmp!pe:mm!!!!-f,:;p3u=f,:z00tBRPCEvsBpPCvpzCtCvIvsBovojpzCvpzvovpzvovovpztCtvmmp,9mp!pe:mm!-fe:mm!-fvmpp,:;p3u=f,:oBsvsvz00BpR15BRztBoCvpzCBRzBRzvz00CtCjpPvoCvpR15CvpzvojoCvmm!-f,9mp!pe:mm!-fe:mm!-fvmpp,:;p3u=f,:svz00vRPCttCBRzBotttCtBRPtCvpPvpPvRPvovpzvoBojRzvpzvmzvmm!-f,:mm-fe:mm!-fe:mm!-fvmpp,:;p3u=f,:svsvz00ttttttBRzttvsBovovpPCBpR15vpzvoCjpzvpR15BpzBmm!-f,:mpp,9mm!-fe:mm!pvmp3_v;p3u=f,:stvz00tBz00tttBsvz00vIvIvz00tvstvovpzBRzvpzvovpzCvpzBpzvovpzBRzvmm!p,:mpp,9mm!-f,9mm-_e:;p3u=f,:svsvsvoBz00CBpR15tBsvsvz00Bz00tvz00BoBovpzCvpzCBRzBpzCvpzvpR00vpzvz00vovmzvmm3_,9mm!-f,9mmpvmp3_e:;p3u=_vsvsttBz00ttCtvsvz00tBz00tBoCjpzjpzCjpzvpzvotBRzvmm3_,9mm!-f,9mmpvmp3_e:;p3u=_EvoBRztCBz00tBstBstttBojpzvpzCjpztBRzvmm-_,9mm!pvmpp,9D3_e:;p3u=_Evsttttvz00Bsvz00ttttBRzBojpzjpzCBoCvmm-fvmp3_,9mm!pvmp=fe:;p3u=_tvz00tttttCtBsvsttvotvovovpzvojpzBpzvpzvoCvDpvmp3_,9mm!pvmp=fe:;p3u=_e:R0000vz00ttBsttvstvsvz00ttCBovovovojpzCBRzjRzvDpe:mp3_,9Dpvmp=f,9;p3u=fe:P1re#z00tttBRzttBsvstCtvoCBoBpR00jRzvpzvoBovmm!!=fvmp=f,9;p3up,#PTre#R0000ttttvstvsvz00ttBovovoBpzvotBRzBQvQvQvRR15vmm-_,:pp=fe:;pp=_,#PTry#P1re#R0000tttBRzBstttCBoCjpzBRzty#P15y9QvQvQvRR15,:pp=f,:;pp=_vRRRy#PTry#PT5e#R0000tvsvstttBovoCvpzvoy#P1rvQvQvQvQvQ,:pp=fe:;pp=_y#J#PTry#PT5vQvQvQvQvRR15e#Sm=_v;pp=_y#J#J#P15y9Sm3qSm=f,9;pp=_e:J#J#P15y9P15e:mm!!=fv;pp=_,:J#J9P15,:pp=_v;p3up,:J#PTry#P1ry9P15,:ppp,9mm!!!!-_v;p3u=f,:J#P1ry9P15,:pp3_e:mml!!!p,9;UUpp3_,9mpll!-fe:;UUU;UUU;UUU;UUU;UUU;UUU;"
d={{"nmvS","A"},{"e~","B"},{"vRz","C"},{"mppvmp","D"},{"vsvsvs","E"},{"7f","F"},{"PTry#PTry","J"},{"qSm3qSm","K"},{"v9494","L"},{"vaaaaSv","M"},{"RvpRRvpRR","N"},{"1515","P"},{"pvSSpvSS","O"},{"RR15vRR15","Q"},{"2a","R"},{"6a","S"},{"1ry#15151","T"},{"p3u=_,:","U"},{"vpzvpzv","j"},{"mv7f7fmv","k"},{"!!!!!","l"},{"55","m"},{"6a55v6a6a","n"},{"3f","p"},{"2azv2az","o"},{"fv6a553fv","q"},{"5y#151515","r"},{"z00vz00","s"},{"e~2a0000","t"},{"f=_,:3f3f","u"},{"e9","v"},{"e#151515e","y"},{"1500","z"},{"-fe95555","!"},{"3_,:3f3f3","="},{"92a0000e9","~"},{"9151515e9","#"},{"3fe955553","-"},{"f,:3f3f3f","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                