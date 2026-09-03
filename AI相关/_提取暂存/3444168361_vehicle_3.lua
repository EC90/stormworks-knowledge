-- source: steam id 3444168361 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3444168361
iN,P=input.getNumber,property
function N(a) return P.getNumber(P.getText(a)) end
function B(a) return P.getBool(P.getText(a)) end
m=math
sin,cos,atan,sqrt,pi=m.sin,m.cos,m.atan,m.sqrt,m.pi

C={r=N("4"),g=N("5"),b=N("6"),a=N("i"),sr=N("b"),sg=N("c"),sb=N("d"),sa=N("o")}

gunData={{n="MG",v=800,d=0.025,t=112,g=30,min=50,a=0,at=0},
{n="LAC",v=1000,d=0.02,t=154,g=30,min=50,a=0,at=0},
{n="RAC",v=1000,d=0.01,t=527,g=30,min=50,a=0,at=0},
{n="HAC",v=1000,d=0.005,t=704,g=30,min=50,a=0,at=0},
{n="Battle",v=800,d=0.002,t=2066,g=30,min=0,a=0,at=0},
{n="Arty",v=700,d=0.001,t=2108,g=30,min=0,a=0,at=0},
{n="Bertha",v=600,d=0.0005,t=2054,g=30,min=0,a=0,at=0},
{n="Rocket",v=50,d=0.003,t=1623,g=30,min=0,a=600,at=60}}

G={}
G.t=0
G.xml=1
G.p={}
G.ofst={x=0,y=0,z=0}
G.mP={x=0,y=0,z=0,vx=0,vy=0,vz=0}
G.mPP={x=0,y=0,z=0}
G.dist=0

traj={}
isTOnly=B("9")
isTrace=B("a")
maxDis={d=0,i=1}
LOD=N("k")
tracer=0
tracerFreq=120
trajG=B("f")
trajGI=N("g")
tgtD=0

isLead=B("l")
lM=N("n")
lS=N("m")
iLS=1-lS

sleep=0

S={}
S.p={0,0,0,0,0,0}
S.pP={0,0,0,0,0,0}
S.ofst={x=N("1")/4,y=N("2")/4,z=N("3")/4}
S.view={x=0,y=0}
S.headPos={x=0,y=0,z=0}
S.dist=0
S.tgt=0
S.v={0,0,0,0,0,0}
S.pL={}

function R(x,y,z,a,b,c,rev)
local d,e,f,g,h,i=cos(a),sin(a),cos(b),sin(b),cos(c),sin(c)
local r={h*f,h*g*e-i*d,h*g*d+i*e,i*f,i*g*e+h*d,i*g*d-h*e,-g,f*e,f*d}
if rev then return r[1]*x+r[4]*y+r[7]*z,r[2]*x+r[5]*y+r[8]*z,r[3]*x+r[6]*y+r[9]*z end
return r[1]*x+r[2]*y+r[3]*z,r[4]*x+r[5]*y+r[6]*z,r[7]*x+r[8]*y+r[9]*z
end

gCh=13
sCh=19
function onTick()
isLead=iN(32)>0
if sleep>0 then
getGun(13)
calcBallistic()
getSeat(19)
if isLead then calcL() end
else 
sleep=sleep>0 and sleep-1 or 0
end
tgtD=S.dist~=0 and S.dist or G.dist
end

function getGun(c)
G.t=iN(c)
for i=1,6 do
G.p[i]=iN(i)
end
G.mPP.x,G.mPP.y,G.mPP.z=G.mP.x,G.mP.y,G.mP.z
G.xml=iN(c+1)
G.ofst={x=iN(c+2)/4,y=iN(c+3)/4,z=iN(c+4)/4}
G.dist=iN(c+5)
local x,y,z=R(G.ofst.x,G.ofst.y,G.ofst.z,G.p[4],G.p[5],G.p[6])
x,y,z=x+G.p[1],y+G.p[2],z+G.p[3]
G.mP={x=x,y=y,z=z,vx=(x-G.mPP.x)*60,vy=(y-G.mPP.y)*60,vz=(z-G.mPP.z)*60}
end

