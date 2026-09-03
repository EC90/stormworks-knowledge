-- source: steam id 2835713385 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2835713385
igN = input.getNumber
osN = output.setNumber
igB = input.getBool
osB = output.setBool
ssC = screen.setColor
sdL = screen.drawLine
sdC = screen.drawCircle
sdR = screen.drawRect
sdTF = screen.drawTriangleF
sdRF= screen.drawRectF
sdCF = screen.drawCircleF
sdT = screen.drawText
stf = string.format
sts = string.sub

function Within(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function button(x,y,w,h,p)
	if p == true then
		ssC(30,30,30)
		sdL(x,y,x+w-1,y)
		sdL(x,y,x,y+h-1)
		ssC(70,70,70)
		sdL(x+w-1,y+1,x+w-1,y+h)
		sdL(x+1,y+h-1,x+w-1,y+h-1)
	else
		ssC(70,70,70)
		sdL(x,y,x+w-1,y)
		sdL(x,y,x,y+h-1)
		ssC(30,30,30)
		sdL(x+w-1,y+1,x+w-1,y+h)
		sdL(x+1,y+h-1,x+w-1,y+h-1)
	end
end

function highlight(x,y,w,h,p)
	if p == true then
		ssC(7,7,7)
		sdL(x,y,x+w-1,y)
		sdL(x,y,x,y+h-1)
		ssC(3,3,3)
		sdL(x+w-1,y+1,x+w-1,y+h)
		sdL(x+1,y+h-1,x+w-1,y+h-1)
	else
		ssC(3,3,3)
		sdL(x,y,x+w-1,y)
		sdL(x,y,x,y+h-1)
		ssC(7,7,7)
		sdL(x+w-1,y+1,x+w-1,y+h)
		sdL(x+1,y+h-1,x+w-1,y+h-1)
	end
end

stop,play,pause = false,false,false
PrevX,PrevY = 2,3
NextX,NextY = 16,3
WNP,HNP = 13,8
PauseX,PauseY = 2,12
StopX,StopY = 11,12
PlayX,PlayY = 20,12
WPSP,HPSP = 8,8

function onTick()
	X,Y,P  = igN(3),igN(4),igB(1)

	Next = (P and Within(X, Y, NextX,NextY,WNP,HNP))
	Prev = (P and Within(X, Y, PrevX,PrevY,WNP,HNP))
	stop = (P and Within(X, Y, StopX,StopY,WPSP,HPSP))
	pause = (P and Within(X, Y, PauseX,PauseY,WPSP,HPSP))
	play = (P and Within(X, Y, PlayX,PlayY,WPSP+1,HPSP))
	
	osB(5, stop)
	osB(6, pause)
	osB(7, play)
	osB(3,Next)
	osB(4,Prev)
	
end

function onDraw()
	ssC(50,50,50)
	sdRF(PrevX,PrevY,WNP,HNP)
	sdRF(NextX,NextY,WNP,HNP)
	sdRF(PauseX,PauseY,WPSP,HPSP)
	sdRF(StopX,StopY,WPSP,HPSP)
	sdRF(PlayX,PlayY,WPSP+1,HPSP)
	button(PrevX,PrevY,WNP,HNP,Prev)
	button(NextX,NextY,WNP,HNP,Next)
	button(PauseX,PauseY,WPSP,HPSP,pause)
	button(StopX,StopY,WPSP,HPSP,stop)
	button(PlayX,PlayY,WPSP+1,HPSP,play)
	if Next == false then ssC(30,30,30) else ssC(255,255,255) end
	sdTF(NextX+2,NextY+2,NextX+7,NextY+6,NextX+2,NextY+6)
	sdTF(NextX+6,NextY+2,NextX+11,NextY+6,NextX+6,NextY+6)
	if Prev == false then ssC(30,30,30) else ssC(255,255,255) end
	sdTF(PrevX+2,PrevY+6,PrevX+7,PrevY+2,PrevX+7,PrevY+6)
	sdL(PrevX+3,PrevY+4,PrevX+6,PrevY+1)
	sdTF(PrevX+6,PrevY+6,PrevX+11,PrevY+2,PrevX+11,PrevY+6)
	sdL(PrevX+7,PrevY+4,PrevX+10,PrevY+1)
	if stop == false then ssC(30,30,30) else ssC(150,0,0) end
	sdRF(StopX+2,StopY+2,WPSP-4,HPSP-4)
	if pause == false then ssC(30,30,30) else ssC(100,40,10) end
	sdRF(PauseX+2,PauseY+2,1,HPSP-4)
	sdRF(PauseX+5,PauseY+2,1,HPSP-4)
	if play == false then ssC(30,30,30) else ssC(0,150,0) end
	sdRF(PlayX+2,PlayY+2,3,4)
	sdRF(PlayX+2,PlayY+3,5,2)
	
	
	highlight(0,0,96,32,true)
	highlight(30,3,62,26,false)
end