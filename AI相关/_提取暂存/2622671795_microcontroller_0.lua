-- source: steam id 2622671795 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2622671795
KF={}

function kalmanFilter(data)
	if #KF==0 then
		for key,value in pairs(data) do
			pminus=1+Q
			k=pminus/(pminus+R)
			p=(1-k)*pminus
			KF[key]={xhatminus=0,pminus=pminus,k=k,xhat=k*value,p=p}
		end
	else
		for key,value in pairs(data) do
			xhatminus=KF[key].xhat
			pminus=KF[key].p+Q
			k=pminus/(pminus+R)
			xhat=xhatminus+k*(value-xhatminus)
			p=(1-k)*pminus
			KF[key]={xhatminus=xhatminus,pminus=pminus,k=k,xhat=xhat,p=p}
		end
	end
end

function onTick()
	value = input.getNumber(1)
	Q,R=property.getNumber('Q'),property.getNumber('R')
	kalmanFilter({x=x})
	output.setNumber(1, KF.x.xhat)
end

function onDraw()
end