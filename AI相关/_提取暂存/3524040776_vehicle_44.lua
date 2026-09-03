-- source: steam id 3524040776 / vehicle.xml block#44
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--helihud draw TWS
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
SF=string.format
T=table
TS=T.insert
--math
M=math
Ma=M.atan
Mb=M.abs
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P=pi*2
function Mp(x,min,max)
	return M.max(min,M.min(x,max))
end
--turn per pixel
tpp=165
w,h=32*8,32*6
t1,t2,t3,t4={},{},{},{}
Ao=0
function Av(n,v,t)
	table.insert(n,v)
	local s=0
	if #n>t then for i=1,#n-t do table.remove(n,1) end end
	for i=1,#n do s=s+n[i] end return s/#n
end
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function G2AE(g)
	local l=Mv(E2R(Eu),{g[1]-sp[1],g[2]-sp[2],g[3]-sp[3]})
	return M.atan(l[1],l[2]),M.atan(l[3],l[2])
end
function AE2S(a,e)--rad
	local da,de=a-lookx,e-looky
	return w/2+da*tpp/Mc(da),h/2-de*tpp/Mc(de) end 
function Dst(p1,p2) return Mr((p1[1]-p2[1])^2+(p1[2]-p2[2])^2+(p1[3]-p2[3])^2) end
function CD(c,t)
	c,t=c%1,t%1
	if (c-t)>0.5 then t=t+1
	elseif (c-t)<-0.5 then t=t-1
	end
	return (c-t)
end
--read tws
id=1
trcid=1
Ttrc={}
TSlt={}
for i=1,8 do
	TSlt[i]={0,0,0,0,0}
end
function onTick()
	--self position
	sp={GN(1),GN(3),GN(2)}
	Eu={GN(4),GN(6),GN(5)}
	lookx=GN(19)*P--rad
	looky=GN(20)*P--rad
	p,r,c=GN(15),-GN(16),-GN(17)
	if c<0 then
		c=1+c
	end
	--global offset
	X,Y=AE2S(0,0)
	X,Y=Mf(X),Mf(Y)
	--slot lifespan check
	for i=1,8 do
		if TSlt[i][1]~=0 then
			TSlt[i][4]=TSlt[i][4]+1
		end
		if TSlt[i][4]>120 then
			TSlt[i]={0,0,0,0,0}
		end
	end
	if GN(25)~=0 then
		TSlt[GN(31)]={GN(25),GN(26),GN(27),0}
	end
	slsl=GN(32)
	if GN(28)~=0 then
		table.insert(Ttrc,{GN(28),GN(29),GN(30),60})
	end
	for i=#Ttrc,1,-1 do
		Ttrc[i][4]=Ttrc[i][4]-1
		if Ttrc[i][4]<0 then
			table.remove(Ttrc,i)
		end
	end
	--updEl(GN(28),GN(29),GN(30),trcid,Ttrc)
	--trcid=id%6000+1
end
S=screen
SC=S.setColor
function C(x)
	if x==1 then
		SC(10,220,20)
	elseif x==0 then
		SC(0,0,0)
	end
end
DC=S.drawCircle
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
DR=S.drawRect
DRF=S.drawRectF
D3F=S.drawTriangleF
function B(x,y,a,l)
	S.drawLine(x,y,x+l*Ms(0.01*a*P),y-l*Mc(0.01*a*P))
end
--draw small number
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}
num[0]=2122222
function DN(x,y,s)
	x,y=Mf(x),Mf(y)
	s=tostring(s) 
	local l=string.len(s)
	for i=1,l do
		local n,w=s:sub(i,i),4
		if n=='.' then local w=2 end
		local N=tonumber(n)
		if N then
			--if N==1 then w=2 end
			local startx,starty,dx,dy=x,y+4,0,0
			for j=1,7 do
				startx,starty=startx+dx*2,starty-dy*2
				if j==5 then starty=starty-2 end
				dx,dy=Ms(0.25*P*(j-1)),Mc(0.25*P*(j-1))
				if string.sub(num[N],j,j)=='2' then
					DL(startx,starty,startx+dx*3,starty-dy*3)
				end
			end
		else
			S.drawText(x,y,n)
		end
		x=x+w
	end
end
fcsname={'a','b','c','d','e','f','g','h'}
function onDraw()
	for i=1,#Ttrc do
		x,y=AE2S(G2AE(Ttrc[i]))
		x,y=Mf(x),Mf(y)
		SC(10,10+Ttrc[i][4],10)
		S.drawCircleF(x,y,1.4)
	end
	for i=1,8 do
		if TSlt[i][1]~=0 then
			x,y=AE2S(G2AE(TSlt[i]))
			x,y=Mf(x),Mf(y)
			SC(0,0,0)
			DRF(x-2,y-2,4,4)
			SC(22,222,22)
			DT(x-2,y+4,fcsname[i])
			msg=SF('%1.1f',Dst(TSlt[i],sp)/1000)
			DN(x-5,y-8,msg)
			DR(x-2,y-2,4,4)
			if i==slsl then
				SC(222,22,22)
				DR(x-3,y-3,6,6)
			end
		end
	end
end