-- source: steam id 3430170617 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3430170617
I=input
O=output
P=property
ign=I.getNumber
igb=I.getBool
osn=O.setNumber
osb=O.setBool
pgn=P.getNumber
pgb=P.getBool

max_tgt=pgn("Max Target")

function onTick()
	for i=1,max_tgt do
	numi=(i-1)*4
	numo=(i-1)*3

	osn(numo+1,ign(numi+1))
	osn(numo+2,ign(numi+2))
	osn(numo+3,ign(numi+3))
	osb(i,igb(i))
	end
end