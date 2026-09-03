-- source: steam id 2790345070 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
i,o=input,output
gn,sn,gb,sb=i.getNumber,o.setNumber,i.getBool,o.setBool
sf,ss=string.format,string.sub
w,h,lock=0,0,false
st={}
tck=0
tck2=0
tck3=0
frq=0
frqo=0
frqd=0
function onTick()
	iX=gn(3)
	iY=gn(4)
	ps=gb(1)
	sg=gb(2)
	blk=gb(3)
	mt={{1,7,11,7,"TR",gn(5)},
		{13,7,11,7,"LC",gn(6)},
		{25,7,6,7,"M",gn(7)}
	}
	
	if ps then
		for i,v in ipairs(mt) do
			if tc(v[1],v[2],v[3],v[4]) and not lock then
				lock=true
				if v[6]==1 then
					sn(i,0)
					mt[i][6]=0
				else
					if v[6]==0 then
						sn(i,1)
						mt[i][6]=1
					end
				end
			end
		end
	else
		lock=false
	end
	
	for i,v in ipairs(mt) do
		if v[6]==1 then
			sb(i,true)
		else
			sb(i,false)
		end
	end
	
	if sg then
		table.insert(st,1)
		--frqo=frq
		frq=tck2/60
		tck2=0
	else
		table.insert(st,0)
		tck2=tck2+1
	end
	
	if #st==28 then
		table.remove(st,1)
	end
	
	if tck==60 then
		tck=0
		table.insert(st,2)
	else
		tck=tck+1
	end
	
	if #st==28 then
		table.remove(st,1)
	end
	
	if tck3==180 then
		tck3=0
		frqo=frq
	else
		tck3=tck3+1
	end
	
	if frq>60 or tck2/60>60 then
		frqd=">60"
		frq=0
	elseif frq<1 then
		frqd=ss(sf("%03.2f",frq),2)
	elseif frq<10 then
		frqd=sf("%3.1f",frq)
	elseif frq<100 then
		frqd=sf("%03.0f",frq)
	end
end

S=screen
sc=S.setColor
function onDraw()
	w,h=S.getWidth(),S.getHeight()

	sc(0,0,0)
	S.drawClear()
	
	sc(200,200,200)
	S.drawTextBox(0,0,w,7,"Beacon",0,0)
	
	for i,v in ipairs(mt) do
		if v[6]==1 then
			if i==3 or (i==1 and blk) then
				sc(255,0,0)
			else
				sc(0,255,0)
			end
		else
			sc(0,10,0)
		end
		S.drawRectF(v[1],v[2],v[3],v[4])
	
		sc(0,0,0)
		S.drawTextBox(v[1],v[2],v[3],v[4],v[5],0,0)
	end
	
	if frq<frqo and mt[2][6]==1 then
		sc(0,255,0)
	else
		sc(3,3,3)
	end
	S.drawRectF(1,15,7,5)
	sc(0,0,0)
	S.drawLine(2,16,5,19)
	S.drawLine(4,18,7,15)
	
	if frq>frqo and mt[2][6]==1 then
		sc(255,0,0)
	else
		sc(3,3,3)
	end
	S.drawRectF(24,15,7,5)
	sc(0,0,0)
	S.drawLine(25,18,28,15)
	S.drawLine(27,16,30,19)
	
	sc(3,3,3)
	S.drawRectF(1,21,30,10)
	
	if mt[2][6]==1 then
		sc(0,255,0)
		S.drawTextBox(7,14,18,7,frqd,0,0)
	
		for i,v in ipairs(st) do
			sc(0,255,0)
			if v==1 then
				S.drawLine(i+1,29,i+2,22)
			elseif v==2 then
				sc(0,200,255)
				S.drawLine(i+1,30,i+1,20)
			else
				if st[i-1]==1 then
					S.drawLine(i+1,22,i+2,29)
				else
					S.drawLine(i+1,29,i+2,29)
				end
			end
		end
	else
		sc(3,3,3)
		S.drawTextBox(7,14,18,7,"000",0,0)
	end
	
	--sc(255,255,255)
	--S.drawTextBox(0,0,w,h,frq,0,0)
end

function tc(x,y,w,h)
	return iX>x and iY>y and iX<x+w and iY<y+h
end