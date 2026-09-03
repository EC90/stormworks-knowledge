-- source: steam id 2816850764 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2816850764


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
H="Ruuz#y,uuz#Q;I,uu~~yuu,r;ISu_!~~~~u_S:;I#uz!~q~q~,uzNQ;P,u~_#y,_#yyuqr;PSsoysps#y,sN:;P#_oyuouoy_S_Q;I_q#yuzyuzyq#_r;I_Ny,uvvkuyq,_:;I_#os!vzoz!vsoSsQ;IOk_pm-Or;I_#yt-sos!k_o,sQ;I_o#z=uyu-z#p_:;I_TN-uou!-zqo_r;P#T#kupu=-q#y_Q;Pp_-,uzyuz,-_y_Q;PotSs=vk-s#!-_oz:;Py,_-z,tkzTk-_N-_yqr;Py_-z#z!k_y_kzN=_Tr;PT=_S=_pm#tz#qr;Ip_-_#-O-,m_TQ;I#q=s-,O,-s-z#qQ;Io_-m#A;US_B;U#C;Ioz=t_ND;E;IT=ms-J;K;l,oNj;loT!j;Rn-~yM;Rn-~yM;loT!j;l,oNj;K;IT=ms-J;E;Ioz=t_ND;U#C;US_B;Io_-m#A;I#q=s-,O,-s-z#qQ;Ip_-_#-O-,m_TQ;PT=_S=_pm#tz#qr;Py_-z#z!k_y_kzN=_Tr;Py,_-z,tkzTk-_N-_yqr;PotSs=vk-s#!-_oz:;Pp_-,uzyuz,-_y_Q;P#T#kupu=-q#y_Q;I_TN-uou!-zqo_r;I_o#z=uyu-z#p_:;I_#yt-sos!k_o,sQ;IOk_pm-Or;I_#os!vzoz!vsoSsQ;I_Ny,uvvkuyq,_:;I_q#yuzyuzyq#_r;P#_oyuouoy_S_Q;PSsoysps#y,sN:;P,u~O~uqr;I#uz!~q#q#~uzNQ;ISu_!~~~~u_S:;I,uu~~yuu,r;Ruu_yuu_,Q;;"
d={{"_p_#=m_y:","A"},{"o_N!-mzp:","B"},{"_y_q=mzp:","C"},{"vkz,ttzp:","D"},{"Iy_-t_#!F","E"},{"-p=Smt_yr","F"},{"zT-s-mzpr","J"},{"IT=ts-SpL","K"},{"#!-s-tzpr","L"},{",-~n,-n,Q","M"},{"!q","N"},{"Iz","P"},{"sys","O"},{"ef","Q"},{"1f4f1f","R"},{"!,","S"},{"yz","T"},{"Ioz=mz","U"},{"-mtzpr","j"},{"--","k"},{"Iyz=tmz","l"},{"_=","m"},{"~y-~y","n"},{"#,","p"},{"!y","o"},{",z","q"},{"!ef","r"},{"_z","s"},{"_!-","t"},{"__","u"},{"----","v"},{",,","y"},{":I","z"},{"efI","!"},{":002f1f","="},{",,,,,","~"},{":1f4f1f","#"},{"ef002f1f","-"},{":I:I","_"},{"ef1f4f1f",","},{"efIefIef",":"}}
C=a(H)