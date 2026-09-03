-- source: steam id 2891959205 / vehicle.xml block#27
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891959205
--ticks to average
ta=30
igb=input.getBool
ign=input.getNumber
osn=output.setNumber
osb=output.setBool
CurD,CurA,CurE={},{},{}
AD,AA,AE={},{},{}
for i=1,8 do
	CurD[i],CurA[i],CurE[i]={},{},{}
end
function avg(n,v,t)
	table.insert(n,v)
	if #n>t then
		table.remove(n,1)
	end
	sum=0
	for i=1,#n do
		sum=sum+n[i]
	end
	return sum/#n
end
function onTick()
	--prepare base data
	for i=1,8 do
		if ign(-3+4*i)>0 then
			AD[i]=avg(CurD[i],ign(-3+4*i),ta)
			AA[i]=avg(CurA[i],ign(-2+4*i),ta)
			AE[i]=avg(CurE[i],ign(-1+4*i),ta)
		else
			AD[i]=0
			AA[i]=0
			AE[i]=0
		end
	end
	--expt rst
	for i=1,#AD do
		osn(-3+4*i,AD[i])
		osn(-2+4*i,AA[i])
		osn(-1+4*i,AE[i])
	end
end