-- source: steam id 2403178838 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2403178838
gN = input.getNumber
gB = input.getBool
sC = screen.setColor
oN = output.setNumber
m = math
fl = m.floor
ab = m.abs
ce = m.ceil
de = m.deg
at = m.atan
si = m.sin
co = m.cos
b = 13125
d = 1250
c = d/2
e = -1
x = c

function df(A,B,C,D,E)
	m = A+D*E
	return m>B and C+(m-B-D) or m<C and B+(m-C+D) or m
end

function onTick()
	if gB(1) == false then
		n = 0
	end
	n = 0
	if n ~= 1 then
		x = df(x,b,c,d,1)
		n = 1
	end
	oN(32,x/100000)
	oN(1,df(x,b,c,d,e))
	oN(2,b)
	oN(3,c)
	oN(4,d)
end
--caution!! Do not input too small a value! OK? YOU