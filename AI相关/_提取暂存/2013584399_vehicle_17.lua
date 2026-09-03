-- source: steam id 2013584399 / vehicle.xml block#17
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2013584399
function onTick()

	fls = input.getNumber(1)*10
	fkm = input.getNumber(2)
	fr = input.getNumber(3)
	tf = input.getNumber(4)
	f = input.getNumber(5)
	
	ctr=property.getNumber("Color Text R")
	ctg=property.getNumber("Color Text G")
	ctb=property.getNumber("Color Text B")
	cnr=property.getNumber("Color Numbers R")
	cng=property.getNumber("Color Numbers G")
	cnb=property.getNumber("Color Numbers B")
	csr=property.getNumber("Color Streaks R")
	csg=property.getNumber("Color Streaks G")
	csb=property.getNumber("Color Streaks B")
	
	
	
	
	
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	screen.setColor(csr,csg,csb)
        screen.drawRectF(0,3,64,9)
    screen.setColor(10,10,10)
        screen.drawRectF(0,4,64,7)


    screen.setColor(3,3,3)
        screen.drawRectF(0,19,43,5)
    screen.setColor(3,3,3)
        screen.drawRectF(45,19,19,5)

    screen.setColor(3,3,3)
        screen.drawRectF(0,26,43,5)
    screen.setColor(3,3,3)
        screen.drawRectF(45,26,19,5)

    screen.setColor(3,3,3)
        screen.drawRectF(0,33,43,5)
    screen.setColor(3,3,3)
        screen.drawRectF(45,33,19,5)

    screen.setColor(3,3,3)
        screen.drawRectF(0,40,43,5)
    screen.setColor(3,3,3)
        screen.drawRectF(45,40,19,5)

    screen.setColor(3,3,3)
        screen.drawRectF(0,54,23,5)
    screen.setColor(3,3,3)
        screen.drawRectF(25,54,44,5)


	screen.setColor(ctr,ctg,ctb)
	screen.drawText(0,5,"Fuel Computer")
	screen.drawText(1,19,"l/sec:")
	screen.drawText(1,26,"l/km :")
	screen.drawText(1,33,"Range km:")
	screen.drawText(1,40,"Time min:")
	screen.drawText(1,54,"Fuel:")

	screen.setColor(cnr,cng,cnb)
	screen.drawText(45,19,math.floor(fls)/10)
	screen.drawText(45,26,math.floor(fkm))
	screen.drawText(45,33,math.floor(fr))
	screen.drawText(45,40,math.floor(tf))
	screen.drawText(25,54,math.floor(f))

	
					
end
						

						

