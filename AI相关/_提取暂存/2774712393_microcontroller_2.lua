-- source: steam id 2774712393 / microcontroller.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2774712393
FONT=property.getText("FONT1")..property.getText("FONT2") FONT_D={} FONT_S=0 for n in FONT:gmatch("....")do FONT_D[FONT_S+1]=tonumber(n,16)FONT_S=FONT_S+1 end function dst(x,y,t,s,r,m)s=s or 1 r=r or 1 if r>2then t=t:reverse()end t=t:upper()for c in t:gmatch(".")do ci=c:byte()-31if 0<ci and ci<=FONT_S then for i=1,15 do if r>2 then p=2^i else p=2^(16-i)end if FONT_D[ci]&p==p then xx,yy=((i-1)%3)*s,((i-1)//3)*s if r%2==1then screen.drawRectF(x+xx,y+yy,s,s)else screen.drawRectF(x+5-yy,y+xx,s,s)end end end if FONT_D[ci]&1==1 and not m then i=2*s else i=4*s end if r%2==1then x=x+i else y=y+i end end end end
s=screen
sC=s.setColor
iN=input.getNumber
iB=input.getBool
B={{l="1",x=6,y=6,p=false},{l="t",x=1,y=6,t=false,p=false},{l="+",x=11,y=6,p=false},{l="-",x=16,y=6,p=false},{l="b",x=27,y=6,t=false,p=false},{l="m",x=22,y=6,t=false,p=false}}
mode=0
count=0
function onTick()
	count=(count+1)%60
	w=iN(1)
	h=iN(2)
	if w==0 then w=32 h=32 end cy=h/2 cx=w/2
	ix=iN(3)
	iy=iN(4)
	bc_x=iN(5)
	t=iB(1) or iB(2)
	t2=false if t and not last_t then t2=true end last_t=t
	for i,v in pairs(B) do
		if t and ix>v.x-1 and iy>h-v.y-2 and ix<v.x+4 and iy<h-v.y+6 then
			B[i].p=true
			if t2 then
				if i==2 then mode=0 end
				if v.t~=nil and not (i==2 and B[5].t) then
					B[i].t=not v.t
					if i==5 then B[2].t=false end
				end
				if i==1 and bc_x~=0 then
					z=1
					mode=(mode+1)%3
					B[1].l=tostring(mode+1)
				end
			end
		else
			B[i].p=false
		end
	end
	output.setNumber(1,w)
	output.setNumber(2,h)
	output.setNumber(3,mode)
	output.setBool(1,B[1].p)
	output.setBool(2,B[2].t)
	output.setBool(3,B[3].p)
	output.setBool(4,B[4].p)
	output.setBool(5,B[5].t)
	output.setBool(6,B[6].t)
end
function onDraw()
	sC(2,5,2)
	s.drawRectF(0,h-7,w,7)
	for i,v in pairs(B) do
		if not ((i==3 or i==4) and mode==1) and not (i==1 and bc_x==0) then
			if v.t and not v.p and i<6 then
				sC(20,20,20)
				if i==5 and v.t and count<10 then sC(100,0,0) end
				s.drawRectF(v.x-1,h-v.y,5,5)
			end
			if v.p then
				sC(50,25,2)
			else
				sC(50,50,50)
			end
			dst(v.x,h-v.y,v.l)
		end
	end
end