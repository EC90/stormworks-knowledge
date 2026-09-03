-- source: steam id 2836937357 / vehicle.xml block#22
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
s=screen
sc=s.setColor
dl=s.drawLine
dtx=s.drawText


function onTick()
	time=input.getNumber(1)
	LANG=input.getNumber(2)
end

function onDraw()

sc(200,200,200)
if LANG == 1
then
dtx(13,33,"Welcome Aboard")
end
if LANG == 2
then
dtx(18,33,"Kalosorisate")
end
if LANG == 3
then
dtx(3,33,"Willkommen an Bord")
end
if LANG == 4
then
dtx(5,33,"Vitejte na palube")
end
if LANG == 5
then
dtx(8,33,"Bienvenue a bord")
end

dtx(4,57,"Local time:")
screen.drawText(62, 57, string.format("%.2f" , time))
dtx(4,12,"A321-200")

sc(0,64,225)
dl(88,2,93.25,2.25)
dl(87,3,92.25,3.25)
dl(86,5,91.25,5.25)
dl(85,6,90.25,6.25)
dl(84,8,89.25,8.25)
dl(83,9,88.25,9.25)
dtx(4,3,"b2")
sc(44,112,181)
dl(0,54,96.25,54.25)
dl(80,6,80.25,7.25)
dl(77,5,79.25,5.25)
dl(80,3,80.25,4.25)
dl(77,3,80.25,3.25)
dl(75,3,75.25,7.25)
dl(73,5,73.25,7.25)
dl(70,5,73.25,5.25)
dl(70,5,70.25,7.25)
dl(70,3,73.25,3.25)
dl(68,3,68.25,7.25)
dl(65,3,68.25,3.25)
dl(65,7,68.25,7.25)
dl(63,3,63.25,7.25)
dl(60,3,63.25,3.25)
dl(60,3,60.25,7.25)
dl(55,7,58.25,7.25)
dl(55,5,58.25,5.25)
dl(55,3,58.25,3.25)
dl(0,9,80.25,9.25)


end