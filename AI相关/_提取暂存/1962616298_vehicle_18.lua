-- source: steam id 1962616298 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
inp={}
bool={}
bat={0, 0}
dlt={0, 0}
perc={}
sign={}
chrg={}
hr={}
mn={}
sc={}
tt={"M.", "S."}
Line=screen.drawLine
Text=screen.drawText
TextBox=screen.drawTextBox
genn=property.getNumber("Number of Generators")
stby=property.getBool("Include Standby Battery")

function onTick()
go=input.getBool(32)
if go then
	if stby then
		sby=2
	else
		sby=1
	end
	for i=1, 32 do
		inp[i]=input.getNumber(i)
		bool[i]=input.getBool(i)
	end
	for i=1, 2 do --finds time to charge/drain
		if dlt[i]==0 then
			t=0
		elseif dlt[i]<0 then
			t=(inp[12+i]/(-dlt[i]))/60
		else
			t=((1-inp[12+i])/dlt[i])/60
		end
		if t>359999 then
			t=359999
		end
		hr[i]=math.floor(t/3600)
		t=t-hr[i]*3600
		mn[i]=math.floor((math.fmod(t, 3600))/60)
		t=t-mn[i]*60
		sc[i]=math.floor(t)
	end
	for i=1, 2 do
		dlt[i]=inp[i+12]-bat[i] -- batery charge delta
		if dlt[i]<0 then
			sign[i]=""
			chrg[i]=" Drain"
		else
			sign[i]="+"
			chrg[i]=" Charge"
		end
	end
	bat[1]=inp[13]
	bat[2]=inp[14]
	det=inp[24]
end
end
function onDraw()
	screen.setColor(0, 0, 0)
	screen.drawClear()
	screen.setColor(200, 200, 200)
	w=screen.getWidth()
	h=screen.getHeight()
	a=h/2
	b=w/2
	perc[1]=math.ceil(inp[13]*1000-0.5)/10
	perc[2]=math.ceil(inp[14]*1000-0.5)/10
	if det==0 then --main screen
		Line(0, inp[29]+7, w, inp[29]+7)
		if genn>=3 then
			Line(0, inp[29]+21, w, inp[29]+21)
		end
		for i=1, genn do
			Text(inp[i+24]-9, inp[i+28]-5, "GEN"..i)
			TextBox(inp[i+24]-b/2, inp[i+28]+1, b, 7, math.ceil(inp[i+8]*100-0.5)/100, 0, -1)
		end
		btcnt=math.max(inp[29], inp[30], inp[31]) --center of generator bottom row
		barh=h-(btcnt+12) --battery bar height
		barct=h-3-barh/2 --bar y center value
		perc[3]=math.ceil(perc[1]-0.5) --battery value 0-100
		perc[4]=math.ceil(perc[2]-0.5)
		for i=1, sby do
			if inp[i+12]>0.9 then --dynamic color
				screen.setColor(0, 255, 0)
			elseif inp[i+12]<0.1 then
				screen.setColor(255, 0, 0)
			else
				d=(inp[i+12]-0.1)/0.8
				screen.setColor(255*(1-d), 255*d, 0)
			end
			if stby then
				ref=(i-1)*b+b/4
			else
				ref=b
			end
			screen.drawRectF(ref-5, h-2.5, 4, inp[i+12]*(-barh+1))
			screen.setColor(200, 200, 200)
			screen.drawRect(ref-5, btcnt+9, 4, barh)
			Line(ref+1, btcnt+9, ref+5, btcnt+9)
			Line(ref+1, h-3, ref+5, h-3)
			Line(ref+1, barct, ref+3, barct)
			TextBox(ref+5, barct-8, 15, 7, tt[i], 0, -1)
			TextBox(ref+5, barct-2, 15, 7, "BAT", 0, -1)
			TextBox(ref+1, barct+4, 21, 7, perc[i+2].."%", 0, -1)
		end
	else -- detailed screen
		if det==1 then
			ttl="M. BATT"
		else
			ttl="S. BATT"
		end
		dlt1=math.ceil((dlt[det])*10000000-0.5)/100 
		if dlt1>99.99 then
			dlt1=99.99
		elseif dlt1<-99.99 then
			dlt1=-99.99
		end
		if hr[det]>9 then
			hrs=tostring(hr[det])
		else
			hrs="0"..tostring(hr[det])
		end
		if mn[det]>9 then
			min=tostring(mn[det])
		else
			min="0"..tostring(mn[det])
		end
		if sc[det]>9 then
			sec=tostring(sc[det])
		else
			sec="0"..tostring(sc[det])
		end
		screen.setColor(50, 50, 50, 50) --back button
		screen.drawRectF(0, -0.5, 11, 12)
		screen.setColor(200, 200, 200, 200)
		Line(2, 5, 9, 5)
		Line(2, 5, 6, 1)
		Line(2, 5, 6, 9)
		if inp[12+det]>0.9 then --dynamic color
			screen.setColor(0, 255, 0)
		elseif inp[12+det]<0.1 then
			screen.setColor(255, 0, 0)
		else
			d=(inp[12+det]-0.1)/0.8
			screen.setColor(255*(1-d), 255*d, 0)
		end
		screen.drawRectF(4, h-2.5, 3, -inp[12+det]*(h-16)) --batt display
		screen.setColor(200, 200, 200)
		screen.drawRect(3, 12, 4, h-15)
		Line(9, 12, 13, 12)
		Line(9, h-3, 13, h-3)
		Line(9, 12+(h-15)/2, 11, 12+(h-15)/2)
		Text((w-9)/2-8, 3, ttl)
		Text(9+(w-9)/2-12, 11, "Level")
		TextBox(9+(w-9)/2-15, 17, 30, 7, perc[det].."%", 0, -1)
		Text(9+(w-9)/2-15, 24, "Charge")
		TextBox(9+(w-9)/2-18, 30, 35, 7, sign[det]..dlt1, 0, -1)
		TextBox(12, 37, w-12, 14, " TIME TO"..chrg[det], 0, -1)
		if w>65 then
			y=6
		else
			y=0
		end
		TextBox(12, 49-y, w-12, 14, hrs..":"..min..":"..sec, 0, -1)
		if bool[15] then
			Text(9+(w-9)/2-25, h-9, "EXT PWR ")
			screen.setColor(0, 255, 0)
			Text(9+(w-9)/2+15, h-9, "ON")
			screen.setColor(200, 200, 200)
		end
	end
end