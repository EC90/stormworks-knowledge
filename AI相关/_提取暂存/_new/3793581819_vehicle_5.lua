-- source: steam id 3793581819 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
s=screen
sc=s.setColor
dr=s.drawRect
drf=s.drawRectF
dl=s.drawLine
drt=s.drawTextBox
dc=s.drawCircle
i=input
o=output
w1=44
h1=44
w=96
h=96
pi=math.pi
pi2=pi*2
fov=property.getNumber("Distance from Seat center to hud")
sin=math.sin
cos=math.cos
ign=i.getNumber
igb=i.getBool
cx=w/2
cy=h/2
function onTick()
cp=ign(5)
sp=ign(3)
alt=ign(4)
rd=igb(1)
arm=igb(2)
ad=ign(6)
ws=ign(7)
zoom=ign(8)
mx=ign(9)
my=ign(10)
a=math.tan(ad*2*pi)*fov*96
b=math.tan(ws*2*pi)*fov*96
x=96/2+a
y=96/2-b-6
tar=igb(3)
f_tilt=(ign(1)*4)*90
l_tilt=(ign(2)*4)*90
ver=ign(11)
Tilt_front=ign(1)
Tilt_right=ign(2)
Tilt_up=ign(12)
if Tilt_up>=0 then
RollAngle=-pi2*Tilt_right
elseif Tilt_up<0 and Tilt_right>=0 then
RollAngle=-pi2*(0.5-Tilt_right)
elseif Tilt_up<0 and Tilt_right<0 then
RollAngle=-pi2*(-0.5-Tilt_right)
end
PitchAngle=pi2*Tilt_front	
end
function onDraw()
sW=s.getWidth()
sH=s.getHeight()
sc(255,255,255)
dr(38,5,19,8)
sc(255,255,255)
dl(20,16,22.25,16.25)
dl(73,16,75.25,16.25)
dl(73,17,73.25,78.25)
dl(74,78,75.25,78.25)
dl(22,17,22.25,78.25)
dl(20,78,21.25,78.25)
sc(47,79,52)
drt(6,18.5,16,6, string.format("%.f", sp))
drt(77,18.5,20,6, string.format("%.1f", alt))
drt(42,7,17,7, string.format("%.f", cp))
drt(6,11.5,16,5, "SPD")
drt(77,11.5,16,5, "ALT")
drt(77,26,16,5, "KM")
drt(6,26,16,5, "KMH")
drt(77,65,16,5, string.format("%.f", ver))
if arm then
drt(6,71,16,5, "ARM")
end
dc(47+mx,41-my,5)
dl(47+mx,30-my,47.25+mx,35.25-my)
dl(47+mx,47-my,47.25+mx,52.25-my)
dl(53+mx,41-my,58.25+mx,41.25-my)
dl(36+mx,41-my,41.25+mx,41.25-my)
if rd then
sc(255,0,0)
dr(2,2,91,91)
end
if tar then
s.drawRect(x-2, y, 4, 4)
end
sc(255, 255, 255, 120)
temp_X=sW/2+sin(RollAngle)*sH*PitchAngle 
temp_Y=sH/2+cos(RollAngle)*sH*PitchAngle
sc(200, 0, 0)--color medio
dl(temp_X,temp_Y,temp_X+cos(RollAngle)*15,temp_Y-sin(RollAngle)*15) 
dl(temp_X,temp_Y,temp_X-cos(RollAngle)*15,temp_Y+sin(RollAngle)*15)
sc(255, 255, 255, 120)
for i=-18,18 do
if i~=0 then 
if i<0 then 
--color cielo?
elseif i>0 then
--color tierra?
end
temp_X=sW/2+sin(RollAngle)*sH*PitchAngle+i*pi*sH/18*sin(RollAngle) 
temp_Y=sH/2+cos(RollAngle)*sH*PitchAngle+i*pi*sH/18*cos(RollAngle)
dl(temp_X,temp_Y,temp_X+cos(RollAngle)*15,temp_Y-sin(RollAngle)*15)
dl(temp_X,temp_Y,temp_X-cos(RollAngle)*15,temp_Y+sin(RollAngle)*15)
end
end
sc(255, 255, 255, 120)
pitch=math.acos(f_tilt / 90)
roll=math.rad(90 - l_tilt)			
if l_tilt > 45 then 
mroll_display = 45
else
mroll_display = l_tilt
end
if l_tilt < -45 then 
mroll_display = -45
end
troll=math.rad(0 - l_tilt)
broll=math.rad(180 - l_tilt)
croll=math.rad(90)
fifthteen_roll_right=math.rad(75)
fifthteen_roll_left=math.rad(105)
thirty_roll_right=math.rad(60)
thirty_roll_left=math.rad(120)
fortyfive_roll_right=math.rad(45)
fortyfive_roll_left=math.rad(135)	
tlroll=math.rad(100-mroll_display)
trroll=math.rad(80-mroll_display)
tcroll=math.rad(90-mroll_display)
radius=w+h
roll_l_rad_t=(w+h)/7 
roll_l_rad_b=roll_l_rad_t-4 
roll_t_rad_x=roll_l_rad_t-6 
roll_t_rad_c=roll_l_rad_t-8 
roll_t_rad_t=roll_l_rad_t-9 
roll_t_rad_b=roll_l_rad_t-5 
x11=cx+roll_l_rad_t*cos(croll) 
y11=cy+roll_l_rad_t*sin(croll)	
x12=cx+roll_t_rad_c*cos(croll) 
y12=cy+roll_t_rad_c*sin(croll)
x17=cx+roll_l_rad_t*cos(fortyfive_roll_right) 
y17=cy+roll_l_rad_t*sin(fortyfive_roll_right)	
x18=cx+roll_l_rad_b*cos(fortyfive_roll_right) 
y18=cy+roll_l_rad_b*sin(fortyfive_roll_right)
x19=cx+roll_l_rad_t*cos(fortyfive_roll_left) 
y19=cy+roll_l_rad_t*sin(fortyfive_roll_left)	
x20=cx+roll_l_rad_b*cos(fortyfive_roll_left)  
y20=cy+roll_l_rad_b*sin(fortyfive_roll_left)
x221=cx+roll_t_rad_t*cos(tlroll) 
y221=cy+roll_t_rad_t*sin(tlroll)	
x222=cx+roll_t_rad_t*cos(trroll)
y222=cy+roll_t_rad_t*sin(trroll)
x223=cx+roll_t_rad_b*cos(tcroll)
y223=cy+roll_t_rad_b*sin(tcroll)
sc(200, 200, 200) 
dl(x11, y11, x12, y12) 
dl(x17, y17, x18, y18)
dl(x19, y19, x20, y20)	
dl(x23, y23, x24, y24)
sc(200, 0, 0) -- red
s.drawTriangleF(x221, y221, x222, y222, x223, y223)
end


	