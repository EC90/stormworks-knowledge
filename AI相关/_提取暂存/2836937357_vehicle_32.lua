-- source: steam id 2836937357 / vehicle.xml block#32
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
igb=input.getBool
s=screen
DL=screen.drawLine
SC=screen.setColor
DR=screen.drawRect
DRF=screen.drawRectF
DT=screen.drawTriangle
DTF=screen.drawTriangleF
DTX=screen.drawText
GN=input.getNumber
SN=output.setNumber
FMT=string.format
SUB=string.sub
FLOOR=math.floor

function onTick()
	speed=GN(4)
	altitude=math.floor(GN(5))
	ALTH = igb(1)
	HDG=GN(6)
	
end

function zero(x,y)
	DR(x,y,2,4)
end
function one(x,y)
	DL(x+1,y,x+1,y+4)
	DL(x,y+4,x+3,y+4)
	DL(x,y+1,x+1,y+1)
end
function two(x,y)
	DL(x,y,x+3,y)
	DL(x,y+2,x+3,y+2)
	DL(x,y+4,x+3,y+4)
	DL(x+2,y,x+2,y+2)
	DL(x,y+2,x,y+4)
end
function three(x,y)
	DL(x,y,x+3,y)
	DL(x,y+2,x+3,y+2)
	DL(x,y+4,x+3,y+4)
	DL(x+2,y,x+2,y+4)
end
function four(x,y)
	DL(x,y+2,x+3,y+2)
	DL(x+2,y,x+2,y+5)
	DL(x,y,x,y+2)
end
function five(x,y)
	DL(x,y,x+3,y)
	DL(x,y+2,x+3,y+2)
	DL(x,y+4,x+3,y+4)
	DL(x,y,x,y+2)
	DL(x+2,y+2,x+2,y+4)
end
function six(x,y)
	DR(x,y+2,2,2)
	DL(x,y,x+3,y)
	DL(x,y,x,y+2)
end
function seven(x,y)
	DL(x,y,x+3,y)
	DL(x+2,y,x+2,y+5)
end
function eight(x,y)
	DR(x,y,2,4)
	DL(x,y+2,x+3,y+2)
end
function nine(x,y)
	DR(x,y,2,2)
	DL(x+2,y,x+2,y+5)
	DL(x,y+4,x+3,y+4)
end

--convert to small number
function CSN(x,y,n)
	if n=="0" then zero(x,y)
	elseif n=="1" then one(x,y)
	elseif n=="2" then two(x,y)
	elseif n=="3" then three(x,y)
	elseif n=="4" then four(x,y)
	elseif n=="5" then five(x,y)
	elseif n=="6" then six(x,y)
	elseif n=="7" then seven(x,y)
	elseif n=="8" then eight(x,y)
	elseif n=="9" then nine(x,y)
	end
end

--draw small numbers
function DSN(x,y,s)
	s=tostring(s)
		l=string.len(s)
	for i=1,l do
		n=s:sub(i,i)
		CSN(x,y,n)
		x=x+4
	end
end 
function onDraw()

    if ALTH == true then
		SC(0,255,0)
		DTX(20,1,"ALT")
	end
    SC(0, 0, 0, 255)
	DRF(0, 0, 15, 64)
	DRF(49, 0, 16, 64)
	SC(0, 0, 0, 255)
	DRF(15, 0, 34, 10)
	DRF(15, 53, 34, 64)
	DTF(15, 10, 14, 16, 19, 10) --here
	DTF(44, 10, 49, 16, 49, 10)
	DTF(15, 49, 15, 53, 19, 53)
	DTF(49, 49, 45, 53, 49, 53)
	SC(0, 0, 0)
	DRF(23, -1, 18, 7)
	SC(0, 0, 0, 0)
	DTF(32, 32, 22, 36, 22, 42)
	DTF(32, 32, 43, 36, 43, 42)
	SC(175, 175, 0)
	DTF(32, 32, 27, 38, 37.5, 38)
	DR(18, 32, 2, 1)
	DR(44, 32, 2, 1)
	SC(255, 255, 255, 255) --Lines for speed
	DL(0, 9, 15, 9)
	DL(0, 53 ,15, 53)
	DL(12, 9 ,12, 53)
	SC(20, 20, 20, 255)
	DRF(0, 10, 12, 43)
	SC(255, 255, 255, 255) --Lines for Altitude
	DL(51, 9, 67, 9)
	DL(51, 53 ,67, 53)
	SC(20, 20, 20, 255)
	DRF(51, 10, 12, 43)
	SC(255, 255, 255, 255)
	DR(20, 56, 24, 10)---lines for HDG
	SC(20, 20, 20, 255)
	DRF(21, 57, 23, 9)
	SC(255, 255, 255, 100)
	DSN(0, 21,FMT("%03i",math.ceil(speed)+1))
	DSN(0, 12,FMT("%03i",math.ceil(speed)+2))
	if speed > 1 then
	DSN(0, 39,FMT("%03i",math.ceil(speed)-1))
	DSN(0, 48,FMT("%03i",math.ceil(speed)-2))
	end
	if speed > 0 then
	DSN(0, 39,FMT("%03i",math.ceil(speed)-1))
	end
	
	DSN(51, 22,FMT("%03i",math.ceil(altitude)+1))
	DSN(51, 14,FMT("%03i",math.ceil(altitude)+2))
	if altitude > 1 then
	DSN(51, 38,FMT("%03i",altitude-1))
	end
	if altitude > 2 then
	DSN(51, 46,FMT("%03i",math.ceil(altitude)-2))
	end
    SC(0, 0, 0)
	DRF(0, 28, 15, 8)
	DRF(48, 28, 15, 8)
	DRF(48, 56, 15, 8)
	DRF(0, 56, 15, 8)
	SC(255, 255, 0)
	DR(48, 28, 15, 8)
	SC(255, 255, 255, 200)
	DSN(0,30,FMT("%03i",math.ceil(speed)))
	DSN(27,58,FMT("%03i",math.ceil(HDG)))
	SC(0, 255, 0, 200)
	DSN(51, 30,FMT("%03i",math.ceil(altitude)))
	SC(255, 255, 255, 255)
	DL(48, 0, 48, 7)
	DL(15, 0, 15, 7)
	DL(32, 0, 32, 7)

end
	
