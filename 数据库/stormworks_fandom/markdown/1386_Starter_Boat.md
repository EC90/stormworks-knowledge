---
title: "Starter Boat"
source_url: "https://stormworks.fandom.com/wiki/Starter_Boat"
page_id: 1386
revision_id: 3553
revision_timestamp: "2023-11-02T23:16:43Z"
retrieved_at: "2026-08-31T10:05:04+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: []
---
# Starter Boat

[![The preset starter boat](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/c/c8/Starter_boat.png/revision/latest/scale-to-width-down/300?cb=20220329214836)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/c/c8/Starter_boat.png/revision/latest?cb=20220329214836)

[https://stormworks.fandom.com/wiki/File:Starter_boat.png](https://stormworks.fandom.com/wiki/File:Starter_boat.png)

The preset starter boat

The Starter Boat is an in-game preset vehicle which comes with a variety of features, and is meant to showcase various principles of vehicle design in Stormworks, as well as providing a basic vehicle for beginners to learn to perform search and rescue missions.

## Propulsion

It uses two small water-cooled diesel engines connected to [thrust pivoting](https://stormworks.fandom.com/wiki/Wiki/Vehicles/Water/Boat#Thrust_pivoting) propellers which give it a very tight turning radius compared to purely rudder-steered boats. Another interesting aspect of its design is the use of fluid hose anchors and hoses to move the coolant water instead of pipes, showing a simpler method to connect fluid systems than winding, complex pipe chains. This was set up in the editor under Logic > Rope, the same as the ropes on the rim.

## Hull design

The hull is designed with a heavy but almost neutrally-buoyant bottom section which is centered underneath a lighter, hollow rim section. This provides excellent static stability, reducing the risk of the boat capsizing (though also making it harder to flip upright if it does capsize).

## Active stability

It uses a [Gyro](https://stormworks.fandom.com/wiki/Wiki/Guides/Gyro) (normally used on helicopters) for roll and pitch stabilization. The gyro is connected to small control fins at the back of the boat, allowing it to partially counteract pitch and roll induced by waves while it is moving.

## Other features

The starter boat showcases a long-range [radio](https://stormworks.fandom.com/wiki/Radio) with adjustable channels.

It also has six seats for carrying rescued passengers, a variety of search and rescue [equipment](https://stormworks.fandom.com/wiki/Equipment) (such as a fire extinguisher and med kits), a transponder locator, compass, heater (for arctic operation), a forward winch, and multiple rope anchor mounts for towing vehicles or being towed.

## Problems

It has a switch at the back labeled "reserve battery", but this doesn't actually do anything. All three batteries are connected to the same side of the same circuit breaker. This connects into the RHIB MC (microcontroller name) at Panel In under channel 20, but isn't used from there. Players can fix this by getting rid of the button and using a circuit breaker which separately connects the third battery, or can add an Electric Relay controlled by the button, though it should be noted this will not work if the main batteries (which power the button) are fully depleted.

The deprecated radar next to the radio at the back isn't connected to anything. Players can remove this and replace it with a new [radar](https://stormworks.fandom.com/wiki/Radar).

At full throttle the engine RPS is maintained at near idle 8 RPS so the boat is kind of slow, doesn't sound right and when you add too much throttle too quickly, the engine stalls and starter will kick in, sometimes multiple times, wasting needless battery charge. The low RPS was chosen probably on purpose to get a decent range. The [non-modular diesel engines](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Propulsion/DieselEngines) are the most efficient around this RPS. One can adjust the max engine RPS parameter to get higher speeds but with worse fuel economy.

The idle RPS will be temporarily higher than set after driving for a while. This is caused by the RPS being limited by the engines not by the PID controller in RHIB MC. The PID controller is set to `i: 0.000050` which accumulates as an error while driving (when the PID controller cannot reach the target RPS set on the RHIB MC as property) and manifests itself when idling right after it. The quick solution is to set the driving RPS to 8 on the RHIB MC property, but then the engine never reaches 8 RPS so it isn't ideal.

The air intake for engines is easily flooded in rough weather with water because it's on the sides of the helm at floor height. Can be easily fixed by piping the air intake much higher externally.

The exhaust port located at the engine-like boxes on the rear is also easily blocked by water chocking the engine. Piping it higher up fixes that.

The throttle lever has very small steps making the throttle feel unresponsive. The throttle lever position is not easily visible during maneuvers which can add to confusion. Adding throttle position indicator to dashboard and increasing the throttle lever sensitivity to like 50+% are easy fixes for this.

The generators are connected and loading the engine even if the battery is charged to 100%. At full throttle the generators make about 3kW while you only need a like 300W to run the boat's electric systems. This isn't such a big problem since it increases the fuel consumption by only about 5% with the stock setup. However, if you try to maximize the range (e.g. using hydrofoils and using higher gear ratios), it will become a significant burden. The solution would be to have the generator connected through a separate clutch and control the clutch based on battery level.

---

Source: [Starter Boat](https://stormworks.fandom.com/wiki/Starter_Boat) · Revision 3553 · CC BY-NC-SA
