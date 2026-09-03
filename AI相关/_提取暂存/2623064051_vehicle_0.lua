-- source: steam id 2623064051 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2623064051
function hex2rgb(hex)
    hex = hex:gsub("#","")
        return {r=tonumber("0x"..hex:sub(1,2)), g=tonumber("0x"..hex:sub(3,4)), b=tonumber("0x"..hex:sub(5,6))}
end

function onTick()
	H=(((1-input.getNumber(1))%1)*360)
	C=hex2rgb(property.getText("Bars Color (Hex)"))
	C2=hex2rgb(property.getText("Heading Color (Hex)"))
	T=property.getNumber("Bars Transparency")
	OF=property.getNumber("Height Offset")
	FLP=property.getBool("Flip Vertically")
	Show=property.getBool("Show Heading")
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()					
	
	sp=H-math.floor(H/5)*5
	l=math.ceil((w/2-sp)/5)
	x=w/2-sp-l*5
	v=math.floor(H-w/2+x)%360
	
	if FLP == true then
		PL = -6
		P1 = 1
		P2 = 0
	else
		PL = 3
		P1 = 0
		P2 = 1
	end
	
	screen.setColor(C["r"],C["g"],C["b"],T)
	while (x<w) do
			if (v/15==math.floor(v/15)) then
			screen.drawLine(x, OF, x, 2+OF)
			if x<w/2-12 or x>w/2+12 or Show == false then
				if v==0 then 
					screen.drawText(x-1,PL+OF,"N")
				elseif v==45 then
					screen.drawText(x-4,PL+OF,"NE")
				elseif v==90 then
					screen.drawText(x-1,PL+OF,"E")
				elseif v==135 then
					screen.drawText(x-4,PL+OF,"SE")
				elseif v==180 then
					screen.drawText(x-1,PL+OF,"S")
				elseif v==225 then
					screen.drawText(x-4,PL+OF,"SW")
				elseif v==270 then
					screen.drawText(x-1,PL+OF,"W") 
				elseif v==315 then
					screen.drawText(x-4,PL+OF,"NW") 
				end
			end
		else
			screen.drawLine(x, P1+OF, x, P2+OF)
		end
		x=x+5 v=(v+5)%360
	end
	if Show == true then
	screen.setColor(C2["r"],C2["g"],C2["b"])
	screen.drawLine(w/2, OF, w/2, 2+OF)
	screen.drawText((w-#(string.format("%.0f", H))*5)/2+1, PL+OF, string.format("%.0f", H))
	end
end