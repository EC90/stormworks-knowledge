-- source: steam id 3791754921 / vehicle.xml block#17
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
H="T3vTe:ntOP#PtTtTtPtntTtP#OJOOzJOJssssssJJT#TtJT#TtR15D~fmRo,9RR~f_9FFTNqFu~fmoT,9;T3v3-mJntTn15mTtTtTtntTtTtntzJsJsOImssssszJT#T#JT#TtRnD~f,9RR~f_9FoQRu~fmoT,9;T3v3-e:JTtT1515mT1515mTn15mTtntTtTtntzsJsImsssJntzsOOJJTtTtJOT#JT15DT,9oATmRo,:;T3v3-,9PtTn15mT1515mPtPtPtzJOP#ntTn15mntT1515mJOOJJsOPtntzsOJJT#JJ15tPtT1500_9RR~fmRo,9oATmoT,:;T3v3-,:ntTtntTtPtPtP#JP#JP#ntTtTtntOPtPtJPtJOOzJntOImzzs150000_9RR~fmRo,9oATmoT,:;T3v3-,:TtP#TtPtntTtntzzzzntzzzn1515mOP#sOOJJOJntO1500DT,:RRuu~f_9oT,:;T3v3-,:ntTtTtntT1515mPtTtzJOzntzP#JOzzntsssJsJ1500DTmRo,:ouu~fmo3-m;T3v3-,:Tn00mT#JPtJPtzOzJOOImImszOzssssOOn00D~f,:ouu~-e:;T3v3-,:ntTtPtTtTtTtPtPtzOzOOJJP#JOzzsssOJOn00D~-_9RRu~f_9o3-e:;T3v3-,:TtTtntTtPtPtJP#JOJJszzzzJsssJJOJn00D~-mouuTmo3-e:;T3v3-,:TtTtTtTtPtPtJJP#JOOJOJPtOzJntzJOOImImOOImOOzJJn00D~-mou~f_9C3-e:;T3v3-,:PtTtTtPtPtP#ntzJOOP#OJJntzPtJOImOOImImsOzJJn00DT_9o3-e:ou~-,:;T3v!fmP#TtTn00mP#PtPtPtJJOOJP#JOOzzJsJJszzn0000_9CTmCTmCTmo3-,9RR~f_9C3-,:;T3v!fe:JPtTtTtPtPtzssOJJOzOzzszzn0000,9CTe:CTe:o3-,9CTmCTmo!fm;T3v!fmnnnm151515mPtPtJJntzJsOzOzOOJOzzzzP#nn1rmTTn_9RRuTmRR!fmo!f,9;T3vT,:1S515mPtPtPtJssJOOntzzzzzzJnn1rUrUrmnn1r_9RR!-,:TTTe:;T3vTe:1Sp15mPtzzsOzzJP#ntzJJOOJJ1515yrUrUrUrU5,:TT!f,:;T3vTe:B51py5mJntzzzJJP#1S5yrUrUrUrUr,:TT!fm;T3vTe:BSpy=m1Spy=UrUrUrUrU5,:TT3-,:;T3vTe:BSpy=m1Sp15mn151rUrUrUrUrU=qR!f,9;T3vT,9BSpy=m151pyrmn151rUrUrUrUrmnn1rmnny=m15151=_9RomRR!fm;T3v3-e:BSpy=m1515y5mn151=mn1515mn1515mn151rUrUrmnn15mnny=m151py=e:RRu3-,9;T3v!f,9BSpy=mB51p1=e:RRuuTmRR3-m;jTTTe:BSpy=m1S51=,9RRA~fmRo,9;jT3vTe:nnnm1S51=mnnn,:TT3-moAATe:;jjj;jjj;jjj;jjj;jjj;jjj;"
d={{"uuu","A"},{"1Spy=m1","B"},{"oTmo","C"},{"00_9RRu","D"},{"7f","E"},{"6a","F"},{"n#","J"},{"m9494","K"},{"nmTnnmTnn","L"},{"maaaa6am","M"},{"q6aTq6aT","N"},{"ntn","P"},{"15#","O"},{"qoqoq","Q"},{"55","R"},{"51py=m151","S"},{"3f","T"},{"mnn1rmnn1","U"},{"3f3v!-,:","j"},{"6a55q6a","k"},{"55m7f7f55","l"},{"e9","m"},{"2a","n"},{"5y=e91515","p"},{"553f","o"},{"e96a","q"},{"5e92a2a15","r"},{"15#15#15#","s"},{"1500e9","t"},{"~f_95555","u"},{"f!-,:3f3f","v"},{"1=e915151","y"},{"2a#2a#2a#","z"},{"3-,:3f3f3","!"},{"5e9151515","="},{"3f_955553","~"},{"0000e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                