function calcBallistic()
traj={}
if gunData[G.t]==nil then return end
local D=gunData[G.t]
local t,v,d=1,D.v*G.xml,1-D.d
local vx,vy,vz=R(0,0,v,G.p[4],G.p[5],G.p[6])
local acc={vx/v*D.a/60,vy/v*D.a/60,vz/v*D.a/60}
vx,vy,vz=vx+G.mP.vx,vy+G.mP.vy,vz+G.mP.vz
local x,y,z,dis,l=G.mP.x,G.mP.y,G.mP.z,0,0
table.insert(traj,{x=x,y=y,z=z,d=0,l=0})
while t<=D.t and y>0 and v>D.min do
if t<=D.at then
vx,vy,vz=vx*d+acc[1],vy*d+acc[2]-D.g/60,vz*d+acc[3]
else
vx,vy,vz=vx*d,vy*d-D.g/60,vz*d
end
x,y,z=x+vx/60,y+vy/60,z+vz/60
dis,v,t,l=sqrt((G.mP.x-x)^2+(G.mP.y-y)^2+(G.mP.z-z)^2),sqrt(vx^2+vy^2+vz^2),t+1,l+v/60
table.insert(traj,{x=x,y=y,z=z,d=dis,l=l})
if maxDis.d<dis then maxDis={d=dis,i=#traj} end
end
end

function getSeat(c)
for i=1,6 do S.pP[i]=S.p[i] end
local x,y,z=iN(c),iN(c+1),iN(c+2)
S.p={x,y,z,iN(c+3),iN(c+4),iN(c+5)}
S.view={x=iN(c+6),y=iN(c+7)}
S.dist=iN(c+8)
S.tgt=iN(c+9)~=0 and iN(c+9) or N("h")
local hx,hy,hz=R(S.ofst.x,S.ofst.y,S.ofst.z,S.p[4],S.p[5],S.p[6])
hx,hy,hz=hx+x,hy+y,hz+z
S.headPos={x=hx,y=hy,z=hz}
S.v={(x-S.pP[1])*iLS+S.v[1]*lS,(y-S.pP[2])*iLS+S.v[2]*lS,(z-S.pP[3])*iLS+S.v[3]*lS,(iN(c+10)*pi/30)*iLS+S.v[4]*lS,(iN(c+11)*pi/30)*iLS+S.v[5]*lS,(iN(c+12)*pi/30)*iLS+S.v[6]*lS}
end

function calcL()
	S.pL={}
	local p,q,rv,vx,vy,vz={x=0,y=0,z=0},E2Q(S.p[4],S.p[5],S.p[6]),{S.v[4],S.v[5],S.v[6]},R(S.v[1],S.v[2],S.v[3],S.p[4],S.p[5],S.p[6],true)
	local dQ=qM({cos(rv[3]/2),0,0,sin(rv[3]/2)},qM({cos(rv[2]/2),0,sin(rv[2]/2),0},{cos(rv[1]/2),sin(rv[1]/2),0,0}))
	for i=1,#traj do
		if i<lM or lM<0 then
			q=nmQ(qM(dQ,q))
			local v=rVQ(q,{vx,vy,vz})
			p.x,p.y,p.z=p.x+v.x,p.y+v.y,p.z+v.z
			table.insert(S.pL,{q={q[1],q[2],q[3],q[4]},p={x=p.x,y=p.y,z=p.z}})
		end
	end
end

function qM(q, Q)
local w,x,y,z,W,X,Y,Z=q[1],q[2],q[3],q[4],Q[1],Q[2],Q[3],Q[4]
return {w*W-x*X-y*Y-z*Z,w*X+x*W+y*Z-z*Y,w*Y-x*Z+y*W+z*X,w*Z+x*Y-y*X+z*W}
end

function nmQ(q)
local l=sqrt(q[1]^2+q[2]^2+q[3]^2+q[4]^2)
return l>0 and {q[1]/l,q[2]/l,q[3]/l,q[4]/l} or {1,0,0,0}
end

function E2Q(x,y,z)
local cz,sz,cy,sy,cx,sx=cos(z/2),sin(z/2),cos(y/2),sin(y/2),cos(x/2),sin(x/2)
return nmQ(qM(qM({cz,0,0,sz},{cy,0,sy,0}),{cx,sx,0,0}))
end

function Q2E(q)
local w,x,y,z=q[1],q[2],q[3],q[4]
return {z=atan(2*(w*z+x*y),1-2*(y^2+z^2)),y=math.asin(math.max(math.min(2*(w*y-z*x),1),-1)),x=atan(2*(w*x+y*z),1-2*(x^2+y^2))}
end

function rVQ(q,v)
local w,x,y,z,a,b,c=q[1],q[2],q[3],q[4],v[1],v[2],v[3]
local X,Y,Z=2*(y*c-z*b),2*(z*a-x*c),2*(x*b-y*a)
return {x=a+w*X+y*Z-z*Y,y=b+w*Y+z*X-x*Z,z=c+w*Z+x*Y-y*X}
end

w,h=32*8,32*6
s=screen
dL=s.drawLine
dT=s.drawText
function onDraw()
sleep=5
tracer=(tracer>#traj or tracer>tracerFreq) and 0 or tracer+1
local lastDraw={}
local tMrk,aTgtD,showTr,showG,showTg,noSkip=nil,m.abs(tgtD),false,false,false,false
if #traj>0 then
local x,y,isShow,isBack=posToHUD(traj[1],1)
lastDraw={x=x,y=y,isB=isBack}
local trueDis=sqrt((traj[1].x-S.headPos.x)^2+(traj[1].y-S.headPos.y)^2+(traj[1].z-S.headPos.z)^2)
if (isShow or B("j")) and not isTOnly and B("e") then gunMarker(lastDraw.x,lastDraw.y) end
for i=2,#traj-1 do
local d,ld,l,ll=traj[i].d,traj[i-1].d,traj[i].l,traj[i-1].l
local skipScale=trueDis>1000 and (trueDis/1000)*LOD or LOD
showTr=isTrace and i%tracerFreq==tracer%tracerFreq
showG=trajG and ((d%trajGI<ld%trajGI and d>ld) or (d%trajGI>ld%trajGI and d<ld))
showTg=(d>aTgtD and ld<aTgtD) or (ld>-tgtD and d<-tgtD) and aTgtD~=0
noSkip=LOD==0 or (l%skipScale<ll%skipScale and l>ll) or (l%skipScale>ll%skipScale and l<ll) or i==#traj
if showTr or showG or showTg or noSkip then
x,y,isShow,isBack=posToHUD(traj[i],i)
if LOD>0 or showG then
trueDis=sqrt((traj[i].x-S.headPos.x)^2+(traj[i].y-S.headPos.y)^2+(traj[i].z-S.headPos.z)^2)
end
if isShow then
if showTr then
stC(1,true)
dL(x,y,x+1,y)
end
if showG then
stC(0.3,true)
local len=atan(S.tgt,trueDis)*h
if d<ld then len=-len end
dL(x,y,x+len,y)
end
local alpha=(i>lM and isLead) and 0.05 or (1-i/#traj)*0.9+0.1
stC(alpha)
if not lastDraw.isB then
dL(x,y,lastDraw.x,lastDraw.y)
end
end
if showTg then
local ratio=(d>ld and (aTgtD-ld)/(d-ld)) or (aTgtD-d)/(ld-d)
local lx,ly,lis=posToHUD(traj[i-1],i-1)
tMrk={x=x*ratio+lx*(1-ratio),y=y*ratio+ly*(1-ratio),index=i}
end
lastDraw={x=x,y=y,isB=isBack}
end
end
if not isTOnly then tgtMarker(tMrk,lastDraw) end
end
end

function stC(a,isSub)
a=a>1 and 1 or a
if isSub then s.setColor(C.sr,C.sg,C.sb,a*C.sa)
else s.setColor(C.r,C.g,C.b,a*C.a) end
end

lastLeadR={}
fL=(h/2)/math.tan(1/2)
function posToHUD(p,i)
local dx,dy,dz=p.x-S.headPos.x,p.y-S.headPos.y,p.z-S.headPos.z
if isLead and i>1 then
if i<lM or lM<0 then
lastLeadR=Q2E(S.pL[i-1].q)
else
i=#S.pL
end
local r=lastLeadR
dx,dy,dz=R(dx-S.pL[i-1].p.x,dy-S.pL[i-1].p.y,dz-S.pL[i-1].p.z,r.x,r.y,r.z,true)
else
dx,dy,dz=R(dx,dy,dz,S.p[4],S.p[5],S.p[6],true)
end
dx,dy,dz=R(dx,dy,dz,-S.view.y*m.pi*2,S.view.x*m.pi*2,0,true)
local X,Y=w/2+(dx/dz)*fL,h/2-(dy/dz)*fL
return X,Y,math.abs(X-w/2)<w/2 and math.abs(Y-h/2)<h/2,dz<0.01
end

function gunMarker(x,y)
local a,d={x=5,y=3},1
if B("j") then
d=x<1 and 2 or y<1 and 3 or x>=w and 4 or 1
x,y=m.min(m.max(x,0),w),m.min(m.max(y,0),h)
end
stC(1)
local b={{0,-3,-a.x/2,-3-a.y,a.x/2,-3-a.y},{3,0,3+a.y,-a.x/2,3+a.y,a.x/2},{0,3,a.x/2,3+a.y,-a.x/2,3+a.y},{-3,0,-3-a.y,a.x/2,-3-a.y,-a.x/2}}
s.drawTriangleF(x+b[d][1],y+b[d][2],x+b[d][3],y+b[d][4],x+b[d][5],y+b[d][6])
dT(x-(d==4 and #gunData[G.t].n*5 or 0),y-3-a.y+(d==3 and 10+a.y or -7)+((d==2 or d==4) and 5 or 0),gunData[G.t].n)
end

function tgtMarker(mrk,l)
if mrk==nil and tgtD==0 then return end
local isRange=true
local d=tgtD
if mrk==nil then
mrk,d,isRange={x=l.x,y=l.y,index=#traj},traj[#traj].d,false
end
local x,y=mrk.x+N("7"),mrk.y+N("8")
stC(1)
if isRange then
s.drawCircle(mrk.x,mrk.y,3)
else
s.drawTriangle(mrk.x,mrk.y+3,mrk.x-2.5,mrk.y-2,mrk.x+2.5,mrk.y-2)
end
if not isRange then
stC(0.2)
end
local sec=string.format("%.1f",mrk.index/60)
d=string.format("%d",m.floor(m.abs(d)))
dT(x,y-7,sec.."[")
dT(x+(#sec*5)+4,y-7,"s")
dT(x+(#sec*5)+8,y-7,"]")
dT(x,y,d.."[")
dT(x+(#d*5)+4,y,"m")
dT(x+(#d*5)+8,y,"]")
end