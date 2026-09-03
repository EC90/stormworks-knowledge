-- source: steam id 2885633937 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2885633937
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
z=2.5
mox,moy=0,0
mapofst,mapofsto=false,false
touchxo,touchyo=0,0
touched=false
aimgps=false
function pushbutton(bx,by,bw,bh)
	if touch and tx>bx and tx<bx+bw and ty>by and ty<by+bh then
		return true
	else
		return false
	end
end
function togglebutton(bx,by,bw,bh,stts)
    if touch and tx>bx and tx<bx+bw and ty>by and ty<by+bh and (not touched) then
        stts=not stts
    else
    end
    return stts
end
function drawbutton(bx,by,bw,bh,msg,stts)
	if stts then
		screen.setColor(15,233,15,200)
		screen.drawRectF(bx,by,bw,bh)
		screen.setColor(0,0,0,128)
		screen.drawText(bx+1,by+1,msg)
	else
		screen.setColor(0,0,0,128)
		screen.drawRectF(bx,by,bw,bh)
		screen.setColor(15,233,15,200)
		screen.drawText(bx+1,by+1,msg)
	end        
end
function onTick()
	w=GN(1)
	h=GN(2)
	tx=GN(3)
	ty=GN(4)
	gpsx=GN(5)
	gpsy=GN(6)
	touch=input.getBool(1)
	zi,zo=false,false
	oW,oE,oN,oS=false,false,false,false
	--zizo
	if pushbutton(w-6,h/4-5,6,7) then zi=true z=math.max(z*0.97,0) end
	if pushbutton(w-6,3*h/4-5,6,7) then zo=true z=math.min(z*1.03,50) end
	--map offset
	if pushbutton(1,h/2-5,6,7) then mox=mox-z*5 oW=true end
	if pushbutton(w-7,h/2-5,6,7) then mox=mox+z*5 oE=true end
	if pushbutton(w/2-5,1,6,7) then moy=moy+z*5 oN=true end
	if pushbutton(w/2-5,h-7,6,7) then moy=moy-z*5 oS=true end
	if math.abs(mox)>0 or math.abs(moy)>0 then
		mapofst=true
		if pushbutton(1,h-8,6,7) then mapofst=false mox,moy=0,0 end
	end
	if mapofst then
		if not mapofsto then
			mcx,mcy=gpsx,gpsy
		else
			mcx,mcy=mcx,mcy
		end
	else
		mcx,mcy=gpsx,gpsy
	end
	mapofsto=mapofst
	SN(30,mcx+mox)
	SN(31,mcy+moy)
	SN(32,z)
	aimgps=togglebutton(w-17,1,16,7,aimgps)
	SB(32,aimgps)
	if tx>6 and ty>6 and tx<w-6 and ty<h-6 then
	touchx,touchy=map.screenToMap(mcx+mox,mcy+moy,z,w,h,tx,ty) end
	SN(21,touchx)
	SN(22,touchy)
	touchxo=touchx
	touchyo=touchy
	touched=touch
	tempx,tempy=map.mapToScreen(mcx+mox,mcy+moy,z,w,h,touchx,touchy)
end
function onDraw()
	drawbutton(w-17,1,16,7,"AIM",aimgps)
	drawbutton(w-6,h/4-5,5,7,"+",zi)
	drawbutton(w-6,3*h/4-5,5,7,"-",zo)
	drawbutton(1,h/2-5,6,7,"W",oW)
	drawbutton(w-7,h/2-5,6,7,"E",oE)
	drawbutton(w/2-5,1,6,7,"N",oN)
	drawbutton(w/2-5,h-8,6,7,"S",oS)
	if mapofst then
		drawbutton(1,h-8,6,7,"R",not mapofst)
	end
	if touchx~=0 then
	screen.drawText(tempx-2,tempy-2,"+")
	end
end