-- source: steam id 2446775682 / microcontroller.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()
	addon = input.getNumber(1)
	page = input.getNumber(31)
	osb = input.getNumber(32)
	
	if page==1 then
	if osb==1 then pg=2 end
	if osb==2 then pg=3 end
	if osb==3 then pg=4 end
	if osb==4 then pg=5 end
	if osb==5 then pg=6 end	
	if osb==15 then pg=7 end
	if osb==14 then pg=8 end
	if osb==13 then pg=9 end
	if osb==12 then pg=10 end
	if osb==11 then pg=11 end
	if osb==8 then pg=20 end
	end
	
	if page==20 then
	if osb==1 then pg=21 end
	if osb==2 then pg=22 end
	if osb==3 then pg=23 end
	if osb==4 then pg=24 end
	if osb==15 then pg=26 end
	if addon>0 and osb==14 then pg=31 end
	if addon>1 and osb==13 then pg=32 end
	if addon>2 and osb==12 then pg=33 end
	end
	
	if page>1 and page<21 and page~=6 and page~=2 then
	if osb==8 then pg=1 end
	end
	if page==6 then
	if osb==11 then pg=1 end
	end
	if page==2 then
	if osb==5 then pg=1 end
	end
	
	if page>20 then
	if osb==8 then pg=20 end
	end
	
	
	
	
	if osb==0 then pg=0 end
	output.setNumber(1, pg)
end



function onDraw()
if page==1 then
	screen.setColor(0,0,0)
	screen.drawRectF(0, 0, 70, 70)
	screen.setColor(0,255,0)
	screen.drawText(5, 10, "pfd")
	screen.drawText(5, 20, "hsi")
	screen.drawText(5, 30, "eng")
	screen.drawText(5, 40, "wth")
	screen.drawText(5, 50, "fl")
	screen.drawText(39, 10, "flcs")
	screen.drawText(44, 20, "map")
	screen.drawText(44, 30, "inu")
	screen.drawText(44, 40, "tgp")
	screen.drawText(44, 50, "rdr")
	screen.drawText(30, 54, "1")
	end
	
if page==20 then
	screen.setColor(0,0,0)
	screen.drawRectF(0, 0, 70, 70)
	screen.setColor(0,255,0)
	screen.drawText(5, 10, "hyd")
	screen.drawText(5, 20, "elc")
	screen.drawText(5, 30, "lct")
	screen.drawText(5, 40, "chr")
	screen.drawText(5, 50, "xxx")
	screen.drawText(44, 10, "spi")
	if addon>0 then
	screen.drawText(44, 20, "ao1")
	end
	if addon>1 then
	screen.drawText(44, 30, "ao2")
	end
	if addon>2 then
	screen.drawText(44, 40, "ao3")
	end
	
	screen.drawText(30, 54, "2")
	end

	
end