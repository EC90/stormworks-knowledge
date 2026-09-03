-- source: steam id 2892569502 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2892569502
touched=false
mode=1
Rack={}
RackC={property.getNumber('Rack capacity A'),property.getNumber('Rack capacity B'),property.getNumber('Rack capacity C')}
RackN={property.getText('Shell type A'),property.getText('Shell type B'),property.getText('Shell type C')}
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
		screen.setColor(15,233,15)
	else
		screen.setColor(0,0,0,200)
		screen.drawRectF(bx,by,bw,bh)
		screen.setColor(15,233,15)
		screen.drawText(bx+1,by+1,msg)
	end        
end
function onTick()
tx=input.getNumber(3)
ty=input.getNumber(4)
touch=input.getBool(1)
loading=input.getBool(10)
ready=input.getBool(11)
mg=input.getBool(12)
Rack={RackC[1]-input.getNumber(10),RackC[2]-input.getNumber(11),input.getNumber(12)}
if pushbutton(1,8,14,8) and not touched then mode=1 end
if pushbutton(17,8,14,8) and not touched then mode=2 end
output.setNumber(1,mode)
touched=touch
end
function onDraw()
screen.setColor(5,5,5)
screen.drawClear()
screen.setColor(15,233,15)
if mg then
	msg='H M G'
	modea=3
	ofst=6
	screen.drawRect(1,8,30,7)
	screen.drawRectF(3,10,27*(Rack[modea]/RackC[modea]),4)
else
	msg='CANNON'
	modea=mode
	ofst=0
	drawbutton(1,8,14,8,RackN[1],mode==1)
	drawbutton(17,8,14,8,RackN[2],mode==2)
end
screen.setColor(15,233,15)
screen.drawTextBox(0,1,32,6,msg,0,0)
if Rack[modea]>0 then
	if ready or mg then
		screen.setColor(15,233,15)
		msg='READY'
	elseif loading then
		screen.setColor(233,200,15)
		msg='LOAD'
	else
		screen.setColor(233,200,15)
		msg='EMPTY'
	end
else
	screen.setColor(233,15,15)
	msg='OUT'
end
	screen.drawTextBox(1,25,30,6,msg,0,0)
	if Rack[modea]==100 then 
		msg='Full'
	else
		msg=math.floor(Rack[modea])..'/'..math.floor(RackC[modea])
	end
	screen.drawTextBox(0,18,32,6,msg,0,0)
end