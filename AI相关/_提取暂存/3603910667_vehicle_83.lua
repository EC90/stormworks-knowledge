-- source: steam id 3603910667 / vehicle.xml block#83
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pN=property.getNumber
pB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
sqrt=M.sqrt
asin=M.asin
atan=M.atan
exp=M.exp
floor=M.floor
pi=M.pi
pi2=M.pi*2
S=string
T=true
F=false

FlueScale={0.1,0.5,0.25,0}
FlueSpeed={0.001,0.001,0.001,0.001}
FlueTime={3600,1800,900,0}
FlueLeak={F,F,F,F}
Charge=1
Tempture={25,70,100,114}
RPS={0,16,10,10}
Throttle={0,0,0,0}
EngineWrn={F,F,F,F}
EngineErr={F,F,F,F}
EngineSht={F,F,F,F}

FlueWarn=pN("FlueWrnLevel")

function onTick()
	RPSTarget=GN(1)
	Charge=GN(28)
	for i=1,4 do
		Tempture[i]=GN(i*3+1)
		FlueScale[i]=GN(i*3+2)
		FlueTime[i]=clamp(GN(i*3+3),0,3600*9+60*59)
		EngineErr[i]=not GB(i*2+4) or not GB(i*2+12)
		FlueLeak[i]=GB(i*2+5)
		RPS[i]=GN(i*3+14)
		EngineSht[i]=not GB(i*2+13)
		Throttle[i]=GN(i*3+13)
		EngineWrn[i]=abs(RPSTarget-RPS[i])>0.3
	end
end

EngineIcon={
{3,0,8,0},
{5,1,5,2},
{4,2,8,2},
{3,3,3,4},
{3,9,11,9},
{0,4,0,9},
{1,6,1,7},
{2,4,2,9},
{7,2,10,5},
{10,4,10,9},
{11,6,12,6},
{12,4,12,9}
}

TemptureIcon={
{6,0,6,10},
{6,1,8,1},
{6,3,8,3},
{6,5,8,5},
{5,7,5,10},
{7,7,7,10},
{0,9,4,7},
{9,9,13,7},
{9,9,13,7},
{0,12,1,11},
{1,11,3,11},
{11,12,13,12},
{3,12,7,10},
{7,12,11,10}
}

BatteryIcon={
{0,1,13,1},
{0,1,0,10},
{0,9,13,9},
{12,1,12,10},
{2,0,2,1},
{10,0,10,1},
{2,4,5,4},
{3,3,3,6},
{8,4,11,4}
}

FlueIcon={
{3,0,3,11},
{3,0,9,0},
{2,10,10,10},
{4,3,4,10},
{5,3,5,10},
{6,3,6,10},
{7,3,7,10},
{8,0,8,10},
{9,6,9,8},
{7,3,7,10},
{9,7,11,7},
{9,1,11,3},
{11,3,11,7}
}

