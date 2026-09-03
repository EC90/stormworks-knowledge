---
title: "Wiki/Guides/Fluid Cannon"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Guides/Fluid_Cannon"
page_id: 511
revision_id: 2305
revision_timestamp: "2019-10-19T17:52:21Z"
retrieved_at: "2026-08-31T10:12:09+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Wiki_Page"]
---
# Wiki/Guides/Fluid Cannon

## Fluid Cannon

[![Fluid Cannon](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e9/Fluid_Cannon.png/revision/latest/scale-to-width-down/180?cb=20190211194153)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e9/Fluid_Cannon.png/revision/latest?cb=20190211194153)

[https://stormworks.fandom.com/wiki/File:Fluid_Cannon.png](https://stormworks.fandom.com/wiki/File:Fluid_Cannon.png)

Fluid Cannon

[![Active Water Cannon](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/a9/Water_cannon_in_use.png/revision/latest/scale-to-width-down/197?cb=20190211201204)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/a9/Water_cannon_in_use.png/revision/latest?cb=20190211201204)

[https://stormworks.fandom.com/wiki/File:Water_cannon_in_use.png](https://stormworks.fandom.com/wiki/File:Water_cannon_in_use.png)

Active Water Cannon

The Fluid Cannon is a component available in [normal mode](https://stormworks.fandom.com/wiki/Wiki/Building/Normal_Mode) and [advanced mode](https://stormworks.fandom.com/wiki/Wiki/Building/Advanced_Mode) that is primarily used for creating a turret to put out fires. It normally is attached to a [Fluid Tank](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Fluids) with a [Fluid Pump](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Fluids) to provide pressure.

### Requirements

The Fluid Cannon needs a pressurised fluid supply, invariably water. In Advanced mode, it also requires an electricity supply. The turret's direction can be controlled using logic data inputs, such as throttles.

## Example Normal Mode Water Cannon

[![A functioning water cannon](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/df/Water_cannon_example.png/revision/latest/scale-to-width-down/253?cb=20190211195426)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/df/Water_cannon_example.png/revision/latest?cb=20190211195426)

[https://stormworks.fandom.com/wiki/File:Water_cannon_example.png](https://stormworks.fandom.com/wiki/File:Water_cannon_example.png)

A functioning water cannon

An example configuration for a water cannon compromising of a [Fluid Tank Large](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Fluids), a [Large Fluid Pump](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Fluids), a Fluid Cannon, a [Toggle Button](https://stormworks.fandom.com/wiki/Wiki/Building/Components/User_Input), two [Throttle](https://stormworks.fandom.com/wiki/Wiki/Building/Components/User_Input)s, and (optionally) a [numeric inverter](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Logic). Note that since we are not in Advanced mode, the fluid connections do not need to line up directly with pipes and thus the components can be placed anywhere on the ship. The only thing that matters is they are connected via Logic connections.

- The Fluid Tank Large provides the source of water. Naturally there are other ways of getting water out at sea, but this is good enough for us. Note that the Fluid Tank Large **must** be set to the Water type using the 'Select' tool.
- The Large Fluid Pump takes the water from the Fluid Tank Large and pressurises it, which prepares the water for being fired out of the cannon.
- The Fluid Cannon takes the water from the Large Fluid Pump and fires it out of the turret at the fire (or perhaps another target).
- The Toggle Button is attached to the Large Fluid Pump on the Logic Data screen, allowing the pump to be turned on and off. This allows the operator to control when the cannon is in use or not.
- The Throttles are used to move the turret left/right and up/down. They should be selected with the Select tool and their Min Value set to -1 rather than 0. This allows them to move in both directions. A numeric inverter can be also be added as a connection between the throttles and the fluid cannons to reverse any connections which seem 'backwards'.

### Logic Connections

[![Water Cannon Fluid Connections](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/5f/Water_Cannon_Fluid_Connections.png/revision/latest?cb=20190211201049)

[![Water Cannon Data Connections](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e9/Water_Cannon_Data_Connections.png/revision/latest?cb=20190211200551)

- The Toggle Button should have a Data connection to the Large Fluid Pump
- The Throttles should have a Data connection to the Fluid Cannon's two axes, one each.
- If a Throttle is the wrong way around, a Numeric Inverter should be added. The Throttle should then be connected to the Numeric Inverter first, with the Numeric Inverter then connected to the appropriate Fluid Cannon node. You may need two. Or you could just turn the throttles around, but where's the fun in that?
- The Fluid Tank Large's Fluid Out node should be connected to the Large Fluid Pump's Fluid In node.
- The Large Fluid Pump's Fluid Out node should be connected to the Fluid Cannon's Fluid In node.

### Additional Ideas

The power of the pump can be altered to give less pressure with the Select tool. This can be really helpful, as the cannon will spray more widely instead of firing a long distance in a tight formation.

Try strapping a Fluid Cannon to a [linear track base](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Mechanics) for a nippy turret right where you need it.

Turrets are cool, but fire [hoses](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Fluids) can be more flexible.

---

Source: [Wiki/Guides/Fluid Cannon](https://stormworks.fandom.com/wiki/Wiki/Guides/Fluid_Cannon) · Revision 2305 · CC BY-NC-SA
