-- source: steam id 3603910667 / vehicle.xml block#84
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
--anti radio draw
GN=input.getNumber
SN=output.setNumber
aT={100,1000,4000,20000}
sA=1000
M=math
Ma=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P2=M.pi*2
T=table
--draw small number
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}
num[0]=2122222
function DN(x,y,s)
	x,y=math.floor(x+0.5),math.floor(y+0.5)
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
				dx,dy=math.sin(0.25*math.pi*2*(j-1)),math.cos(0.25*math.pi*2*(j-1))
				if string.sub(num[N],j,j)=='2' then
					screen.drawLine(startx,starty,startx+dx*3,starty-dy*3)
				end
			end
		else
			screen.drawText(x,y,n)
		end
		x=x+w
	end
end
--inatialize
w,h=64,64
signals={}
timeout=600
touched=false
z=128--1 pixel = 100m
sl=0
newSignal={}
---
cnt1=-3
cnt2=0
cnt3=1
flst={}
mode=-1--0=src,1=trk
debug=333
spc={0,1111,2222,3333,4444,5555,6666,7777,8888,9999,11111,114514,1919,1919810,7355608,1234,12345,123456,1999,2000,2023,2022,1024,2048,3090,3080,65535}
history={}
delay=4
freqOfst=0
if #history<delay then T.insert(history,{0,250,500,750,1111}) end
--
function dst(p1,p2)
	return Mr((p1.x-p2.x)^2+(p1.y-p2.y)^2)
end
function pnts(c1,c2)
	local d=dst(c1,c2)
	if d<=c1.R+c2.R and d>=M.abs(c1.R-c2.R) then
		local a=(c1.R^2-c2.R^2+d^2)/(2*d)
		local h=M.sqrt(c1.R^2-a^2)
		local x0=c1.x+a*(c2.x-c1.x)/d
		local y0=c1.y+a*(c2.y-c1.y)/d
		return {{x=x0+h*(c2.y-c1.y)/d,y=y0-h*(c2.x-c1.x)/d},{x=x0-h*(c2.y-c1.y)/d,y=y0+h*(c2.x-c1.x)/d}}
	else return {}
	end
end
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3])*Ms(r[2]),r[1]*Mc(r[3])*Mc(r[2]),r[1]*Ms(r[3])}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function cpr(a,b)
	return a.e<b.e
end
function erc(ps,c,lst)
	if ps~={} then
		local temp={}
		for i=1,#ps do
			T.insert(temp,{x=ps[i].x,y=ps[i].y,e=M.abs(dst(ps[i],c)-c.R),A=c.A})
		end
		if #temp>1 then
			T.sort(temp,cpr)
			T.insert(lst,temp[1])
		end
	end
end
--
function onTick()
	--
	if GN(20)>0.5 and not foa then
		freqOfst=math.min(freqOfst+1000,20000)
	elseif GN(21)>0.5 and not fom then
		freqOfst=math.max(freqOfst-1000,0)
	end
	foa=GN(20)>0.5
	fom=GN(21)>0.5
	sys=GN(22)>0.5
	if sys then
		if mode==-1 then
			mode=0
		end
	else
		mode=-1
	end
	sp={GN(1),GN(3),GN(2)} Eu={GN(4),GN(6),GN(5)}
	--listen
	if mode==0 then--src
		for i=1,4 do
			if GN(i+10)>0.01 and cnt1>delay and history[1][i]~=GN(21) then
				T.insert(flst,history[1][i])
			end
		end
		if GN(15)>0.01 and cnt1>delay and cnt1<=#spc+delay then
			T.insert(flst,history[1][5])
		end
		debug=#flst
		--
		SN(11,freqOfst+cnt1)
		SN(12,freqOfst+cnt1+250)
		SN(13,freqOfst+cnt1+500)
		SN(14,freqOfst+cnt1+750)
		if cnt1>0 and cnt1<=#spc then
			C5=spc[cnt1]
		else
			C5=255255
		end
		SN(15,C5)
		T.insert(history,{freqOfst+cnt1,freqOfst+cnt1+250,freqOfst+cnt1+500,freqOfst+cnt1+750,C5})
		if #history>5 then
			T.remove(history,1)
		end
		cnt1=cnt1+1
	end
	--reset timer
	if cnt1>250+delay then
		if #flst>0 then
			mode=1
			cnt1=-delay
		else
			cnt1=-delay
		end
	end
	--track
	newSignal={}
	if mode==1 then
		if cnt3<=#flst then
			for i=11,14 do
				SN(i,flst[cnt3])
			end
			if cnt2>5 then
				--calculate
				rH={}
				rV={}
				for i=1,#aT do
					cF={x=0,y=2.25,R=(1-GN(11))*(aT[i]+sA),A=i}
					cC={x=0,y=0,R=(1-GN(12))*(aT[i]+sA),A=i}
					cR={x=2.25,y=0,R=(1-GN(14))*(aT[i]+sA),A=i}
					erc(pnts(cC,cR),cF,rH)
				end
				if rH~={} then
					T.sort(rH,cpr)
					a=rH[1].A
					cC={x=0,y=0,R=(1-GN(12))*(aT[a]+sA),A=a}
					cT={x=2,y=0,R=(1-GN(13))*(aT[a]+sA),A=a}
					cF={x=0,y=2.25,R=(1-GN(11))*(aT[a]+sA),A=a}
					erc(pnts(cC,cT),cF,rV)
					if rV[1] then
						T.sort(rV,cpr)
						temp=Mv(tM(E2R(Eu)),{rH[1].x,rH[1].y,rV[1].x})
						newSignal={temp[1]+sp[1],temp[2]+sp[2],temp[3]+sp[3],flst[cnt3],0}
					end
				end
				cnt2=0
				cnt3=cnt3+1
			end
			cnt2=cnt2+1
		else
			flst={} mode=0 cnt3=1 cnt4=0
		end
	end
	--
	if #signals>0 then
		for i=1,#signals do
			signals[i][5]=signals[i][5]+1
			if signals[i][5]>timeout then
				T.remove(signals,i)
				break
			end
		end
	end
	if newSignal[1] then
		found=false
		for i=1,#signals do
			if signals[i][4]==newSignal[4] then
				signals[i]=newSignal
				found=true
				break
			end
		end
		if not found then
			T.insert(signals,newSignal)
		end
	end
	--touch screen
	touch=GN(18)>0.5
	touchx,touchy=GN(16),GN(17)
	if touch and not touched then
		if touchx<6 and touchy>=10 and touchy<37 then
			if touchy<17 then
				z=math.max(z/2,4)
			elseif touchy>=30 then
				z=math.min(z*2,2048)
			end
		elseif touchx<w-4 and touchx>=w-9 then
			sl=math.floor(touchy/6)
		end
	end
	touched=touch
	selfx,selfy=GN(1),GN(3)
	SN(1,0)
	SN(2,0)
	SN(3,0)
	SN(4,0)
	if sl>0 and sl<=#signals then
		--output selected signal
		if signals[sl] then
			SN(1,signals[sl][1])
			SN(2,signals[sl][2])
			SN(3,signals[sl][3])
			SN(4,signals[sl][4])
		end
	else
		sl=0
	end
	cps=GN(19)
	SN(32,mode)
