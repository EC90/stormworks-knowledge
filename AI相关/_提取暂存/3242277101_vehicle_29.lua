-- source: steam id 3242277101 / vehicle.xml block#29
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3242277101
--datalink3dataRecieving
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
M=math
Mb=M.abs
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
P=M.pi*2
selfID=M.random(99)
T=1
Rcv={}
MarkXo,MarkYo=0,0
SLID={0,0,0}
function tableUpdate(con,tbl,cur,total,v1,v2,v3,v4)
	local TBL=tbl
	if con then
		if TBL then
			if total<#TBL then
				for l=1,#TBL-total do
					table.remove(TBL)
				end
			end
			if total>#TBL then
				for l=1,total-#TBL do
					local _={0,0,0,0}
					table.insert(TBL,_)
				end
			end
			if cur>0 then
				TBL[cur]={v1,v2,v3,v4}
			end
		else
			TBL={}
		end
	end
	return TBL
end
function onTick()
	rcvid=GN(1)
	SLj=GN(24)
	page=GN(26)
	MarkX=GN(27)
	MarkY=GN(28)
	MapX=GN(30)
	MapY=GN(31)
	zoom=GN(32)
	--update data
	if rcvid==selfID then--conflict
		selfID=M.random(99)
	end
	if rcvid~=0 then
		j=#Rcv+1
		if #Rcv>0 then
			for i=1,#Rcv do
				if rcvid==Rcv[i].id then
					j=i
					break
				end
			end
		end
		if j>#Rcv then
			Rcv[j]={j={},w={}}
		end
		Rcv[j].id=rcvid
		Rcv[j].x=GN(2)
		Rcv[j].y=GN(3)
		Rcv[j].z=GN(4)
		Rcv[j].ts=GN(8)
		Rcv[j].t=0
		Rcv[j].s={GB(1),GB(2),GB(3),GB(4)}
		tmp1=GN(15)
		tmp2=GN(16)
		if GB(5) then
			Rcv[j].j=tableUpdate(true,Rcv[j].j,mF(tmp1/1e5),mF(tmp1%1e5/1e4),GN(10),GN(11),GN(12),tmp1%100)
			Rcv[j].w=tableUpdate(tmp2<1e4,Rcv[j].w,mF(tmp1%1e4/1e3),mF(tmp1%1e3/1e2),GN(13),GN(14),tmp2%1e2*50,mF(tmp2%1e4/1e2)*50)
		else
			Rcv[j].j={}
			Rcv[j].w={}
		end
		if GN(2)~=0 then Rcv[j].j[1]={GN(5),GN(6),GN(7),GN(9)} end
	end
	--send msg
	SN(1,selfID)
	--select
	if (Mb(MarkX-MarkXo)>10*zoom or Mb(MarkY-MarkYo)>10*zoom)and #Rcv>0 then
		SLID={0,0,0}
		if page==1 or page==3 then
			for i=1,#Rcv do
				for j=1,#Rcv[i].j do
					if Mb(Rcv[i].j[j][1]-MarkX)+Mb(Rcv[i].j[j][2]-MarkY)<zoom*80 then
						SLID={i,Rcv[i].id,j}
						break
						break
					end
				end
			end
		end
	end
	SN(2,SLID[2])--listen
	SN(3,SLID[3])
	SN(4,SLj)
	MarkXo,MarkYo=MarkX,MarkY
	--time out data remove
	if #Rcv>0 then
		for i=1,#Rcv do
			Rcv[i].t=Rcv[i].t+1
			if Rcv[i].t>300 then
				table.remove(Rcv,i)
				break
			end
		end
	end	
	if not Rcv[SLID[1]] then
		SLID={0,0,0}
	elseif not Rcv[SLID[1]].j[SLID[3]] then
		SLID={0,0,0}
	end
	SN(11,0)
	SN(12,0)
	SN(13,0)
	--if SLID[1]>0 and Rcv[SLID[1]] then
	if SLID[1]>0 then
		tmp1=GN(20)
		Rcv[SLID[1]].j=tableUpdate(GN(17)~=0,Rcv[SLID[1]].j,mF(tmp1/1e3),mF(tmp1%1e3/1e2),GN(17),GN(18),GN(19),tmp1%100)
		for i=1,3 do
			SN(10+i,Rcv[SLID[1]].j[SLID[3]][i])
		end
	end
end
--prepare draw
str=string
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DC=S.drawCircle
DTF=S.drawTriangleF
--small font data
num={2111211,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}
num[0]=2122222
function N(x,y,s)
	x=Mf(x) y=Mf(y)
	s=tostring(s) 
	local l=str.len(s)
	for i=1,l do
		local n,w=s:sub(i,i),4
		local N=tonumber(n)
		if N then
			if N==1 then w=2 end
			local startx,starty,dx,dy=x,y+4,0,0
			for j=1,7 do
				startx,starty=startx+dx*2,starty-dy*2
				if j==5 then starty=starty-2 end
				dx,dy=M.sin(0.25*P*(j-1)),M.cos(0.25*P*(j-1))
				if str.sub(num[N],j,j)=='2' then
					DL(startx,starty,startx+dx*3,starty-dy*3)
				end
			end
		else
			S.drawText(x,y,n)
		end
		x=x+w
	end
