-- source: steam id 3793581819 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
s=string
M=math
si=M.sin
co=M.cos
at=M.atan
ab=M.abs
pi=M.pi
pi2=pi*2
pih=pi/2
S=screen
dTF=S.drawTriangleF
P=property
prB=P.getBool
prN=P.getNumber
prT=P.getText
tU=table.unpack

function dRC(a,b,c,d,e,f,g,h)dTF(a,b,c,d,e,f)dTF(e,f,g,h,c,d)end --custom rectangle

chr={ --charset
	A={{0,0,2,1,2,0,"",1,3},{9,-1,-8,0,8,1,"",5,0}},
	B={{0,4,0,-2,2,0,-4,0},{0,0,2,2,2,3,0,-9}},
	C={{4,-2,-2,0,2,2},{0,0,2,5,2,0}},
	D={{0,3,2,0,-2,-3,0},{0,0,2,5,2,0,-9}},
	E={{4,-4,0,4,"",0,3},{0,0,9,0,"",4,0}},
	F={{4,-4,0,"",0,3},{0,0,9,"",4,0}},
	G={{5,-3,-2,0,2,3,0,-2},{0,0,2,5,2,0,-4,0}},
	H={{0,0,"",0,5,"",5,0},{0,9,"",4,0,"",0,9}},
	I={{0,0},{0,9}},
	J={{2,0,-2,0},{0,9,0,-2}},
	K={{0,0,"",5,-4,4,0},{0,9,"",0,4,4,1}},
	L={{0,0,4},{0,9,0}},
	M={{0,0,1,2,2,1,0},{9,-9,0,5,-5,0,9}},
	N={{0,0,1,2,1,0},{9,-9,0,9,0,-9}},
	O={{0,5,0,-5,0},{0,0,9,0,-9}},
	P={{0,0,4,0,-3},{9,-9,0,4,0}},
	Q={{3,-3,0,4,0,1},{9,0,-9,0,8,1}},
	R={{0,0,4,0,-3,3,0},{9,-9,0,4,0,4,1}},
	S={{4,0,-4,0,4,0,-4,0},{2,-2,0,4,0,5,0,-2}},
	T={{0,5,"",2,0},{0,0,"",0,9}},
	U={{0,0,4,0},{0,9,0,-9}},
	V={{0,0,2,2,0},{0,6,3,-3,-6}},
	W={{0,0,1,2,2,1,0},{0,5,3,-4,4,-3,-5}},
	X={{0,0,4,0,"",0,0,4,0},{0,2,5,2,"",9,-2,-5,-2}},
	Y={{0,0,2.5,"",5,0,-5},{0,3,3,"",0,3,6}},
	Z={{0,5,0,-5,0,6},{0,0,2,5,2,0}},
	[1]={{0,2,0},{2,-2,9}},
	[2]={{0,0,4,0,-4,5},{2,-2,0,2,7,0}},
	[3]={{0,0,4,0,-1,1,0,-4,0},{2,-2,0,3,1,1,4,0,-2}},
	[4]={{2,-2,5,"",3,0},{0,5,0,"",3,6}},
	[5]={{4,-3,-1,4,0,-4,0},{0,0,4,0,5,0,-2}},
	[6]={{0,4,0,-4,0,2},{5,0,4,0,-5,-4}},
	[7]={{0,4,-3},{0,0,9}},
	[8]={{0,0,3,0,-4,0,4,0},{4,-4,0,4,0,5,0,-5}},
	[9]={{4,-4,0,4,0,-3},{4,0,-4,0,4,5}},
	[0]={{3,-3,0,4,0},{0,0,9,0,-8}},
	["!"]={{0,0,"",0,0},{0,6,"",8,1}},
	["?"]={{0,0,3,0,-2,0,"",1,0},{2,-2,0,2,3,1,"",8,1}},
	["+"]={{0,3.5,"",1.5,0},{4,0,"",2,4}},
	["-"]={{0,3.5},{4,0}},
	[":"]={{0,0,"",0,0},{2,1,"",5,1}},
	["_"]={{0,4},{9,0}},
	["."]={{0,0},{8.5,1}},
	[","]={{0,1},{10,-2}}
}
chrd={}
chrd[s.byte(" ")]={w=5}
W=(property.getNumber("Fontweight") or 5)/10 --weight

for i,tbl in pairs(chr) do --pre-render the font
	tx=tbl[1]
	ty=tbl[2]
	asc=s.byte(i)
	chrd[asc]={}
	chrd[asc].t={}
	mx=0
	x,y=0,0
	for z=1,#tx do
		if tx[z]=="" then
			skip=true
			x,y=0,0
			chrd[asc].t[z]=false
		else
			x,y=x+tx[z],y+ty[z]
			a1=(z==1 or skip) and at(ty[z+1],tx[z+1]) or at(ty[z],tx[z])
			a2=(z==#tx or tx[z+1]=="") and a1 or at(ty[z+1],tx[z+1])
			a0=(a1+a2)/2
			d=a0-a1
			d=d<0 and d or pi2-d
			w=W/M.max(si(d),co(d))
			local j,k,l,m = x+w*co(a0-pih),y+w*si(a0-pih),x+w*co(a0+pih),y+w*si(a0+pih)
			if ab(j)<W/2 then j,l=-W,-W end
			if ab(k)<W/2 then k,m=-W,-W end
			if ab(k-9)<W/4 then k,m=9+W,9+W end
			chrd[asc].t[z]={j,k,l,m}
			mx=M.max(mx,j,l)
			skip=false
		end
	end
	chrd[asc].w=mx
end

function TXT(txt,xx,yy,ww,hh) --Text, xpos, ypos, fontscale, maxwidth
	txt=s.upper(txt)
	local lw,tw,r,zz,ss,th=0,0,ww/hh,0,0,9
	for a=1,2 do
		if a>1 then
			tw=lw-2+W
			ss=M.min(hh/th, ww/tw)
			wl=ww/ss
		end
		lw=0
		for i=1,#txt do
			c=chrd[s.byte(s.sub(txt,i,i))]
			w,t=c.w,c.t
			
			if a>1 and t~=nil then
				for a,b in pairs(t) do
					if a>1 and t[a-1] and t[a] then
						local x=xx+ss*(lw+W)
						local y=yy+(hh-ss*th)/2
						local j,k,l,m=tU(t[a-1])
						local n,o,p,q=tU(t[a])
						dRC(x+ss*j,y+ss*k,x+ss*l,y+ss*m,x+ss*n,y+ss*o,x+ss*p,y+ss*q)
					end
				end
			end
			lw=lw+w+2
		end
	end
end

function onTick()
	grad = input.getNumber(1)
end

function onDraw()
S.setColor(prN("R"),prN("G"),prN("B"), grad)
	TXT("Vlasko Systems",0,0,S.getWidth(),S.getHeight())
end