-- source: steam id 3603910667 / vehicle.xml block#57
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
--datalink3dataSending8k tws
shareAll=property.getBool('Share All Targets or Only selected')
rdrjtac=property.getBool('Tracking Radar Override JTAC')
extjtac=property.getBool('External Target Input Override JTAC1')
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
M=math
Mb=M.abs
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
P=M.pi*2
T=1
Slf={j={},w={}}
for i=1,8 do
	_={0,0,0,0,0}
	table.insert(Slf.j,_)
end
jcnt=0
tsd={}
MarkXo,MarkYo=0,0
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DC=S.drawCircle
DCF=S.drawCircleF
DTF=S.drawTriangleF
u=233 v=15
sdj=1
sdw=0
SLj=0
SLw=0
rt=1
function SC(_)
	sC(_,_,_)
end
function DNATO(d,C,F,T,s)--x,y,faction,type,selected
	d,C=Mf(d),Mf(C)
	local a,b,c,e,f,g,A,B,D,E=d-3,d-2,d-1,d+1,d+2,d+3,C-2,C-1,C+1,C+2
	if F==1 then--ally
		sC(v,64,u) DRF(b,A,5,5) SC(v) DR(a,A-1,6,6) 
	elseif F==2 then--enemy
		sC(u,v,v)
		if s then
			DTF(a,D,e,A-1,g+2,D) DTF(a,D,e,E+3,g+2,D) SC(v) DL(d,A-2,a-1,C) DL(a-1,C,d,E+2) DL(d,E+2,g+1,C) DL(g+1,C,d,A-2)
		else
			DRF(c,B,3,3) SC(v) DL(d,A,b,C) DL(b,C,d,E) DL(d,E,f,C) DL(f,C,d,A)
		end
	elseif F==4 then--wp
		sC(v,u,v) DCF(d,C,1.4) sC(v,v,v) DC(d,C,1.4)
		if s then
			DC(d,C,2)
		end
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
function M2S(mx,my)
	local _x,_y=map.mapToScreen(MapX,MapY,zoom,w,h,mx,my)
	return Mf(_x),Mf(_y)