S=screen
SC=S.setColor
DL=S.drawLine
DR=S.drawRect
DF=S.drawRectF
DT=S.drawText
function onDraw()
	width = screen.getWidth()
	height = screen.getHeight()
	
	RPSPosition={
		{6,16},
		{width-15,16},
		{6,16+height/2},
		{width-15,16+height/2}
	}
	FluePosition={
		{25,34},
		{width-39,34},
		{25,34+height/2},
		{width-39,34+height/2}
	}
	FlueLeakPosition={
		{25,50},
		{width-39,50},
		{25,10+height/2},
		{width-39,10+height/2}
	}
	TimePosition={
		{25,41},
		{width-44,41},
		{25,41+height/2},
		{width-44,41+height/2}
	}
	TempturePosition={
		{3,25},
		{width-18,25},
		{3,25+height/2},
		{width-18,25+height/2}
	}
	
	SC(255,255,255)
	DR(0,0,20,height/2-1)
	DR(0,height/2,20,height/2-1)
	DR(width-21,0,20,height/2-1)
	DR(width-21,height/2,20,height/2-1)
	
	SC(clamp0((FlueWarn-FlueScale[1]))*64/(1-FlueWarn),0,0)
	DF(21,1,3,height/2-1)
	SC(clamp0((FlueWarn-FlueScale[2]))*64/(1-FlueWarn),0,0)
	DF(width-24,1,3,height/2-1)
	SC(clamp0((FlueWarn-FlueScale[3]))*64/(1-FlueWarn),0,0)
	DF(21,1+height/2,3,height/2-1)
	SC(clamp0((FlueWarn-FlueScale[4]))*64/(1-FlueWarn),0,0)
	DF(width-24,1+height/2,3,height/2-1)
	
	SC(255,64,0)
	DF(21,(height/2-1)*(1-FlueScale[1])+1,3,(height/2-1)*FlueScale[1])
	DF(width-24,(height/2-1)*(1-FlueScale[2])+1,3,(height/2-1)*FlueScale[2])
	DF(21,(height/2-1)*(1-FlueScale[3])+1+height/2,3,(height/2-1)*FlueScale[3])
	DF(width-24,(height/2-1)*(1-FlueScale[4])+1+height/2,3,(height/2-1)*FlueScale[4])
	
	RPSText={}
	RPSColor={}
	for n,m in ipairs(RPS) do
		RPSText[n]=string.format("%02d",floor(m))
		if EngineSht[n] then
			RPSColor[n]={16,16,16}
		elseif m<3 or m>15 then
			RPSColor[n]={255,64,0}
		else
			RPSColor[n]={0,255,0}
		end
		
		if EngineErr[n] then
			SC(255,0,0)
		elseif EngineWrn[n] then
			SC(255,64,0)
		elseif EngineSht[n] then
			SC(16,16,16)
		else
			SC(0,255,0)
		end
		
		DrawIcon(RPSPosition[n][1]-2,RPSPosition[n][2]-13,EngineIcon)
	end
	DrawAllText(RPSPosition,RPSText,RPSColor)
	
	FlueText={}
	for n,m in ipairs(FlueScale) do
		FlueText[n]=string.format("%03d",floor(m*100))
	end
	DrawAllText(FluePosition,FlueText,{{255,64,0},{255,64,0},{255,64,0},{255,64,0}})
	
	for n,m in ipairs(Throttle) do
		SC(255,128,64)
		DT(FluePosition[n][1],FluePosition[n][2]-10,string.format("%03d",floor(m*100)))
	end
	
	for n,m in ipairs(FlueLeak) do
		if m then
			SC(255,0,0)
		else
			SC(32,32,32)
		end
		DT(FlueLeakPosition[n][1],FlueLeakPosition[n][2],"FLK")
	end
	
	FlueTimeText={}
	FlueTimeColor={}
	for n,m in ipairs(FlueTime) do
		FlueTimeText[n]=string.format("%01d:%02d",floor(m/3600),floor(m/60)%60)
		if FlueLeak[n] then
			FlueTimeColor[n]={255,0,0}
		else
			FlueTimeColor[n]={255,64,0}
		end
	end
	DrawAllText(TimePosition,FlueTimeText,FlueTimeColor)
	
	TemptureText={}
	TemptureColor={}
	for n,m in ipairs(Tempture) do
		TemptureText[n]=string.format("%03d",floor(m))
		TemptureColor[n]={clamp0((m-25)/90)*255,clamp0((1-(m-25)/90))*255,0}
		if m>=114 then
			SC(255,0,0)
		elseif m>=100 then
			SC(255,64,0)
		else
			SC(16,16,16)
		end
		DrawIcon(TempturePosition[n][1]+1,TempturePosition[n][2]+7,TemptureIcon)
		SC(255*clamp0((m-25)/90),255*clamp0((1-(m-25)/90)),0)
		DL(TempturePosition[n][1]-1,TempturePosition[n][2]+21,TempturePosition[n][1]+16,TempturePosition[n][2]+21)
		DL(TempturePosition[n][1]-2,TempturePosition[n][2]+21,TempturePosition[n][1]-2,TempturePosition[n][2]+21-(height/2-2)*clamp0(m/115))
		DL(TempturePosition[n][1]+16,TempturePosition[n][2]+21,TempturePosition[n][1]+16,TempturePosition[n][2]+21-(height/2-2)*clamp0(m/115))
	end
	DrawAllText(TempturePosition,TemptureText,TemptureColor)
	
	SC(255,255,0)
	DT(width/2-8,14,'100')
	
	if Charge<0.8 then
		SC(255,64,0)
	else
		SC(0,255,0)
	end
	DrawIcon(width/2-13,1,BatteryIcon)
	if FlueScale[1]<=FlueWarn or FlueScale[2]<=FlueWarn or FlueScale[3]<=FlueWarn or FlueScale[4]<=FlueWarn then
		SC(255,64,0)
	else
		SC(0,255,0)
	end
	DrawIcon(width/2+1,1,FlueIcon)
end

function DrawAllText(List,Text,color)
	for n,position in ipairs(List) do
		SC(color[n][1],color[n][2],color[n][3])
		DT(position[1],position[2],Text[n])
	end
end

function DrawIcon(x,y,Icon)
	for n,position in ipairs(Icon) do
		DL(position[1]+x,position[2]+y,position[3]+x,position[4]+y)
	end
end
	
function clamp0(x)
	if x<0 then x=0 end
	if x>1 then x=1 end
	return x
end
	
function clamp(x,a,b)
	if x<a then x=a end
	if x>b then x=b end
	return x
end