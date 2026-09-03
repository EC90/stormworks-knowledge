-- source: steam id 2446775682 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()

	iX = input.getNumber(3)
	iY = input.getNumber(4)
	ips = input.getBool(1)

	if ips and ipr(iX, iY, 0, 10, 4, 4) then osb=1 end
	if ips and ipr(iX, iY, 0, 20, 4, 4) then osb=2 end
	if ips and ipr(iX, iY, 0, 30, 4, 4) then osb=3 end
	if ips and ipr(iX, iY, 0, 40, 4, 4) then osb=4 end
	if ips and ipr(iX, iY, 0, 50, 4, 4) then osb=5 end
	
	if ips and ipr(iX, iY, 10, 60, 4, 4) then osb=6 end
	if ips and ipr(iX, iY, 20, 60, 4, 4) then osb=7 end
	if ips and ipr(iX, iY, 30, 60, 4, 4) then osb=8 end
	if ips and ipr(iX, iY, 40, 60, 4, 4) then osb=9 end
	if ips and ipr(iX, iY, 50, 60, 4, 4) then osb=10 end
	
	if ips and ipr(iX, iY, 60, 50, 4, 4) then osb=11 end
	if ips and ipr(iX, iY, 60, 40, 4, 4) then osb=12 end
	if ips and ipr(iX, iY, 60, 30, 4, 4) then osb=13 end
	if ips and ipr(iX, iY, 60, 20, 4, 4) then osb=14 end
	if ips and ipr(iX, iY, 60, 10, 4, 4) then osb=15 end
	
	if ips and ipr(iX, iY, 50, 0, 4, 4) then osb=16 end
	if ips and ipr(iX, iY, 40, 0, 4, 4) then osb=17 end
	if ips and ipr(iX, iY, 30, 0, 4, 4) then osb=18 end
	if ips and ipr(iX, iY, 20, 0, 4, 4) then osb=19 end
	if ips and ipr(iX, iY, 10, 0, 4, 4) then osb=20 end
	
	if ips==false then osb=0 end
	
	output.setNumber(1, osb)
end


function ipr(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

