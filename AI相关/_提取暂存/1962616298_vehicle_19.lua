-- source: steam id 1962616298 / vehicle.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
inp={}
bool={}
c="Include "
p=" "
fuel={0, 0, 0, 0, 0} --fuel input
flav={0, 0, 0, 0, 0} --fuel avg
cap={}
perc={}
dlt={0, 0, 0, 0, 0}
hr={}
mn={}
sc={}
ff={}
rng={}
s={0, 0, 0, 0, 0}
ttl={"LWT:", "CENT", "RWT:", "AUX:", "TOT:"}
wng=property.getBool(c.."Wing Tanks")
cnt=property.getBool(c.."Center Tanks")
aux=property.getBool(c.."Aux Tanks")
if property.getBool("Range Units") then
	rngu=0.000539957
	rngt="nm"
else
	rngu=0.001
	rngt="km"
end
if property.getBool("Fuel Units") then
	unit=0.264172
	untt="G"
else
	unit=1
	untt="L"
end
Line=screen.drawLine
Text=screen.drawText
TextB=screen.drawTextBox
Rect=screen.drawRect
RectF=screen.drawRectF

function onTick()
go=input.getBool(32)
	for i=1, 32 do
		inp[i]=input.getNumber(i)
		bool[i]=input.getBool(i)
	end
	for i=1, 4 do --gathers fuel info
		dlt[i]=dlt[i]*0.92+(inp[21+i*2]*unit-fuel[i])*0.08 --fuel flow
		fuel[i]=inp[21+i*2]*unit
		flav[i]=flav[i]*0.92+fuel[i]*0.08
		cap[i]=inp[22+i*2]*unit
		perc[i]=flav[i]/cap[i]
	end
	dlt[5]=dlt[5]*0.92+((inp[23]+inp[25]+inp[27]+inp[29])*unit-fuel[5])*0.08
	fuel[5]=fuel[1]+fuel[2]+fuel[3]+fuel[4]
	flav[5]=flav[5]*0.92+fuel[5]*0.08
	cap[5]=cap[1]+cap[2]+cap[3]+cap[4]
	perc[5]=flav[5]/cap[5]
	for i=1, 5 do --finds time to empty
		if dlt[i]<0 then
			s[i]=s[i]*0.92+((fuel[i]/(-dlt[i]))/60)*0.08
		else
			s[i]=0
		end
		if s[i]>=359999 then
			s[i]=359999
		end
		rng[i]=s[i]*inp[2]*rngu
		hr[i]=math.floor(s[i]/3600)
		t=s[i]-hr[i]*3600
		mn[i]=math.floor(t/60)
		t=t-mn[i]*60
		sc[i]=math.floor(t)
		ff[i]=dlt[i]*3600 --fuel flow/min
	end
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	a=h/2
	b=w/2
	det=inp[1]
	if det==0 then --main fuel display
		if cnt then
			TextB(b-9, a/4+4, 20, 7, "Cent", 0, -1)
			TextB(b-12, a/4+12, 25, 7, math.ceil(flav[2]-0.5), 1, -1)
		end
		if wng then
			TextB(b/2-9, a-2, 20, 7, "L-WT", 0, -1)
			TextB(b/2-12, a+6, 25, 7, math.ceil(flav[1]-0.5), 1, -1)
			
			TextB(3*b/2-9, a-2, 20, 7, "R-WT", 0, -1)
			TextB(3*b/2-12, a+6, 25, 7, math.ceil(flav[3]-0.5), 1, -1)
		end
		if aux then
			TextB(b-9, 3*a/2, 20, 7, "AUXT", 0, -1)
			TextB(b-12, 3*a/2+8, 25, 7, math.ceil(flav[4]-0.5), 1, -1)
		end
		screen.setColor(0, 0, 0)
		RectF(w-57, 1.5, 56, 7)
		screen.setColor(200, 200, 200)
		Rect(w-58, 0, 57, 8)
		TextB(w-56, 2, 55, 7, "TOT:"..string.rep(p, 6-string.len(math.ceil(flav[5]-0.5)))..math.ceil(flav[5]-0.5)..untt)
	else --detailed fuel display
		bh=h-18 --fuel bar height
		if hr[det]>9 then --sets endurance time strings
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
		Line(5, 13, 5, bh+13) --draws fuel bar
		Line(3, bh/4+13, 8, bh/4+13)
		Line(2, bh/2+12, 8, bh/2+12)
		Line(3, 3*bh/4+12, 8, 3*bh/4+12)
		screen.setColor(0, 255, 0)
		RectF(4, 16.5, 3, bh-3)
		screen.setColor(255, 255, 0)
		RectF(4, 5*bh/8+13.5, 3, 3*bh/8)
		screen.setColor(255, 0, 0)
		RectF(4, 7*bh/8+13.5, 3, 1*bh/8)
		screen.setColor(200, 200, 200)
		Line(2, 13, 8, 13)
		Line(2, bh+12, 8, bh+12) 
		screen.drawTriangleF(8.5, bh+13-(bh-1)*perc[det], 13, bh+13-(bh-1)*perc[det]+4, 13, bh+13-(bh-1)*perc[det]-4)--fuel indicator
		TextB(11, 2, w-11, 7, ttl[det]..string.rep(p, 5-string.len(math.ceil(perc[det]*1000-0.5)/10))..math.ceil(perc[det]*1000-0.5)/10 .."%", 0, -1) --detailed page title
		TextB(11, 8, w-11, 7, math.ceil(flav[det]-0.5)..untt, 0, -1) --fuel value
		TextB(11, 16, w-11, 7, "Fuel flow", 0, -1)
		TextB(11, 22, w-11, 7, math.abs(math.ceil(ff[det]-0.5))..untt.."/m", 0, -1) --fuel flow/min
		TextB(11, 30, w-11, 7, "time to", 0, -1)
		TextB(11, 36, w-11, 7, "empty", 0, -1)
		TextB(11, 42, w-11, 7, hrs..":"..min..":"..sec, 0, -1)
		TextB(11, 50, w-11, 7, "range", 0, -1)
		TextB(11, 56, w-11, 7, math.ceil(rng[det]-0.5)..rngt, 0, -1)
		screen.setColor(50, 50, 50, 50) --back button
		RectF(0, -0.5, 11, 12)
		screen.setColor(200, 200, 200, 200)
		Line(2, 5, 9, 5)
		Line(2, 5, 6, 1)
		Line(2, 5, 6, 9)
	end
end