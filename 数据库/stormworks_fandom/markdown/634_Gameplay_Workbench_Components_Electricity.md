---
title: "Gameplay/Workbench/Components/Electricity"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Electricity"
page_id: 634
revision_id: 4155
revision_timestamp: "2025-05-14T02:40:54Z"
retrieved_at: "2026-08-31T10:02:43+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Gameplay/Workbench/Components/Electricity

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Electricity?action=edit). |
| --- | --- |

## Electricity

### Storage

Currently the only components that store electricity are batteries and hardpoint connectors. Batteries have no inputs and output a value of their total power between 1 and 0 (75% would output 0.75). Hardpoint connectors have no output to read their battery level. As batteries deplete, their output scales down resulting in, for example, lower electrical engine RPM and dimmer lights. Unlike fuel tanks, batteries will spawn full when playing with limited fuel option.

- Maximum battery power (small or big) is 600kW and is proportional to its voltage; max voltage for batteries in game is 1. We can calculate needed count of motors and batteries for needed power.

Battery Small

[![Battery Small](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f9/Battery_Small.jpg/revision/latest/scale-to-width-down/100?cb=20190317005248)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f9/Battery_Small.jpg/revision/latest?cb=20190317005248)

- Stores 1600 kJ
- Mass 10
- Blocks 2
- Shape 1 X 2 X 1
- Best for place-ability

Battery Medium

[![Battery Medium](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d1/Battery_Medium.jpg/revision/latest/scale-to-width-down/100?cb=20190317005237)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d1/Battery_Medium.jpg/revision/latest?cb=20190317005237)

- Stores 12800 kJ
- Mass 60
- Blocks 12
- Shape 3 X 2 X 2
- Best for Capacity Per Mass

Battery Large

[![Battery Large](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/8a/Battery_Large.jpg/revision/latest?cb=20190317005232)

- Stores 256000 kJ
- Mass 800
- Blocks 175
- Shape 7 X 5 X 5
- Best for Capacity Per Block

Hardpoint Connector Attachment

[![Hardpoint Connector](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/4/4e/Hardpoint_Connector.png/revision/latest?cb=20221009062735)

- Stores 300 kJ
- Mass 2
- Blocks 2
- Shape 1 X 1 X 2 (Physics Hitbox 1 X 1 X 1)
- Best for vehicles that need little electricity for a short time, like missiles.

### Production

Power calc

- We can calculate producing power with formula: Power [kWatts] = RPS^2*Pp, where i called Pp = generator power potential.
- Pp Alternator = 0.00540
- Pp SmallGen = 0.00642
- Pp MedGen = 0.24100
- Pp BigGen = 1.13800
- kJoule/kWatt i called game electricity power unit.

Generator Small

[![Generator Small](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/ab/Generator_Small.jpg/revision/latest?cb=20190317005337)

- Produces electrical power
- As of v1.3.13, a small generator directly attached to a small prefab engine at ~20 RPS can fully charge an empty small battery in approximately 10 minutes; this is a non-optimized setup, gear ratios can improve this.

Generator Medium

[![Generator Medium](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/c/c2/Generator_Medium.jpg/revision/latest?cb=20190317005330)

- Produces electrical power
- As of v1.3.13, a medium generator directly attached to a medium prefab engine at ~20 RPS can fully charge an empty small battery in approximately 16 seconds; this is a non-optimized setup, gear ratios can improve this.

Generator Large

[![Generator Large](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/96/Generator_Large.jpg/revision/latest?cb=20190317005322)

- Produces electrical power
- As of v1.3.13, a large generator directly attached to a large prefab engine at ~20 RPS can fully charge an empty small battery in approximately 3.5 seconds; this is a non-optimized setup, gear ratios can improve this.

Solar Cell

[![Solar Cell](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/6e/Solar_Cell.jpg/revision/latest?cb=20190317005343)

- Produces electrical power (low amounts)
- As of v1.3.13, one Solar Cell can fully charge an empty small battery in approximately 83 real world hours when in direct sunlight; weather and darkness can decrease this.

### Consumption

Most components require electricity in varying amounts.

### Utilities

Electric Circuit Breaker

[![Electric Circuit Breaker](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/54/Electric_Circuit_Breaker.jpg/revision/latest?cb=20190317005307)

- a switch the player can interact with. When activated it will connect its two electric connectionpoints.

Electric Relay

[![Electric Relay](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/5e/Electric_Relay.jpg/revision/latest?cb=20190317005315)

- Input 1 (On/Off): toggle electric connection
- same as Electric Circuit Break but you can toggle it via the input

Electric Connector

[![Connector Electric](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f9/Connector_Electric.jpg/revision/latest?cb=20190317005254)

- Can connect to other connectors
- can transfer electricity between vehicles

Anchor Electrical Cable

[![Anchor Electrical Cable](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/b/b4/Anchor_Electrical_Cable.png/revision/latest?cb=20200130195219)

You can connect electrical cable between two of these blocks.

---

Source: [Gameplay/Workbench/Components/Electricity](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Electricity) · Revision 4155 · CC BY-NC-SA
