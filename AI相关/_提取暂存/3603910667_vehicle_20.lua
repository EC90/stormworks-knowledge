-- source: steam id 3603910667 / vehicle.xml block#20
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
s=screen
SC=screen.setColor
DL=screen.drawLine
DR=screen.drawRect
FMT=string.format
SUB=string.sub

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
function DSN(x,y,s) --(x,y,string)
	s=tostring(s)
	l=string.len(s)
	for i=1,l do
		n=s:sub(i,i)
		CSN(x,y,n)
		x=x+4
	end
end

function onTick()
	--write what you want here
end
	
function onDraw() --add whatever you want here
	

		
end