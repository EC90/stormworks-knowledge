-- source: steam id 3524040776 / vehicle.xml block#17
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--0~999 to 10 bit bool
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
PT=property.getText
M=math
Ma=M.abs
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P=pi*2
function d2b(d)
	local b=''
	while d>0 do
		local r=d%2
		b=r..b
		d=mF(d/2)
	end
	if b=='' then b='0' end
	if string.len(b)<10 then
		local zs=10-string.len(b)
		for i=1,zs do
			b='0'..b
		end
	end
	return b
end
function onTick()
	txout=d2b(M.min(M.max(Mf(GN(11)),0),999))
	for i=1,10 do
		SB(i,string.sub(txout,i,i)=='1')
	end
end