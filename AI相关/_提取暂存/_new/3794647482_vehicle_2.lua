-- source: steam id 3794647482 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
iN=input.getNumber
oN=output.setNumber
sin=math.sin
cos=math.cos

function onTick()
	local ex,ey,ez=iN(4),iN(5),iN(6)
	if ex~=ex or ey~=ey or ez~=ez then return end

	local xs,xc,ys,yc,zs,zc=sin(ex),cos(ex),sin(ey),cos(ey),sin(ez),cos(ez)

	local x,y,z=iN(10),iN(11),iN(12)
	x,y=x*zc+y*zs,y*zc-x*zs
	x,z=x*yc-z*ys,z*yc+x*ys
	y,z=y*xc+z*xs,z*xc-y*xs

	oN(1,x)
	oN(2,y)
	oN(3,z)
end
