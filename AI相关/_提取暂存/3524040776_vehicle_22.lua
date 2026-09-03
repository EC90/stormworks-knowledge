-- source: steam id 3524040776 / vehicle.xml block#22
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--PYOs FCS 2025 Build Pivot Monitor
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Mf=M.floor
function mF(x)
	return Mf(x+0.5)
end
CPMin=PN('-')
CPMax=PN('+')
z=1
zp=2
touched=false
isIR=false
isRDR=false
isSW=false
rst=false
mBo=0
w,h=64,64
function PB(bx,by,bw,bh)
	if touch and touchX>bx and touchX<bx+bw and touchY>by and touchY<by+bh then
		return true
	else
		return false
	end
end
function TB(bx,by,bw,bh,stts)
	if touch and touchX>bx and touchX<bx+bw and touchY>by and touchY<by+bh and (not touched) then
		stts=not stts
	else
	end
	return stts
end
function DB(bx,by,bw,bh,msg,stts)
	if stts then
		SC(22,222,22)
		DRF(bx,by,bw,bh)
		SC(0,0,0,200)
		DT(bx+1,by+1,msg)
	else
		SC(0,0,0,200)
		DRF(bx,by,bw,bh)
		SC(22,222,22)
		DT(bx+1,by+1,msg)
	end        
end
function onTick()
	touchX=GN(3)
	touchY=GN(4)
	cps=GN(5)
	trtr=GN(6)
	cpit=GN(7)--cannon ele
	mergedA=GN(8)
	mB=GN(9)
	Slow=mergedA%1000>99
	rdr=mergedA%100>9
	stb=mergedA%10>0
	if cps<0 then
		dir=-cps*360
	else
		dir=360-cps*360
	end
	touch=GB(1)
	zi,zo=false,false
	if PB(10,h/2,w-20,h/2-10) then
		zi=true
	end
	if (zi and not touched) or (mB==9 and mBo==5) then
		z=M.max(z*0.5,0.5) zp=M.max(zp-1,1)
	end
	if PB(10,10,w-20,h/2-10) then
		zo=true
	end
	if (zo and not touched) or (mB==1 and mBo==5) then
		z=M.min(z*2,32) zp=M.min(zp+1,7)
	end
	isIR=TB(w-12,0,12,7,isIR)
	isSW=TB(0,h-14,16,7,isSW)
	rst=TB(w-13,h-16,13,16,rst)
	SB(3,isIR)
	fov=(2.2-(45.9/z/180)*M.pi)/2.175
	--fovr=(45.9/z/180)*M.pi
	--fovt=45.9/z/360
	fovd=45.9/z
	SN(1,fov)
	SN(3,zp)
	if rst then
		rsto=0
	else
		rsto=1
	end
	SN(2,rsto*10+zp)
	touched=touch
	mBo=mB
	trigger=GN(10)>0.5
end
S=screen
SC=S.setColor
DR=S.drawRect
DRF=S.drawRectF
DC=S.drawCircle
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
TextDir={'N','E','S','W'}
function onDraw()
	--get screen size, when scope, scale the ui
	w=S.getWidth()
	h=S.getHeight()
	if w==288 then
		ui0=32
		w=224
		h=96
	else
		ui0=0
	end
	--draw cps basic
	SC(22,222,22)
	_=mF(dir)
	for i=_-mF(0.45*fovd),_+mF(0.45*fovd) do
		if i%15==0 then
			mlen=4
		else
			mlen=3
		end
		dx=ui0+w/2-(_-i)/fovd*w
		dy=ui0+1
		if i%5==0 then
			if i%90==0 then
				DT(dx-2,dy,TextDir[i/90+1])
			else
				DL(dx,dy,dx,dy+mlen)
			end
		end
	end
	SC(0,0,0,200)
	DRF(ui0,ui0,w,7)--upper filled rect
	SC(22,222,22)
	DTB(ui0+w/2-8,ui0+1,16,5,_,0,0)--draw cps number
	--draw elevation cage
	dx=ui0
	dy=ui0+10
	dw=3
	dh=h-27
	SC(22,222,22)
	DR(dx,dy,dw,dh)
	eleZ=dy+dh+CPMin/(CPMax-CPMin)*dh
	DL(dx,eleZ,dx+dw,eleZ)
	SC(0,0,0,200)
	DRF(dx,dy,dw+1,dh+1)
	SC(22,222,22)
	DR(dx,dy+dh-(cpit*90-CPMin)/(CPMax-CPMin)*dh,3,2)
	--draw lower filled rect
	SC(0,0,0,200)
	DRF(ui0,ui0+h-7,w,7)
	--draw slow
	SC(22,222,22)
	if Slow then
		DT(ui0+w-18,ui0+h-6,'S')
	end
	--draw zoom
	if z<1 then
		msg='0.5'
	else
		msg=string.format('%2.0f',z)..'x'
	end
	DT(ui0+1,ui0+h-6,msg)
	--draw other buttons
	DB(ui0+w-12,ui0,12,7,"IR",isIR)
	DB(ui0,ui0,16,7,"RDR",rdr)
	--draw trt
	SC(0,0,0,200)
	DRF(ui0+w-13,ui0+h-16,13,9)
	if rst then
		SC(222,22,22)
	elseif stb then
		SC(22,222,22)
	else
		SC(222,222,22)
	end
	dx=ui0+w-7
	dy=ui0+h-9
	DR(dx-5,dy-6,10,13)
	DC(dx,dy,3)
	DL(dx,dy,dx+8*M.sin(trtr*M.pi*2),dy-8*M.cos(trtr*M.pi*2))
	if trigger then
		SC(22,222,22)
		DT(ui0+0.5*w-9,ui0+h-12,'fire')
	end
end