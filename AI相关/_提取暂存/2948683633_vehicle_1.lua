-- source: steam id 2948683633 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2948683633
ign = input.getNumber
osn = output.setNumber
igb = input.getBool
osb = output.setBool;
pgn = property.getNumber
pgb = property.getBool
m = math 
abs = m.abs
cos = m.cos
sin = m.sin
acos = m.acos
asin = m.asin
tan = m.tan
sqrt = m.sqrt
atan = m.atan
pi = m.pi
pi2 = pi*2
tc=pgn("Tick Compensation")
nc=pgn("Nav Const")
lx,ly,lz,kx,ky,kz,oldLOSA,oldLOSE=0,0,0,0,0,0,0,0
deltaLOSE = 0
deltaLOSA = 0
function onTick()
--coords
	TargetX=ign(7)
	TargetY=ign(8)
	TargetZ=ign(9)
	
	BombX=ign(1)
	BombY=ign(3)
	BombZ=ign(2)
--tick comp
	tx,ty,tz = TargetX,TargetY,TargetZ
	dtx,dty,dtz = tx-lx,ty-ly,tz-lz
	TargetX,TargetY,TargetZ = tx+dtx*tc,ty+dty*tc,tz+dtz*tc
	
	bx,by,bz = BombX,BombY,BombZ
	dbx,dby,dbz = bx-kx,by-ky,bz-kz
	BombX,Bomby,BombZ = bx+dbx*tc,by+dby*tc,bz+dbz*tc
--guidance
	Distance = sqrt((TargetX-BombX)^2+(TargetY-BombY)^2+(TargetZ-BombZ)^2)
    LOSA = atan(TargetX-BombX,TargetY-BombY)
    LOSE = asin((TargetZ-BombZ)/Distance)

    deltaLOSA = LOSA-oldLOSA
    oldLOSA = LOSA
    deltaLOSE = LOSE-oldLOSE
    oldLOSE = LOSE
    PNPitch=deltaLOSE*nc
    PNYaw=deltaLOSA*nc
	if igb(1)==true then
    	output.setNumber(1,PNYaw)
    	output.setNumber(2,PNPitch-0.275)
	end
	lx,ly,lz=tx,ty,tz
	kx,ky,kz=bx,by,bz
end