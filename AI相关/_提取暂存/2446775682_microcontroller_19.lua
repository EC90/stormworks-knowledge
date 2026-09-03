-- source: steam id 2446775682 / microcontroller.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()

	page = input.getNumber(31)
	osb = input.getNumber(32)
	camnv = input.getBool(2)
	zooming = input.getBool(1)
	camzoom = input.getNumber(11)
	stab = input.getBool(17)
	trak = input.getBool(18)
	narw = input.getBool(19)
	
	rdr = input.getNumber(10)
	trimp = input.getNumber(7)
	trimr = input.getNumber(8)
	trimy = input.getNumber(9)
	autotrim = input.getBool(3)
	
	amt = input.getNumber(13)
	lpm = input.getNumber(14)
	time = input.getNumber(15)
	rng = input.getNumber(16)
	perkm = input.getNumber(17)
	pitch = input.getNumber(18)
	roll = input.getNumber(19)
	
	apup = input.getNumber(21)
	hydlo = input.getBool(5)
	pump1 = input.getNumber(23)
	pump2 = input.getNumber(24)

	if page==10 then
	if osb==1 then nv=true else nv=false end
	if osb==15 then cplus=true else cplus=false end
	if osb==14 then cminus=true else cminus=false end
	if osb==2 then st=true else st=false end
	if osb==3 then tk=true else tk=false end
	if osb==11 then nr=true else nr=false end
	end
	if page==7 then
	if osb==2 then resetp=true else resetp=false end
	if osb==3 then resetr=true else resetr=false end
	if osb==4 then resety=true else resety=false end
	if osb==5 then mode=true else mode=false end	
	end
	

	output.setBool(1, nv)
	output.setBool(2, cplus)
	output.setBool(3, cminus)
	output.setBool(4, resetp)
	output.setBool(5, resetr)
	output.setBool(6, resety)
	output.setBool(7, mode)
	output.setBool(8, st)
	output.setBool(9, tk)
	output.setBool(10, nr)
	perkm2 = (string.format("%0.0f", perkm))
	lpm2 = (string.format("%0.0f", lpm))
	amt2 = (string.format("%0.0f", amt))
	time2 = (string.format("%0.1f", time))
	rng2 = (string.format("%0.0f", rng))
end
function onDraw()

if page==7 then
screen.setColor(0,0,0)
screen.drawRectF(0, 0, 70, 70)
screen.setColor(0,255,0)
screen.drawText(5, 20, "p:"..(string.format("%0.3f", trimp)))
screen.drawText(5, 30, "r:"..(string.format("%0.3f", trimr)))
screen.drawText(5, 40, "y:"..(string.format("%0.3f", trimy)))
if autotrim==true then
screen.drawText(5, 50, "auto")
else
screen.drawText(5, 50, "man")
end

screen.drawText(22, 10, "flcs")
screen.drawText(25, 55, "mnu")
end
if page==10 then
	screen.setColor(0,0,0)
	screen.drawRectF(3, 9, 14, 7)
	screen.drawRectF(54, 9, 8, 7)
	screen.drawRectF(54, 19, 8, 7)
	screen.drawRectF(54, 49, 8, 7)
	screen.drawRectF(24, 54, 16, 7)
	screen.drawRectF(3, 9, 14, 7)
	screen.drawRectF(3, 19, 10, 7)
	screen.drawRectF(3, 29, 10, 7)
	screen.setColor(0,255,0)
	if narw==false then

	screen.drawRect(14, 14, 36, 36)
	end
	screen.drawLine(20, 31, 28, 31)
	screen.drawLine(44, 31, 36, 31)
	screen.drawLine(32, 20, 32, 28)
	screen.drawLine(32, 44, 32, 36)
	screen.drawTextBox(18, 3, 30, 9, (string.format("%0.0f", rdr)).."r", 0, 0)
	screen.drawText(5, 10, "NV")
	screen.drawText(5, 20, "s")
	screen.drawText(5, 30, "t")
	screen.drawText(55, 10, "+")
	screen.drawText(55, 20, "-")
	screen.drawText(55, 50, "n")
	screen.drawText(25, 55, "mnu")
	if zooming==true then
	screen.setColor(0, 0, 0)
	screen.drawRectF(10, 5, 50, 10)
	screen.setColor(0, 255, 0)
	screen.drawTextBox(10, 5, 49, 9, "ZOOM "..(string.format("%0.1f", camzoom*10)), 0, 0)
	end
	if camnv==true then
	screen.drawText(10, 53, "NV")
	end
	if stab==true then
	screen.drawText(44, 53, "ST")
	end
	if trak==true then
	screen.drawRect(30, 30, 4, 4)
	end end
if page==6 then
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, 0, 70, 70)
	screen.setColor(0, 255, 0)
	screen.drawText(5, 10, "tme:"..time2)
	screen.drawText(5, 20, "qty:"..amt2)
	screen.drawText(5, 30, "lpm:"..lpm2)
	screen.drawText(5, 40, "lpk:"..perkm2)
	screen.drawText(5, 50, "rng:"..rng2)
	screen.drawText(44, 50, "mnu")
	end
if page==21 then
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, 0, 70, 70)
	screen.setColor(0, 255, 0)
	screen.drawText(25, 55, "mnu")
	screen.drawText(23, 5, "hydr")
	screen.drawText(5, 10, "apu:"..(string.format("%0.1f", apup)))
	screen.drawText(5, 20, "pmp1:"..(string.format("%0.1f", pump1)))
	screen.drawText(5, 30, "pmp2:"..(string.format("%0.1f", pump2)))
	if hydlo==true then
	screen.drawText(5, 40, "hyd pres lo")
	end
	end

end
