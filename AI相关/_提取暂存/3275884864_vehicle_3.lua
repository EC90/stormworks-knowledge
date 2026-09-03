-- source: steam id 3275884864 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
--ztq15cmdMnt
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
CPMin=PN('-')/90
CPMax=PN('+')/90
z=1
zp=2
touched=false
isIR=false
isSW=false
rst=false
ovr=false
gps=false
WP={'cnn','m g'}
function PB(bx,by,bw,bh)
	if touch and tx>bx and tx<bx+bw and ty>by and ty<by+bh then
		return true
	else
		return false
	end
end
function TB(bx,by,bw,bh,stts)
	if touch and tx>bx and tx<bx+bw and ty>by and ty<by+bh and (not touched) then
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
mBo=0
function onTick()
w=GN(1)
h=GN(2)
tx=GN(3)
ty=GN(4)
cps=GN(5)--cur
trtr=GN(6)
cpit=GN(7)
mA=GN(8)
mB=GN(9)
mtrtr=GN(10)--cps
hcps=GN(11)--cps
sa=mA%1000>99
rdr=mA%100>9
stb=mA%10>0
if cps<0 then
dir=-cps*360
else
dir=360-cps*360
end
hclock=(hcps-cps)*12
if hclock<0.5 then
	hclock=12+hclock
end
touch=GB(1)
zi,zo=false,false
if PB(10,h/2,w-20,h/2-10) then zi=true end
if (zi and not touched) or (mB==9 and mBo==5) then z=M.max(z*0.5,0.5) zp=M.max(zp-1,1) end
if PB(10,10,w-20,h/2-10) then zo=true end
if (zo and not touched) or (mB==1 and mBo==5) then z=M.min(z*2,32) zp=M.min(zp+1,7) end
isIR=TB(w-12,0,12,7,isIR)
isSW=TB(0,h-14,16,7,isSW)
if isSW then wp=2 else wp=1 end
SN(12,wp)
rst=TB(w-13,h-16,13,16,rst)
ovr=TB(0,7,16,7,ovr)
gps=TB(0,14,16,7,gps)
SB(3,isIR)
fov=(2.2-(45.9/z/180)*M.pi)/2.175
fovr=(45.9/z/180)*M.pi
fovt=45.9/z/360
fovd=45.9/z
SN(1,fov)
SN(3,zp)
if rst then rsto=0 else rsto=1 end
SN(2,rsto)
SB(4,rst)
if ovr then ovro=1 else ovro=0 end
if gps then gpso=10 else gpso=0 end
SN(4,ovro+gpso)
touched=touch
mBo=mB
SN(11,zp*10+rsto)
end
S=screen
SC=S.setColor
DR=S.drawRect
DRF=S.drawRectF
DC=S.drawCircle
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
function tclr()
   if rst then
        SC(222,22,22)
    elseif stb then
        SC(22,222,22)
    else
        SC(222,222,22)
    end
end
function onDraw()
SC(22,222,22)
DT(w/2-4,7,string.format('%02.0f',hclock))
for i=M.floor(dir)-M.floor(0.45*fovd),M.floor(dir)+M.floor(0.45*fovd) do
if i%15==0 then mlen=4 else mlen=3 end
if i%5==0 then
if i==90 then DT(w/2-(M.floor(dir)-i)/fovd*w-2,1,"E")
elseif i==180 then DT(w/2-(M.floor(dir)-i)/fovd*w-2,1,"S")
elseif i==270 then DT(w/2-(M.floor(dir)-i)/fovd*w-2,1,"W")
elseif i==0 or i==360 then DT(w/2-(M.floor(dir)-i)/fovd*w-2,1,"N")
else
DL(w/2-(M.floor(dir)-i)/fovd*w,1,w/2-(M.floor(dir)-i)/fovd*w,1+mlen)
end
end
end
DR(h-5,10,3,h-27)
SC(0,0,0,200)
DRF(0,h-14,16,7)
DRF(w-13,h-16,13,9)
DRF(0,0,w,7)
DRF(0,h-7,w,7)
DRF(h-5,10,4,h-26)
SC(22,222,22)
DTB(w/2-8,1,16,5,M.floor(dir),0,0)
if sa then DT(w-18,h-6,'S') end
DR(h-5,h-19-((cpit-CPMin)/(CPMax-CPMin))*(h-29),3,2)
if z<1 then msg='0.5' else msg=string.format('%2.0f',z)..'x' end
DT(1,h-6,msg)
DT(1,h-13,WP[wp])
DB(w-12,0,12,7,"IR",isIR)
DB(0,7,16,7,"OVR",ovr)
DB(0,14,16,7,"GPS",gps)
DB(0,0,16,7,"RDR",rdr)
tclr()
DR(w-12,h-15,10,13)
SC(55,55,55)
DC(w-7,h-9,4)
DL(w-7,h-9,w-7+9*M.sin((hcps-mtrtr)*M.pi*2),h-9-9*M.cos((hcps-mtrtr)*M.pi*2))
tclr()
DC(w-7,h-9,2)
DL(w-7,h-9,w-7+6*M.sin((hcps-cps)*M.pi*2),h-9-6*M.cos((hcps-cps)*M.pi*2))
end