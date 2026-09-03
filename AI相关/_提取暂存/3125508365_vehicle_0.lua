-- source: steam id 3125508365 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3125508365
M=math
S=screen
pi=M.pi
pi2=pi*2
g=9.807

function sgn(x)
if x<0 then
return -1
else
return 1
end
end
function atan2(dx,dy)
if dx~=0 then
return sgn(dx)*pi/2-M.atan(dy/dx)
else
return pi/2-sgn(dy)*pi/2
end
end
function norm(x)
return x-pi2-pi2*M.floor(x/pi2-0.5)
end

cam={x=0,y=1.5,z=-3,a=0,e=0}
jac=0

function fl(x,y,z,w,l,c)
w=w/2
l=l/2
obj[#obj+1]=
{
{{x=x-w,y=y,z=z-l},{x=x-w,y=y,z=z+l},{x=x+w,y=y,z=z+l},c=c,col=true},{{x=x-w,y=y,z=z-l},{x=x+w,y=y,z=z-l},{x=x+w,y=y,z=z+l},c=c,col=true}
}
end

function ri(x,y,z,r,a,h,n,c1,c2)
temp={}
for i=1,2*n do
flp=i%2-0.5
if flp==0.5 then
c=c1
else
c=c2
end
temp[i]={{x=x+r*M.sin((i+1)/n*pi+a),y=y-h*flp,z=z+r*M.cos((i+1)/n*pi+a)},{x=x+r*M.sin(i/n*pi+a),y=y+h*flp,z=z+r*M.cos(i/n*pi+a)},{x=x+r*M.sin((i-1)/n*pi+a),y=y-h*flp,z=z+r*M.cos((i-1)/n*pi+a)},c=c,col=true}
end
obj[#obj+1]=temp
end
function cr(x,y,z,r,n,c)
temp={}
for i=1,n do
temp[i]={{x=x+r*M.sin(i/n*pi2),y=y,z=z+r*M.cos(i/n*pi2)},{x=x,y=y,z=z},{x=x+r*M.sin((i+1)/n*pi2),y=y,z=z+r*M.cos((i+1)/n*pi2)},c=c,col=false}
end
obj[#obj+1]=temp
end

fov=120
fov=M.tan(fov/180*pi/2)

feet=1.5

function onTick()
move=M.min(M.sqrt(input.getNumber(1)^2+input.getNumber(2)^2),1)/10
mova=atan2(input.getNumber(1),input.getNumber(2))
cam.x=cam.x+move*M.sin(cam.a+mova)
cam.z=cam.z+move*M.cos(cam.a+mova)
cam.e=M.min(M.max(cam.e+input.getNumber(4)/20,-pi/2),pi/2)
cam.a=cam.a+input.getNumber(3)/20

obj={}

--replace the following with your own polygons:
cr(cam.x,feet-1.45,cam.z,1/3,16,{0,0,0,50})
ri(0,0.5,0,1.5,pi/24,1,24,{20,20,20,255},{21,21,21,255})
cr(0,1,0,1.5,24,{20,20,20,255})
ri(0,1.5,0,0.5,pi/8,1,8,{21,21,21,255},{20,20,20,255})
cr(0,2,0,0.5,8,{21,21,21,255})
n=0.5
for i=-4,4 do
for j=-4,8 do
n=-n
fl(i,0,j,1,1,{3.5+n,3.5+n,3.5+n,255})--floor
end
end
--don't add past here

draw={}
poly={}

for n=1,#obj do
for k,v in pairs(obj[n]) do
poly[#poly+1]=v
end
end
for k,v in pairs(poly) do
for i=1,3 do
v[i].x=v[i].x-cam.x
v[i].y=v[i].y-cam.y
v[i].z=v[i].z-cam.z
end
end

table.sort(poly, function (k1,k2) k1m=0 for p=1,3 do sum=M.sqrt(k1[p].x^2+k1[p].y^2+k1[p].z^2) if sum>k1m then k1m=sum end end k2m=0 for p=1,3 do sum=M.sqrt(k2[p].x^2+k2[p].y^2+k2[p].z^2) if sum>k2m then k2m=sum end end return k1m>k2m end)

cols={}
jacs={}
for i=#poly,1,-1 do
temps={}
tmps={}
for j=1,3 do
temps[j]=atan2(poly[i][j].x,poly[i][j].z)
end
if sgn(norm(temps[1]-temps[2]))==sgn(norm(temps[2]-temps[3])) and sgn(norm(temps[2]-temps[3]))==sgn(norm(temps[3]-temps[1])) then
cols[#cols+1]=i
n=poly[i]
n1=n[3].z-n[1].z
n2=n[3].x-n[1].x
n3=n[3].y-n[1].y
n4=n[2].z-n[1].z
A=((n[2].y-n[1].y)*n1-n3*n4)/((n[2].x-n[1].x-cam.x*2)*n1-n2*n4)
B=(n3-A*n2)/n1
jacs[#jacs+1]=(n[1].y+cam.y)-A*n[1].x-B*n[1].z
end
end

if #jacs>0 then
le=0
for k,v in pairs(jacs) do
if v>le and cam.y-1.4>v then
le=v
end
end
feet=le+1.5
end

jump=input.getBool(31) and cam.y<=feet+0.1
if jump~=jump1 and jump then
jac=g/2
end
jump1=jump
cam.y=cam.y+jac/60
if cam.y>feet then
jac=jac-g/60
else
jac=0
end
cam.y=M.max(cam.y,feet)

for i=1,#poly do
draw[i]={{x=0,y=0},{x=0,y=0},{x=0,y=0},c={0,0,0,0}}
end

for k,v in pairs(poly) do
temp={{x=0,y=0},{x=0,y=0},{x=0,y=0}}
temps={true,true,true}

for i=1,3 do
rx=v[i].x
ry=v[i].y
rz=v[i].z

rd=M.sqrt(rx^2+rz^2)
ra=atan2(rx,rz)
rx=rd*M.sin(ra-cam.a)
rz=rd*M.cos(ra-cam.a)

rd=M.sqrt(ry^2+rz^2)
ra=atan2(ry,rz)
ry=rd*M.sin(ra-cam.e)
rz=rd*M.cos(ra-cam.e)

if rz<=0 then
temps[i]=false
ra=atan2(rx,ry)
temp[i].x=M.sin(ra)*1000000
temp[i].y=M.cos(ra)*1000000
else
temp[i].x=(rx/rz)
temp[i].y=(ry/rz)
end

end

temp1=false
for i=1,3 do
if temps[i]==true then
temp1=true
break
end
end

if temp1 then
for i=1,3 do
draw[k][i]=temp[i]
end
if v.c~=nil then
draw[k].c=v.c
else
draw[k].c={0,0,0,50}
end
end

end

end

function onDraw()
sw=S.getWidth()
sh=S.getHeight()
S.setColor(20,50,60)
S.drawRectF(0,0,sw,sh)
S.setColor(255,255,255)
for k,v in pairs(jacs) do
S.drawText(1,6*k-5,v)
end

for k,v in pairs(draw) do
S.setColor(v.c[1],v.c[2],v.c[3],v.c[4])
S.drawTriangleF(
sw/2+v[1].x/fov*sw/2,sh/2-v[1].y/fov*sw/2,
sw/2+v[2].x/fov*sw/2,sh/2-v[2].y/fov*sw/2,
sw/2+v[3].x/fov*sw/2,sh/2-v[3].y/fov*sw/2
)
end

end