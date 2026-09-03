-- source: steam id 2213181424 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
inp,out,dL,dT,drF,sC,dR,gN,gB,sB=input,output,screen.drawLine,screen.drawText,screen.drawRectF,screen.setColor,screen.drawRect,input.getNumber,input.getBool,output.setBool

function onTick()
act=gB(32)
if act then
p = gB(1)
x = gN(3)
y = gN(4)
	
str1 = gN(5)
recv1 = gB(7)
str2 = gN(6)
recv2 = gB(8)
f1 = gN(7)
f2 = gN(8)
ptt1 = gB(9)
ptt2 = gB(10)

ic = gN(9)
paptt = gB(11)
pai = gB(12)
pa1 = gB(13)
pa2 = gB(14)

fd1 = p and ipi(x,y,0,24,8,7)
fu1 = p and ipi(x,y,9,24,7,7)
fd10 = p and ipi(x,y,0,34,8,7)
fu10 = p and ipi(x,y,9,34,7,7)
pttb1 = p and ipi(x,y,16,24,16,16)
	
fd2 = p and ipi(x,y,32,24,8,7)
fu2 = p and ipi(x,y,41,24,7,7)
fd20 = p and ipi(x,y,32,34,8,7)
fu20 = p and ipi(x,y,41,34,7,7)
pttb2 = p and ipi(x,y,48,24,16,16)

paib = p and ipi(x,y,0,42,8,8)
pa1b = p and ipi(x,y,0,50,8,8)
pa2b = p and ipi(x,y,8,50,8,8)
papttb = p and ipi(x,y,16,50,16,8)

sB(2,pttb1)
sB(3,pttb2)

sB(2,pttb1)
sB(3,pttb2)

sB(13,papttb)
sB(14,paib)
sB(15,pa1b)
sB(16,pa2b)



if f1 < 999 then
sB(5,fu1)
end
if f1 > 1 then
sB(6,fd1)
end
if f1 <990 then
sB(7,fu10)
end
if f1 > 10 then
sB(8,fd10)
end
if f2 <999 then
sB(9,fu2)
end
if f2 > 1 then
sB(10,fd2)
end
if f2 <990 then
sB(11,fu20)
end
if f2 > 10 then
sB(12,fd20)
end

end
end

function ipi(x, y, rectX, rectY, rectW, rectH)
return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
if act then
w = screen.getWidth()
h = screen.getHeight()

sC(25,50,100)
dL(0,24,w,24)
dL(0,7,w,7)
dL(w/2,0,w/2,h-6)
dL(0,h-6,w,h-6)
drF(16,61,32,3)
	
dT(18,30,"PTT")
dL(8,25,8,41)
dL(16,25,16,41)
dL(0,32,16,32)
dL(0,40,32,40)
	
dT(2,26,"<")
dT(12,26,">")
	
dT(1,34,"<")
dT(4,34,"<")
	
dT(10,34,">")
dT(13,34,">")
	
	
dT(2,17,"CH:"..string.format("%.0f",f1))
dT(2,1,"LR1")
	
dT(50,30,"PTT")
dL(40,25,40,41)
dL(48,25,48,41)
dL(32,32,48,32)
dL(32,40,64,40)
	
dT(34,26,"<")
dT(44,26,">")
	
dT(33,34,"<")
dT(36,34,"<")
	
dT(42,34,">")
dT(45,34,">")
	
dT(34,17,"CH:"..string.format("%.0f",f2))
dT(34,1,"LR2")

-- R1
if fd1 then
drF(0,25,8,7)
sC(0,0,0)
dT(2,26,"<")
sC(25,50,100)

elseif fu1 then
drF(9,25,7,7)
sC(0,0,0)
dT(12,26,">")
sC(25,50,100)
	
elseif fd10 then
drF(0,33,8,7)
sC(0,0,0)
dT(1,34,"<")
dT(4,34,"<")
sC(25,50,100)

elseif fu10 then
drF(9,33,7,7)
sC(0,0,0)
dT(10,34,">")
dT(13,34,">")
sC(25,50,100)
end
if  ptt1 then
sC(100,0,0)
drF(17,25,15,15)
sC(0,0,0)
dT(18,30,"PTT")
sC(25,50,100)
end
	
if recv1 then
sC(150,112,0)
else
sC(150*0.05,112*0.05,0*0.05)
end
dT(4,10,"INCOM")
	
sx = 19
sy = -9
sC(25*0.05,50*0.05,100*0.05,255)
if str1 > 0.8 then
sC(25,50,100)
end
drF(8+sx,10+sy,1,5)
if str1 > 0.65 then
sC(25,50,100)
end
drF(6+sx,11+sy,1,4)
if str1 > 0.35 then
sC(25,50,100)
end
drF(4+sx,12+sy,1,3)
if str1 > 0.1 then
sC(25,50,100)
end
drF(2+sx,13+sy,1,2)
	
sC(25,50,100)

-- R2
if fd2 then
drF(32,25,8,7)
sC(0,0,0)
dT(34,26,"<")
sC(25,50,100)

elseif fu2 then
drF(41,25,7,7)
sC(0,0,0)
dT(44,26,">")
sC(25,50,100)

elseif fd20 then
drF(32,33,8,7)
sC(0,0,0)
dT(33,34,"<")
dT(36,34,"<")
sC(25,50,100)

elseif fu20 then
drF(41,33,7,7)
sC(0,0,0)
dT(42,34,">")
dT(45,34,">")
sC(25,50,100)
end

if ptt2 then
sC(100,0,0)
drF(49,25,15,15)
sC(0,0,0)
dT(50,30,"PTT")
sC(25,50,100)
end

if recv2 then
sC(150,112,0)
else
sC(150*0.05,112*0.05,0*0.05)
end
dT(36,10,"INCOM")
	
sx = 19
sy = -9
sC(25*0.05,50*0.05,100*0.05,255)
if str2 > 0.8 then
sC(25,50,100)
end
drF(40+sx,10+sy,1,5)
if str2 > 0.65 then
sC(25,50,100)
end
drF(38+sx,11+sy,1,4)
if str2 > 0.35 then
sC(25,50,100)
end
drF(36+sx,12+sy,1,3)
if str2 > 0.1 then
sC(25,50,100)
end
drF(34+sx,13+sy,1,2)


sC(25,50,100)
dT(34,43,"INTCOM")
if ic <= 999 and ic >=0 then
	dT(34,51,"CH:"..string.format("%.0f",ic))
	else
	dT(34,51,"CH:ERR")
end

dT(16,43,"PA")

dR(0,42,8,8)
dT(3,44,"I")

dR(0,50,8,8)
dT(2,52,"1")

dR(8,50,8,8)
dT(10,52,"2")

dR(16,50,16,8)
dT(18,52,"PTT")

if pai then
drF(0,42,8,8)
sC(0,0,0)
dT(3,44,"I")
sC(25,50,100)
end
if pa1 then
drF(0,50,8,8)
sC(0,0,0)
dT(2,52,"1")
sC(25,50,100)
end
if pa2 then
drF(8,50,8,8)
sC(0,0,0)
dT(10,52,"2")
end
if paptt then
sC(100,0,0)
drF(17,51,15,7)
sC(0,0,0)	
dT(18,52,"PTT")
sC(25,50,100)
end

end
end