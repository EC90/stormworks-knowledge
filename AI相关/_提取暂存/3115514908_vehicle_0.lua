-- source: steam id 3115514908 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3115514908
bools = {}
isHeld = {}
reset = false
function onTick()
   for i = 1, 32 do
      if bools[i] and input.getBool(i) and not isHeld[i] then
         -- If we pressed a button and it's already on, then turn everything off.
         bools = {}
         reset = true
      end
      if input.getBool(i) and not (isHeld[i] or reset) then
         -- If we pressed a button and it's not already on, then turn this one on and turn everything else off.
         bools = {}
         bools[i] = true
      end
      output.setBool(i, bools[i])
      isHeld[i] = input.getBool(i)        
   end
   reset = false
end