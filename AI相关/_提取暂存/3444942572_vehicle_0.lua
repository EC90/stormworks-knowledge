-- source: steam id 3444942572 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3444942572
randFrequency = math.random(10000,2^24)
randPassword = math.random(-2^24,2^24)

randFrequency = 0
randPassword = 0
function onTick()

    start = input.getBool(7)
	randomishthing = input.getNumber(30)
    if start and randFrequency == 0 then
        randFrequency = randomishthing
        randPassword = (randomishthing*23664)%2638159
    end
    
    output.setNumber(20,randFrequency)
    output.setNumber(21,randPassword)
    output.setNumber(1,input.getNumber(1))
    output.setNumber(2,input.getNumber(2))
    output.setNumber(3,input.getNumber(3))
    output.setNumber(4,input.getNumber(4))
	output.setNumber(5,input.getNumber(29))

    output.setBool(1,input.getBool(1))
    output.setBool(2,input.getBool(2))
    output.setBool(3,input.getBool(3))
    output.setBool(4,input.getBool(4))
    output.setBool(5,input.getBool(5))
    output.setBool(6,input.getBool(6))
	output.setBool(7,input.getBool(31))
    output.setBool(20,start)

end