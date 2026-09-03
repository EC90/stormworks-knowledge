-- source: steam id 2835713385 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2835713385
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

TT=false



Tx,Ty=1,8
y=32
z=0
E=0
Tim=0
Lim=240

function onTick()
ON = input.getBool(1)
if ON == false then
	Tim=0
	Change = false
else 
	if Tim<Lim then
		Tim=Tim+1
		Change = false
	elseif Tim==Lim then
		Change = true
	end
end

if Tim>1 then
Turnon=true
else
Turnon=false
end

if Tim<Lim/2 then
	E=2*Tim/Lim
	TT=false
else
	E=1
	TT=true
end

if E == 1 then
	if y > 14 then
		y=y-0.75
	elseif y>12 then
		y=y-0.125
	elseif y <= 10 then
		y=y
	end
	if Tx<44 then
		Tx=Tx+1.25
	elseif Tx<46 then
		Tx=Tx+0.125
	elseif Tx>=50 then
		Tx=Tx
	end
else
	y=32
	Tx=0
end

output.setBool(1,Change)
output.setBool(2,Turnon)
end

function onDraw()
	A=x.getWidth()
	B=x.getHeight()
	x.setColor(0,0,0)
	x.drawClear()
	x.setColor(20,20,20)
	if TT==true then
		x.drawText(Tx+1, Ty+1, "FAULDS")
		x.drawText(Tx+2, Ty+9, "INDUSTRY")
		x.setColor(255,255,255)
		x.drawText(Tx, Ty,"FAULDS")
		x.drawText(Tx+1, Ty+8,"INDUSTRY")
	end
	x.setColor(0,0,0)
	x.drawRectF(0,0,40,32)

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

D=1
f={{"000000","I"},{"ggggg","H"},{"gggggggggg","G"},{"wwwww","V"},{"wwwwwwwwww","W"},{"xxx","Z"},{"xxxxx","Y"},{"xxxxxxxxxx","X"},{"ffffffff","g"},{"000000ff","w"},{"00000000","x"}}
H="F;F;XXxmYxx;Y###Xxx#qqqYZ;Y##q#Xx##qqYZ;Zx#qqq##Yxx~05:m#Yxx;Zx#qqm#xx~,n05:##Yxx;Zmmn,kO~,Jxx;Zm#~R-:O~RO1f0Rr:O~,Y;ZK,krf~R-:O1f0,Y;LO1f0RzO~ROJ;L-:O~RrfJ;ZKRO~,krfJ;Zssn,k-:O~,~,n,Y;xxsss~,n,pf=f=f~,n05:Z;xsss##n05:pf=:zzOpf=f=fn,x;xssj!#1f0,p:z-:BvA-:B:pfY;xsj!jf5:#=f=:zAB_kzovB:=f=fY;D=:zovzkylNy:=:OY;DkzB_IkNy:00-:evNc:=:OY;P!#kzkc:IkIkt:e:evylUc_=:OY;P!SUc_k-:OY;Tf5:TM;xj!jM;xj!j!#kz-vc_00-vQclY;xm#kz-vQy_e:c:Zx;Zp:z-vEevc:PCe:c_Zx;Zp:zzkEkPf5ljCY;Z=fxkzz-vy_e:y_Zj!Y;YxkzzOxkovovB:XY;F;F;;"
d={{"z-:ovz","A"},{"af8","B"},{"f5:jf5_","C"},{"usu6f6!#","D"},{"ylIevc:I","E"},{"XXXxx","F"},{"~05:Y","J"},{"##nRrf1f0","K"},{"Z##~,kOnR","L"},{"!StvyvOYx","M"},{"IkIkIev","N"},{"uuu6f6","P"},{"-f","O"},{"y_e:y_e:","Q"},{"05v","R"},{"#kzkc_Uyl","S"},{"6f6f5:6f6","T"},{"tf00-v","U"},{"5f5","j"},{"ef","k"},{":e:c:","l"},{"####","m"},{"~,1f0","n"},{"=f=f=","p"},{"af8vaf8","o"},{"1f1f1:","q"},{"-f1f0,ef-","r"},{"bfbfb:","s"},{"00-f00-","t"},{"9faf7:","u"},{":ef","v"},{"c_e:c","y"},{"-:-:","z"},{"f5:5f5f5:","!"},{"cf6f00e","="},{"1f0,1f0","~"},{"2f2f2:","#"},{"8f00e","-"},{":e:c:e:c:","_"},{"05:1f005:",","},{"fef",":"}}
C=a(H)
                
                