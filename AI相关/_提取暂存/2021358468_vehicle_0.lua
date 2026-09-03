-- source: steam id 2021358468 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2021358468
PD = 0
P = 0
line = screen.drawLine
cos = math.cos
sin = math.sin
rad = math.rad
COL = screen.setColor
WM = property.getBool("whisky marker")
BG = property.getBool("background")
LiD = math.ceil(property.getNumber("line degree"))
Vline = property.getBool("vertical line")
function onTick()
	P = input.getNumber(1)*360
	R = input.getNumber(2)*360
	V = input.getNumber(3)

	R2 = R-90
	R3 = R+90
	if V < 0
	then 
		 P = P*-1
		 R = R
		 R2 = R2*-1
	else
		 P = P*-1
		 R = R*-1
		 R2 = R2
	end
	RD = rad(R)
	RD2 = rad(R2)
	LD = 16
	SLD = 12
	RC = cos(RD)
	RS = sin(RD)
	RC2 = cos(RD2)
	RC3 = cos(rad(R3))
	RS2 = sin(RD2)
	PRS = P*RS2
	PRC = P*RC2
	MCP = math.ceil(P)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	w2 = w/2
	h2 = h/2
	if BG
	then
	COL(0,0,0)
	screen.drawRectF(0,0,w,h)
	end
	COL(0,255,0,200)
	if WM
	then
	line(w2,h2,w2-4,h2+3)
	line(w2-4,h2+3,w2-8,h2)
	line(w2-8,h2,w2-26,h2)
	line(w2,h2,w2+4,h2+3)
	line(w2+4,h2+3,w2+8,h2)
	line(w2+8,h2,w2+26,h2)
	end
	COL(0,255,0,200)
	line(w2-PRC+5*RC,h2-PRS-5*RS,w2-PRC+LD*RC,h2-PRS-LD*RS)
	line(w2-PRC-LD*RC,h2-PRS+LD*RS,w2-PRC-5*RC,h2-PRS+5*RS)
	line(w2-PRC-LD*RC,h2-PRS+LD*RS,(w2-PRC-LD*RC)+5*RC2,(h2-PRS+LD*RS)+5*RS2)
	line(w2-PRC+LD*RC,h2-PRS-LD*RS,(w2-PRC+LD*RC)+5*RC2,(h2-PRS-LD*RS)+5*RS2)

	for PD = -LiD,-90,-LiD do
		if PD+MCP < 25 and PD+P > -25
		then
		COL(0,255,0,200)
		line((w2-PD*RC2)-PRC-7*RC,(h2-PD*RS2)-PRS+7*RS,(w2-PD*RC2)-PRC-SLD*RC,(h2-PD*RS2)-PRS+SLD*RS)
		line((w2-PD*RC2)-PRC+SLD*RC,(h2-PD*RS2)-PRS-SLD*RS,(w2-PD*RC2)-PRC+7*RC,(h2-PD*RS2)-PRS-7*RS)
		line((w2-PD*RC2)-PRC-SLD*RC,(h2-PD*RS2)-PRS+SLD*RS,(w2-PD*RC2)-PRC-SLD*RC+5*RC2,(h2-PD*RS2)-PRS+SLD*RS+5*RS2)
		line((w2-PD*RC2)-PRC+SLD*RC,(h2-PD*RS2)-PRS-SLD*RS,(w2-PD*RC2)-PRC+SLD*RC+5*RC2,(h2-PD*RS2)-PRS-SLD*RS+5*RS2)
		COL(0,255,0,200)
		screen.drawText((w2-PD*RC2)-PRC-4*RC,(h2-3-PD*RS2)-PRS,math.abs(PD))
		end
	end
	for PD = LiD,90,LiD do
		if PD+MCP < 25 and PD+P > -25
		then
		COL(0,255,0,200)
		line((w2-PD*RC2)-PRC-7*RC,(h2-PD*RS2)-PRS+7*RS,(w2-PD*RC2)-PRC-SLD*RC,(h2-PD*RS2)-PRS+SLD*RS)
		line((w2-PD*RC2)-PRC+SLD*RC,(h2-PD*RS2)-PRS-SLD*RS,(w2-PD*RC2)-PRC+7*RC,(h2-PD*RS2)-PRS-7*RS)
		line((w2-PD*RC2)-PRC-SLD*RC,(h2-PD*RS2)-PRS+SLD*RS,(w2-PD*RC2)-PRC-SLD*RC+5*RC2,(h2-PD*RS2)-PRS+SLD*RS+5*RS2)
		line((w2-PD*RC2)-PRC+SLD*RC,(h2-PD*RS2)-PRS-SLD*RS,(w2-PD*RC2)-PRC+SLD*RC+5*RC2,(h2-PD*RS2)-PRS-SLD*RS+5*RS2)
		COL(0,255,0,200)
		screen.drawText((w2-PD*RC2)-PRC-4*RC,(h2-3-PD*RS2)-PRS,PD)
		end
	end

end