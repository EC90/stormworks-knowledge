-- source: steam id 3603910667 / vehicle.xml block#91
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
--TWS Draw
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
PT=property.getText
M=math
Ma=M.abs
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P=pi*2
zoom=0.01--100m=1pixel
w,h=96,64
btn={
	{0,10,18,9,true,'t','cps'},
	{0,80,18,9,false,'t','wpn'},
	{0,80,18,9,true,'t','D L'},
	{0,80,18,9,false,'t','A R'},
	{0,20,18,9,false,'t','AE1'},
	{0,30,18,9,false,'t','AE2'},
	{0,0,18,9,true,'t','U I'}}
function db(n)
	if btn[n] then
		local tb=btn[n]
		if btnt and tx>tb[1] and tx<tb[1]+tb[3] and ty>tb[2] and ty<tb[2]+tb[4] then
			if tb[6]=='t' then
				tb[5]=not tb[5]
			else
				tb[5]=true
			end
		elseif tb[6]~='t' then
			tb[5]=false
		end
		SC(8,8,8)
		DRF(tb[1],tb[2],tb[3],tb[4])
		if tb[5] then
			SC(64,64,64)
		else
			SC(24,24,24)
		end
		DR(tb[1],tb[2],tb[3]-1,tb[4]-1)
		DTB(tb[1],tb[2],tb[3],tb[4],tb[7],0,0)
	end
end
function d2b(d)
	local b=''
	while d>0 do
		local r=d%2
		b=r..b
		d=mF(d/2)
	end
	if b=='' then b='0' end
	if string.len(b)<9 then
		local zs=9-string.len(b)
		for i=1,zs do
			b='0'..b
		end
	end
	return b
end
function onTick()
	tc=GB(1)
	cps=GN(11)
	wh,hh=w/2,h/2
	SN(1,w/32*10+h/32+zoom)
	SB(1,tc and not tcd)
	tx,ty=GN(3),GN(4)
	txout=d2b(mF(GN(3)))
	tyout=d2b(mF(GN(4)))
	for i=1,9 do
		SB(1+i,string.sub(txout,i,i)=='1')
	end
	for i=1,9 do
		SB(10+i,string.sub(tyout,i,i)=='1')
	end
	btnc1=ty<0.6*h+5 and ty>0.6*h
	btnc2=tx>0.4*w and tx<0.4*w+5
	btnc3=tx<0.6*w and tx>0.6*w-5
	if tc and btnc1 and btnc2 then btnm=32 else btnm=16 end
	if tc and btnc1 and btnc3 then btnp=32 else btnp=16 end
	if btnt and btnc1 then
		if btnc2 then
			zoom=M.max(zoom/1.3,0.002)
		elseif btnc3 then
			zoom=M.min(zoom*1.3,0.02)
		end
	end
	btnt=tc and not tcd
	tcd=tc
	out=0
	if btn[3][5] then out=1 end
	SN(31,out)
	out=0
	if btn[4][5] then out=1 end
	SN(32,out)
	SB(20,btn[5][5])--ae1
	SB(21,btn[6][5])--ae2
	SB(22,btn[7][5])--ui
end
S=screen
SC=S.setColor
DR=S.drawRect
DRF=S.drawRectF
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
function DC(x,y,r,d) for i=1,360,d do x1=x+r*Ms(P*i/360) y1=y-r*Mc(P*i/360) x2=x+r*Ms(P*(i+d)/360) y2=y-r*Mc(P*(i+d)/360) DL(x1,y1,x2,y2) end end
function DS(x,y,r,d,s,e)
	for i=s,e,d do
		x1=x+r*Ms(i/360*P)
		y1=y-r*Mc(i/360*P)
		x2=x+r*Ms((i+d)/360*P)
		y2=y-r*Mc((i+d)/360*P)
		if i<e then
			DL(x1,y1,x2,y2)
		end
		if i==s or i==e then
			DL(x,y,x1,y1)
		end
	end
end
cs={2e3,5e3,1e4,15e3,2e4}
css={'2km','5km','10km','15km','20km'}
dirs={'N','E','S','W'}
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}
num[0]=2122222
function N(x,y,s)
	w,h=S.getWidth(),S.getHeight()
	s=tostring(s) 
	local l=string.len(s)
	for i=1,l do
		local n,w=s:sub(i,i),4
		local N=tonumber(n)
		if N then
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
function onDraw()
	SC(8,8,8)
	S.drawClear()
	SC(10,10,10)
	for i=1,#cs do
		DC(wh,hh,cs[i]*zoom,10)
		DT(wh+cs[i]*0.75*zoom,hh+cs[i]*0.75*zoom,css[i])
		DT(wh-cs[i]*0.75*zoom-12,hh-cs[i]*0.75*zoom-4,css[i])
	end
	if btn[2][5] then
		SC(16,16,16)
		DS(wh,hh,PN('wp1 range')*zoom,5,PN('wp1 angle start'),PN('wp1 angle end'))
		_=Mc((PN('wp1 angle end')+PN('wp1 angle start'))/720*P)
		if _>0 then __=-6 else __=2 end
		DTB(0,hh-PN('wp1 range')*zoom*_+__,w,6,PT('wp1 name'),0,0)
		_=Mc((PN('wp2 angle end')+PN('wp2 angle start'))/720*P)
		if _>0 then __=-6 else __=2 end
		DS(wh,hh,PN('wp2 range')*zoom,5,PN('wp2 angle start'),PN('wp2 angle end'))
		DTB(0,hh-PN('wp2 range')*zoom*_+__,w,6,PT('wp2 name'),0,0)
	end
	if btn[1][5] then
		SC(24,24,24)
		DC(wh,hh,hh-3,10)
		for i=0,270,90 do
			x=wh+(hh-3)*Ms(i/360*P+cps*P)
			y=hh-(hh-3)*Mc(i/360*P+cps*P)
			SC(8,8,8)
			DRF(x-3,y-3,6,7)
			SC(24,24,24)
			DT(x-2,y-2,dirs[i/90+1])
		end
		SC(8,8,8)
		DRF(wh-6,0,13,7)
		SC(32,32,32)
		N(wh-5,1,string.format('%03.0f',(360-cps*360)%360))
	end
	SC(8,8,8)
	x1=Mf(0.4*w)
	x2=Mf(0.6*w)
	y=Mf(0.6*h)
	DRF(x1,y,5,5)
	DRF(x2,y,-5,5)
	SC(btnm,btnm,btnm)
	DT(x1+2,y+1,'-')
	DR(x1,y,6,6)
	SC(btnp,btnp,btnp)
	DT(x2-4,y+1,'+')
	DR(x2,y,-6,6)
	db(7)
	if btn[7][5] then
		db(1)
		db(5)
		db(6)
	end
end