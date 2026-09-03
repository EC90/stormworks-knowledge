-- source: steam id 2902431068 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2902431068
d=math;e=input;i=output;
b={}function onTick()for a=1,16,1 do b[a]=e.getNumber(2*a-1)f=e.getNumber(30)end;g=e.getNumber(32)c=68.2454-(1.1-f)+d.random()/2;i.setNumber(2,c+27)for a=1,16,1 do if b[a]~=0 then h=d.min(d.abs(g-b[a]),1-d.abs(g-b[a]))c=c+32.25424*(0.5-h)*(0.5-h)*(4+d.random()/3)end end;if f<0 then i.setNumber(1,c)end end