-- source: steam id 2379508495 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2379508495
x2 = 0
x4 = 0
y = 0
z = 0
w = 0
x = 0
angletable = {}
x5 = 0
x6 = 0
x7 = 0
verticalangledelta = 0
horizontalangledelta = 0
verticalangle = 0
horizontalangle = 0


function rotate(s,a,p,n,j)
        sin=math.sin(p)
        cos=math.cos(p)
        tx=-(((s*cos)-(a*sin))+n) --assumes radar is facing where the left is positive
        ty=((s*sin)+(a*cos))+j
    return tx,ty
    end

function onTick()




radarh = input.getNumber(1) * (math.pi*2)
radarv = input.getNumber(2) * (math.pi*2)
tiltroll = (input.getNumber(3) * (math.pi*2))
tiltpitch = (input.getNumber(4) * (math.pi*2))
compass = (input.getNumber(5) * (math.pi*2))
tiltsensorup = input.getNumber(6) * (math.pi*2)
targetdistance = input.getNumber(7)
navigationconstant = input.getNumber(8)

roll=math.atan(tiltroll, tiltsensorup)


horizontalangle,verticalangle = rotate(radarh,radarv,roll,compass,tiltpitch)


verticalangledelta = verticalangle - x2
x2 = verticalangle

horizontalangledelta = horizontalangle - x4
x4 = horizontalangle

closingvelocity = targetdistance - x5
x5 = targetdistance

HLOSaccel = horizontalangledelta - x6
x6 = horizontalangledelta

VLOSaccel = verticalangledelta - x7
x7 = verticalangledelta


verax= navigationconstant * verticalangledelta * (math.abs(closingvelocity)) + (VLOSaccel/2)*navigationconstant
horax= navigationconstant * horizontalangledelta * (math.abs(closingvelocity)) + (HLOSaccel/2)*navigationconstant

--rollangle = math.atan(tiltroll,tiltsensorup)
--x = verticalangledelta
--y = rollangle
--z = horizontalangledelta
--w = 0
    

output.setNumber(1,(horax)) --(x*math.sin(y))+(z*math.cos(y))+w + (0*math.pi*2))
output.setNumber(2,(verax)) --(x*math.sin(y))+(z*math.cos(y))+w + (.25*math.pi*2))
output.setNumber(5,(horax))--(x*math.sin(y))+(z*math.cos(y))+w + (.5*math.pi*2))
output.setNumber(6,(verax))--(x*math.sin(y))+(z*math.cos(y))+w + (.75*math.pi*2))

end