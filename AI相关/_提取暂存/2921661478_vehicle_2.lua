-- source: steam id 2921661478 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2921661478
--Radar Missile Detection. Made by PlakToetsBart

--Variabelen Declareren
SecPulse = false;
PreviousTick = 0;
CurrentTick = 0;
TicksPerSecond = 60;
bRadarAlmLock = false;
bAlarmPulse = false
almPulse = false
almPulsePrev = 0
almPulseIntv = 5 -- Interval van de alm lock uitgang

function onTick()
  CurrentTick = CurrentTick + 1;
 
 SecPulse = false
 if CurrentTick - PreviousTick > TicksPerSecond then 
	PreviousTick = CurrentTick
	SecPulse = true
 end


  bAlarmPulse = input.getBool(1)
  
  if not bRadarAlmLock and bAlarmPulse and SecPulse then
      bRadarAlmLock = true
  end 
  if bRadarAlmLock and not bAlarmPulse and SecPulse then 
	  bRadarAlmLock = false
  end

  if CurrentTick - almPulsePrev > almPulseIntv then
	almPulse = not almPulse
	almPulsePrev = CurrentTick
  end


  output.setBool(31, bRadarAlmLock and almPulse)
  output.setBool(32, bAlarmPulse or bRadarAlmLock)
end
 


--Debug monitor schrijven
function onDraw()
  
  screen.drawText(2, 2, "Ticks: " .. CurrentTick);
  screen.drawText(2, 12, "Sensor: " .. tostring(bAlarmPulse));
  if bRadarAlmLock then
     screen.drawText(2, 22, "!!ALARM Lock!!");   
  end

end
