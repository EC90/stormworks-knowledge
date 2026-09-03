---
title: "RCS thruster"
source_url: "https://stormworks.fandom.com/wiki/RCS_thruster"
page_id: 1717
revision_id: 4726
revision_timestamp: "2026-08-22T02:42:40Z"
retrieved_at: "2026-08-31T10:04:46+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Electric_components"]
---
# RCS thruster

## Specifications

| Field | Value |
| --- | --- |
| name | RCS Thruster |
| cost | $140 |
| dimensions | 1x1x1 |
| mass | {{Property\|mass}} 1 |
| logicinput1 | {{Property\|composite}} Composite input |
| connection1 | {{Property\|electric}} |
| connection2 | {{Property\|fluid}} Fluid supply |
| adjustparam1 | Power |
| adjustparam2 | Stabilization threshold |

## RCS Thruster

### Cost

$140

### Dimensions

1x1x1

## Properties

| mass 1 |

## Logics Inputs

| composite Composite input |

## Connections

| electric | fluid Fluid supply |
| --- | --- |

## Adjustable parameters

| Power | Stabilization threshold |
| --- | --- |

RCS thrusters are multi-directional inert gas rockets used for stabilizing spacecraft and making fine adjustments in rotation and position.

"A fluid jet that fires pressurized air for altitude (sic) control and translation. The reaction control system can fire in 4 non-cardinal directions resulting in 5 directions of motion. RCS thrusters also have body relative activation modes where thrusters will collaborate from different orientations to achieve the desired translation or rotation. The RCS thruster also has positional and rotational stabilization toggles."

## Control

RCS thrusters have 18 boolean input channels. Channels 1-4 control the RCS thrusters based upon how the thruster is oriented (relative to the large and small arrows indicated on each thruster in the construction workbench interface). Channels 5-6 let the thrusters respectively control the vehicle's positioning and rotation, regardless of their orientation on the vehicle. Channels 7-18 control the vehicle independently of how they were oriented on it (directions in parentheses are relative to the enormous forward arrow shown at the bottom of the construction workbench interface):

1. Component X+ (move in the direction of the thruster's little arrow)
2. Component X- (opposite of 1)
3. Component Z+ (move in the direction of the thruster's big arrow)
4. Component Z- (opposite of 3)
5. Enable position stabilization
6. Enable rotation stabilization
7. Body X+ (move right)
8. Body X- (move left)
9. Body Y+ (move up)
10. Body Y- (move down)
11. Body Z+ (move forward)
12. Body Z- (move backward)
13. Body Rotate X+ (pitch down)
14. Body Rotate X- (pitch up)
15. Body Rotate Y+ (yaw right)
16. Body Rotate Y- (yaw left)
17. Body Rotate Z+ (roll left)
18. Body Rotate Z- (roll right)

## Fuel and thrust

RCS thrusters can work with pressurized gases including air, oxygen, nitrogen, hydrogen, and steam. The type of gas makes no difference in produced thrust. RCS thrusters will not work with fluids like water (for that, see the [fluid jet](https://stormworks.fandom.com/wiki/Fluid_jet)). RCS thrust is relative to pressure, but quite small, and quite inefficient compared to liquid fuel rockets even at full pressure (59.4 atm). With fully pressurized tanks, thrust is enough to lift about 18 mass units against gravity (~1,800 N). Assuming constant pressure (e.g. by using a pump to constantly top off pressure in a small tank), producing this amount of thrust will consume the full contents of a huge gas tank in about 20 minutes, the full contents of a large gas tank in a little over 5 minutes, a medium tank in about 38 seconds, or a small gas tank in about 16 seconds. RCS thruster will not produce thrust if its fluid supply is less than 4.51 L/s.

---

Source: [RCS thruster](https://stormworks.fandom.com/wiki/RCS_thruster) · Revision 4726 · CC BY-NC-SA
