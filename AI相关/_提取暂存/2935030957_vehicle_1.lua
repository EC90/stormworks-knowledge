-- source: steam id 2935030957 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2935030957
AxH="Y"
AxV="Z"
L=24

iN=input.getNumber
iB=input.getBool
oN=output.setNumber
oB=output.setBool
sc=screen
sC=sc.setColor
dT=sc.drawText
dL=sc.drawLine
dC=sc.drawCircle
fo=string.format

function dL2(cx,cy,dx,dy)
	dL(cx,cy,cx+dx,cy-dy)
end
function onTick()
	B={{},{},{}}
	for i=1,3 do
		for j=1,3 do
			B[i][j]=iN(11+3*(i-1)+(j-1))
		end
	end
	
	if AxH=="X" then
		HInd=1
	elseif AxH=="Y" then
		HInd=2
	else
		HInd=3
	end
	
	if AxV=="X" then
		VInd=1
	elseif AxV=="Y" then
		VInd=2
	else
		VInd=3
	end
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	
	sC(255,255,255)
	dL(0,h/2,w,h/2)
	dL(w/2,0,w/2,h)
	dT(w/2-5,h/2+2,"O")
	dT(w-5,h/2+2,AxH)
	dT(w/2-5,2,AxV)
	
	sC(255,63,63)
	dL2(w/2,h/2,L*B[1][HInd],L*B[1][VInd])
	sC(63,255,63)
	dL2(w/2,h/2,L*B[2][HInd],L*B[2][VInd])
	sC(63,63,255)
	dL2(w/2,h/2,L*B[3][HInd],L*B[3][VInd])
end