-- source: steam id 2778980873 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2778980873
ipGN = input.getNumber
dcx = 0
dcy = 0
dcz = 0
dtx = 0
dty = 0
dtz = 0
btt = 0
thresh = 5

function onTick()
tx = ipGN(1)
ty = ipGN(2)
tz = ipGN(3)
cx = ipGN(4)
cy = ipGN(5)
cz = ipGN(6)
btt = ipGN(7)
laser = input.getBool(29)
lead = property.getBool("Leading")

tti=property.getNumber('Weapon Type')//1|0
params={
	{28},
	{28},
	{28},
	{26},
	{24},
	{28},
	{25},
	{50},
	}
	if lead and not laser then
		txdelta = (tx-dtx)
		dtx = tx
		tydelta = (ty-dty)
		dty = ty
		tzdelta = (tz-dtz)
		dtz = tz
		cxdelta = (cx-dcx)
		dcx = cx
		cydelta = (cy-dcy)
		dcy = cy
		czdelta = (cz-dcz)
		dcz = cz

		btt = btt + params[tti][1]

		x = tx + ((txdelta - cxdelta)*btt)
		y = ty + ((tydelta - cydelta)*btt)
		z = tz + ((tzdelta - czdelta)*btt)
	else
		x = tx
		y = ty
		z = tz
	end
if (tx == 0 and ty == 0 and tz == 0) or (tx >=cx - thresh and tx <=cx + thresh and ty >=cy - thresh and ty <=cy + thresh) and lead then
x = 0
y = 0
z = 0
end
output.setNumber(1, x)
output.setNumber(2, y)
output.setNumber(3, z)
end

