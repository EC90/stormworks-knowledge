-- source: steam id 3664940456 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3664940456

BUF_SIZE=20
MIN_DIST=50
MAX_TICKS=900
BASELINE_STORE=0.33
BASELINE_SWITCH=0.50
M=math
abs=M.abs
sqrt=M.sqrt
atan=M.atan
floor=M.floor
ticks=0
last_sig=false
last_pulse_tick=-999
buffer={}
target={x=0,y=0}
last_valid_target={x=0,y=0}
has_lock=false
cur_dist=0
cur_delta=0
res_buffer={}
RES_BUF_MAX=6
OUTLIER_DIST=350
out_cnt=0
precision=0
base_point=nil
candidate_point=nil
mx,my=0,0
lx,ly=0,0
vx,vy=0,0
function onTick()
ticks=ticks+1
mx=input.getNumber(1)
my_alt=input.getNumber(2)
my=input.getNumber(3)
sig=input.getBool(1)
vx=(mx-lx)*60
vy=(my-ly)*60
lx=mx
ly=my
if sig and not last_sig then
delta=ticks-last_pulse_tick
if delta>10 and delta<MAX_TICKS then
cur_delta=delta
dist_slant=250+(delta-10)*50
cur_dist=dist_slant
r_horiz=0
if dist_slant>abs(my_alt)then
r_horiz=sqrt(dist_slant^2-my_alt^2)else r_horiz=0
end
valid_point=true
if r_horiz<=0 then
valid_point=false
end
if r_horiz~=r_horiz then
valid_point=false
end
if valid_point then
store=true
if#buffer>0 then
last=buffer[#buffer]d_moved=sqrt((mx-last.x)^2+(my-last.y)^2)
if d_moved<MIN_DIST then
store=false
end
end
if store then
table.insert(buffer,{x=mx,y=my,r=r_horiz})if#buffer>BUF_SIZE then
table.remove(buffer,1)
end
end
end
result=nil
if valid_point and r_horiz>0 then
curr={x=mx,y=my,r=r_horiz}
if not base_point then
base_point=curr
else d_base=sqrt((mx-base_point.x)^2+(my-base_point.y)^2)
thresh_store=base_point.r*BASELINE_STORE
thresh_switch=base_point.r*BASELINE_SWITCH
if d_base>thresh_store and not candidate_point then
candidate_point=curr
end
if d_base>thresh_switch then
if candidate_point then
base_point=candidate_point
candidate_point=nil
else base_point=curr
end
end
end
end
if#res_buffer>0 and base_point then
curr=buffer[#buffer]if curr and base_point~=curr then
res_avg={x=0,y=0}
for b=1,#res_buffer do
res_avg.x=res_avg.x+res_buffer[b].x
res_avg.y=res_avg.y+res_buffer[b].y 
end
res_avg.x=res_avg.x/#res_buffer
res_avg.y=res_avg.y/#res_buffer
p1,p2=solve_2_circles(base_point,curr)
if p1 and p2 then
d1=(p1.x-res_avg.x)^2+(p1.y-res_avg.y)^2
d2=(p2.x-res_avg.x)^2+(p2.y-res_avg.y)^2
if d1<d2 then
result=p1
else result=p2
end
end
end
elseif#buffer>=3 then
idx_a=#buffer
idx_b=1
idx_c=-1
A=buffer[idx_a]B=buffer[idx_b]max_dist_line=-1
L_A=B.y-A.y
L_B=A.x-B.x
L_C=B.x*A.y-B.y*A.x
L_denom=sqrt(L_A^2+L_B^2)
if L_denom>0.1 then
for b=2,#buffer-1 do
P=buffer[b]d_line=abs(L_A*P.x+L_B*P.y+L_C)/L_denom
if d_line>max_dist_line then
max_dist_line=d_line
idx_c=b
end
end
end
if idx_c~=-1 and max_dist_line>2 then
C=buffer[idx_c]result=solve_3_circles(A,B,C)
end
end
if result then
is_outlier=false
if#res_buffer>=3 then
ax,ay=0,0
for b=1,#res_buffer do
ax=ax+res_buffer[b].x
ay=ay+res_buffer[b].y 
end
ax,ay=ax/#res_buffer,ay/#res_buffer
if sqrt((result.x-ax)^2+(result.y-ay)^2)>OUTLIER_DIST then
is_outlier=true
out_cnt=out_cnt+1 
end
end
if out_cnt>=3 then
res_buffer={}
buffer={}
base_point=nil
candidate_point=nil
out_cnt=0
is_outlier=false
result=nil
end
if not is_outlier and result then
table.insert(res_buffer,result)if#res_buffer>RES_BUF_MAX then
table.remove(res_buffer,1)
end
out_cnt=0
end
if#res_buffer>0 then
tx,ty=0,0
for b=1,#res_buffer do
tx=tx+res_buffer[b].x
ty=ty+res_buffer[b].y 
end
target.x,target.y=tx/#res_buffer,ty/#res_buffer
last_valid_target={x=target.x,y=target.y}
max_d=0
for b=1,#res_buffer do
d_res=sqrt((res_buffer[b].x-target.x)^2+(res_buffer[b].y-target.y)^2)
if d_res>max_d then
max_d=d_res
end
end
precision=max_d
has_lock=true
end
end
end
last_pulse_tick=ticks
end
last_sig=sig
if ticks-last_pulse_tick>MAX_TICKS then
has_lock=false
res_buffer={}
buffer={}
base_point=nil
candidate_point=nil
out_cnt=0
end
output.setNumber(1,target.x)
output.setNumber(2,target.y)
output.setNumber(3,0)
output.setNumber(4,cur_dist)
output.setNumber(5,cur_delta)
output.setNumber(6,precision)
output.setBool(1,has_lock)
end
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}num[0]=2122222
function DN(c,e,f)c,e=math.floor(c+0.5),math.floor(e+0.5)
f=tostring(f)
local g=string.len(f)
for b=1,g do
local i,w=f:sub(b,b),4
if i=='.'
then
local w=2
end
local j=tonumber(i)
if j then
local k,l,dx,dy=c,e+4,0,0
for m=1,7 do
k,l=k+dx*2,l-dy*2
if m==5 then
l=l-2 
end
dx,dy=math.sin(0.25*math.pi*2*(m-1)),math.cos(0.25*math.pi*2*(m-1))
if string.sub(num[j],m,m)=='2'
then
screen.drawLine(k,l,k+dx*3,l-dy*3)
end
end
else screen.drawText(c,e,i)
end
c=c+w 
end
end

function onDraw()
w=screen.getWidth()
h=screen.getHeight()
cx,cy=mx,my
zoom=5
if has_lock then
cx=(mx+target.x)/2
cy=(my+target.y)/2
dx=abs(mx-target.x)
dy=abs(my-target.y)
d_span=M.max(dx,dy)
zoom=d_span*1.5/1000
if zoom<0.1 then
zoom=0.1
end
if zoom>50 then
zoom=50
end
end
screen.drawMap(cx,cy,zoom)rsx,rsy=map.mapToScreen(cx,cy,zoom,w,h,mx,my)sx,sy=floor(rsx+0.5),floor(rsy+0.5)
screen.setColor(22,222,22)
screen.drawCircleF(sx,sy,1.5)
spd=sqrt(vx^2+vy^2)
if spd>2 then
pt_ahead_x=mx+vx
pt_ahead_y=my+vy
sax,say=map.mapToScreen(cx,cy,zoom,w,h,pt_ahead_x,pt_ahead_y)
v_sx=sax-rsx
v_sy=say-rsy
v_len=sqrt(v_sx^2+v_sy^2)
if v_len>0 then
tgt_len=h*0.1
scale=tgt_len/v_len
screen.drawLine(sx,sy,floor(sx+v_sx*scale+0.5),floor(sy+v_sy*scale+0.5))
end
end
tx,ty=last_valid_target.x,last_valid_target.y
if has_lock or tx~=0 and ty~=0 then
stx,sty=map.mapToScreen(cx,cy,zoom,w,h,tx,ty)stx,sty=floor(stx+0.5),floor(sty+0.5)
screen.setColor(222,22,22)
px_r=precision*h/(zoom*1000)
if px_r<2 then
px_r=2
end
screen.drawCircle(stx,sty,px_r)
screen.drawCircleF(stx,sty,1.5)
screen.setColor(0,0,0,128)
screen.drawRectF(0,h-7,w,7)
screen.setColor(255,255,255)
DN(w/2-25,h-6,string.format("%.0f,%.0f"
,tx,ty))
end
screen.setColor(0,0,0,128)
screen.drawRectF(0,0,w,7)
status="IDLE"
if has_lock then
status="TRACK"
elseif cur_dist>0 then
status="DIST"
end
screen.setColor(255,255,255)
screen.drawText(2,1,status)
DN(w-30,1,string.format("%.0f"
,cur_dist))
end

function solve_3_circles(n,o,p)
d=sqrt((n.x-o.x)^2+(n.y-o.y)^2)
if d>n.r+o.r or d<abs(n.r-o.r)or d==0 then
return nil 
end
a=(n.r^2-o.r^2+d^2)/(2*d)
h=sqrt(M.max(0,n.r^2-a^2))
x2=o.x-n.x
y2=o.y-n.y
x0=n.x+a*x2/d
y0=n.y+a*y2/d
rx=-y2*h/d
ry=x2*h/d
p1={x=x0+rx,y=y0+ry}
p2={x=x0-rx,y=y0-ry}
err1=abs(sqrt((p1.x-p.x)^2+(p1.y-p.y)^2)-p.r)
err2=abs(sqrt((p2.x-p.x)^2+(p2.y-p.y)^2)-p.r)
if err1<err2 then
return p1 else 
return p2 
end
end

function solve_2_circles(n,o)
d=sqrt((n.x-o.x)^2+(n.y-o.y)^2)
if d>n.r+o.r or d<abs(n.r-o.r)or d==0 then
return nil,nil 
end
a=(n.r^2-o.r^2+d^2)/(2*d)
h=sqrt(M.max(0,n.r^2-a^2))x2,y2=o.x-n.x,o.y-n.y
x0,y0=n.x+a*x2/d,n.y+a*y2/d
rx,ry=-y2*h/d,x2*h/d
return{x=x0+rx,y=y0+ry},{x=x0-rx,y=y0-ry}end