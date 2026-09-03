-- source: steam id 3584922070 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3584922070
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pN=property.getNumber
pB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
sqrt=M.sqrt
asin=M.asin
atan=M.atan
exp=M.exp
pi=M.pi
pi2=M.pi*2

width=pN("Width")
function onTick()
	ad=GN(8)
	speed=GN(7)
	length=dis({GN(1)-GN(4),GN(2)-GN(5),GN(3)-GN(6)})
	curvature_scale=GN(12)
	max_Gforce=GN(11)*10
	turning_center_static=GN(9)
	turning_center_scale=GN(10)
	turning_center=length-turning_center_static-speed*turning_center_scale
	
	max_curvature_wheelbase=1/curvature_scale
	max_curvature_gforce=max_Gforce/(speed^2)
	max_curvature=min(max_curvature_wheelbase,max_curvature_gforce) 
	curvature=ad*max_curvature
	if abs(curvature)>0.00001 then
		L=atan(turning_center/(1/(-curvature)-width/2))/pi2*8
		R=-atan(turning_center/(1/(-curvature)+width/2))/pi2*8
	else
		L=0
		R=0
	end
	SN(1,L)
	SN(2,R)
	SN(3,curvature_scale)
end
	
function min(x,y) 
	if x<y then
		return x
	else
		return y
	end
end
function dis(y) return sqrt(y[1]^2+y[2]^2+y[3]^2) end
function clamp(x,a,b)
	if x<a then x=a end
	if x>b then x=b end
	return x
end