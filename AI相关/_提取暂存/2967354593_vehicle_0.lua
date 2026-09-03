-- source: steam id 2967354593 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2967354593
m=math s=screen pi=m.pi pi2=pi*2 i=input o=output p=property ign=i.getNumber igb=i.getBool osn=o.setNumber osb=o.setBool pgn=p.getNumber pgb=p.getBool
function vec(x,y,z) return {
x=x or 0,
y=y or 0,
z=z or 0,
add=function(a,b)return vec(a.x+b.x,a.y+b.y,a.z+b.z) end,
sub=function(a,b)return vec(a.x-b.x,a.y-b.y,a.z-b.z) end,
scale=function(a,b)return vec(a.x*b,a.y*b,a.z*b) end,
dot=function(a,b)return (a.x*b.x+a.y*b.y+a.z*b.z) end,
cross=function(a,b)return vec(a.y*b.z-a.z*b.y,a.z*b.x-a.x*b.z,a.x*b.y-a.y*b.x) end,
len=function(a)return a:dot(a)^0.5 end,
norm=function(a)return a:scale(1/a:len()) end,
unpack=function(a,...)return a.x,a.y,a.z,... end,
clone=function(a)return vec(a.x,a.y,a.z) end,
mult=function(a,b)return vec(a.x*b.x,a.y*b.y,a.z*b.z) end,
reject=function(a,b)return a:sub(b:scale(a:dot(b))) end,
tolocal=function(a,r,f,u)return vec(r:dot(a),f:dot(a),u:dot(a)) end,
toglobal=function(a,r,f,u)return r:scale(a.x):add(f:scale(a.y)):add(u:scale(a.z)) end,
tospherical=function(a,r,f,u,c) b=a:tolocal(r,f,u):sub(c or vec())return vec(m.atan(b.x,b.y),m.asin(b.z/(b:len()))) end
} end
function clamp(a,b,c) return math.min(math.max(a,b),c) end
function avg(a,b) return vec((a.x+b.x)/2, (a.y+b.y)/2, (a.z+b.z)/2) end
ctrl=vec()
otgt=vec()
ovtgt=vec()
pr=vec()
pf=vec()
pu=vec()
pvr=vec()
pvf=vec()
pvu=vec()
function onTick()
comp=vec(pgn("Sensor Offset X"),pgn("Sensor Offset Y"),pgn("Sensor Offset Z"))
tcomp=pgn("Tick Compensation")
pos=vec(ign(1),ign(3),ign(2))
tgt=vec(ign(10),ign(11),ign(12))
vtgt=tgt:sub(otgt)
atgt=vtgt:sub(ovtgt)
if pgb("Accel Compensation") then
etgt=tgt:add(vtgt:scale(tcomp))
else
etgt=tgt:add(vtgt:scale(tcomp)):add(atgt:scale((tcomp^2)/2))
end
rx,ry,rz=ign(4),ign(5),ign(6)
cx,cy,cz=m.cos(rx),m.cos(ry),m.cos(rz)
sx,sy,sz=m.sin(rx),m.sin(ry),m.sin(rz)
r=vec(cy*cz,-sy,cy*sz)
f=vec(sx*sz+cx*sy*cz,cx*cy,-sx*cz+cx*sy*sz)
u=r:cross(f)
vr=r:sub(pr)
vf=f:sub(pf)
vu=u:sub(pu)
ar=vr:sub(pvr)
af=vf:sub(pvf)
au=vu:sub(pvu)
cr=r:add(vr:scale(3)):add(ar:scale(4.5))
cf=f:add(vf:scale(3)):add(af:scale(4.5))
cu=u:add(vu:scale(3)):add(au:scale(4.5))
LOS=etgt:sub(pos)
sphLOS=LOS:tospherical(cr,cf,cu,comp)
osn(1,sphLOS.x/pi2*8 or 0)
osn(2,sphLOS.y/pi2*8 or 0)
otgt=tgt
ovtgt=vtgt
pr=r
pf=f
pu=u
pvr=vr
pvf=vf
pvu=vu
end