end
function DNATO(d,C,F,T,s)--x,y,faction,type,smallscreen
	d,C=Mf(d),Mf(C)
	local a,b,c,e,f,g,A,B,D,E=d-3,d-2,d-1,d+1,d+2,d+3,C-2,C-1,C+1,C+2
	if F==1 then--ally
		sC(15,64,233)
		DRF(b,A,5,5)
		sC(15,15,15)
		DR(a,A-1,6,6) 
	elseif F==2 then--enemy
		sC(233,15,15)
		if s then
			DTF(a,D,e,A-1,g+2,D)
			DTF(a,D,e,E+3,g+2,D)
			sC(15,15,15)
			DL(d,A-2,a-1,C)
			DL(a-1,C,d,E+2)
			DL(d,E+2,g+1,C)
			DL(g+1,C,d,A-2)
		else
			DRF(c,B,3,3)
			sC(15,15,15)
			DL(d,A,b,C)
			DL(b,C,d,E)
			DL(d,E,f,C)
			DL(f,C,d,A)
		end
	elseif F==4 then--wp
		sC(15,64,233)
		S.drawCircleF(d,C,1.4)
		sC(15,15,15)
		DC(d,C,1.4)
	end
	if s then
		if T==1 then DL(d,C,d,D) end 
		if T==2 then DL(c,B,f,B) DL(c,D,f,D) DL(b,C,c,C) DL(f,C,e,C) end 
		if T==3 then DL(b,A,g,E+1) DL(f,A,a,E+1) end 
		if T==4 then DL(b,E,c,D) DL(f,E,e,D) DL(c,D,f,D) end
		if T==5 then DL(b,C,d,A) DL(c,D,f,A) DL(e,D,g,B) end
		if T==6 then DL(b,B,b,E) DL(c,C,f,C) DL(f,B,f,E) end
		if T==7 then DL(d,B,d,C) DL(c,E,c,B) DL(e,E,e,B) end
		if T==8 then DL(d,B,d,D) DL(c,D,f,D) end
		if T==9 then DL(b,D,g,D) end
		if T==10 then DL(c,B,e,D) DL(e,B,c,D) end
		if T==11 then DL(c,B,c,D) DL(c,C,f,C) DL(d,D,b,B) end
	end
end
function DSOS(x,y,tbl)
	x=Mf(x+4) y=Mf(y)
	for i=1,4 do
		if i==1 then sC(233,233,15)
		elseif i==2 then sC(15,233,15)
		elseif i==3 then sC(233,15,15)
		else sC(15,32,233) end
		if tbl[i] then DL(x,y-5+i*2,x+1,y-5+i*2) end
	end
end
function M2S(mx,my)
	return map.mapToScreen(MapX,MapY,zoom,w,h,mx,my)
end
function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	--N(6,6,1234567890)
	tempx,tempy=M2S(MarkX,MarkY)
	--sC(15,233,15,200)
	sC(15,15,15)
	if MarkX~=0 and SLID[2]==0 and SLj==0 then
		N(tempx-1,tempy-2,"+")
		if page<4 then
			msg=Mf(MarkX)..','..Mf(MarkY)
			N(tempx-str.len(msg)*2,tempy-8,msg)
		end
	end
	if #Rcv>0 then
		for i=1,#Rcv do
			--if Rcv[i] then
			Px,Py=M2S(Rcv[i].x,Rcv[i].y)
			if #Rcv[i].w>0 then
				tmxo,tmyo=Px,Py
				--N(6,6,#Rcv[i].w)
				--N(6,12,Rcv[i].d)
				for j=1,#Rcv[i].w do
					tmx,tmy=M2S(Rcv[i].w[j][1],Rcv[i].w[j][2])
					sC(15,64,233,128)
					DL(tmxo,tmyo,tmx,tmy)
					DNATO(tmx,tmy,4,0,false)
					tmxo,tmyo=tmx,tmy
					if page==3 then
							N(tmx+3,tmy-3,'h:'..mF(Rcv[i].w[j][3]))
						if Rcv[i].w[j][4]~=0 then
							N(tmx+3,tmy+3,'r:'..mF(Rcv[i].w[j][4]))
						end
					end
				end
			end
			DNATO(Px,Py,1,Rcv[i].ts,true)
			N(Px-3,Py+4+1,mF(Rcv[i].id))
			DSOS(Px,Py,Rcv[i].s)
			if #Rcv[i].j>0 then
				for j=1,#Rcv[i].j do
					tmx,tmy=M2S(Rcv[i].j[j][1],Rcv[i].j[j][2])
					DNATO(tmx,tmy,2,Rcv[i].j[j][4],i==SLID[1] and j==SLID[3])
					if i==SLID[1] and j==SLID[3] then
					N(tmx-6,tmy+4+1,mF(Rcv[i].id)..'-'..j)
					end
				end
			end
			--end
		end
	end
end