end
function DC(x,y,r,d)
	for i=1,360,d do
		x1=x+r*Ms(P2*i/360)
		y1=y-r*Mc(P2*i/360)
		x2=x+r*Ms(P2*(i+d)/360)
		y2=y-r*Mc(P2*(i+d)/360)
		screen.drawLine(x1,y1,x2,y2)
	end
end
--gps to tws screen xy
function G2XY(wh,hh,g)
	local dx,dy=g[1]-sp[1],g[2]-sp[2]
	local d=Mr(dx^2+dy^2)
	local a=M.atan(dy,dx)+(0.25-cps)*P2
	local x,y=wh+d*Ms(a)/z,hh+d*Mc(a)/z
	return Mf(x+0.5),Mf(y+0.5)
end
function onDraw()
	w,h=screen.getWidth(),screen.getHeight()
	--64 pixels = 10 lines text
	screen.setColor(11,16,11)
	--draw signals on 'map'
	dcx,dcy=math.floor((w-5)/2+0.5),math.floor((h-13)/2+0.5)
	for i=1,#aT do
		_=aT[i]/z
		if _>5 and _<32 then
			DN(dcx+_,dcy+_,aT[i])
			DN(dcx-_-10,dcy-_-5,aT[i])
			DC(dcx,dcy,_,15)
		end
	end
	screen.setColor(22,222,22)
	screen.drawText(dcx-1,dcy-2,'+')
	for i=1,#signals do
		if i==sl then
			screen.setColor(222,222,222)
		else
			screen.setColor(22,222,22)
		end
		dx,dy=G2XY(dcx,dcy,signals[i])
		if dx<w-5 and dy<h-13 then
			--screen.drawCircle(dx,dy,1.5)
			screen.setColor(16,16,16)
			screen.drawRectF(dx-2,dy-3,4,5)
			screen.setColor(22,222,22)
			DN(dx-2,dy-3,i)
		end
	end
	--draw detail
	screen.setColor(8,8,8)
	screen.drawRectF(0,h-13,w-5,13)
	screen.setColor(22,222,22)
	screen.drawLine(1,h-13,w-5,h-13)
	--show selected xyz in bottom
	for i=0,#signals do
		dx=w-10
		dy=i*6
		screen.setColor(16,16,16)
		screen.drawRectF(dx,dy,5,5)
		screen.setColor(22,222,22)
		if i==sl and sl~=0 then
			DN(1,h-11,'x'..string.format('%+6.0f',signals[i][1])..' z'..string.format('%5.0f',signals[i][3]))
			DN(1,h-5,'y'..string.format('%+6.0f',signals[i][2])..' f'..string.format('%5.0f',signals[i][4]))
			screen.setColor(111,111,111)
		end
		DN(dx+1,dy,i)
	end
	--draw zoom btns
	screen.setColor(8,8,8)
	screen.drawRectF(0,10,6,7)
	screen.drawRectF(0,30,6,7)
	screen.setColor(22,222,22)
	screen.drawRect(0,10,6,6)
	screen.drawRect(0,30,6,6)
	screen.drawText(2,11,'+')
	screen.drawText(2,31,'-')
	DN(1,0,freqOfst..'~')
end