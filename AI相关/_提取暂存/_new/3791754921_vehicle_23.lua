-- source: steam id 3791754921 / vehicle.xml block#23
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
H="l3ul,:2a2a2arokkrokkrIrovo~F~kkrok~QkkrIrIrIrokkrIrIrokkrok~ot~FkroFUFUk~oBkrl2aorl2aorloBk_9mmyArmml,9mm#f_9SSOrSSArmll,9;l3u3-rIrIr2akkrovk~QkkroF~kkrIr2aoUkUo~kUoUoUvFUo~kUo~ot~oBttk_9mmyArmml,9mm#f_NArmll,9;l3u3-,92aQvQkkrovF~ottUvoUo~vk~otUkUoUott~okrl2akrl2akrl2atk_9mmlrlokrmo~ok_9mmylrmml,9mlDlrmml,:;l3u3-,:2avk~okroQvF~otUvQvvo~voUo~ot~otkrl2aorlott~okrokkrm2aorl2aormok_9mmylrmml,9mlDlrmll,:;l3u!frloUo~FkrovkUFUokrovvFUkUo~kUkBUoUotkrl2aorlotkroFtt~kk_9mmylrmml,9mlDlrmll,:;l3u!fe:2avkUoUFUo~vFUktUo~k~ottUoUoBUoUoB~FUFk_9mmylrmml,:mmyA_9mll,:;l3u!fe:2ao~voUoUoUoUkUkUFUvkttkrl2a~oBkrlktUoUoB~FUkk_9mmA,:mlyArml3-r;l3u!fe:2avkUvvFUvkUFUFtUk~okrl2aorloBtt~ktt~F~ktkrlkk_9mmA,:mlyy#-e:;l3u!fe:2ao~vkUFkrIrovFUkUo~FUoUk~otUoUotkrlvk~otUkkrokttk_9mmArmm3-_9mmA_9ml3-e:;l3u!fe:2avo~kUvvvkUFUo~kUFBkrl2aor2aott~ot~otUF~kttk_9mmArmm3-rmlyylrml3-e:;l3u!fe:2ao~vFUkUvvvkUo~kt~FUoBBttUFkrok~ot~kk_9mmArmm3-rmlA_9K3-e:;l3u!fe:2avvvvvvkUvF~oBt~ottUo~okroFkroFUok_9mmArml3-e:mly#-,:;l3u!fe:2aoUFUkUo~vvoUvo~vFUoBBUokrokkroFkroF~okrKl_9KlrKlrKlrml3-,9mm#f_9K3-,:;l3u!fe:2ao~FUoUkUo~FkrovvFUkUot~otUoBtUo~QQF~kkrmll,9Kle:Kle:ml3-,9KlrKlrml!fr;l3u!f,92avkUkUkUvFUoUFUo~ottUo~k~ottUo~QQkkroF~2aorRrq2a2a_9mm#-,:lllrml!f,9;l3u3-,9oo1z=9ooor2aoUkUF~otUFkrovkUoUoUoUo~ktt~k~ot~Fk=9ooo=92akkrokk=9ooorRrRrq2aor2a2ao_9mm!-,:llle:;l3ul,:on=9ooo=92aotUo~k~ottUvoUoUoUo~kUoUoUo~ok=9onrRrRrRrq2ao_9mm!-,:;l3ule:on=9onr2avkUkUoUFUo~kUoUoUoUo~kk=9on=9RrRrRrq2ao_9Sm#-,:ll3-e:;l3ulM=9onr2aoUo~vFUoUo~ok=9onrRrRrRrR=NlrSm!-r;l3ulMM=9on=9oo1zrRrRrRrq2aor2a2a1z=NlesSmlrSm!f,9;l3ulMM=9on=9qoorRrRrq2aor2a2a1z=9oo1zrooo_9mmlrSmArmm!fr;l3ule:onMMr2aoo=92aoor2aoor2aoorq2a1z=9on=9ooo_9mmD3-,9;l3ul,:onMM=9on=9oo1z=:mmDy#-r;l3u3-,:2a2a2aMM=9onrooo,9mmDDlrmml,9;TlllM=9on,:llDDyAe:;TTT;TTT;TTT;TTT;TTT;TTT;"
d={{"y#f","A"},{"ttt","B"},{"pmrS","C"},{"yyy","D"},{"7f","E"},{"k~k","F"},{"r9494","J"},{"mllrml","K"},{"raaaaSr","L"},{"=9on=9on","M"},{"sSmlesSm","N"},{"a2arl2a2a","P"},{"lrSSlrSSl","O"},{"kkrokkro","Q"},{"q2aorq2ao","R"},{"6a","S"},{"l3u!-,:","T"},{"~o~","U"},{"mr7f7fmr","j"},{"00","k"},{"3f","l"},{"55","m"},{"o1z=9oo1z","n"},{"6a55r6a6a","p"},{"15","o"},{"2a2a15r2a","q"},{"e9","r"},{"96a553fe9","s"},{"00e93f15","t"},{"f!-,:3f3f","u"},{"00~00~00~","v"},{"#f_95555","y"},{"5=9151515","z"},{"3-,:3f3f3","!"},{"e9151515e","="},{"00e92a","~"},{"3f_955553","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                