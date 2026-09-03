-- source: steam id 1969765716 / vehicle.xml block#25
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
function pid(p,i,d)
    return{p=p,i=i,d=d,E=0,D=0,I=0,
		run=function(s,sp,pv)
			local E,D,A
			E = sp-pv
			D = E-s.E
			A = math.abs(D-s.D)
			s.E = E
			s.D = D
			s.I = A<E and s.I +E*s.i or s.I*0.5
			return E*s.p +(A<E and s.I or 0) +D*s.d
		end
	}
end

function onTick()
	switch = input.getBool(1)
	pd = input.getNumber(3)
	pid1 = pid(pd,1, pd)
	x = input.getNumber(1)
	pv1 = input.getNumber(2)
	if not switch then setpoint=x+(0.0000011257*x^3+0.00081888*x^2+0.0019329*x-0.00011981)
	else setpoint=x+(0.00000071820*x^3+0.000080226*x^2+0.035166*x-0.56486) end
	output.setNumber(1,pid1:run(setpoint,pv1))
end