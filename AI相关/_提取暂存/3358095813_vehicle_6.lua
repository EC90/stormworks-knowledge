-- source: steam id 3358095813 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3358095813
--TWS draw datalink shared
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P=pi*2
T=table
TS=T.insert
function Mp(x,min,max)
	return M.max(min,M.min(x,max))
end
function Dst(p1,p2) return Mr((p1[1]-p2[1])^2+(p1[2]-p2[2])^2+(p1[3]-p2[3])^2) end
function Sortdg(a,b) return a.dg>b.dg end
function Sortid(a,b) return a.id>b.id end
mergedist=PN('merge dist')
D={}
F={}
R={}
id=1
cur=1
function onTick()
	--rend
	w=mF(GN(32)/10)*32
	h=mF(GN(32))%10*32
	wh=w/2
	hh=h/2
	zoom=GN(32)%1
	--self position
	cps=GN(29)
	sp={GN(30),GN(31),25}
	--renderer
	rdl=GN(19)>0
	rar=GN(20)>0
	--friendly
	if #F>0 then
		for i=1,#F do
			F[i][5]=F[i][5]+1
			if F[i][5]>120 then
				T.remove(F,i)
				break
			end
		end
	end
	if #R>0 then
		for i=1,#R do
			R[i][5]=R[i][5]+1
			if R[i][5]>1200 then
				T.remove(R,i)
				break
			end
		end
	end
	if GN(5)~=0 then
		if #F>0 then
			id=GN(1)+0.1
			match=0
			for i=1,#F do
				if F[i][4]==id then
					F[i]={GN(5),GN(6),GN(7),id,0}
					match=1
					break
				end
			end
			if match==0 then
				TS(F,{GN(5),GN(6),GN(7),id,0})
			end
		else
			TS(F,{GN(5),GN(6),GN(7),id,0})
		end
	end
	if GN(10)~=0 then
		if #F>0 then
			match=0
			id=GN(1)+mF(GN(15)/1e5)/10
			for i=1,#F do
				if F[i][4]==id then
					F[i]={GN(10),GN(11),GN(12),id,0}
					match=1
					break
				end
			end
			if match==0 then
				TS(F,{GN(10),GN(11),GN(12),id,0})
			end
		else
			TS(F,{GN(10),GN(11),GN(12),id,0})
		end
	end
	--
	if GN(24)~=0 then
		if #R>0 then
			id=GN(27)
			match=0
			for i=1,#R do
				if R[i][4]==id then
					R[i]={GN(24),GN(25),GN(26),id,0}
					match=1
					break
				end
			end
			if match==0 then
				TS(R,{GN(24),GN(25),GN(26),id,0})
			end
		else
			TS(R,{GN(24),GN(25),GN(26),id,0})
		end
	end	
end
S=screen
SC=S.setColor
DL=S.drawLine
DRF=S.drawRectF
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}
num[0]=2122222
function N(x,y,s)
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
function G2XY(g)
	local dx,dy=g[1]-sp[1],g[2]-sp[2]
	local d=Mr(dx^2+dy^2)
	local a=M.atan(dy,dx)+(0.25-cps)*P
	local x,y=wh+zoom*d*Ms(a),hh+zoom*d*Mc(a)
	return Mf(x),Mf(y)
end
function DV(x,y,z)
	local _=-3
	if z<30 then _=3 end
	DL(x,y,x-3,y+_)
	DL(x,y,x+3,y+_)
end
function onDraw()
	if #F>0 and rdl then
		for i=1,#F do
			x,y=G2XY(F[i])
			SC(32,12,8)
			DV(x,y,F[i][3])
			msg=string.format('%02.1f',F[i][4])
			SC(8,8,8)
			DRF(x+4,y-3,14,7)
			SC(24,24,24)
			N(x+4,y-2,msg)
		end
	end
	if #R>0 and rar then
		for i=1,#R do
			x,y=G2XY(R[i])
			SC(222,111,1)
			DV(x,y,R[i][3])
			msg='R='..mF(R[i][4])
			S.drawTextBox(x-16,y-8,32,6,msg,0,0)
		end
	end
end