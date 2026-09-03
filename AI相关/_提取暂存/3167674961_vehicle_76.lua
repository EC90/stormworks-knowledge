-- source: steam id 3167674961 / vehicle.xml block#76
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
m=math
atan=m.atan
sin=m.sin
asin=m.asin
cos=m.cos
sqrt=m.sqrt
pi=m.pi
abs=m.abs
tau=2*pi
i=input
o=output
ign=i.getNumber
igb=i.getBool
osn=o.setNumber
osb=o.setBool
lastError=0
integral=0
glbtrkXdelta=0
lastglbtrkX=0
filter=property.getNumber("Terminal Mass Filter")
ignore=property.getNumber("Initial Launch IFF Distance")
midcourse=property.getBool("New Sonar Midcourse Search")
timer=0
midrange=1000
function clamp(a,b,c) 
    return math.min(math.max(a,b),c) 
end
 
function getTransform()
	local rx,ry,rz=ign(4),ign(5),ign(6)
	local cx,sx=cos(rx),sin(rx)
	local cy,sy=cos(ry),sin(ry)
	local cz,sz=cos(rz),sin(rz)
	local right   = {x =  cy*cz,            y = -sy,    z =  cy*sz}
	local forward = {x =  sx*sz + cx*sy*cz, y =  cx*cy, z = -sx*cz + cx*sy*sz}
	local up      = {x = -cx*sz + sx*sy*cz, y =  sx*cy, z =  cx*cz + sx*sy*sz}
	return right,forward,up
end
					
function onTick()

	-- Bool Inputs
	isfired=igb(1)
	srchtgt=igb(2)
	
	-- GPS Inputs
	cx=ign(1)
	cz=ign(2)
	cy=ign(3)	
	tx=ign(7)
	ty=ign(8)
	tz=ign(9)
	compass=ign(10)
	
	-- Sonar Inputs
	srchsonX=ign(11)
	srchsonY=ign(12)
	trksonX=ign(13)
	trksonY=ign(14)
	trksondist=ign(15)
	trksonsigst=ign(16)
	
	-- Launch Position Input
	lastx=ign(17)
	lasty=ign(18)
	osn(10,cz)
	osb(1,isfired)
	
	-- GPS Transforms
	right,forward,up=getTransform()
	tilt=(atan(right.z,sqrt((right.x^2)+(right.y^2)))/tau)	
	tiltf=(atan(forward.z,sqrt((forward.x^2)+(forward.y^2)))/tau)
	gpsdist=sqrt((tx-cx)^2+(ty-cy)^2)
	trkmass=trksondist*trksonsigst
	sontz=(sin((trksonY+tiltf)*tau)*trksondist)+cz

	-- Midcourse Guidance 
	set=tx~=0 and ty~=0
	if isfired then
		
		-- Ignore Launch GPS	
		launcherdist=sqrt((lastx-cx)^2+(lasty-cy)^2)
		disengage=launcherdist<ignore
		
		-- Depth Hold 
		if trksondist<150 and trksondist ~=0 then
			tgtdepth=(sontz-2)
		else
		tgtdepth=-7
		end
		error=(tgtdepth)-cz
		proportional=error*0.025
		integral=integral+error*0.00001
		derivative=(error-lastError)*2.5
		lastError=error
		depthhold=proportional+integral+derivative	
		pitch=depthhold
		
		if set then
			yaw=((compass+atan(tx-cx,ty-cy)/tau+0.5)%1-0.5)*35
		else
			yaw=0
		end
		
		
		-- If not within IFF location
		if not disengage then 	
			-- Enable New Sonar Search
			if srchtgt and (not set or (set and gpsdist<200)) and not reset and midcourse then
				terminal=true		
			end
		
			-- PN Calc
			if trkmass>filter and trksondist<1000 then
				glbtrkX=trksonX+compass		
				glbtrkXdelta=glbtrkX-lastglbtrkX
				lastglbtrkX=glbtrkX		
				yaw=glbtrkXdelta*-4000
				pitch=trksonY*65+depthhold
				engage=true
			else
				engage=false
			end
			
			-- New Sonar Calc
			if terminal and not engage then
				timer=clamp(timer%35+(1/60),0,35)
				yaw=(srchsonX*15)
				pitch=(srchsonY*0.1)+depthhold
				if timer>=25 then
					if set then
						yaw=((compass+atan(tx-cx,ty-cy)/tau+0.5)%1-0.5)*35
					else
						yaw=2
					end 
				end		

				if gpsdist>=(midrange+2750) then
					terminal=false
				end
			end
		end
	end
	osn(1,yaw)
	osn(2,pitch)
	osn(3,tilt*-2)
end
	

	