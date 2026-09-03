-- source: steam id 3794600080 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080
X={} Y={} H={} T={} E={}
pi=math.pi
pi2=pi*2

Permit=true
Wave=false
Beep=false
Range=2000
MinRange=1000
MaxRange=12000
StepRange=1000
VWave=740
t=0


function onTick()
	
	On=input.getBool(20)
	Echo=input.getBool(21)
	APing=input.getBool(22)
	Ping=input.getBool(23)
	RangeDown=input.getBool(24)
	RangeUp=input.getBool(25)
	
	if On and Echo and (Ping or APing) and not Wave then Wave=true end
	
	if On and Echo and Wave and t/60<(Range+VWave)/VWave then
		t=t+1
		for i=1, 16, 2 do
			if input.getBool(i) and t>5 and t/60<Range/VWave then
				table.insert(H,input.getNumber(i)*pi2)
				table.insert(T,t)
				table.insert(E,0)
				Beep=true
			end
		end
	else
		t=0
		Wave=false
	end
	
	if #E~=nil then
		for i=1,#E do
			if E[i]<150 then
			E[i]=E[i]+2.5
			end
		end
	end
	
	if not On or t==1 then
		for i=1,#H do
			H[i]=nil
			T[i]=nil
			E[i]=nil
		end
	end
	
	if On then
	
	if not Echo then
		for i=1, 16 do
			if input.getBool(i) then
				X[i]=input.getNumber(i*2-1)*pi2
				Y[i]=input.getNumber(i*2)*pi2
			elseif not input.getBool(i) and X[i]~=nil then
				X[i]=nil
				Y[i]=nil
			end
		end
	end
	
	if RangeUp and Permit and Range<MaxRange then
		Range=Range+StepRange
	end
	if RangeDown and Permit and Range>MinRange then
		Range=Range-StepRange
	end
	
	if Ping or RangeUp or RangeDown then Permit=false end
	if not Ping and not RangeUp and not RangeDown then Permit=true end
	
	output.setNumber(1, math.floor(Range/10000))
	output.setNumber(2, math.floor(Range/1000%10))
	end
	
	output.setBool(1, Wave)
	output.setBool(2, Beep)
	
	Beep=false
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	
	Color=screen.setColor
	Rect=screen.drawRect
	RectF=screen.drawRectF
	Circle=screen.drawCircle
	Line=screen.drawLine
	Text=screen.drawText
	flr=math.floor
	sin=math.sin
	cos=math.cos

	if On then

	Color(5,5,5)
	screen.drawClear()

	Color(5,5,10)
	screen.drawCircleF(w/2,h/2,h/2.1)

	Color(5,10,5)
	for i=0, 12 do																--RGrid
	Line(w/2,h/2,w/2+((h/2-1)*math.cos(i*pi2/12)),h/2+((h/2-1)*math.sin(i*pi/6)))
	end

	Circle(w/2,h/2,h/4)

	if not Echo then
		Color(10,100,10)

		for i=0,pi2,pi2/flr(h/3) do												--SoumdCircle
			r1=math.random(flr(h/16),flr(h/16+1))
			Line(w/2+r1*sin(i),h/2+r1*cos(i),
				 w/2+r1*sin(i+pi2/flr(h/3)),h/2+r1*cos(i+pi2/flr(h/3)))
		end

		for i=1, 16 do															--SoumdLine
			if X[i]~=nil then
			r2=math.random(flr(h/4),flr(h/3))
			Line(w/2+r1*-sin(X[i]),h/2+r1*-cos(X[i]),
				 w/2+r2*-sin(X[i]),h/2+r2*-cos(X[i]))
			end
		end
	end

	if Echo then																	--Wave
	
		if t/60<Range/VWave then
			Color(10,100,10,255-(740*(t/60))/(Range/255))
			Circle(w/2,h/2,(740*(t/60))/(Range/(h/2.1)))
		end

		for i=1, #H do																--Target
		Color(10,150,10)
		RectF(w/2+(740*(T[i]/60))/(Range/(h/2.1))*-sin(H[i])-1,
			  h/2+(740*(T[i]/60))/(Range/(h/2.1))*-cos(H[i]),2,2)
		if E[i]~=nil then
		Color(10,150,10,150-E[i])
		Circle(w/2+(740*(T[i]/60))/(Range/(h/2.1))*-sin(H[i]),
			  h/2+(740*(T[i]/60))/(Range/(h/2.1))*-cos(H[i]),E[i]/18.75)
		end
		end
	end

	Color(5,5,5)
	for i=0,pi,0.01 do
		if hpr~=flr(h/2+1+((h/2-2)*cos(i))) then
		Line(-1, flr(h/2+1+((h/2-2)*cos(i))),flr(w/2+((h/2-2)*sin(-i))), flr(h/2+1+((h/2-2)*cos(i))))
		Line( w, flr(h/2+1+((h/2-2)*cos(i))),flr(w/2+((h/2-2)*sin( i))), flr(h/2+1+((h/2-2)*cos(i))))
		hpr=flr(h/2+1+((h/2-2)*cos(i)))
		end
	end
	
	RectF(0,0,w,3)
	RectF(0,h-2,w,2)
	
	Color(2,30,2)
	Circle(w/2,h/2,h/2.05)
	Circle(w/2,h/2,h/2.075)
	
	Color(10,100,10)
	Circle(w/2,h/2,h/2.1)
	
	end
end