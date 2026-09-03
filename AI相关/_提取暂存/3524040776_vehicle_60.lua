-- source: steam id 3524040776 / vehicle.xml block#60
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--mouse render
function onTick()
	mntx=input.getNumber(1)
	mnty=input.getNumber(2)
	cursorx=input.getNumber(3)
	cursory=input.getNumber(4)
	click=input.getBool(1)
	ismouse=input.getBool(3)
end
function onDraw()
	if ismouse then
		screen.setColor(222,222,222,111)
		if click then
			screen.setColor(111,111,111,111)
		end
		--screen.drawTriangleF(cursorx,cursory,cursorx-2,cursory+6,cursorx+3,cursory+4)
		screen.drawCircle(cursorx,cursory,0.9)
        screen.drawLine(cursorx-5,cursory-5,cursorx-3,cursory-5)
        screen.drawLine(cursorx+5,cursory-5,cursorx+3,cursory-5)
        screen.drawLine(cursorx-5,cursory+5,cursorx-3,cursory+5)
        screen.drawLine(cursorx+5,cursory+5,cursorx+3,cursory+5)
        screen.drawLine(cursorx-5,cursory-5,cursorx-5,cursory-3)
        screen.drawLine(cursorx+5,cursory-5,cursorx+5,cursory-3)
        screen.drawLine(cursorx-5,cursory+5,cursorx-5,cursory+3)
        screen.drawLine(cursorx+5,cursory+5,cursorx+5,cursory+3)
        --screen.drawText(cursorx-10,cursory-10,cursorx..","..cursory)
	end
end