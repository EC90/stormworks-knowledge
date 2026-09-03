-- source: steam id 2902431068 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2902431068
d=table;g=input;i=ipairs;j=output;
a={}function onTick()b=0;c=g.getNumber(1)d.insert(a,{x=c})if#a>5 then d.remove(a,1)end;for h,e in i(a)do b=b+e.x end;f=b/#a;j.setNumber(1,f)end