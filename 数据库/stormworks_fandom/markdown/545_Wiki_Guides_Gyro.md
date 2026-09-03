---
title: "Wiki/Guides/Gyro"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Guides/Gyro"
page_id: 545
revision_id: 4575
revision_timestamp: "2025-08-04T03:36:10Z"
retrieved_at: "2026-08-31T10:12:12+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Components", "Stubs", "Wiki_Page"]
---
# Wiki/Guides/Gyro

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Wiki/Guides/Gyro?action=edit). |
| --- | --- |

## Gyro

| Gyro |  |
| --- | --- |
| [![Gyro Description](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/56/Gyro_Description.png/revision/latest/scale-to-width-down/123?cb=20190217205303)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/56/Gyro_Description.png/revision/latest?cb=20190217205303) |  |
| Mass | 10 |
| Dimensions | 5x3x1 |
| Cost | $500 |
| Logic inputs | Bool (Starter), Number (Throttle) |
| Logic outputs | Number (Temperature), Number (RPS) |
| Connections | Roll (In), Pitch (In), Yaw (In), Up/Down (In), Auto-hover (In), Stabilised Roll (Out), Stabilised Pitch (Out), Stabilised Yaw (Out), Stabilised Up/Down (Out) |
| Adjustable parameters | Min Throttle (0-100%), Max Throttle (0-100%), Roll (0-100%), Pitch (0-100%), Yaw (0-100%) |

Gyros take control inputs and translate them into output values that can be fed into [rotors](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Propulsion) for more controlled, stabilized flight. They can also be used for helping to keep a boat stabilized. The gyro component comes equipped with an auto-hover mode that attempts to prevent the vehicle from drifting when no inputs are being given, and which keeps the vehicle at a set pitch/roll when control inputs are used. The gyro also offers editable properties that allow for fine-tuning the sensitivity of the gyro's outputs on each individual axis.

## Integration

Gyros are most easily integrated into [helicopters](https://stormworks.fandom.com/wiki/Wiki/Vehicles/Air/Helicopter) where the rotor component has inputs that correspond to the outputs of the gyro. The outputs of pilot seats can be fed directly into gyros easily and allow for stable controls that feel natural and intuitive.

On [boats](https://stormworks.fandom.com/wiki/Wiki/Vehicles/Water/Boat), gyros can be used to control fins or rudders to maintain stable pitch and roll.

---

Source: [Wiki/Guides/Gyro](https://stormworks.fandom.com/wiki/Wiki/Guides/Gyro) · Revision 4575 · CC BY-NC-SA
