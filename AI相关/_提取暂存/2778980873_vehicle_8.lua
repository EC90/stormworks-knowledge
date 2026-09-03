-- source: steam id 2778980873 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2778980873
iG = input.getNumber
s = screen
sd = screen.drawRectF
st = screen.drawText

function onTick()
sw = input.getBool(3)
ed = input.getBool(4)
rcv = input.getBool(5)
gpsx = iG(3)
gpsy = iG(4)
alt = iG(5)

if gpsx == 0 and gpsy == 0 then nan = true
else nan = false 
end

end

function onDraw()
if ed then
		s.setColor(5,5,5,218)
		sd(1,10,60,7)
		sd(1,17,60,7)
		sd(1,24,60,7)	
		sd(1,1,61,7)
		s.setColor(255,255,255,218)
		st(2,11,"TX:")
		st(2,18,"TY:")
		st(2,25,"ALT:")
		if nan then
			st(15,11, "NO DATA")
			st(15,18, "NO DATA")
			st(20,25, "NO DATA")
		else
			st(15,11, string.format("%.0f", gpsx))	
			st(15,18, string.format("%.0f", gpsy))
			st(20,25, string.format("%.0fM", alt))	
		end

if not rcv then
	if sw then
		st(2,2,"LAS TGT INFO")
		else
		st(2,2,"RDR TGT INFO")
	end
else
	st(2,2, "JTAC TGT RCV")
end

end

end
		