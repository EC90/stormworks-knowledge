-- source: steam id 3261800786 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3261800786
--PYOs FCS hull-trt+sensor-gun Monitor
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
function onTick()
	lookx=GN(9)
	looky=GN(10)
	kx=GN(11)
	ky=GN(12)
end
S=screen
SC=S.setColor
DR=S.drawRect
DRF=S.drawRectF
DC=S.drawCircle
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	ofstx=-lookx*150
	ofsty=looky*150+5
	SC(22,222,22)
	llx1=0.25*w+ofstx
	lly1=0.5*h+ofsty
	llx2=-0.25*w+ofstx
	lly2=0.5*h+ofsty
	DL(llx1,lly1,llx2,lly2)
	lrx1=0.75*w+ofstx
	lry1=0.5*h+ofsty
	lrx2=1.25*w+ofstx
	lry2=0.5*h+ofsty
	DL(lrx1,lry1,lrx2,lry2)
	lm1x1=0.45*w+ofstx
	lm1y1=0.6*h+ofsty
	lm1x2=ofstx
	lm1y2=1.4*h+ofsty
	DL(lm1x1,lm1y1,lm1x2,lm1y2)
	lm2x1=0.55*w+ofstx
	lm2y1=0.6*h+ofsty
	lm2x2=w+ofstx
	lm2y2=1.4*h+ofsty
	DL(lm2x1,lm2y1,lm2x2,lm2y2)
end