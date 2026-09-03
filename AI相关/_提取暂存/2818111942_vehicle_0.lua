-- source: steam id 2818111942 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2818111942
LAST_TIME,FASTEST_TIME,TIMER=0,0,0
START,VALID=false,true
TICK_RATE=60
CHECKPOINTS,NOW_CHECK,CHECK_AREA={
{2291,-4854},
{1875,-4367},
{1130,-3766},
{-198,-4666},
{-794,-5240},
{-2305,-4701},
{-3231,-4874},
{-3618,-5914},
{-3375,-6643},
{-2534,-7239},
{-1981,-8241},
{-2366,-9162},
{-2300,-10150},
{-1314,-10668},
{803,-9881},
{1388,-10192},
{1816,-9944},
{1861,-9113},
{2492,-8297},
{1959,-7433},
{2056,-6348},
{2843,-5487},
{3356,-4909},
},1,25
REC_CHECK={}
lEle,lFuel=0,0

P=property
PN,PB,PT=P.getNumber,P.getBool,P.getText

tMin,tSec,tMs=PN('target min'),PN('target sec'),PN('target ms')
tTime=tMin*TICK_RATE*TICK_RATE+tSec*TICK_RATE+tMs/1000*TICK_RATE
FASTEST_TIME=tTime
LAST_TIME=tTime

for i=1,#CHECKPOINTS do
	table.insert(REC_CHECK,math.floor(tTime*i/#CHECKPOINTS))
end


function onTick()
	I,O=input,output
	GN,GB=I.getNumber,I.getBool
	SN,SB=O.setNumber,O.setBool
	
	TIMER=TIMER+1
	gpsx,gpsy,alt,compass,electric,fuel=GN(1),GN(2),GN(3),GN(4),GN(5),GN(6)
	
	tx,ty=CHECKPOINTS[NOW_CHECK][1],CHECKPOINTS[NOW_CHECK][2]
	nextDirection=compass*math.pi*2-math.atan(ty-gpsy,tx-gpsx)
	nextDist=dist(tx-gpsx, ty-gpsy)
	
	if nextDist<=CHECK_AREA then
		REC_CHECK[NOW_CHECK]=TIMER
		NOW_CHECK=(NOW_CHECK%#CHECKPOINTS)+1
		if lEle~=0 and electric>=lEle then
			VALID=false
		end
		lEle=electric
		if lFuel~=0 and fuel>=lFuel then
			VALID=false
		end
		lFuel=fuel
		if START==false and NOW_CHECK==2 then
			START=true
			TIMER=0
		elseif NOW_CHECK==2 then
			LAST_TIME=TIMER
			if FASTEST_TIME==0 then
				FASTEST_TIME=LAST_TIME
			else
				FASTEST_TIME=math.min(FASTEST_TIME,LAST_TIME)
			end
			TIMER=0
		end
	end
end

function onDraw()
	S=screen
	Text,TextBox,Color,Line,RectF,Rect,Circle,CircleF,Triangle,TriangleF=S.drawText,S.drawTextBox,S.setColor,S.drawLine,S.drawRectF,S.drawRect,S.drawCircle,S.drawCircleF,S.drawTriangle,S.drawTriangleF
	w,h=S.getWidth(),S.getHeight()

	if VALID==false then
		Color(10,0,0)
		RectF(0,0,w,h)
		Color(255,0,0)
		Text(10,1,"INVALID")
	end

	Color(70,70,70)
	TextBox(0,h/2-13,w,5,tick2time(LAST_TIME),0,0)

	Color(255,255,255)
	Text(2,2,NOW_CHECK)
	TextBox(0,h/2,w,5,tick2time(TIMER),0,0)
	
	showdtime(S, w/2-20, h/2-7, LAST_TIME-FASTEST_TIME)
	showdtime(S, w/2-20, h/2+7, TIMER-REC_CHECK[NOW_CHECK])
	
	sspx,sspy=13,h/2
	dsl=math.min(nextDist/10,10)
	dsx,dsy=dsl*math.cos(nextDirection),dsl*math.sin(nextDirection)
	Color(255,255,255)
	Line(sspx,sspy,sspx+dsx,sspy+dsy)
	Color(70,70,70)
	CircleF(sspx,sspy,2)
end
	
function dist(x,y) return math.sqrt(x*x+y*y) end
function tick2time(x) return string.format("%d:%d:%d",math.floor(x/TICK_RATE/TICK_RATE),math.floor(x/TICK_RATE)%TICK_RATE,math.floor((x%TICK_RATE)/TICK_RATE*1000)) end
function showdtime(s, x, y, t)
	if t>=0 then
		s.setColor(70,0,0)
		s.drawText(x,y,"+"..tick2time(t))
	else
		s.setColor(0,70,0)
		s.drawText(x,y,"-"..tick2time(-t))
	end
end