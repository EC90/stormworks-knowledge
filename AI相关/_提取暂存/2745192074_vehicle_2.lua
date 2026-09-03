-- source: steam id 2745192074 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2745192074
dis = {}
yaw={}
pitch={}
for i=1, 8 do
	table.insert(dis, 0)
	table.insert(yaw, 0)
	table.insert(pitch, 0)
end


function onTick()
	
	for i=1,32,4 do
		dis[math.floor((i-1)/4+1)]=input.getNumber(i)
		yaw[math.floor((i-1)/4+1)]=input.getNumber(i+1)
		pitch[math.floor((i-1)/4+1)]=input.getNumber(i+2)
	end
	
	min=dis[1]
	mini=1
	for i=2,8 do
		if min > dis[i] and dis[i] ~= 0 then
			mini=i
			min=dis[i]
		end
	end
	
	output.setNumber(1,dis[mini])
	output.setNumber(2,yaw[mini])
	output.setNumber(3,pitch[mini])
	
end