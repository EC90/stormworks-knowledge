-- source: steam id 3157729996 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3157729996
i,o,p,m=input,output,property,math
pgn,pgb,gn,gb,sn,sb=p.getNumber,p.getBool,i.getNumber,i.getBool,o.setNumber,o.setBool
abs,min,max,sqrt,atan,pi2=m.abs,m.min,m.max,m.sqrt,m.atan,m.pi*2

function trn(mat)
local out={}
local lin,col=#mat,#mat[1]
for i=1,col do
	out[i]={}
	for j=1,lin do
		out[i][j]=mat[j][i]
	end
end
return out
end

function sum(mat1,mat2,fac)
local out={}
local fac=fac or 1
local lin,col=#mat1,#mat1[1]
for i=1,lin do
	out[i]={}
	for j=1,col do
		out[i][j]=mat1[i][j]+fac*mat2[i][j]
	end
end
return out
end

function mul(mat1,mat2)
local out={}
local lin,col1,col2=#mat1,#mat1[1],#mat2[1]
for i=1,lin do
	out[i]={}
	for j=1,col2 do
		out[i][j]=0
		for k=1,col1 do
			out[i][j]=out[i][j]+mat1[i][k]*mat2[k][j]
		end
	end
end
return out
end

function blc(mat)
local out={}
local lin,col=#mat,#mat[1]
for i=1,3*lin do
	out[i]={}
	for j=1,3*col do
		out[i][j]=0
	end
end
for i=1,3 do
	for j=1,lin do
		for k=1,col do
			out[(i-1)*lin+j][(i-1)*col+k]=mat[j][k]
		end
	end
end
return out
end

function inv(a)
local a1,a2,a3,a4,a5,a6,a7,a8,a9=a[1][1],a[1][2],a[1][3],a[2][1],a[2][2],a[2][3],a[3][1],a[3][2],a[3][3]
local out={{a5*a9-a6*a8, a3*a8-a2*a9, a2*a6-a3*a5},
		   {a6*a7-a4*a9, a1*a9-a3*a7, a3*a4-a1*a6},
		   {a4*a8-a5*a7, a2*a7-a1*a8, a1*a5-a2*a4}}
local det=a1*a5*a9+a2*a6*a7+a3*a4*a8-a3*a5*a7-a1*a6*a8-a2*a4*a9
if det~=0 then
	for i=1,3 do
		for j=1,3 do
			out[i][j]=out[i][j]/det
		end
	end
else
	return im
end
return out
end

del=pgn("Tick delay compensation")
red=not pgb("Reduce noise for slow targets")
out=pgn("Output")

p0=0.001^2
q0=0.00007^2

rm={{0,0,0},
	{0,p0,0},
	{0,0,p0}}
	
qm={{0.25,0.5,0.5},
	{0.5,1,1},
	{0.5,1,1}}

fm={{1,1,0.5},
	{0,1,1},
	{0,0,1}}

qm=blc(qm)
fm=blc(fm)
ft=trn(fm)

im,xp,xe,pe,pp,xd={},{},{},{},{},{}

for i=1,9 do
	im[i]={}
	for j=1,9 do
		im[i][j]=i==j and 1 or 0
	end
end

function onTick()
for i=1,8 do
	if gb(i) then
		zm={{gn(4*i-3)},{pi2*gn(4*i-2)},{pi2*gn(4*i-1)}}
		rm[1][1]=(zm[1][1]*0.001)^2
		if xp[i][1][1]==0 and xp[i][4][1]==0 and xp[i][7][1]==0 then
			xp[i][1][1]=zm[1][1]*m.sin(zm[2][1])*m.cos(zm[3][1])
			xp[i][4][1]=zm[1][1]*m.sin(zm[3][1])
			xp[i][7][1]=zm[1][1]*m.cos(zm[2][1])*m.cos(zm[3][1])
			pp[i]=sum(mul(mul(fm,im),ft),qm)
		else
			x,y,z=xp[i][1][1],xp[i][4][1],xp[i][7][1]
			t1=sqrt(x^2+y^2+z^2)
			t2=sqrt(x^2+z^2)
			hm={{t1},{atan(x,z)},{atan(y,t2)}}
			dh={{x/t1,0,0,y/t1,0,0,z/t1,0,0},
				{z/t2^2,0,0,0,0,0,-x/t2^2,0,0},
				{-x*y/(t1^2*t2),0,0,t2/t1^2,0,0,-y*z/(t1^2*t2),0,0}}
			t3=trn(dh)	
			kg=mul(mul(pp[i],t3),inv(sum(mul(mul(dh,pp[i]),t3),rm)))
			xe[i]=sum(xp[i],mul(kg,sum(zm,hm,-1)))
			t4=sum(im,mul(kg,dh),-1)
			pe[i]=sum(mul(mul(t4,pp[i]),trn(t4)),mul(mul(kg,rm),trn(kg)))
			xp[i]=mul(fm,xe[i])
			qf=red and min(m.sqrt(xe[i][2][1]^2+xe[i][5][1]^2+xe[i][8][1]^2),1) or 1
			pp[i]=sum(mul(mul(fm,pe[i]),ft),qm,q0*qf)
		end
	else		
		xp[i]={{0},{0},{0},{0},{0},{0},{0},{0},{0}}
		xd[i]={0,0,0,0,0,0,0,0,0}
	end
	for j=1,3 do
		xd[i][j]=xp[i][3*j-2][1]+del*xp[i][3*j-1][1]+0.5*del^2*xp[i][3*j][1]
	end
	sn(4*i,gn(4*i))
	sb(i,gb(i))
	
	if out==1 then
		sn(4*i-3,sqrt(xd[i][1]^2+xd[i][2]^2+xd[i][3]^2))
		sn(4*i-2,atan(xd[i][1],xd[i][3])/pi2)
		sn(4*i-1,atan(xd[i][2],sqrt(xd[i][1]^2+xd[i][3]^2))/pi2)
	elseif out==2 then
		sn(4*i-3,xd[i][1])
		sn(4*i-2,xd[i][2])
		sn(4*i-1,xd[i][3])
	elseif out==3 then
		sn(4*i-3,3.6*60*xp[i][2][1])
		sn(4*i-2,3.6*60*xp[i][5][1])
		sn(4*i-1,3.6*60*xp[i][8][1])
	end
end
end