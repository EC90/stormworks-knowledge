-- source: steam id 2308050926 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2308050926
I=input
getN=I.getNumber

S=screen
txt=S.drawText
C=S.setColor
M=math

hh={ms=0,i=0,n=0}
mm={ms=0,i=0,n=0}
ss={ms=0,i=0,n=0}
ms={ms=0,i=0,n=0}
time=0

zFmt=function (v,n) return string.format("%0"..n.."d",v) end

function onTick()
	spd=getN(9)
	dis=getN(16)
	
	if spd>0.5 then
		hh.ms=dis/spd*60
		hh.i=M.floor(hh.ms/60^3)
		hh.n=hh.i*60^3
		
		mm.ms=hh.ms-hh.n
		mm.i=M.floor(mm.ms/60^2)
		mm.n=mm.i*60^2
		
		ss.ms=mm.ms-mm.n
		ss.i=M.floor(ss.ms/60^1)
		ss.n=ss.i*60^1
		
		ms.ms=ss.ms-ss.n
		ms.i=M.floor(ms.ms/60^0)
		ms.n=ms.i*60^0
	end
	
	if hh.i>0 then
		time=hh.i..":"..zFmt(mm.i,2)..":"..zFmt(ss.i,2)
	end

	if hh.i==0 and mm.i>0 then
		time=mm.i..":"..zFmt(ss.i,2)	
	end
	
	if hh.i==0 and mm.i==0 and ss.i>0 then
		time=ss.i
	end
	
end

function onDraw()
	w=S.getWidth()
	h=S.getHeight()	
	C(255,255,0,64)
	txt(3,h/2+11,"T:-"..time)
end
