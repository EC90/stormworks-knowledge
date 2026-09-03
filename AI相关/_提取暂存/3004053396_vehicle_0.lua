-- source: steam id 3004053396 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3004053396
gn,ob,on = input.getNumber,output.setBool,output.setNumber

tbl={}
tbla={}
tblb={}

function thld(x) return x>0 and x<0.26 end

function onTick()
count=0
LA = thld(gn(25)) and thld(gn(26)) and thld(gn(27))
LB = thld(gn(28)) and thld(gn(29)) and thld(gn(30))

for i=1,24 do 
	tbl[i]=gn(i) 
		if tbl[i] ~=0 then
			count=count+1
		end
	end

for i=1,4 do 
	tbla[i]=tbl[(i*3)-2]+tbl[(i*3)-1]+tbl[i*3] 
	tblb[i]=tbl[(i*3)+10]+tbl[(i*3)+11]+tbl[(i*3)+12] 
end

	a1 = tbla[1]==0 and tbla[3]==0 
	a2 = tbla[2]==0 and tbla[4]==0
	b1 = tblb[1]==0 and tblb[3]==0 
	b2 = tblb[2]==0 and tblb[4]==0
	
	ob(1,a1 and a2) ob(2,a1) ob(3,a2) ob(4,b1) ob(5,a2) on(1,count)
	ob(6,LA) ob(7,LB)

end

