-- source: steam id 2156436786 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2156436786
sc,inp,out=screen,input,output
freq=16
freqb=freq
ptt=false

function hex2rgb(hex)
    hex = hex:gsub("#","")
    	return {r=tonumber("0x"..hex:sub(1,2)), g=tonumber("0x"..hex:sub(3,4)), b=tonumber("0x"..hex:sub(5,6))}
end

function onTick()
	p = inp.getBool(1)
	x = inp.getNumber(3)
	y = inp.getNumber(4)
	str = inp.getNumber(5)
	recv = inp.getBool(3)
	out.setNumber(1,freq)
	out.setBool(1,ptt)
	
	BGC = hex2rgb(property.getText("Background Color (Hex)"))
	FGC = hex2rgb(property.getText("Foreground Color (Hex)"))
end
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	sc.setColor(BGC["r"],BGC["g"],BGC["b"],255)
	sc.drawClear()
	sc.setColor(FGC["r"]*0.3,FGC["g"]*0.3,FGC["b"]*0.3,255)
	if y > 24 then
		if x < 8 and p then
			sc.drawRectF(0,25,8,10)
			if freq > 1 then
					freq=freqb-1
			end
		elseif x > 8 and x < 16 and p then
			sc.drawRectF(9,25,8,10)
			if freq < 88 then
				freq=freqb+1
			end
		else
				freqb=freq
		end
		if x > 16 and p then
			sc.drawRectF(16,25,16,8)
			ptt=true
		else
			ptt=false
		end
	end
	if recv then
	sc.setColor(FGC["r"],FGC["g"],FGC["b"],255)
	else
	sc.setColor(FGC["r"]*0.05,FGC["g"]*0.05,FGC["b"]*0.05,255)
	end
	sc.drawText(4,10,"INCOM")
	
	sx = 19
	sy = -9
	sc.setColor(FGC["r"]*0.05,FGC["g"]*0.05,FGC["b"]*0.05,255)
	if str > 0.8 then
	sc.setColor(FGC["r"],FGC["g"],FGC["b"],255)
	end
	sc.drawRectF(10+sx,10+sy,1,5)
	if str > 0.65 then
	sc.setColor(FGC["r"],FGC["g"],FGC["b"],255)
	end
	sc.drawRectF(8+sx,11+sy,1,4)
	if str > 0.35 then
	sc.setColor(FGC["r"],FGC["g"],FGC["b"],255)
	end
	sc.drawRectF(6+sx,12+sy,1,3)
	if str > 0.1 then
	sc.setColor(FGC["r"],FGC["g"],FGC["b"],255)
	end
	sc.drawRectF(4+sx,13+sy,1,2)
	
	sc.setColor(FGC["r"],FGC["g"],FGC["b"],255)
	sc.drawLine(0,24,w,24)
	sc.drawLine(0,7,w,7)
	sc.drawLine(8,25,8,32)
	sc.drawLine(16,25,16,32)
	sc.drawText(2,26,"<")
	sc.drawText(11,26,">")
	sc.drawText(18,26,"PTT")
	sc.drawText(4,17,"CH:"..string.format("%.0f",freq))
	sc.drawText(2,1,"VHF")
end