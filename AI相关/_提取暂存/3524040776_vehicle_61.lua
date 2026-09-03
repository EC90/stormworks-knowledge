-- source: steam id 3524040776 / vehicle.xml block#61
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--for scope
mntx=9*32
mnty=5*32
function onTick()
	lookx=input.getNumber(9)
	looky=input.getNumber(10)
	click=input.getBool(1)
	cursorx=math.min(math.max(math.floor(mntx*0.5+lookx*mntx*1.5+0.5),0),mntx)
	cursory=math.min(math.max(math.floor(mnty*0.5-looky*mnty*3+0.5),0),mnty)
	output.setNumber(1,mntx)
	output.setNumber(2,mnty)
	output.setNumber(3,cursorx)
	output.setNumber(4,cursory)
	output.setBool(1,click)
	output.setBool(3,true)
end