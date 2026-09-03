-- source: steam id 2891959205 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891959205
z=1
touched=false
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
touch=input.getBool(1)
zi,zo=false,false
if pushbutton(1,1,6,7) or pushbutton(10,h/2,w-20,h/2-10) then zi=true end
if zi and not touched then z=math.max(z*0.5,0.5) end
if pushbutton(w-7,1,6,7) or pushbutton(10,10,w-20,h/2-10) then zo=true end
if zo and not touched then z=math.min(z*2,16) end
fov=(2.2-(32.5/z/180)*math.pi)/(2.2-0.025)
fovr=(32.5/z/180)*math.pi
fovt=32.5/z/360
fovd=32.5/z
output.setNumber(1,fov)
touched=touch
end
function rad(deg)
return deg*math.pi/180 end
function distToDeg(dist)
return -0.0642+0.00162*dist-5.86*10^(-7)*dist^2+4.19*10^(-10)*dist^3 end
function onDraw()
screen.setColor(15,233,15)
screen.drawText(w/2+7,1,0.1*math.floor(10*z))
screen.setColor(15,233,15,180)
if z>4 then
--500
y5=h/2+rad(distToDeg(500))/fovr*h
screen.drawLine(w/2-2,y5,w/2+3,y5)
screen.drawText(w/2+6,y5,'5')
--1500
y15=h/2+rad(distToDeg(1500))/fovr*h
screen.drawLine(w/2-2,y15,w/2+3,y15)
screen.drawText(w/2+6,y15,'15')
end
if z>1 then
--1000
y10=h/2+rad(distToDeg(1000))/fovr*h
screen.drawLine(w/2-2,y10,w/2+3,y10)
screen.drawText(w/2+6,y10,'10')
--2000
y20=h/2+rad(distToDeg(2000))/fovr*h
screen.drawLine(w/2-2,y20,w/2+3,y20)
screen.drawText(w/2+6,y20,'20')
end
screen.drawCircle(w/2,h/2,3)
screen.setColor(15,233,15)
drawbutton(1,1,6,7,"<",zi)
drawbutton(w-7,1,6,7,">",zo)
screen.drawText(w/2-27,7,'TAP TO FIRE')
end