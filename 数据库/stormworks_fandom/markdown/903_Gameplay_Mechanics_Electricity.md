---
title: "Gameplay/Mechanics/Electricity"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Mechanics/Electricity"
page_id: 903
revision_id: 4604
revision_timestamp: "2025-08-16T13:38:13Z"
retrieved_at: "2026-08-31T10:02:20+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: []
---
# Gameplay/Mechanics/Electricity

Electricity is used to power electrical components. Most functional components consume electricity at least slowly, while others such as motors, engine starters, and radar rapidly consume electricity. Electricity can be generated using generators and solar panels and stored in batteries for later use.

When the infinite electricity option is enabled, all electrical components will operate at full capacity (SV @ 1) regardless of whether or not a fully-charged power source is connected.

This page was last updated for Stormworks [V1.15.2](https://stormworks.fandom.com/wiki/V1.15.2) (14 August 2025).

## Units

Stormworks doesn't use real-life units of electricity and there is no in-game explanation of these topics, so the explanations in this article are based on experiments and the terms used are based upon common terminology between players.

Voltage works based on the battery charge level, called SV (SVolts or Stormworks Volt) which is proportional to battery charge level between 0-1. The SV proportionally affects components which consume electricity, for example a motor will run half as fast at SV=0.5 compared to SV=1. There's no way to get SV above 1, so there's no difference between linking batteries in parallel or in series.

The rate of energy transfer (power production/consumption) is measured in Swatts. Generator and solar panel output is measured in this unit.

The unit of energy is generally called Swatt-seconds (SWs or Stormworks Watt seconds). This is the amount of energy transferred each second at a rate of 1 swatt. Battery capacity is measured in SWs.

For example, a small battery has a capacity of 1600SWs. A solar panel pointed directly at the sun without rain or fog has a power output of 0.0027 swatts. Thus, 100 solar panels pointed at the sun could fully charge a small battery in 5,926 seconds which is approximately one hour and 39 minutes.

## Storage

Batteries are necessary components for every vehicle to store electricity as energy.

There are four batteries available:

Battery Small

[![Battery Small](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f9/Battery_Small.jpg/revision/latest/scale-to-width-down/100?cb=20190317005248)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f9/Battery_Small.jpg/revision/latest?cb=20190317005248)

- Stores 1600 SWs
- $150, mass=10
- Shape 1 X 2 X 1
- (160 SWs/mass unit, 267 SWs/block, 11 SWs/$)

Battery Medium

[![Battery Medium](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d1/Battery_Medium.jpg/revision/latest/scale-to-width-down/100?cb=20190317005237)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d1/Battery_Medium.jpg/revision/latest?cb=20190317005237)

- Stores 12800 SWs
- $1200, mass=60
- Shape 3 X 2 X 2
- (213 SWs/mass unit, 1066 SWs/block, 11 SWs/$)

Battery Large

[![Battery Large](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/8a/Battery_Large.jpg/revision/latest/scale-to-width-down/100?cb=20190317005232)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/8a/Battery_Large.jpg/revision/latest?cb=20190317005232)

- Stores 256000 SWs
- $10000, mass=800
- Shape 7 X 5 X 5
- (320 SWs/mass unit, 1462 SWs/block, 26 SWs/$)

Hardpoint Connector Attachment

[![Hardpoint Connector](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/4/4e/Hardpoint_Connector.png/revision/latest?cb=20221009062735)

- Stores 300 SWs
- $20, mass=2
- Shape 1 X 1 X 2 (Physics Hitbox 1 X 1 X 1)
- (150 SWs/mass unit, 150 SWs/block, 15 SWs/$)

Larger batteries are better than multiple smaller batteries because they will weigh less and take up less space.

As with normal electrical connections, batteries can be connected in parallel or in series to any component requiring power.

## Production

Electricity to recharge batteries can be produced in four different ways: generators, solar panels, recharge stations, and electric chargers.

### Generators

There are three standalone generators plus the alternator used in modular engines:

Generator Small

[![Generator Small](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/ab/Generator_Small.jpg/revision/latest?cb=20190317005337)

- Generator constant (GC) = 0.00642
- $600, mass=5
- Shape 1 X 1 X 1

Generator Medium

[![Generator Medium](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/c/c2/Generator_Medium.jpg/revision/latest?cb=20190317005330)

- Generator constant (GC) = 0.24100
- $2000, mass=100
- Shape 3 X 3 X 3

Generator Large

[![Generator Large](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/96/Generator_Large.jpg/revision/latest?cb=20190317005322)

- Generator constant (GC) = 1.13800
- $12000, mass=400
- Shape 5 X 5 X 5

Alternator

[![Alternator](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/66/Alternator.png/revision/latest?cb=20250814152049)

- Generator constant (GC) = 0.00540
- $30, mass=1
- Shape 1 X 1 X 1

Generators convert mechanical power to electricity. Mechanical power can be created by a variety of components such as [diesel engines](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Propulsion/DieselEngines), jet engines, and torque cranks (hand cranks). Diesel and jet engines require fuel to run but can produce high torque and RPS while torque cranks rely on interaction by the player and produce relatively low torque and RPS.

Electrical power production can be calculated as follows:

Power (Swatts) = RPS^2*GC

For example, a torque crank with three 3:1 gearboxes (arrows pointing towards it) connected to a small generator will turn at 0.5104 rps. Because of the gearboxes, this will turn the small generator at 13.73 rps. We expect this to make 13.73^2*0.00642 = 1.21 swatts, and can verify from the generator that it does produce 1.21 swatts. If we use this to charge a small battery and look at the rate at which the battery charges, multiplying its per-second delta (i.e. per-tick delta x 60) by its expected total charge of 1,600 SWs, we get the same result with a charge rate of 1.21 swatts.

For another example, a small diesel engine with a 3:2 gearbox (arrows pointing at the engine) connected to a medium generator will turn at 8.16 RPS. With the gearbox, this will turn the generator at 12.2 rps. We expect this to make 12.2^2*0.24100 = 35.9 swatts, and can verify from the generator that it does produce 35.9 swatts. If we use this to charge a medium battery (using the same approach as above), we can again confirm that the battery charges at the expected rate of 35.9 swatts.

### Solar Panels

Solar panels convert the sun's energy into electricity at a very slow rate. Solar panels are expensive and heavy for the small amount of power they provide.

A solar cell (1x1) costs $400, weighs 2 units, provides a peak of 0.0027 swatts (when directly facing the sun with no fog or rain), and provides no power at night.

A large solar cell (5x5) costs $8,000, weighs 40 units, and provides a peak of 0.068 swatts when directly facing the sun without fog or rain (25 times the 1x1 solar cell).

### Recharge Stations

Recharge stations are found near all workbenches where vehicles are spawned and can supply electricity to charge a vehicle's batteries via an electrical cable anchor. Recharge stations are painted yellow with two black lightning bolt icons. A cable can be found in an equipment inventory slot attached to each recharge station.

Recharge stations charge at a maximum rate of 400 swatts (for a single, fully depleted battery), but the charge rate approaches zero as the battery approaches full charge. Additional batteries increase the charge rate, but it is not linear (e.g. 5 fully depleted batteries charge at a little bit over 800 swatts, instead of 2,000 as might be expected).

### Electric chargers

Electric chargers are parts that take power from one system and deliver it to another. They draw and deliver power with 100% efficiency at a maximum rate of 0.6 swatts. The rate shows linear dependence with the charge of the source (SV), so a 50% charged source delivers energy half as quickly. Note that it doesn't matter if the source has less charge than the destination, for example, a 10% charged battery can be used to charge a battery which is 90% full, although it would charge quite slowly at just 0.06 swatts.

Note that a single electric charger can become infinitely efficient when using a large battery as its input source. It will deliver power without taking power, with power still being supplied at the usual slow rate. However, no charge will occur if the battery is connected to both the input and output side of the charger; at least two batteries must be used with the source being a large battery to get this benefit. Also note that using multiple electric chargers drawing from a single large battery will deplete it as usual.

## Consumption

### Fixed consumption

With full battery charge, these components always draw the same amount of power:

- Mounted welder: 30.2 swatts
- RX Directional (Large) [on]: 23.8 swatts
- RX Directional [on]: 18.3 swatts
- RX Directional (Large) [off]: 5.49 swatts
- RX Directional [off]: 3.66 swatts
- Radar (AWACS): 2.75 swatts
- Radar (dish): 0.92 swatts
- Radar (phalanx): 0.60 swatts
- Radar (basic): 0.37 swatts
- Radar (missile): 0.13 swatts
- Heater: 0.065 swatts
- Radio RX Huge: 0.054 swatts
- Radio RX Large: 0.014 swatts
- Transponder: 0.011 swatts
- Search Light: 0.011 swatts
- Rotating light: 0.011 swatts
- Light: 0.011 swatts
- Small spotlight: 0.011 swatts
- Camera Medium: 0.057 swatts
- Camera Small: 0.057 swatts
- Video xmit: 0.0057 swatts
- Radio RX Medium: 0.0057 swatts
- Radio RX Small: 0.0057 swatts
- Toggle / Push button: 0 swatts

### Variable consumption

#### Diesel engine starters

In the following section, the low value is without any load, e.g. using a clutch set to 0 to remove all strain on the engine. The high value is with a heavy load, e.g. 4x 3:1 gears and a propeller. Tests were done using a single large battery and confirmed with a single medium battery. Use of additional batteries was tested and confirmed to allow for increased maximum power draw (in a non-linear fashion that will require further analysis). However, since most vehicles use a single battery for engine starting, the maximum is simply reported as the maximum with a single battery.

- Large Engine [starter]: 35.7 up to 600 swatts
- Medium Engine [starter]: 11 up to 600 swatts
- Small Engine [starter]: 3.66 up to 340 swatts

## Sudden loss of power

- **Lightning:** A nearby lightning strike while in a vehicle above 120 m in altitude will cause power to go out for about 10 seconds. It will also trip any circuit breakers, and has a reportedly small chance to damage any components not protected by a circuit breaker.

- **EMP:** Similar to lightning, a nearby [EMP warhead](https://stormworks.fandom.com/wiki/Weapon_DLC#EMP_Warheads) being set off will cause vehicles to lose power. EMP range is approximately 500 meters. Engines will be shut down by this, even if they are already running, and even if their throttle is a constant value which doesn't depend on power. Circuit breakers will be tripped, and resetting them will not fix the issue. Power will start coming back on after 55 seconds, and will ramp back up to full power by 60 seconds.

- **Damage:** Vehicle damage can be caused by collisions, fire, or by attacks from various weapons. Damaged batteries will stop supplying power (and will still be fully drained even after being repaired, requiring recharging as well). However other components (even circuit breakers) will continue to relay power if damaged.

- **High drain:** Suddenly using large amounts of power can cause a decreased power supply to other components. For example, running a medium engine starter from a small battery while the engine is at full clutch can cause lights to flicker due to the large power draw, even though the battery may still have sufficient energy to run the lights normally after the engine has started.

## Notable effects of low/no power

- **Electric Motors:** An electric motor's speed will decrease as its power supply dwindles. Diesel-electric vehicles with insufficient power generation may slow down until they stop.

- **Engine starters:** Similar to motors, engine starters provide lower maximum RPS as power supply decreases. This can result in engine RPS being stuck below the minimum RPS (2.0) required to start the engine. Vehicles outfitted with an electrical cable anchor can be connected to another vehicle to draw power from its batteries, allowing one vehicle to jump-start another.

- **Lights:** Lights dim in low power and shut off when power is completely unavailable. This can make a vehicle interior extremely dark and difficult to navigate, though flashlights can mitigate this problem.

- **Powered doors:** Powered doors and hatches will open without power. This can break seals and cause flooding. Manually-operated doors and hatches can be used to reduce this risk.

- **Controls:** Many control components such as buttons and throttles (except keypads, microprocessor or controller seats) cannot be operated to change logic signal without power, even to operate components that don't require power like parachutes, flare launchers, machine guns, etc.

## Tips

- Power drain with engine startup can be reduced by using a clutch; engine RPS on startup can be improved by this as well. Release the clutch (set its clutch pressure to zero), then try to start the engine. Only re-engage the clutch when the engine is above 3 RPS.

- To avoid crashing as a result of lightning or EMP, aircraft can be equipped with a vehicle parachute triggered to activate with a loss of power. For example, a laser distance sensor within the vehicle will report whatever distance is between it and some other point of the vehicle it is pointed towards; when the power goes out, it will report zero distance. A microcontroller or an equals and a delay logic block could be used to detect when the reported distance becomes zero and stays that way longer than 10 seconds (indicating EMP, not just lightning), and use that to trigger the parachute release without requiring power to do so.

- Gradual loss of power can deplete a vehicle's batteries and leave it unable to start if left unattended for too long. This can be prevented by using a circuit breaker. Connect your batteries to one end of the breaker, then connect everything that draws power to the other end of it. An open circuit breaker effectively separates two circuits and no electricity will be consumed by the connected circuit until the breaker is closed again.

---

Source: [Gameplay/Mechanics/Electricity](https://stormworks.fandom.com/wiki/Gameplay/Mechanics/Electricity) · Revision 4604 · CC BY-NC-SA
