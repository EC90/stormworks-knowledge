-- source: steam id 3793581819 / vehicle.xml block#35
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
ign=input.getNumber
igb=input.getBool
osn=output.setNumber
osb=output.setBool

tar=property.getNumber("Max Target")*4
a=tar/4

F={}
v1={}
v2={}

function Table(num)
	for i=1,num do
	F[i]={0, 0, 1, 0, 0, 0}
	end

	for i=1,num do
	v1[i]=0
	v2[i]=0
	end
end

Table(tar)

function onTick()
	for i=1,tar do
	Filter(i)
	end
	for i=1,a do
	n=i+(i-1)*3
	v2[i]=math.max(math.min(math.floor(ign(n))/500,0.99),0.9)
	v1[i]=1-v2[i]
	end
end

function Filter(num)
	if (num%4)==0 then
	n2=num/4
	else
	n2=math.ceil(num/4)
	end
	F[num][1]=F[num][3]+v1[n2]
	F[num][2]=F[num][1]/(F[num][1]+v2[n2])
	F[num][3]=(1-F[num][2])*F[num][1]
	F[num][5]=F[num][4]
	F[num][4]=F[num][6]
	F[num][6]=F[num][2]*(ign(num)-F[num][5])+F[num][4]
	osn(num, F[num][6])
	osb(num,igb(num))
end
