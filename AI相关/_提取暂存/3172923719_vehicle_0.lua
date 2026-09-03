-- source: steam id 3172923719 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3172923719
z=1
touched=false
isIR=false
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
		screen.setColor(15,233,15)
		screen.drawRectF(bx,by,bw,bh)
screen.setColor(0,0,0,200)
		screen.drawText(bx+1,by+1,msg)
	else
screen.setColor(0,0,0,200)
		screen.drawRectF(bx,by,bw,bh)
		screen.setColor(15,233,15)
		screen.drawText(bx+1,by+1,msg)
	end        
end
function onTick()
w=input.getNumber(1)
h=input.getNumber(2)
tx=input.getNumber(3)
ty=input.getNumber(4)
cps=input.getNumber(5)
if cps<0 then
dir=-cps*360
else
dir=360-cps*360
end
touch=input.getBool(1)
zi,zo=false,false
if pushbutton(10,h/2,w-20,h/2-10) then zi=true end
if zi and not touched then z=math.max(z*0.5,0.5) end
if pushbutton(10,10,w-20,h/2-10) then zo=true end
if zo and not touched then z=math.min(z*2,16) end
isIR=togglebutton(1,h-8,12,7,isIR)
output.setBool(3,isIR)
fov=(2.2-(32.5/z/180)*math.pi)/(2.2-0.025)
fovr=(32.5/z/180)*math.pi
fovt=32.5/z/360
fovd=32.5/z
output.setNumber(1,fov)
touched=touch
end
function onDraw()
screen.setColor(15,233,15)
for i=math.floor(dir)-math.floor(0.3*fovd),math.floor(dir)+math.floor(0.3*fovd) do
if i%10==0 then mlen=4 else mlen=3 end
if i%5==0 then
if i==90 then screen.drawText(w/2-(math.floor(dir)-i)/fovd*w-2,2,"E")
elseif i==180 then screen.drawText(w/2-(math.floor(dir)-i)/fovd*w-2,2,"S")
elseif i==270 then screen.drawText(w/2-(math.floor(dir)-i)/fovd*w-2,2,"W")
elseif i==0 or i==360 then screen.drawText(w/2-(math.floor(dir)-i)/fovd*w-2,2,"N")
else
screen.drawLine(w/2-(math.floor(dir)-i)/fovd*w,2,w/2-(math.floor(dir)-i)/fovd*w,2+mlen)
end
end
end
screen.setColor(0,0,0,200)
screen.drawRectF(w/2-8,1,16,7)
screen.drawRectF(w-16,h-9,15,7)
screen.setColor(15,233,15)
screen.drawTextBox(w/2-8,1,16,7,math.floor(dir),0,0)
screen.drawText(w-15,h-8,0.1*math.floor(10*z))
if isIR then
screen.setColor(15,233,15,180)
else
screen.setColor(0,0,0,220)
end
screen.setColor(15,233,15)
drawbutton(1,h-8,12,7,"IR",isIR)
screen.drawCircle(w/2,h/2,3)
end