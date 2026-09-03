-- source: steam id 3004053396 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3004053396
i,m,p = input,math,property
gn,gb,pgn = i.getNumber,i.getBool,p.getNumber

RXF,RYF = pgn("Radar Xa Fov")*360,pgn("Radar Ya Fov")*360
rxf,ryf = pgn("Radar Xb Fov")*360,pgn("Radar Yb Fov")*360

G = pgn("Tick Comp Gain")

n=1
rdrB={}
hudX={}
hudY={}
rdrV={}
rdrD={}

rdrX={0,0,0,0,0,0,0,0}
rdrY={0,0,0,0,0,0,0,0}
PrdrD={0,0,0,0,0,0,0,0}
SrdrD={0,0,0,0,0,0,0,0}
sCV = {0,0,0,0,0,0,0,0}


function onTick()

	ordBool=gb(9)
	RWR=gb(10)
	up,down = gb(11),gb(12)
	chdt = gn(8)
	chdb = gn(12)
	
	cm = m.floor(chdt*192)
	cr = m.floor(((1-chdt)%1)*360)
	tr = m.floor((((chdt-chdb)+1.5)%1-0.5)*192)
	
	count=0
	for i=1,8 do		
		rdrX[i],rdrY[i],rdrD[i],rdrB[i]=(gn((i*4)-2)*360),(gn((i*4)-1)*360),gn((i*4)-3),gb(i)
		if rdrB[i] then count=count+1 end
	end
	
	if up then n=n+1 end
	if down then n=n-1 end
	if n>count then n=count end
	if n<1 then n=1 end
	
	output.setNumber(1,n) output.setNumber(2,count)
	
	zoom=((135-1.43)*(1-gn(4)))+1.43
	
	bX,bY = (RXF/zoom)*47,(RYF/zoom)*47
	cX,cY = (rxf/zoom)*47,(ryf/zoom)*47

	for i=1,8 do
		hudX[i],hudY[i]=((((rdrX[i])/zoom)*95)+46),((((-rdrY[i])/zoom)*95)+46)
		SrdrD[i] = SrdrD[i]+(rdrD[i]-SrdrD[i])/10
		rdrV[i] = PrdrD[i]-SrdrD[i]
		PrdrD[i] = SrdrD[i]
		sCV[i] = sCV[i]+(rdrV[i]-sCV[i])/40
	end	
	
	
end
	
S=screen
SC,DR,DRF,DTX,DL=S.setColor,S.drawRect,S.drawRectF,S.drawText,S.drawLine

function onDraw()

SC(0,255,0,150)
DR(bX+47,bY+47,bX*-2,bY*-2)
DR(cX+47,cY+47,cX*-2,cY*-2)

SC(255,255,0,200)

for i=1,8 do
	
	if rdrB[i] then
		if n~=i then	
			DR(hudX[i],hudY[i],3,3)
		else end
	else end
end
	
	if ordBool then
		
		SC(0,255,0)
		DTX(37,80,"SHOOT")
	else
		
		SC(0,255,0)
	end

if rdrB[n] then
	
		DR(hudX[n],hudY[n],3,3)
		SC(0,255,0)
		DTX(hudX[n]+5,hudY[n]-3,string.format("%.0f",SrdrD[n]))
		DTX(hudX[n]+5,hudY[n]+4,string.format("%.0f",sCV[n]*60))
else end

if rdrB[1] then
	SC(0,255,0)
	DTX(1,1,"tgts:")
	DTX(25,1,string.format("%01.0f",count))
else end

if RWR then
SC(255,0,0)
DTX(31,10,"warning")
else end

shape(cm,-2,cr,tr)

end

function shape(x,y,a,b)SC(0,255,0,200)DL(-96+x,96+y,-94.75+x,96.25+y)DL(-88+x,96+y,-86.75+x,96.25+y)DL(-80+x,96+y,-78.75+x,96.25+y)DL(-72+x,96+y,-70.75+x,96.25+y)DL(-64+x,96+y,-62.75+x,96.25+y)DL(-56+x,96+y,-54.75+x,96.25+y)DL(-48+x,96+y,-46.75+x,96.25+y)DL(-40+x,96+y,-38.75+x,96.25+y)DL(-32+x,96+y,-30.75+x,96.25+y)DL(-24+x,96+y,-22.75+x,96.25+y)DL(-16+x,96+y,-14.75+x,96.25+y)DL(-8+x,96+y,-6.75+x,96.25+y)DL(0+x,96+y,1.25+x,96.25+y)DL(8+x,96+y,9.25+x,96.25+y)DL(16+x,96+y,17.25+x,96.25+y)DL(24+x,96+y,25.25+x,96.25+y)DL(32+x,96+y,33.25+x,96.25+y)DL(40+x,96+y,41.25+x,96.25+y)DL(48+x,96+y,49.25+x,96.25+y)DL(56+x,96+y,57.25+x,96.25+y)DL(64+x,96+y,65.25+x,96.25+y)DL(72+x,96+y,73.25+x,96.25+y)DL(80+x,96+y,81.25+x,96.25+y)DL(88+x,96+y,89.25+x,96.25+y)DL(96+x,96+y,97.25+x,96.25+y)DL(104+x,96+y,105.25+x,96.25+y)DL(112+x,96+y,113.25+x,96.25+y)DL(120+x,96+y,121.25+x,96.25+y)DL(128+x,96+y,129.25+x,96.25+y)DL(136+x,96+y,137.25+x,96.25+y)DL(144+x,96+y,145.25+x,96.25+y)DL(152+x,96+y,153.25+x,96.25+y)DL(160+x,96+y,161.25+x,96.25+y)DL(168+x,96+y,169.25+x,96.25+y)DL(176+x,96+y,177.25+x,96.25+y)DL(184+x,96+y,185.25+x,96.25+y)DL(192+x,96+y,193.25+x,96.25+y)DL(-96+x,97+y,193.25+x,97.25+y)DRF(47,91.5,2,3)DTX(50,88,string.format("%03.0f",a))DRF(47+b,93+y,2,3)end
	