end
function onTick()
	rcv={GN(14),GN(15),GN(16)}
	slfx,slfy=GN(17),GN(18)
	selfID=GN(20)
	order=GN(21)
	tgttp=GN(22)
	wph=GN(23)
	uavh=GN(24)
	uavr=GN(25)
	page=GN(26)
	MarkX=GN(27)
	MarkY=GN(28)
	AltKBD=GN(29)
	MapX=GN(30)
	MapY=GN(31)
	zoom=GN(32)
	--bool
	add=GB(21)
	del=GB(22)
	atk=GB(23)
	slave=GB(31)
	--send timing
	if T==0 then
		send=true
		T=28+M.random(5)
	else
		send=false
		T=T-1
	end
	--self data
	if page==1 then
		if add and jcnt<8 then
			for i=1,#Slf.j do
				if Slf.j[i][1]==0 then
					Slf.j[i]={MarkX,MarkY,AltKBD,tgttp,0}
					break
				end
			end
		end
		if del and jcnt>0 then
			if SLj>0 and SLj<#Slf.j then
				Slf.j[SLj]={0,0,0,0,0}
			else
				for i=8,1,-1 do
					if Slf.j[i][1]~=0 then
						Slf.j[i]={0,0,0,0,0}
						break
					end
				end
			end
		end
		if SLj>#Slf.j then SLj=#Slf.j end
	elseif page==2 then
		if add and #Slf.w<9 then
			if SLw==#Slf.w or SLw==0 then
				table.insert(Slf.w,{MarkX,MarkY,wph,uavr})
			else
				table.insert(Slf.w,SLw+1,{MarkX,MarkY,wph,uavr})
			end
		end
		if del and #Slf.w>0 then
			if SLw~=0 then
				table.remove(Slf.w,SLw)
			else
				table.remove(Slf.w,1)
			end
		end
		odredt=Mf((order-5)/4)
		if Slf.w[SLw+odredt] and odredt~=0 and SLw~=0 then
			temp=Slf.w[SLw+odredt]
			Slf.w[SLw+odredt]=Slf.w[SLw]
			Slf.w[SLw]=temp
		end
		if SLw>#Slf.w then SLw=#Slf.w end
	elseif page==3 then
		if add or del or atk then
			table.insert(tsd,{MarkX,MarkY,uavh,uavr,add,del,atk})
		end
	end
	if rdrjtac and GN(1)~=0 then--static radar override jtac targets
		cur=GN(7)
		Slf.j[cur]={GN(1),GN(2),GN(3),tgttp,0}
	end
	if rdrjtac then--auto deleting
		for i=1,8 do
			Slf.j[i][5]=Slf.j[i][5]+1
			if Slf.j[i][5]>60 then
				Slf.j[i]={0,0,0,0,0}
			end
		end
	end
	if extjtac and GN(11)~=0 then--fcs result override jtac target 1
		Slf.j[1]={GN(11),GN(12),GN(13),tgttp,0}
	end
	--send msg
	ele1,ele2,ele3=0,0,0
	ele4,ele5,ele6,ele7,ele8=0,0,0,0,0
	jcnt=0
	aj={}
	for i=1,#Slf.j do
		if Slf.j[i][1]~=0 then
			jcnt=jcnt+1
			if i~=1 then
				table.insert(aj,i)
			end
		end
	end
	SN(5,0)
	SN(6,0)
	SN(7,0)
	SN(9,0)
	if jcnt>0 then
		if shareAll then
			SN(5,Slf.j[1][1])
			SN(6,Slf.j[1][2])
			SN(7,Slf.j[1][3])
			SN(9,Slf.j[1][4])
			if #aj>1 and Slf.j[aj[sdj]] then
				SN(10,Slf.j[aj[sdj]][1])
				SN(11,Slf.j[aj[sdj]][2])
				SN(12,Slf.j[aj[sdj]][3])
				ele8=Slf.j[aj[sdj]][4]
				ele4=aj[sdj]*1e5
			end
			ele5=(#aj+1)*1e4
		else
			for i=5,9 do
				SN(i,0)
			end
			if SLj~=0 then
				if Slf.j[SLj] then
					SN(5,Slf.j[1][1])
					SN(6,Slf.j[1][2])
					SN(7,Slf.j[1][3])
					SN(9,Slf.j[1][4])
					ele5=1e4
				end
			end
		end
	end
	if #Slf.w>0 and sdw<=#Slf.w and sdw>0 and page~=3 then
		SN(13,Slf.w[sdw][1])
		SN(14,Slf.w[sdw][2])
		ele3=Slf.w[sdw][3]
		ele2=Slf.w[sdw][4]*1e2
		ele6=sdw*1e3
		ele7=#Slf.w*1e2
	end
	for i=29,32 do
		SB(i,false)
	end
	if #tsd>0 and page==3 then
		ele3=tsd[1][3]
		ele2=tsd[1][4]*1e2
		SN(13,tsd[1][1])
		SN(14,tsd[1][2])
		SB(29,tsd[1][5])
		SB(30,tsd[1][6])
		SB(31,tsd[1][7])
	end
	if page>2 then
		ele1=GN(19)*1e4
	end
	SN(15,ele4+ele5+ele6+ele7+ele8)
	SN(16,ele1+ele2+ele3)
	SB(32,send and GB(32))
	--
	if GN(8)~=0 then SLj=GN(8) end
	if Mb(MarkX-MarkXo)>10*zoom or Mb(MarkY-MarkYo)>10*zoom then
		SLj=GN(8) SLw=0
		if SLj==0 and #Slf.j>0 and (page==1 or page==3) then
			for i=1,#Slf.j do
				dx=Mb(Slf.j[i][1]-MarkX)
				dy=Mb(Slf.j[i][2]-MarkY)
				if dx+dy<zoom*80 then
					SLj=i
					break
				end
			end
		end
		if #Slf.w>0 and page==2 then
			for i=1,#Slf.w do
				dx=Mb(Slf.w[i][1]-MarkX)
				dy=Mb(Slf.w[i][2]-MarkY)
				if dx+dy<zoom*80 then
					SLw=i
					break
				end
			end
		end
	end
	MarkXo,MarkYo=MarkX,MarkY
	--after send
	if send then
		if #aj>0 then
			sdj=sdj%#aj+1
		end
		if #Slf.w>0 then
			sdw=sdw%#Slf.w+1
		end
		if #tsd>0 then
			table.remove(tsd,1)
		end
	end
	table.insert(aj,1)
	if #aj>0 then 
		rt=rt%#aj+1
		for i=1,3 do
			SN(16+i,Slf.j[aj[rt]][i])
		end
		SN(20,aj[rt]*1e3+#aj*1e2+Slf.j[aj[rt]][4])
	end
	SN(21,SLj)
	for i=26,32 do
		SN(i,0)
	end
	if jcnt>0 and SLj>0 then
		for i=1,3 do
			SN(26+i,Slf.j[SLj][i]+rcv[i])
		end
	else
		for i=1,3 do
			SN(26+i,rcv[i])
		end
	end
	if #Slf.w>0 then
		SN(30,Slf.w[1][1])
		SN(31,Slf.w[1][2])
		SN(32,Slf.w[1][3]*50)
		SN(26,Slf.w[1][4]*50)
	end
	if GB(28) and #Slf.w>0 then
		table.remove(Slf.w,1)
	end
end
jnames={'A','B','C','D','E','F','G','H'}
function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	for i=1,8 do
		if Slf.j[i][1]~=0 and Slf.j[i][2]~=0 then
			Px,Py=M2S(Slf.j[i][1],Slf.j[i][2])
			DNATO(Px,Py,2,Slf.j[i][4],i==SLj)
			if i==SLj then yo=6 else yo=4 end
			S.drawText(Px-1,Py+yo,jnames[i])
		end
	end
	Px,Py=M2S(slfx,slfy)
	if #Slf.w>0 then
		for i=1,#Slf.w do
			tmxo,tmyo=tmx,tmy
			tmx,tmy=M2S(Slf.w[i][1],Slf.w[i][2])
			sC(v,u,v,128)
			if i==1 then
				DL(Px,Py,tmx,tmy)
			else
				DL(tmxo,tmyo,tmx,tmy)
			end
			DNATO(tmx,tmy,4,0,i==SLw)
		end
	end
	if slave then
		sC(128,v,v)
		S.drawText(w/2-10,h/2-3,'SLAVE')
	end
end