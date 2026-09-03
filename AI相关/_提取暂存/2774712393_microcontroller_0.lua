-- source: steam id 2774712393 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2774712393
FONT=property.getText("FONT1")..property.getText("FONT2") FONT_D={} FONT_S=0 for n in FONT:gmatch("....")do FONT_D[FONT_S+1]=tonumber(n,16)FONT_S=FONT_S+1 end function dst(x,y,t,s,r,m)s=s or 1 r=r or 1 if r>2then t=t:reverse()end t=t:upper()for c in t:gmatch(".")do ci=c:byte()-31if 0<ci and ci<=FONT_S then for i=1,15 do if r>2 then p=2^i else p=2^(16-i)end if FONT_D[ci]&p==p then xx,yy=((i-1)%3)*s,((i-1)//3)*s if r%2==1then screen.drawRectF(x+xx,y+yy,s,s)else screen.drawRectF(x+5-yy,y+xx,s,s)end end end if FONT_D[ci]&1==1 and not m then i=2*s else i=4*s end if r%2==1then x=x+i else y=y+i end end end end
s=screen
dL=s.drawLine
sC=s.setColor
iN=input.getNumber
iB=input.getBool
C={}
D={}
count=0
max_speed=property.getNumber("Max Speed [m/s]")
function onTick()
	w=iN(1)
	h=iN(2)
	if w==0 then w=32 h=32 end cy=h/2 cx=w/2
	gps_x=iN(4)
	gps_y=iN(5)
	dist=iN(9)
	speed=iN(10)
	mx=iN(11)
	my=iN(12)
	mz=iN(13)
	pulse=iB(7)
	valid=iB(8)
	toggle=iB(2)
	
	if toggle and dist>0 then
		if pulse then
			count=0
		elseif count<1000 then
			count=count+1
		end
		if dist>300 and valid and speed<max_speed then
			if not C[1] or length(C[#C].x,C[#C].y,gps_x,gps_y)>clamp(#C*5,10,200) then
				table.insert(C,{x=gps_x,y=gps_y,r=dist,e=speed+1})
				if #C>3 then
					T=findTripletsIntersections(C)
					point={x=0,y=0,d=0}
					for i,v in ipairs(T) do
						point.x=point.x+v.x*(1/v.e)
						point.y=point.y+v.y*(1/v.e)
						point.d=point.d+1/v.e
					end
					if point.d>0 then
						local x,y=closestPointOnCircle(point.x/point.d,point.y/point.d,gps_x,gps_y,dist)
						D={x=x,y=y,m=length(point.x/point.d,point.y/point.d,x,y)}
					end
					if #C>50 then
						table.remove(C,1)
					end
				end
			end
		end
	else
		C={}
		D={}
	end
	output.setNumber(1,D.x)
	output.setNumber(2,D.y)
	output.setNumber(3,D.m)
end
function onDraw()
	if D.x then
		sC(90,10,10)
		x,y=map.mapToScreen(mx,my,mz,w,h,D.x,D.y)
		s.drawCircleF(x,y,1)
		s.drawCircle(x,y,count)
		sC(90,10,10,50)
		s.drawCircleF(x,y,(D.m/1000)*(h/mz))
	end
	if toggle and speed>=max_speed then
		sC(2,2,2,100)
		s.drawRectF(0,0,w,5)
		sC(100,0,0)
		dst(cx-15,0,"too fast")
	elseif dist>50 then
		sC(20,20,20,150)
		x,y=map.mapToScreen(mx,my,mz,w,h,gps_x,gps_y)
		s.drawCircle(x,y,(dist/1000)*(h/mz))
		sC(2,2,2,100)
		s.drawRectF(0,0,w,5)
		sC(100,50,0)
		dst(cx-10,0,math.floor(dist/100+.5)/10 .." km")
	end
end
function clamp(x,min,max)
	return math.max(math.min(x,max),min)
end
function length(x1,y1,x2,y2)
	return ((x1-x2)^2+(y1-y2)^2)^(1/2)
end
function closestPointOnCircle(x,y,cx,cy,r)
    local dx=x-cx
    local dy=y-cy
    local dist=length(x,y,cx,cy)
    if dist==0 then
        return cx+r,cy
    end
    return cx+(dx/dist)*r,cy+(dy/dist)*r
end
function circlesDoIntersect(c1,c2) -- check if 2 circles intersect
    return (c1.x-c2.x)^2+(c1.y-c2.y)^2<=(c1.r+c2.r)^2
end
function findCircleIntersections(c1,c2,c3)    -- find the intersection of 3 circles
    local A=2*(c2.x-c1.x)
    local B=2*(c2.y-c1.y)
    local C=c1.r^2-c2.r^2-c1.x^2+c2.x^2-c1.y^2+c2.y^2
    local D=2*(c3.x-c2.x)
    local E=2*(c3.y-c2.y)
    local F=c2.r^2-c3.r^2-c2.x^2+c3.x^2-c2.y^2+c3.y^2
    return {x=(C*E-F*B)/(E*A-B*D),y=(C*D-A*F)/(B*D-A*E),e=math.max(c1.e,math.max(c2.e,c3.e))}
end
function findTripletsIntersections(C) --find all the intersection points of all the triplets
    local T={}
    for i=1,#C-2 do
        for j=i+1,#C-1 do
            for k=j+1,#C do
                if circlesDoIntersect(C[i],C[j]) and circlesDoIntersect(C[i],C[k]) and circlesDoIntersect(C[j],C[k]) then
                    local point=findCircleIntersections(C[i],C[j],C[k])
					if math.abs(length(gps_x,gps_y,point.x,point.y)-dist)<100 then
						
                    	table.insert(T,point)
					end
                end
            end
        end
    end
    return T
end