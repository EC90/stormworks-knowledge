-- source: steam id 3473753441 / microcontroller.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3473753441
root2 = math.sqrt(2)
root3 = math.sqrt(3)
eps = 0.0
px=0
py=0
pz=0
nx=0
ny=0
nz=0
rx=0
ry=0
rz=0
tx=0
ty=0
tz=0

function onTick()
	error=input.getBool(1)
	drawtarget=input.getBool(2)
	if(not error) then
		px=-input.getNumber(1)
		py=input.getNumber(2)
		pz=input.getNumber(3)
		nx=-input.getNumber(4)
		ny=input.getNumber(5)
		nz=input.getNumber(6)
		rx=-input.getNumber(7)
		ry=input.getNumber(8)
		rz=input.getNumber(9)
		if(drawtarget) then
			tx=-input.getNumber(10)
			ty=input.getNumber(11)
			tz=input.getNumber(12)
		end
	end
	
end
function onDraw()
	w=screen.getWidth()				  
	h=screen.getHeight()
	S=h/12
	pxn=px*h/2
	pyn=py*h/2
	nxn=nx*h/2
	nyn=ny*h/2
	rxn=rx*h/2
	ryn=ry*h/2
	txn=tx*h/2
	tyn=ty*h/2
	if (not error) then
		if (pz>=-eps)then
			drawPrograde(pxn,pyn,w,h,S)
		end
		if (pz<=eps)then
			drawRetrograde(-pxn,-pyn,w,h,S)
		end
		if (nz>=-eps)then
			drawNormal(nxn,nyn,w,h,S)
		end
		if (nz<=eps)then
			drawAntinormal(-nxn,-nyn,w,h,S)
		end
		if (rz>=-eps)then
			drawRadial(rxn,ryn,w,h,S)
		end
		if (rz<=eps)then
			drawAntiradial(-rxn,-ryn,w,h,S)
		end
	end
	if drawtarget then
		if (tz>=-eps)then
			drawTarget(txn,tyn,w,h,S)
		end
		if (tz<=eps)then
			drawAntitarget(-txn,-tyn,w,h,S)
		end
	end
end	
function drawPrograde(x,y,w,h,S)
	X=x+w/2
	Y=-y+h/2
	screen.setColor(255,255,0)
	screen.drawCircle(X,Y,S)
	screen.drawCircleF(X,Y,S/11)
	screen.drawLine(X,-S+Y,X,-2*S+Y)
	screen.drawLine(S+X,Y,2*S+X,Y)
	screen.drawLine(-S+X,Y,-2*S+X,Y)
end	
function drawRetrograde(x,y,w,h,S)
	X=x+w/2
	Y=-y+h/2
	screen.setColor(255,255,0)
	screen.drawCircle(X,Y,S)
	screen.drawLine(X+root2*S/2,Y+root2*S/2,X-root2*S/2,Y-root2*S/2)
	screen.drawLine(X-root2*S/2,Y+root2*S/2,X+root2*S/2,Y-root2*S/2)
	screen.drawLine(X,-S+Y,X,-2*S+Y)
	screen.drawLine(X+root3*S/2,Y+S/2,X+root3*S,Y+S)
	screen.drawLine(X-root3*S/2,Y+S/2,X-root3*S,Y+S)
end
function drawNormal(x,y,w,h,S)
	X=x+w/2
	Y=-y+h/2
	screen.setColor(255,0,255)
	screen.drawTriangle(X,Y-4*S/3,X+S*2*root3/3,Y+2*S/3,X-S*2*root3/3,Y+2*S/3)
	screen.drawCircleF(X,Y,S/11)
end	
function drawAntinormal(x,y,w,h,S)
	X=x+w/2
	Y=-y+h/2
	screen.setColor(255,0,255)
	screen.drawTriangle(X,Y+4*S/3,X+S*2*root3/3,Y-2*S/3,X-S*2*root3/3,Y-2*S/3)
	screen.drawCircleF(X,Y,S/11)
	screen.drawLine(X,-S*2/3+Y,X,-S*5/3+Y)
	screen.drawLine(X+root3*S*1/3,Y+S*1/3,X+root3*S*5/6, Y+S*5/6)
	screen.drawLine(X-root3*S*1/3,Y+S*1/3,X-root3*S*5/6, Y+S*5/6)
end	
function drawRadial(x,y,w,h,S)
	X=x+w/2
	Y=-y+h/2
	screen.setColor(0,255,255)
	screen.drawCircle(X,Y,S)
	screen.drawLine(X+root2*S/2,Y+root2*S/2,X+root2*S/4-1,Y+root2*S/4-1)
	screen.drawLine(X+root2*S/2,Y-root2*S/2,X+root2*S/4-1,Y-root2*S/4+1)
	screen.drawLine(X-root2*S/2,Y+root2*S/2,X-root2*S/4+1,Y+root2*S/4-1)
	screen.drawLine(X-root2*S/2,Y-root2*S/2,X-root2*S/4+1,Y-root2*S/4+1)
end	
function drawAntiradial(x,y,w,h,S)
	X=x+w/2
	Y=-y+h/2
	screen.setColor(0,255,255)
	screen.drawCircle(X,Y,S)
	screen.drawCircleF(X,Y,S/11)
	screen.drawLine(X+root2*S/2,Y+root2*S/2,X+root2*S*3/4,Y+root2*S*3/4)
	screen.drawLine(X+root2*S/2,Y-root2*S/2,X+root2*S*3/4,Y-root2*S*3/4)
	screen.drawLine(X-root2*S/2,Y+root2*S/2,X-root2*S*3/4,Y+root2*S*3/4)
	screen.drawLine(X-root2*S/2,Y-root2*S/2,X-root2*S*3/4,Y-root2*S*3/4)
end	
function drawTarget(x,y,w,h,S)
	X=x+w/2
	Y=-y+h/2
	screen.setColor(255,0,255)
	screen.drawCircleF(X,Y,S*3/11)
	screen.drawLine(X-S*11/8,Y-S*3/8,X-S*3/8-root2*S/2,Y-S*3/8-root2*S/2)
	screen.drawLine(X-S*3/8,Y-S*11/8,X-S*3/8-root2*S/2,Y-S*3/8-root2*S/2)
	screen.drawLine(X-S*11/8,Y+S*3/8,X-S*3/8-root2*S/2,Y+S*3/8+root2*S/2)
	screen.drawLine(X-S*3/8,Y+S*11/8,X-S*3/8-root2*S/2,Y+S*3/8+root2*S/2)
	screen.drawLine(X+S*11/8,Y-S*3/8,X+S*3/8+root2*S/2,Y-S*3/8-root2*S/2)
	screen.drawLine(X+S*3/8,Y-S*11/8,X+S*3/8+root2*S/2,Y-S*3/8-root2*S/2)
	screen.drawLine(X+S*11/8,Y+S*3/8,X+S*3/8+root2*S/2,Y+S*3/8+root2*S/2)
	screen.drawLine(X+S*3/8,Y+S*11/8,X+S*3/8+root2*S/2,Y+S*3/8+root2*S/2)
end	
function drawAntitarget(x,y,w,h,S)
	X=x+w/2
	Y=-y+h/2
	screen.setColor(255,0,255)
	screen.drawCircleF(X,Y,S*3/11)
	screen.drawLine(X,-S*2/3+Y,X,-S*5/3+Y)
	screen.drawLine(X+root3*S*1/3,Y+S*1/3,X+root3*S*5/6,Y+S*5/6)
	screen.drawLine(X-root3*S*1/3,Y+S*1/3,X-root3*S*5/6,Y+S*5/6)
end