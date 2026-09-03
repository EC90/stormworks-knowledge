-- source: steam id 3793341737 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793341737
last = 0
light = false
function onTick()

cur = input.getNumber(1)

if last >= cur then light = true else light = false end

last = cur
output.setBool(1, light)

end