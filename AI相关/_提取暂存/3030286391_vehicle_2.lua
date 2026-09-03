-- source: steam id 3030286391 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3030286391
pi=math.pi
co=math.cos
si=math.sin

function rotX(x,r)
    return {x[1],co(r)*x[2]-si(r)*x[3],si(r)*x[2]+co(r)*x[3]}
end
function rotY(x,r)
    return {co(r)*x[1]+si(r)*x[3],x[2],-si(r)*x[1]+co(r)*x[3]}
end
function rotZ(x,r)
    return {co(r)*x[1]-si(r)*x[2],si(r)*x[1]+co(r)*x[2],x[3]}
end

function onTick()
    ex,ey,ez=input.getNumber(4),input.getNumber(5),input.getNumber(6)
	deg=((property.getNumber('Output')==1) and true or false)
    
    v1={0,0,1}
    v1=rotZ(rotY(rotX(v1,ex),ey),ez)
    hdg=math.atan(v1[1],v1[3])
    elv=math.atan(v1[2],math.sqrt(v1[1]^2+v1[3]^2))
    
    v2={1,0,0}
    v2=rotZ(rotY(rotX(v2,ex),ey),ez)
    
    v3={1,0,0}
    v3=rotY(rotX(v3,elv),hdg)
    
    crs={v2[2]*v3[3]-v2[3]*v3[2],v2[3]*v3[1]-v2[1]*v3[3],v2[1]*v3[2]-v2[2]*v3[1]}    --sin
	sgn=(v1[1]*crs[1]+v1[2]*crs[2]+v1[3]*crs[3]>=0) and 1 or -1
	crs=math.sqrt(crs[1]^2+crs[2]^2+crs[3]^2)*sgn
    dot=v2[1]*v3[1]+v2[2]*v3[2]+v2[3]*v3[3]    --cos
    rol=math.atan(crs,dot)

	if deg then
		rol=math.deg(rol)
		elv=math.deg(elv)
		hdg=math.deg((hdg+pi*2)%(pi*2))
	end
    
    output.setNumber(1,rol)
    output.setNumber(2,elv)
    output.setNumber(3,hdg)    
end