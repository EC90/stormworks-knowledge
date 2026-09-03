-- source: steam id 2751468095 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095
scr=screen
SC=screen.setColor
DL=screen.drawLine
DC=screen.drawCircle
RF=screen.drawRectF

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
function DST(x,y,t)
	l=string.len(t)
	for i=1,l do
		s=t:sub(i,i)
		CST(x,y,s)
		x=x+4
	end
end

function onTick()
	rwr=input.getBool(1)
	msl=input.getBool(2)
	top=input.getBool(3)
	back=input.getBool(4)
	front=input.getBool(5)
	right=input.getBool(6)
	left=input.getBool(8)
end

function onDraw()
SC(2,2,2)
RF(0,0,64,33)
	SC(17,17,17)
	RF(17,1,29,8)
		SC(255,255,255)
		DST(18,2,"EWS SYS")
			DST(3,2, "RWS")
				DST(50,2,"LWR")
					DL(59,14,59.25,22.25)
					DL(57,11,59.25,13.25)
					DL(55,11,56.25,11.25)
					DL(52,23,59.25,23.25)
					DL(51,13,51.25,23.25)
					DL(53,11,51.25,13.25)
					DL(54,11,54.25,11.25)
						SC(101,0,0)
						if left then
						DL(49,16,49.25,19.25)
						end
						if right then
						DL(61,16,61.25,19.25)
						end
						if top then
						RF(54,16,3,3)
						end
						if front then
						DL(53,9,57.25,9.25)
						end
						if back then
						DL(53,25,57.25,25.25)
						end
							if msl then
							SC(101,0,0)
							RF(4,21,37,7)
							SC(255,255,255)
							DST(5,22, "MISL WARN")
							end
								if rwr then
								SC(199,68,4)
								RF(4,11,37,7)
								SC(255,255,255)
								DST(5,12, "RDR DETEC")
								end
end