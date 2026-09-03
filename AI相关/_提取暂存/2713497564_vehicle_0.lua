-- source: steam id 2713497564 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2713497564
igN=input.getNumber
osN=output.setNumber


--Simple Moving Average (SMA)
n=20
SMA={}
for i=1,n do
	SMA[i]=0
end


--First-Order Exponential Smoothing (FES)
--Second-Order Exponential Smoothing (SES)
a=0.01
m=0
s_m=0



function onTick()
	sig=igN(1)
	method=igN(2)		
	
	
	if method==0 then --Simple Moving Average (SMA)
		for i=n,2,-1 do 
			SMA[i]=SMA[i-1]
		end
		SMA[1]=sig
		sum=0
		for i=1,n do
			sum=sum+SMA[i]
		end
		sig_smoothed=sum/n
	elseif method==1 then --First-Order Exponential Smoothing (FES)
		m=a*sig+(1-a)*m
		sig_smoothed=m
	elseif method==2 then --Second-Order Exponential Smoothing (SES)
		m=a*sig+(1-a)*m
		s_m=a*m+(1-a)*s_m
		sig_smoothed=2*m-s_m+a/(1-a)*(m-s_m)
	end
	
	
	osN(1,sig_smoothed)		
end