-- source: steam id 2793900947 / vehicle.xml block#31
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
old1=0
old2=0
old3=0
old4=0
old5=0
old6=0
old7=0
old8=0
gn=input.getNumber
gb=input.getBool
function onTick()
t1v=gn(1)
t2v=gn(5)
t3v=gn(9)
t4v=gn(13)
t5v=gn(17)
t6v=gn(21)
t7v=gn(25)
t8v=gn(29)			 
t1d=gb(1)
t2d=gb(2)
t3d=gb(3)
t4d=gb(4)
t5d=gb(5)
t6d=gb(6)
t7d=gb(7)
t8d=gb(8)
	d1=t1v-old1
	old1=t1v
	t1cv=d1*-60
	d2=t2v-old2
	old2=t2v
	t2cv=d2*-60
	d3=t3v-old3
	old3=t3v
	t3cv=d3*-60
	d4=t4v-old4
	old4=t4v
	t4cv=d4*-60
	d5=t5v-old5
	old5=t5v
	t5cv=d5*-60
	d6=t6v-old6
	old6=t6v
	t6cv=d6*-60
	d7=t7v-old7
	old7=t7v
	t7cv=d7*-60
	d8=t8v-old8
	old8=t8v
	t8cv=d8*-60
		t1dv=(t1cv>=30)
		t2dv=(t2cv>=30)
		t3dv=(t3cv>=30)
		t4dv=(t4cv>=30)
		t5dv=(t5cv>=30)
		t6dv=(t6cv>=30)
		t7dv=(t7cv>=30)
		t8dv=(t8cv>=30)
			t1l=t1dv and t1d
			t2l=t2dv and t2d
			t3l=t3dv and t3d
			t4l=t4dv and t4d
			t5l=t5dv and t5d
			t6l=t6dv and t6d
			t7l=t7dv and t7d
			t8l=t8dv and t8d
				launchcommand=t1l or t2l or t3l or t4l or t5l or t6l or t7l or t8l
				output.setBool(13, launchcommand)
end