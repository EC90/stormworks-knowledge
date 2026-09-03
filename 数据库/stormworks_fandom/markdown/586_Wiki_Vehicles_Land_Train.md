---
title: "Wiki/Vehicles/Land/Train"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Vehicles/Land/Train"
page_id: 586
revision_id: 3582
revision_timestamp: "2023-12-29T13:21:53Z"
retrieved_at: "2026-08-31T10:12:59+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs"]
---
# Wiki/Vehicles/Land/Train

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Wiki/Vehicles/Land/Train?action=edit). |
| --- | --- |

Trains are good for cargo delivery because all terminals have a train track leading to them, and don't require constant attention from the user to drive. Some stations have train spawn points at them.

## Wheels

Trains use Train Wheel Assemblies to attach to rails and will automatically snap to rails when getting close enough. Every assembly has brakes and an indicator for wheel slip.

There are three categories of train wheels:

- Unpowered
- Regular
- Steam

Unpowered wheels will connect to the rails, but don't provide propulsion. Regular wheels have a Power node, allowing them to be powered and moving the train forwards. A negative amount of RPS will cause them to spin backwards.

Steam wheels rely on a Train Wheel Drive Piston to convert steam to movement. Steam wheel components must be directly adjacent in order to connect.

## Speed

[![This train is not feeling well because it has glowing sparks shooting out from its wheels.](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/58/Train_Wheelslip.jpg/revision/latest/scale-to-width-down/180?cb=20231229124704)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/58/Train_Wheelslip.jpg/revision/latest?cb=20231229124704)

[https://stormworks.fandom.com/wiki/File:Train_Wheelslip.jpg](https://stormworks.fandom.com/wiki/File:Train_Wheelslip.jpg)

A train experiencing wheel slip

Train speed is influenced by size and wheel count. Bigger or heavier trains will not be able to go as fast, and trains with more powered axles will have more traction and a higher top speed.

### Wheel slip

When your train approaches its speed limit, it will start to experience wheel slip. Wheels will start slipping when they are moving too fast relative to the ground. A speed difference of 3 m/s will cause them to slip.

You can calculate how close a regular-size wheel is to slipping using the formula:

- abs( (CURRENT_SPEED ) - (RPS_AT_WHEELS) ) * pi / 9.6
- If this function outputs a value of >1, your train will start to slip, so a value below that is ideal.

CURRENT_SPEED is the speed (in m/s) measured from a linear speed sensor pointing forward. RPS_AT_WHEELS can be measured by a torque sensor.

abs( ) is a function that converts negative numbers to postitive ones. We use it because we don't care about negative rps or speed.

## Rail Switches

[![Rail signals at the Sawyer north harbour](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/52/Sawyer_North_Rail_Signals.jpg/revision/latest/scale-to-width-down/180?cb=20231229123522)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/52/Sawyer_North_Rail_Signals.jpg/revision/latest?cb=20231229123522)

[https://stormworks.fandom.com/wiki/File:Sawyer_North_Rail_Signals.jpg](https://stormworks.fandom.com/wiki/File:Sawyer_North_Rail_Signals.jpg)

Rail signals at the Sawyer north harbour

There are two methods of controlling rail swithches: manually or by remote controlling.

The switch is controlled by the signal next to it. The default direction for switches is always the right side. By pressing the button present at each signal, you can toggle the direction the switch is set to. The signal also listens on Radio frequency 440: A composite signal containing true on channel 1 will also toggle the signal.

The switch will not reset when unloading or leaving the world.

## Derailing

Trains can derail when their wheels get damaged. This usually happens when taking a corner too fast. After being repaired, a train can be placed back on the rails and will snap into place.

Unless derailed, a train cannot be removed from rails unless it passes over the end of the track. No amount of force can lift a train upwards off the rails.

## Some wheels are bugged

There are some train wheel assembly components available that contain multiple axles in a single component. Despite having more wheels, they do not provide more traction. In fact, their stats are identical to their single-axle counterpart. Affected components are:

- Train Wheel Assembly Classic
- Train Wheel Assembly x2
- Train Wheel Assembly x3

## Update v1.5.17

Trains need to be able to be driven on train tracks. Here are the different Train Wheel Assemblies that allow that to happen: There are different types in game: The "Steam"

- There are 3 types in game, The large, The Medium and the small one.
- To use Them you will need the relevant Train wheel Drive Piston (The Large Train Wheel Assembly Needs The large Piston, The Medium Train Wheel Assembly The Medium piston and the small Train wheel The small piston)

The "Classic"*The Old train Wheel was the only one before update v.1.5.17 . The "Normal"

- It is just like the classic in that it has an input for power and exists in 3 sizes, unlike the classic which has only one size.
- The 4 Sizes are:

Train wheel assembly x1, Train wheel assembly x1 small, Train wheel assembly x2 and Train wheel assembly x3 which all have different numbers of train wheels

The "Flanged"

- Unpowered Train wheels

[Train Standards](https://stormworks.fandom.com/wiki/Wiki/Standards/Train_Standards)

---

Source: [Wiki/Vehicles/Land/Train](https://stormworks.fandom.com/wiki/Wiki/Vehicles/Land/Train) · Revision 3582 · CC BY-NC-SA
