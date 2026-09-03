-- source: steam id 2800117544 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2800117544
iN = input.getNumber
iB = input.getBool
oS = output.setNumber
oB = output.setBool
tx = 0
ty = 0
tz = 0
xt = 0
function onTick()

	ps = property.getNumber("Missile Pitch Sensitivity")
	ys = property.getNumber("Missile Yaw Sensitivity")
	
	tx = iN(1)
	ty = iN(2)
	tzcap = iN(3)
	
	cx = iN(4)
	cy = iN(5)
	cz = iN(6)
	comp = iN(7)
	tiltroll = iN(8)
	tiltpitch = iN(9)	
	comproll = iN(10)
	
	radardis = iN(11)
	radaryaw = iN(12)
	radarpitch = iN(13)

	gpsdis = iN(14)
	indis = iN(15)
	
	isfired = iB(1)
	rdetect = iB(2)
	trh = iB(32)
		
		
		
	
	if isfired then	
	
		xt = xt+1
		if rdetect and gpsdis <= 1000 and trh then
			oS(1, radaryaw*25)
			oS(2, radarpitch*25)	
		else
			if xt < 650 then
			roll=((math.atan(tx-cx,ty-cy)/(math.pi*2))+comproll+0.5)%1-0.5
			oS(3, -roll*2)
			oS(2, -0.5)	
			else
			oS(3, 0)
			tz = (-(2*(gpsdis^2))/indis+(2*gpsdis*indis)/indis)+tzcap
			tp={tx-cx, ty-cy, tz-cz}
			if math.sqrt((tx-cx)^2+(ty-cy)^2+(tz-cz)^2)<0 then tp[3]=-cz else tp[3]=tz-cz end
			tvone=zrot(tp, -comp*math.pi*2)
			tvtwo=xrot(tvone, -tiltpitch*math.pi*2)
			tr=yrot(tvtwo, -tiltroll*math.pi*2)
			hlos=math.atan(tr[1], tr[2])
			vlos=math.atan(tr[3], tr[2])
			oS(1, hlos*ys)
			oS(2, -vlos*ps)
			end
		end
	end		
end	

function xrot(vec, angle)
vect={vec[1], vec[2]*math.cos(angle)-vec[3]*math.sin(angle), vec[2]*math.sin(angle)+vec[3]*math.cos(angle)}
return vect
end
function zrot(vec, angle)
vect={vec[1]*math.cos(angle)-vec[2]*math.sin(angle), vec[1]*math.sin(angle)+vec[2]*math.cos(angle), vec[3]}
return vect
end
function yrot(vec, angle)
vect={vec[1]*math.cos(angle)+vec[3]*math.sin(angle), vec[2], -vec[1]*math.sin(angle)+vec[3]*math.cos(angle)}
return vect
end