-- source: steam id 3603910667 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
scr=screen
SC=screen.setColor
DL=screen.drawLine
DC=screen.drawCircle

function AA(x,y)
	DC(x+1,y+1,1)
	DL(x,y+1,x,y+5)
	DL(x+2,y+1,x+2,y+5)
end
function BB(x,y)
	DC(x+1,y+1,1)
	DC(x+1,y+3,1)
	DL(x,y,x,y+5)
end
function CC(x,y)
	DL(x+1,y,x+3,y)
	DL(x+1,y+4,x+3,y+4)
	DL(x,y+1,x,y+4)
end
function DD(x,y)
	DL(x,y,x+2,y)
	DL(x,y+4,x+2,y+4)
	DL(x,y,x,y+5)
	DL(x+2,y+1,x+2,y+4)
end
function EE(x,y)
	DL(x,y,x+3,y)
	DL(x,y+2,x+2,y+2)
	DL(x,y+4,x+3,y+4)
	DL(x,y,x,y+5)
end
function FF(x,y)
	DL(x,y,x+3,y)
	DL(x,y+2,x+2,y+2)
	DL(x,y,x,y+5)
end
function GG(x,y)
	DL(x,y,x+3,y)
	DL(x,y+4,x+3,y+4)
	DL(x,y,x,y+4)
	DL(x+2,y+3,x+2,y+5)
end
function HH(x,y)
	DL(x,y+2,x+3,y+2)
	DL(x,y,x,y+5)
	DL(x+2,y,x+2,y+5)
end
function II(x,y)
	DL(x,y,x+3,y)
	DL(x,y+4,x+3,y+4)
	DL(x+1,y,x+1,y+5)
end
function JJ(x,y)
	DL(x,y,x+3,y)
	DL(x,y+4,x+3,y+4)
	DL(x+2,y,x+2,y+5)
	DL(x,y+3,x,y+5)
end
function KK(x,y)
	DL(x,y+2,x+2,y+2)
	DL(x,y,x,y+5)
	DL(x+2,y,x+2,y+2)
	DL(x+2,y+3,x+2,y+5)
end
function LL(x,y)
	DL(x,y+4,x+3,y+4)
	DL(x,y,x,y+5)
end
function MM(x,y)
	DL(x,y+1,x+3,y+1)
	DL(x,y,x,y+5)
	DL(x+2,y,x+2,y+5)
end
function NN(x,y)
	DL(x,y,x+3,y)
	DL(x,y,x,y+5)
	DL(x+2,y,x+2,y+5)
end
function OO(x,y)
	DL(x+1,y,x+2,y)
	DL(x+1,y+4,x+2,y+4)
	DL(x,y+1,x,y+4)
	DL(x+2,y+1,x+2,y+4)
end
function PP(x,y)
	DC(x+1,y+1,1)
	DL(x,y,x,y+5)
end
function QQ(x,y)
	DL(x+1,y,x+2,y)
	DL(x+1,y+3,x+3,y+3)
	DL(x,y+1,x,y+3)
	DL(x+2,y+1,x+2,y+5)
end
function RR(x,y)
	DC(x+1,y+1,1)
	DL(x,y,x,y+5)
	DL(x+2,y+3,x+2,y+5)
end
function SS(x,y)
	DL(x+1,y,x+3,y)	
	DL(x,y+4,x+2,y+4)
	DL(x,y+1,x+3,y+4)
end
function TT(x,y)
	DL(x,y,x+3,y)
	DL(x+1,y,x+1,y+5)
end
function UU(x,y)
	DL(x,y+4,x+3,y+4)
	DL(x,y,x,y+5)
	DL(x+2,y,x+2,y+5)
end
function VV(x,y)
	DL(x+1,y+3,x+1,y+5)
	DL(x,y,x,y+3)
	DL(x+2,y,x+2,y+3)
end
function WW(x,y)
	DL(x,y+3,x+3,y+3)
	DL(x,y,x,y+5)
	DL(x+2,y,x+2,y+5)
end
function XX(x,y)
	DL(x+1,y+2,x+2,y+2)
	DL(x,y,x,y+2)
	DL(x,y+3,x,y+5)
	DL(x+2,y,x+2,y+2)
	DL(x+2,y+3,x+2,y+5)
end
function YY(x,y)
	DL(x,y,x,y+2)
	DL(x+2,y,x+2,y+2)
	DL(x+1,y+2,x+1,y+5)
end
function ZZ(x,y)
	DL(x,y,x+3,y)
	DL(x,y+4,x+3,y+4)
	DL(x,y+3,x+3,y)
end
--convert to small text
function CST(x,y,s)
	if s=="A" then AA(x,y)
	elseif s=="B" then BB(x,y)
	elseif s=="C" then CC(x,y)
	elseif s=="D" then DD(x,y)
	elseif s=="E" then EE(x,y)
	elseif s=="F" then FF(x,y)
	elseif s=="G" then GG(x,y)
	elseif s=="H" then HH(x,y)
	elseif s=="I" then II(x,y)
	elseif s=="J" then JJ(x,y)
	elseif s=="K" then KK(x,y)
	elseif s=="L" then LL(x,y)
	elseif s=="M" then MM(x,y)
	elseif s=="N" then NN(x,y)
	elseif s=="O" then OO(x,y)
	elseif s=="P" then PP(x,y)
	elseif s=="Q" then QQ(x,y)
	elseif s=="R" then RR(x,y)
	elseif s=="S" then SS(x,y)
	elseif s=="T" then TT(x,y)
	elseif s=="U" then UU(x,y)
	elseif s=="V" then VV(x,y)
	elseif s=="W" then WW(x,y)
	elseif s=="X" then XX(x,y)
	elseif s=="Y" then YY(x,y)
	elseif s=="Z" then ZZ(x,y)
	end
end
--draw small text (x, y, text)
function DST(x,y,t)
	l=string.len(t)
	for i=1,l do
		s=t:sub(i,i)
		CST(x,y,s)
		x=x+4
	end
end

function onTick()
	--add what you want here	
end

function onDraw() --add what you want here

	SC(100,100,100)
	DST(2,1, "    NAV")	
	DST(2,7, " BATTLE")
	DST(2,13,"  NIGHT")
	DST(2,19,"    RAM")
	DST(2,25," FLIGHT")
	
	
end