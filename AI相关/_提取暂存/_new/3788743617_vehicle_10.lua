-- source: steam id 3788743617 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
function onTick()		
	compass = input.getNumber(5)
	gpsx = input.getNumber(6)			 
	gpsy = input.getNumber(7)					
end

S=screen
SC=S.setColor
DL=S.drawLine
DRF=S.drawRectF
DTX=S.drawText
DTXB=S.drawTextBox

function onDraw()

SC(100,100,100)
DTXB(6, 1, 16, 7, string.format("%.0f", compass), 1, 0)
DL(23,2,23.25,2.25)
	
DTX(1, 12, string.format("%.0f", gpsx))
DTX(1, 23, string.format("%.0f", gpsy))

SC(5,5,5)
DL(7,0,31.25,0.25)
DRF(25,1.5,7,7)
DL(0,7,6.25,7.25)
DRF(0,8.5,32,2)
DRF(0,19.5,32,2)
DRF(0,30.5,32,2)




end