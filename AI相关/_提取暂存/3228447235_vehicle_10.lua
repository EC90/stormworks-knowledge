-- source: steam id 3228447235 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228447235
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
m=math
s=m.sin
c=m.cos
t=m.tan
pi=m.pi
pi2=pi*2

function onTick()
	lx,ly=iN(9),iN(10)
	ax=m.ceil((0.5+lx)*999)
	ay=m.ceil((0.5+ly)*999)
	look=ay*10^3+ax
	
	oN(1,look)
end