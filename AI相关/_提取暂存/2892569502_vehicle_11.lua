-- source: steam id 2892569502 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2892569502
function simpleXYZ(b,c,d)f=math;e=b*f.cos(d)return{e*f.cos(c),e*f.sin(c),b*f.sin(d)}end
function matMul(b,c)local d={}for e=1,#b do d[e]={}for f=1,#c[1]do d[e][f]=0;for g=1,#c do d[e][f]=d[e][f]+b[e][g]*c[g][f]end end end;return d end
function rotateMatrix(b,c,d)e,f=math.cos,math.sin;return{{e(d)*e(c),-f(d)*e(b)+e(d)*f(c)*f(b),f(d)*f(b)+e(d)*f(c)*e(b)},{f(d)*e(c),e(d)*e(b)+f(d)*f(c)*f(b),-e(d)*f(b)+f(d)*f(c)*e(b)},{-f(c),e(c)*f(b),e(c)*e(b)}}end
function matXYZ(x,y,z) return{{x,y,z},{x,y,z},{x,y,z}} end
function dematXYZ(mat) return{x=mat[1][1],y=mat[2][2],z=mat[3][3]} end
function dump(b)if type(b)=='table'then local d='{'for e,f in pairs(b)do if type(e)~='number'then e='"'..e..'"'end;d=d..'['..e..'] = '..dump(f)..',\n'end;return d..'} 'else return tostring(b)end end
function stackPush(b,c,d)table.insert(b,d)if#b>c then table.remove(b,1)end end
function tableAvg(b)c=0;for d=1,#b do c=c+b[d]end;return c/#b end

oldx,oldy,oldz=0,0,0
X_SMOOTH,Y_SMOOTH,Z_SMOOTH={},{},{}
STI=30
fps=1000
fpt=fps/62

function onTick()
	I,O=input,output
	GN,GB=I.getNumber,I.getBool
	SN,SB=O.setNumber,O.setBool

	gpsx=GN(1)
	gpsy=GN(2)
	alt=GN(3)
	compass=-GN(4)*math.pi*2
	pitch=-GN(5)*math.pi*2
	roll=GN(6)*math.pi*2

	locked=GB(11)
	dist=GN(11)
	ang=-GN(12)*math.pi*2
	tilt=GN(13)*math.pi*2
	time=GN(14)
	if dist>50 then
	xyz=simpleXYZ(dist,ang,tilt)
	res=matMul(matXYZ(xyz[1],xyz[2],xyz[3]),rotateMatrix(roll,pitch,compass))
	res=dematXYZ(res)
	
	-- direction shift
	tmpX=-res.y+gpsx
	tmpY=res.x+gpsy
	tmpZ=res.z+alt
	res.x=tmpX
	res.y=tmpY
	res.z=tmpZ
	
	--stackPush(X_SMOOTH,STI,res.x)
	--res.x=tableAvg(X_SMOOTH)
	--stackPush(Y_SMOOTH,STI,res.y)
	--res.y=tableAvg(Y_SMOOTH)
	--stackPush(Z_SMOOTH,STI,res.z)
	--res.z=tableAvg(Z_SMOOTH)
	SN(30,res.x)
	SN(31,res.y)
	SN(32,res.z)
	
	dx,dy,dz=res.x-oldx,res.y-oldy,res.z-oldz
	oldx,oldy,oldz=res.x,res.y,res.z
	dltd=math.sqrt((res.x-gpsx)^2+(res.y-gpsy)^2)
	dltt=dltd/fpt
	dltx=res.x-gpsx--+dltt*dx
	dlty=res.y-gpsy--+dltt*dy
	dltz=res.z-alt--+dltt*dz
	anga=math.atan(-dltx,dlty)/(math.pi*2)
	ange=(math.atan(dltz/dltd)+((dltd/1000)*0.025))/(math.pi*2)
	--tgte=rsts[1].e+f.atan(go/rsts[1].d)/(2*pi)+((dltd/1000)*0.025)/(pi*2)
	SN(1,anga)
	SN(2,ange)
	else
		SN(30,0)
		SN(31,0)
		SN(32,0)
		SN(1,0)
		SN(2,0)
	end
end

function onDraw()
	w,h=screen.getWidth(),screen.getHeight()
	screen.setColor(222,0,0)
	screen.drawText(1,46,ange)
	screen.drawText(1,53,tilt)
	screen.drawText(1,60,pitch)
end
