-- source: steam id 3791754921 / vehicle.xml block#16
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
H="jjj;jjj;jjj;jjj;jjj;jjTTTe:ou~f_9FoqFTqkRqkRqku~fmRR3-,9Rom;jT3v!-,9CTmou~f_9FFTqkRqFRmEFlmEkRqkuuT_9o~f_9;jT3v!f,9oT_9ouu~fqFTqklmEElmEElmEERmEkRqRATm;jT3v3-e:CA~fqoqkRqFlm94ERKRKRKRKlqkAT_9;jT3vT,9oAT_9FoqoqkRqkRmEFlmEERKRKFmaa94FKFKRmRR!fe:FFTqFTqRuTm;jT3vTmCuu~fqoqFTqkRqFRmEFlmEERm94ERKRKFKFMaaaaFMaaaaFMTnLmTnLmTnLe:FkRqkRqF~f_9;jT3vTmouu~fqoqFTqkRqFlmEElKRKFmaa94FMaaaaFmbfaaEmbfaaEmaaaaF,9TnLmTnLmTnLe:EElmEkRqk~fm;jT3vTe:ouu~f_9FoqkRqkRmEFlmEElmEElmEERqFRe:CTmTnLmTnLmTnLKRKFm94ElmEkRqFTqo_9;jT3v3-e:oAuuTe:oT_9d4d494md4d494md4d494mbfbfEMaa94FKRm94ERmbfbfEMaa94FKlmEERqkRqFT_9;jT3v!-moTe:Cuu~fe:d4d4aamd4d4aamd4d4aamd4d494md4bfEmbfbfEMaa94Fmd4bf94md4bf94mbfbfEMaaaaFKFm94ElmEkRqFTqom;jTT!f,9CTmoAuuT_9FoQRu~fe:Ro_9FFTmEERKFmbfbfEmd4d494md4bf94mbfbfEmbfaaEM9494Fm94ElmEkRqFTqom;jTT!f,9CAuuT_9FoQoqoqRuT_:Ro_9FFTmEERKFmbfbfEmd4d494md4bf94mbfbfEMaaaaFKFm94ElmEkRqFTqom;jTT!f,:oAu~fQoqFTqoNNQoqo_:Ro_9FFTmEERKFmbfbfEmd4d494md4bf94mbfbfEMaa94FKlmEERqkRqFT_9;jTT!f,9CAu~f_9FoqoNNNQoqo_:Ro_9FFTmEERKFmbfbfEmd4bf94mbfbfEmbfaaEM9494Fm94ElmEkRqFRqo_9;jTT!f,9CAuT_9FoQoNNNQoqoqoe:Ro_9FFTmEERKFmbfaaEmbfbfEmbfbfEM9494FKlmEERqkRqFTqo_9;jTT!f,9CAuT_9FoQoqoNNqFTQoqo_:Ro_9FFTmEERKFMbfbfEmbfbfEM9494lmEERqkRqFTqR~fm;jTT!f,:oAu~fQoqoNNqFTQoqo_:Ro_9FFTmEERKRMbfaaEMaa94FKlmEkRqFTqR~f_9;jTT!f,:CAu~fQoqoNNqFTQo_:Ro_9FFTmEFRKRMaaaaFM9494FmEElqkRqRuTm;jTT!f,:oAu~f_9FoQFTQoqFTQoqoqoe:Ro_9FFTqFRm94ERKFMaa94FKlmEkRqFuT_9;jTT!f,:CAu~fQoQoQoqoqR~fe:Ro_9FoqFlKFmaa94FKFm94ElqkRqRuT_9;jTT!f,:CAu~f_9FoQoQoQR~fe:RR~fqFlKRKRKlmEERqku~fm;jTT!f,:CAuu~fQoqoqRuTe:RR~fqFlmEERm94ERm94ElmEkRqFu~fm;jTT!-mTn15mJJPtTtTtJTtntTtTtT#RtT00DuTqoqRuT_:RR~fqFRmEFlmEElmEERqkRqRuT_9oTm;jTT3-,:JP#JntzzzzT#TtRtRtRtR15DuuTe:RR~fqFTqFlmEElmEkRqFu~fmoTm;jTTT,:TnnmJOOJJOOJJOJOzzImOJJT#TtRtFn00qn00q15Du~fe:RR~fqFTqFRmEFlmEERqkRqFu~fe:;T3v3-,:zzJTnn,:sOJOOJJOzOzOzJJTtTtT#T#TtFn00mRn00mR15DuT_:RR~f_9FkRmEkRqkTqRuT_9oTe:;T3vTe:sOJJPtntzJsJImOOzP#OJJOJJOJOzzJJT#JJORtFn00q15DuTe:o~f_9FFTqkRqkRqFu~fmoTe:;T3vTe:sJntTn15mTtP#P#P#JOJOJszOJP#OOJO15tsJsOJJT#T#T#T#RtR15DuT,9RR~fqoqFTqkRqFTqRuT_9oT,9;"
d={{"uuu","A"},{"1Spy=m1","B"},{"oTmo","C"},{"00_9RRu","D"},{"7f","E"},{"6a","F"},{"n#","J"},{"m9494","K"},{"nmTnnmTnn","L"},{"maaaa6am","M"},{"q6aTq6aT","N"},{"ntn","P"},{"15#","O"},{"qoqoq","Q"},{"55","R"},{"51py=m151","S"},{"3f","T"},{"mnn1rmnn1","U"},{"3f3v!-,:","j"},{"6a55q6a","k"},{"55m7f7f55","l"},{"e9","m"},{"2a","n"},{"5y=e91515","p"},{"553f","o"},{"e96a","q"},{"5e92a2a15","r"},{"15#15#15#","s"},{"1500e9","t"},{"~f_95555","u"},{"f!-,:3f3f","v"},{"1=e915151","y"},{"2a#2a#2a#","z"},{"3-,:3f3f3","!"},{"5e9151515","="},{"3f_955553","~"},{"0000e9","#"},{"f,:3f3f3f","-"},{"e955553fe","_"},{"e:3f3f3fe",","},{"93f3f3fe9",":"}}
C=a(H)
                