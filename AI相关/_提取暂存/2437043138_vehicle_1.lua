-- source: steam id 2437043138 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2437043138
IGN=input.getNumber

autop=false
dist=0.0

ks=4
tangl=0.0

talt=300.0
cfa=0.0
mindist=300
retdist=120
pitch=0.0


targX,targY,targA=0.0,0.0,0.0
x1,x2,y1,y2,a1,a2=0,0,0,0,0,0
startX,startY,startAlt=0,0,0
state=0
ret=false
retpos=false
parashut=false

antiturret,rinit=false,false
r1,r2,t1,t2=false,false,0,0
ralt,rcurse=0,0


function onTick()
	
	autop=input.getBool(1)
	antiturret=input.getBool(2)
	x1,y1,a1,x2,y2,a2=IGN(2),IGN(3),IGN(4),IGN(5),IGN(6),IGN(7)
	startAlt,startX,startY=IGN(29),IGN(30),IGN(31)
	state=IGN(32)
	curse=IGN(16)
	alt=IGN(17)
	speed=IGN(18)
	gpsX=IGN(19)
	gpsY=IGN(20)
	
	alt=alt+startAlt
	
	if autop and not parashut then	
		
		if ret or parashut then antiturret=false end
		checkTarg()
		
		vx=targX-gpsX
		vy=targY-gpsY
		
		dist=math.sqrt(vx*vx+vy*vy)
		tangl=math.atan(vx,vy)/math.pi
		
		if antiturret then maneuvre() else t1,t2=0,0 end
		
		dc = calcdc(-tangl/2, curse)
		steer=-dc*ks
		
		
		curtargA=targA-distto(targX,targY)*cfa
		--k=curtargA-alt
		k=targA-alt
		if math.abs(k)>50 then
			if k>0 then  pitch=-0.7 else pitch=0.7  end
		else
			pitch=-0.7*k/50
		end
		
		pitch=pitch+0.3
	else
		steer=0.0
		pitch=-1
		
	end
	
	
	
	roll=steer*3
	output.setNumber(1, steer)
	output.setNumber(2, pitch)
	output.setNumber(3, roll)
	
	output.setBool(1,parashut)
	
	
	output.setNumber(4, ralt)
	output.setNumber(5, rcurse)
	output.setBool(2, antiturret)
end

function checkTarg()
	if state~=3 then
		
		p1=false
		p2=false
		if x1~=0.0 or y1~=0.0 then p1=true end
		if x2~=0.0 or y2~=0.0 then p2=true end
		
		if p1 or p2 then
			if p1 and not p2 then
				targX=x1
				targY=y1
				if a1~=0.0 then targA=a1 else targA=talt end
				cfa=0.0
			elseif p2 and not p1 then
				targX=x2
				targY=y2
				if a2~=0.0 then targA=a2 else targA=talt end
				cfa=0.0
			else
				
				if (targX~=x1 and targY~=y1) and (targX~=x2 and targY~=y2) then
					targX=x1
					targY=y1
					if a1~=0.0 then targA=a1 else targA=talt end
					cfa=0.0
				else
					
					if (targX==x1 and targY==y1) and distto(x1,y1)<mindist then 
						targX=x2
						targY=y2
						prevAlt=targA
						if a2~=0.0 then targA=a2 else targA=talt end
						if targA~=prevA then
							cfa=(targA-prevAlt)/distto(targX,targY)
						else
							cfa=0.0
						end
					end
					if (targX==x2 and targY==y2) and distto(x2,y2)<mindist then 
						targX=x1
						targY=y1
						prevAlt=targA
						if a1~=0.0 then targA=a1 else targA=talt end
						if targA~=prevA then
							cfa=(targA-prevAlt)/distto(targX,targY)
						else
							cfa=0.0
						end
					end
					
				end
			end
			
		else
			targX=startX
			targY=startY
			targA=talt
			cfa=0.0
		end
		
	
	else
		ret=true
		if distto(startX,startY)>800 then retpos =true end
		if not retpos then
			targX=startX+700
			targY=startY+700
			targA=talt
			if distto(targX,targY)<mindist then retpos=true end
		else
			targX=startX
			targY=startY
			targA=talt
			if distto(targX,targY)<retdist then parashut=true end
		end	
	
	end

end

function distto(x,y)
	return math.sqrt((x-gpsX)*(x-gpsX)+(y-gpsY)*(y-gpsY))
end

function calcdc(curs1, curs2)
	local fdc
	fdc=curs1-curs2
	if math.abs(fdc)>0.5 then
		if curs2 >0 then
			fdc=curs1+(1-curs2)
		else
			fdc=curs1-(1+curs2)
		end
	end
	return fdc
end

function maneuvre()
	if not rinit then
		math.randomseed(240222)
		rinit=true
	end
	--alt curse
	if t1<0 then
		ralt=math.random(0,120)
		t1=math.random(30,80)
		if r1 then t1=t1*0.7 end
		r1= not r1
	end
	if t2<0 then
		rcurse=math.random()/5-(1/10)
		t2=math.random(40,80)
		if r2 then t2=t2*0.7 end
		r2=not r2
	end
	if r1 then alt=alt-ralt end
	if r2 then curse=curse+rcurse end
	
	
	t1=t1-1
	t2=t2-1
end