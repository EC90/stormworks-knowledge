---
title: "Wiki/Vehicles/Water/Boat"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Vehicles/Water/Boat"
page_id: 275
revision_id: 4599
revision_timestamp: "2025-08-15T13:24:54Z"
retrieved_at: "2026-08-31T10:13:02+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Vehicles"]
---
# Wiki/Vehicles/Water/Boat

**Boats** are one of the types of vehicle players can design and operate for their sea rescue service in *[Stormworks: Build and Rescue](https://stormworks.fandom.com/wiki/Stormworks:_Build_and_Rescue)*.

This page was last updated for [V1.5.1](https://stormworks.fandom.com/wiki/V1.5.1) (18 July 2025).

## Overview of building a boat

[![A very simple boat design (19 blocks wide, 14 long, 5 high)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/63/Simple_Boat_Summary.png/revision/latest/scale-to-width-down/180?cb=20190211183623)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/63/Simple_Boat_Summary.png/revision/latest?cb=20190211183623)

[https://stormworks.fandom.com/wiki/File:Simple_Boat_Summary.png](https://stormworks.fandom.com/wiki/File:Simple_Boat_Summary.png)

A very simple boat design (19 blocks wide, 14 long, 5 high)

A minimal standard boat requires:

1. [Buoyancy](https://stormworks.fandom.com/wiki/Buoyancy) provided by a closed area within the ship
2. An engine to provide power
3. A propeller to turn power in to thrust (i.e move the boat!)
4. A rudder to permit steering left and right
5. A pilot seat to allow the captain to start the engine, control the throttle, and to steer

Stormworks provides a starter boat and starter sailboat preset which can be loaded in the editor to save time, or you can continue reading to learn how to make your own from scratch.

## Buoyancy

*Main article: *[Buoyancy](https://stormworks.fandom.com/wiki/Buoyancy)

The most important component of a typical boat is to ensure that it has a large enclosed area within the hull. This is typically below the main deck. It often contains the engine(s) for the vehicle. In overly simple terms, the amount of enclosed space in this area determines how much weight your boat can hold (its maximum *displacement*) - meaning how much weight the ship can carry before it starts to sink. If there is a 'hole' in this part of the ship, the boat will usually immediately sink when spawned in-game because it cannot hold its own weight.

## [Engines](https://stormworks.fandom.com/wiki/Wiki/Guides/Engine)

The simplest way to get a boat moving is with a built-in [diesel engine](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Propulsion/DieselEngines). Pipes will be needed to connect fuel to the engine from fluid tanks; to connect the engine's exhaust to Fluid Exhaust pipes; to connect air from a fluid port or air filter to the engine's air intake; to connect the engine's power output to a propeller (possibly using a clutch and/or gearbox in between); and to connect coolant from the engine to a radiator or heat exchanger and back to the engine. The engine will also require [electricity](https://stormworks.fandom.com/wiki/Electricity) from a battery, a logic input to tell it when to run its starter, and a logic input for its throttle setting.

Note that engines tend to be quite heavy and can easily shift a boat's center of mass. It's recommended to keep engines as close to the bottom of the hull as possible to improve stability and to make it easier to flip back upright if does capsize.

## [Propellers](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Propulsion)

Engines by themselves generate power, but converting that power into forward (and backward) movement requires propellers.

Note that propellers lined up above the [center of mass](https://stormworks.fandom.com/wiki/Wiki/Game_Mechanics/Center_of_Mass) may pitch the ship down into the water (in extreme cases causing the ship to dive, choke the engine, and stop), while propellers far below the center of mass may pitch the ship up all the way out of the water (in extreme cases causing it to hop around almost uncontrollably over waves). Propellers slightly below the center of mass can help to tilt the boat upwards and lift it slightly out of the water, thereby reducing drag and increasing speed.

## Steering

[![Rudder data connection](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/1/1a/Rudder_data_connection.png/revision/latest/scale-to-width-down/416?cb=20190211185922)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/1/1a/Rudder_data_connection.png/revision/latest?cb=20190211185922)

Boat steering can be done in a variety of ways. Rudders are among the easiest approach, though thrust pivoting, unequal propulsion, and lateral propulsion are all options as well.

### Rudders

[Rudders](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Vehicle_Control) allow the boat to turn by directing water to the sides of the boat as the boat moves forwards. This is their key limitation: they only work when the boat is moving forwards (or backwards). For boats that need to perform sharp turns or sometimes maneuver sideways, rudders are insufficient.

Normal rudders (not fin rudder) should be placed with the blocks at the top (on the underside of the boat) with the 'thin end' of the rudder pointing towards the back of the boat. In the Logic Data screen, rudders need to be connected to the A/D node of the pilot seat.

Rudders are often installed in a pair, with one at either side of the back of the boat (port and starboard). Note that if you use the symmetry tool when placing the rudders, they will counteract each other by trying to turn in opposite directions (as the symmetry tool flips them). They must be placed individually or else a separate logic arrangement to negate the turning instructions must be provided to one of the rudders.

### Thrust pivoting

The built-in preset [Starter Boat](https://stormworks.fandom.com/wiki/Starter_Boat) uses thrust pivoting. The engines at the back turn from one side to the other to steer the boat, causing their center of thrust to end up on different sides of the boat's [center of mass](https://stormworks.fandom.com/wiki/Center_of_mass), resulting in a yawing force. Similarly, according to its description, the azimuth thruster is intended for use on a robotic pivot so that it can provide lateral thrust to allow a ship to move sideways or turn sharply. [Fluid jets](https://stormworks.fandom.com/wiki/Fluid_jet) can work similarly, using thrust deflectors to provide lateral force for turning.

### Unequal propulsion

On a ship with at least two propellers, thrust on one propeller can be reduced, eliminated, or even reversed while the other propeller will both push the ship forward and turn it. With gearboxes or electric motors used to allow one propeller to reverse while the other goes forward, a ship can more or less turn on a dime.

### Lateral propulsion

Some large real-life ships have side-oriented propellers to allow them to move sideways towards a dock. These can also be used for turning if they are offset from the center of mass.

## Pilot Seat

A control seat (often a [pilot seat](https://stormworks.fandom.com/wiki/Wiki/Building/Components/User_Input) or [helm](https://stormworks.fandom.com/wiki/Wiki/Building/Components/User_Input)) is the easiest way of setting up controls for a simple boat, although various [throttles](https://stormworks.fandom.com/wiki/Wiki/Building/Components/User_Input) and buttons for control can be more satisfying.

A control seat, once placed, needs to be connected in the Logic Data screen to the components which it controls. W/S is usually used to control the throttle, while A/D is usually used to control the rudders, or power to lateral propellers.

Using the Select Tool, the pilot seat's Hotkey 1 can be set from 'push' to 'toggle' and used to control the on/off state of the engines. In the Logic Data screen, drag Hotkey 1 to the Engine On/Off node to connect it, then press '1' when in game to start the engines.

[![Hotkey set to toggle](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/7f/Hotkey_set_to_toggle.png/revision/latest/scale-to-width-down/682?cb=20190211185542)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/7f/Hotkey_set_to_toggle.png/revision/latest?cb=20190211185542)

## Stability and capsizing

Capsizing refers to when a ship is rolled and becomes stuck upside down or on its side. It is possible to design ships which cannot capsize and will passively self-right even if turned completely upside down, such as submarines. Ships can also be designed with a variety of active measures for stabilization, improved performance in high waves, and even to counteract/reverse being capsized.

### Static roll stability

Since capsizing always starts with rolling over too far to one side, a common approach to prevent it is to improve roll stability. Hulls can be modified as follows:

- Increase width: You can either make the ship wider, or use two or more parallel hull sections spaced apart with the center of mass in the middle of them (see catamaran below). Note that this has the disadvantage of also making the ship harder to turn upright again unless you also make the ship taller while keeping the center of gravity low.

- Keep heavy parts low: The heaviest parts (engine, battery) should be placed on the bottom of the hull to keep the center of mass low.

- Add weights: If the center of mass is still too high, you can add weight blocks to the bottom of the ship. The lower these weights are, the more effective they will be. This has the advantage of also making the ship easier to turn back upright if it does flip over, though the added weight may somewhat reduce fuel efficiency, speed, cargo capacity, and range, and a long keel may make it challenging to move the ship into shallow waters.

-
  - Weighted keels: Making a weighted keel beneath the ship (with some or all of the bottom row of the keel being weight blocks) is a simple approach to get the weights even lower so they provide more leverage (and thus, less weight is needed). However, a large, flat keel at the bottom of the ship can actually increase tendency to roll over when encountering waves from the side, as the ship will slide sideways as it goes down the wave and the flat side of the keel pushing sideways into the water will then convert that sideways movement into roll. With added wind blowing from the side as well, it can be very easy for a ship with a large, flat keel to roll and capsize.

-
  - Alternative: A generally better approach is to have a sloped or flat bottom without a keel. If the extra stability is required, a keel could be constructed with just a connecting strut going down to the row of weight blocks at the bottom. This is similar in concept to a modern [canting keel](https://en.wikipedia.org/wiki/Canting_keel) held in a fixed position, where the keel is simply a long, heavy weight at the bottom of the ship held in place by a strut. Using a pivot to make it into a true canting keel is also feasible.

### Static pitch stability

A common problem is for boats to ride up and down waves, potentially leaping into the air after going up a wave followed by diving underwater after they fall back down. Pitch instability can greatly reduce maximum speed in severe weather conditions. There are several approaches that can be used to address this problem:

- Increase length: A longer ship will tend to handle going up and down waves much more smoothly.

- Use a wave-piercing hull: A [wave-piercing hull](https://en.wikipedia.org/wiki/Wave-piercing_hull) has a minimalist bow (front) which looks like a rectangle from the side (no upward/downward slope), but a triangle from the top. The sides of the bow slope such that wave collisions just cause drag, rather than lift. There can still be pitching due to the bow being submerged while the stern (rear) is not, or vice versa, but the effect is at least reduced.

- Use a fan tail: The stern can be built with a slope such that it sticks out over the water. When the ship tilts backward, the sloped stern section normally above the water will dip down into the water and provide extra buoyancy to tilt the ship back into the correct orientation.

### Static balance

Ships may tip to one side ('list') when their center-of-mass is not directly below the center of the vehicle (center of buoyancy), increasing their risk of capsizing. This is most commonly a problem when heavy cargo on the vehicle is lopsided. Heavy cargo should be kept low and either centered or balanced with an equal weight of heavy cargo on the other side.

If your ship is tipping to one side upon spawn, your center of mass needs to be fixed. In the vehicle editor, there is an option on the right to show your center of mass, and weight blocks can be used to adjust it to one side or another.

If you have to deal with cargo sometimes causing your ship to tip to one side or the other, consider adding ballast tanks to each side of your ship. These can be filled with water to counterbalance any unequal roll forces, allowing you to correct the situation before the ship can be capsized. Note that ballast tanks fill/empty slowly and are not suitable for managing wave-induced roll (this requires dynamic stability).

### Dynamic stability

Dynamic stability is used for managing roll that occurs primarily due to waves. All dynamic stability methods require either a [gyro](https://stormworks.fandom.com/wiki/Wiki/Guides/Gyro), [microcontroller](https://stormworks.fandom.com/wiki/Wiki/Building/Microcontrollers), or PID controller. A gyro does not require any additional sensors, while microcontrollers or PID controllers will need sensors to provide the pitch and roll data. These devices can use a variety of control surfaces / propulsion methods to provide the force for active stabilization:

- Fins: Fins or fin rudders placed on either side of the ship can be used to provide roll force to counteract any wave-induced roll. This will obviously only work when the ship is in motion.

- Fluid jets: A ship propelled by [fluid jets](https://stormworks.fandom.com/wiki/Fluid_jet) can use their pitch trim value to provide some roll force to counteract wave-induced roll.

- Hydrofoils: Hydrofoils (control surfaces with a large area placed below the hull) can be used to not just prevent roll for stabilization, but also provide lift to get the ship out of the water, reducing drag as well as exposure to waves, thereby greatly enhancing speed, fuel efficiency, range, and stability.

### Passive recovery

[![Passive recovery](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/df/Passive_recovery.png/revision/latest?cb=20220304053805)

[https://stormworks.fandom.com/wiki/File:Passive_recovery.png](https://stormworks.fandom.com/wiki/File:Passive_recovery.png)

A well-designed ship can passively recover from being flipped upside down, like a submarine. To do this, we need to the reverse the techniques we used previously for stability now with regard to the top and sides of the ship. A rounded top and sides with a low center of mass will become a round-bottom with a high center of mass if it becomes flipped, which will be very likely to flip over again on its own. Thus, the overall shape of the ship generally needs to either be round (like a submarine), or tall and flat-sided with a very low center of mass. A flat bottom is not strictly necessary but generally beneficial. In all cases, the center of mass needs to be kept below the waterline to ensure that the ship will orient itself correctly, and the lower it is, the better. A ship with tall ceilings and large (enclosed!) empty rooms above the waterline has a significant advantage in getting itself turned upright.

As shown in the image to the right, A) is a submarine-type hull which will orient correctly as long as the center of mass (shown in pink) is below the center of buoyancy (the middle of the hull). B) is a taller submarine-type hull or hull similar to a blue water frigate or cutter except that it has a rounded top. Note that the center of mass needs to be much lower to ensure that it will not be stable on its side, so the upper decks need to be mostly enclosed empty space. C) is a common hull shape mistake which will offer some resistance to tipping initially since the center of mass is below the waterline (the red zone), but once a strong wave flips it over, it will be capsized.

The easiest approach to test if a ship is able to passively recover is as follows:

- Save your work and start a new vehicle.
- Go the selection grid > load content and select your ship.
- Use the L key to flip it upside down.
- Paste it in.
- Spawn the ship and see if it flips itself back upright on its own.

### Active recovery

If a ship has capsized, there are a variety of design options which can be installed to allow it to flip itself upright again.

- [Fluid jets](https://stormworks.fandom.com/wiki/Fluid_jet): Any ship powered by a pair of fluid jets can potentially be flipped as long as it is still able to power the fluid jets. For diesel-powered ships, this can be achieved by having air inlets on both the top and bottom with filters in place to only allow air through, ensuring that the engine can always run whether or not the ship is capsized. The two fluid jets can be given opposite maximum vertical trim inputs to induce roll when they are powered, providing force to flip the ship.

- Roll thrusters: Similar to the above, ships which can maintain engine operation while capsized can power a pair of propellers on robotic pivots which are turned in opposite directions to induce a roll.

- Ballast: Ballast tanks can be pumped full of water to get the ship on its side. As long as the ballast tanks are large enough to get it sideways while capsized, and as long as the ship can passively recover from being sideways, this approach will allow it to recover. Note that ballast tanks tend to fill slowly. For maximum recovery speed, use multiple [pumps](https://stormworks.fandom.com/wiki/Pumps), and try to pump in air as you pump out water or vice versa to avoid forcing the pumps to work against high pressures.

## Troubleshooting

### Engine won't start

Follow this checklist:

- If the engine won't start at all (no noise when attempting to start it), make sure the engine is connected to a battery, and that your starter control (button or seat input) is connected to the engine's starter logic.
  - If you're using a starter button, make sure it is also connected to a battery.
  - If your engine, starter, or starter button are connected to power through a circuit breaker, make sure the circuit breaker is on.
- If the engine's starter works (audible noise) but the ship doesn't move even when the starter is held on, make sure you've connected the engine to the propeller, that any clutches you may be using are oriented so the A side is toward the engine and B side toward the propeller (sides visible when hovering over the connectors on the clutch in the workbench editor), and make sure the clutch setting is well above 0 (0 clutch means no engine power would reach the prop).
- If the engine starter is working but the engine won't continue to run without the starter, check the following:
  - Make sure the throttle is above 0, preferably above 0.15 (typically close to minimum idling throttle), and ideally set to 1 during engine start-up.
  - Make sure the engine exhaust is connected and going out into air (underwater exhaust, especially deep underwater, can create enough backpressure to choke the engine).
    - An overly-long exhaust line can also choke the engine. If the exhaust line is more than 20 blocks long, try a shorter line and see if that fixes it. If so, you can either use a shorter line, use pumps, or run at a lower RPS.
    - Catalytic converters can also significantly increase backpressure, so if your build uses converterss, try running the engine without them as a test.
  - Make sure the engine air intake is connected and drawing from air. Like with the engine exhaust, an overly-long intake line can create problems; use the same approach as above to test if this is an issue and correct the problem if so.
  - Repeat the same check for fuel, and verify that the vehicle does have some fuel to use.
  - If an engine has too much resistance, it may be stalled. If you're using a low-powered engine on a large prop with a high power requirement, try installing a clutch, setting it a to low setting (e.g. 0 during startup) and seeing if the engine is able to start up. If so, you can try ramping up the clutch to see how much power the engine is able to deliver, but you may need to switch to a more powerful engine.
- If your engine bursts into flames almost immediately after starting, the coolant system isn't connected, or else the radiator/heat sink has something obstructing it.
- If your engine bursts into flames after running several seconds or a minute or so, the coolant system is inadequate. Try using a lower RPS, or a fluid heat radiator with the fan on, and with pumps bringing the coolant into and out of the radiator.
  - Warning: Do not use a branching coolant system. Branches significantly reduce coolant flow. If you really want an additional fluid heat radiator, make it in series (coolant out->radiator in->radiator out->radiator in->radiator out->coolant in), not a parallel branching structure.

### Steering problems

If you can't steer your rudders may not be connected to your pilot seat, or your rudders may be turning in opposite directions (you can see this happening if you look under the water).

### Sinking

If your boat immediately sinks, you may have a gap in your hull somewhere. Hull compartments which are not fully closed can instantly fill with water, so they offer no buoyancy, and water can get in even if the hole itself is not below water. In contrast, open doors and hatches will fill slowly, and only when they are below water. An easy test for this is to put a fluid meter inside of the compartment and check the fluid capacity - if it comes back zero, the compartment is not sealed and you'll need to close the hole.

If your compartments are sealed but the ship is still sinking immediately upon spawn, it may be overburdened. This can be an issue when using extremely heavy components along with filling large amounts of your ship with cargo, like fuel on a tanker. Ensure you have enough volume filled with air to keep your ship afloat.

## Next Steps

Common requirements for a boat:

- [Ladders](https://stormworks.fandom.com/wiki/Ladder)! It is possible to jump on our ship (at least, if you've not made it too tall or buoyant), but you'll want to add ladders to make it easier to get on.
- Seats! Place [passenger seats](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Person_Operations) to allow passengers to be safely transported.
- Lights! Add [lights](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Lights) for when it gets dark, or you won't be able to see what's happening.
- Navigation tools! Add a [compass](https://stormworks.fandom.com/wiki/Compass_sensor) so you can tell which way you are headed in career mode. Add a GPS so you can work out your position when it's dark or foggy and you can't see nearby islands.
- Fluid cannons! Add a [fluid cannon](https://stormworks.fandom.com/wiki/Wiki/Guides/Fluid_Cannon) to fire water from your ship, allowing you to put out fires.

## Alternative styles of boat

### Catamaran

A catamaran is made up of two hulls which touch the water. They tend to be very stable, making them less likely to flip. On the other hand, when they do flip they are much harder to upright. Catamaran examples can be found on Wikipedia[[1\]](https://en.wikipedia.org/wiki/Catamaran).

### Hydrofoil

A hydrofoil is a type of high-speed boat which has control surfaces below the waterline. These surfaces are used to provide enough lift to get the boat entirely out of the water, resting only on the hydrofoils to minimize drag. Hydrofoil examples can be found on Wikipedia[[2\]](https://en.wikipedia.org/wiki/Hydrofoil).

---

Source: [Wiki/Vehicles/Water/Boat](https://stormworks.fandom.com/wiki/Wiki/Vehicles/Water/Boat) · Revision 4599 · CC BY-NC-SA
