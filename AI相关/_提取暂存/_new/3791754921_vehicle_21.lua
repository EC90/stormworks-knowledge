-- source: steam id 3791754921 / vehicle.xml block#21
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
D=33
f={{"000000","I"},{"ggggg","H"},{"gggggggggg","G"},{"wwwww","V"},{"wwwwwwwwww","W"},{"xxx","Z"},{"xxxxx","Y"},{"xxxxxxxxxx","X"},{"ffffffff","g"},{"000000ff","w"},{"00000000","x"}}
H="p3!p,:soUoNIysoNIysoUoNssNsoFUoUoUvJNsvjsBsy2asFBFJFJjoBFJJFJJBJJBNpokNusNusNusNuuru3_,9uu#fqCpmKpyCuP3_yupp,9;p3!-fysoNIyIy2aoNIyIysoUoNsoNIy2aoNsojv~v~vFFkjssy2assypssy2asFFBjsJFJUoNsvJJNpoBNusNusNuuru3_,9uu#_mpmpmpmP#fyupp,9;p3!-fyIysoo,:2asJFsyIyIysoUojsF~vJFBjsFFkkFFBjsFB~vNIysoNsoJNsvJJkNusNuurup,9uu#_AP#fyupp,9;ptfp,:2aoJUoJNsoJF~v~vjsBFFkFkFkBsypskkJBUoUoUoNsoJBFkNuu3_ypp2ayu2asyuuPp,9upruP3_,:;ptf-fe:2aoFJJNsoJNsv~vF~vFBFFkFBsyp2asypsjsFFkJUoNsoJBNpoBNp2aNp2asy2asFkJNsvNuu#_,9upruPpyupp,:;pt!py2asJJF~vJjoFJJkFFkFksypsFBjsJkUoJFJk~v~vJJFsyuu#_,9upruPpyupp,:;pt!py2asjvJJFBNp2ajoFNpokFJjsNp2asy2asBFFB~vNsvJF~v~v~vUoNuu#_,:uuru#_yupp,:;ptf-f,:2avF~vjsJkBFkkjsjsBFFBFJFJUvjv~vJJNsoNuuPp,:upru#fyup-fy;ptf-f,:2av~vJjsFkJFNp2asypskkkFFBFFBsy2as~vUoUoNIysv~vJFNsoNuuP3_,:upru3_yuu-fe:;ptf-f,92asJNsv~vjsJJBjsFBsypsJJjoJFJjs~vNIysoUv~vJNsvNuuP3_yuu-_yuurp-fe:;ptf-f,92asjvJJFJFJJFFNp2akkBFFBFkkjoJUoUvJNsoF~vFNuuP#_,:pppyuprupyup-fe:;ptf-f,92as~v~vJjsJJFFkkFBFkBjs~v~vUoUvNsvJFNpoNuuP#_,:pppyuprppyup-fe:;ptf-f,:2avJjsFJJNsoJFBNpokFFkkjsFJJF~vUoUvJJNsvNuurp-fe:upP3_yuu-f,:;ptf-f,:2aoF~vF~vJjsJJkkBFkjoJjoJFJUoUoFJNsoJUoJNup3_yLpyLpyLpyup-f,9uu#_yL-f,:;pt!py2avJJjsjskFFkkBjsjsF~vJJUoUoUoNsvJNupp,9Lpe:Lpe:up-f,9LpyLpyu3!py;pt!p,92asFJjsjsFJFFBFkBjsjs~v~vUoNsv~vJ~nR2anyuu3_yuu-f,:pppyu3!p,9;ptf-fe:sssz=sssz9psFJjsjoBjsFFkFJF~vNsoF~vUoUoJNsoJ~nR2anR2any2a2as,:p3!-fe:;ptfpe:ssszlz=sssy2assy2asJjsjsjsjsJJF~v~vNsoJUoNsoJFoz=sssR2anR2any2any2a2as,:p3!p,:;p3!-f,:ssszlzlz92aojsjsjsjoNsoJUoFozlz=ssse=2assy2asse=2assR2anR2anyuu-f,:pp-fe:;p3!-f,lzlzlz92asFFBjsFozly2a2aszlz=sssR2anR2anz9CupyCu-f,:pp-fy;p3!-f,lzlzlzlzlzle=2assR2anR2any2anz=ssse=CupqupyCu-f,:ppp,9;p3!-f,lzlzlzlzlz=sssy2assy2a2asy2assR2anR2a2aszlyssse:uuP3_yuu-f,:pppy;ptfpzlzlzlzlzly2asse=2assy2asszlzle:uuru#_,:ppp,9;ptfp,:ssszlzlzlzlzlzlz9sss,9uururu3_,:pppy;pt!p,lzlzlzlz=sssz9sss,:uurururu#f,9;Tptf-f,:uururururuP#fe:;TTT;TTT;TTT;TTT;TTT;TTT;"
d={{"qupqu","A"},{"Nps","B"},{"6a","C"},{"pmpmpmp","D"},{"7f","E"},{"~s","F"},{"~o","J"},{"umum","K"},{"uppyup","L"},{"y9494","M"},{"oy","N"},{"#_yuu","P"},{"yaaaa6ay","O"},{"a2ayp2a2a","Q"},{"y2any2any","R"},{"uy7f7fu","S"},{"pt!-f,:","T"},{"oysooys","U"},{"~s~s~","j"},{"oypsoyps","k"},{"=sssz=sss","l"},{"y6a6a","m"},{"2asy2a2as","n"},{"3f","p"},{"00","o"},{"y6au3fy6a","q"},{"#_yuu#_yu","r"},{"15","s"},{"3!-f,:3f3","t"},{"55","u"},{"00~00~00","v"},{"e9","y"},{"e=151515e","z"},{"f-f,:3f3f","!"},{"9151515e9","="},{"00e92a","~"},{"3_e955553","#"},{"3f,:3f3f3","-"},{"fe955553f","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                