---
title: "Wiki/Guides/Gearbox"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Guides/Gearbox"
page_id: 524
revision_id: 4492
revision_timestamp: "2025-07-20T22:41:03Z"
retrieved_at: "2026-08-31T10:12:11+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Wiki_Page"]
---
# Wiki/Guides/Gearbox

## Gearbox

Gearboxes convert torque (rotational force) into rotational speed (rps) and the vice versa. They are extremely useful for optimizing engine performance and allowing vehicles to reverse direction. The degree of change depends on the ratio of the gearbox. A single gearbox in Stormworks can switch between two different ratios. There are currently 8 gearbox ratios to choose from: -1:1, 1:1, 6:5, 3:2, 9:5, 2:1, 5:2 and 3:1. For example, a ratio of 3:1 means that the outputted RPS or torque of the engine (depending on the direction of the gearbox) is multiplied by a factor of 3.

If the gearbox is facing the engine, as indicated by the blue arrows on the gearbox, RPS to the propeller will be multiplied at the expense of torque. An engine limited to 20 RPS would therefore spin an attached propeller with 60 RPS (given that there are no weight constraints that prevent the engine from reaching 20 RPS).

If the gearbox is facing away from the engine, the multiplication is applied with respect to torque. An engine outputting 40 torque, combined with a 3:1 gearbox, would deliver a resulting 120 torque. The increase in torque comes at the cost of RPS, which is divided by 3.

When building a vehicle, it is important to consider whether a high torque or RPS should be achieved. For example, trucks and tractors built to move heavy loads uphill would need gearboxes facing away from the engine which result in a large amount of torque, allowing it to pull heavy objects at low speed. In contrast, a sports car or helicopter would have gearboxes facing towards the engine, resulting in a low torque but higher RPS output and thus maximum speed. Note that because of the low torque, less force is needed to slow or stop the vehicle, so it could be even slower with towing a heavy load, or possibly fail to move at all.

The 1:-1 ratio is used to allow vehicles to run in reverse. In the current build, gearboxes have a 95% efficiency rating.

## Automatic transmission

For most air and sea vehicles, a single set of gears at fixed ratios is often good enough. However, ground vehicles must deal with change in slope, acceleration, and sometimes hauling very heavy loads. If the load is too heavy for the available torque, the engine can stall and stop working. If the load is too low and/or the vehicle moves downhill, the engine may run too fast, delivering less power than it could, using more fuel than necessary, and potentially risking overheating and bursting into flames. This makes an automatic transmission a near necessity for them. Cargo helicopters, tug boats, and cargo freighters often face similarly drastic changes in required torque and power and also benefit greatly from having an automatic transmission.

### Simple(r) approach

A relatively simple approach is to have four gearboxes, all 2:1, two facing the engine, two facing away. All should be configured to increase speed when off, so the gears facing the engine are 2:1 when off and 1:1 when on. The two facing away from the engine are 1:1 when off and 2:1 when on. Thus, each gearbox doubles torque and halves speed when turned on, allowing a range from 1:4 (improving torque) up to 4:1 (improving speed). The five possible configurations would be 1:4, 1:2, 1:1, 2:1, and 4:1. It doesn't matter which gearboxes are turned on, just that each added gearbox turned on will double torque at the expense of RPS.

To use these gearboxes, a microcontroller can be configured with an up/down counter which increments by 1 and is clamped to a range of 0-4. At 1, one of the gearboxes is turned on. At 2, two of them are turned on, and so on. A very simple method would be to use push buttons routed through a pulse, allowing the user to manually adjust the gears to double speed and halve torque, or vice versa, up through the full range of increments. A slightly more sophisticated method would be to check the RPS of the engine and automatically send such pulses to correct high or low rps (e.g. <6 rps, or >10 rps), resetting using RTO timers every half second or so (half a second to give the engine time to adjust after the gear change to see if further change is necessary) before sending additional pulses as necessary to keep the engine in the ideal range.

In testing, this approach works rather well, easily going up hills and over roads at excellent speed without excessive RPS, but the sharp transitions due to doubling and halving the torque / RPS make for somewhat 'jolty', lurching movement.

### Advanced approach

A more advanced approach is to use four different gear ratios to allow for a greater range of possible settings and therefore smoother transitions. For example, suppose gearbox A is 1:3, B is 5:9 (both facing away from the engine) C is 2:1 and D is 5:2 (both facing towards the engine), and all are 1:1 when off. Now we get maximum speed with just CD on, and maximum torque with just AB on.

These four gearboxes can be configured in 16 different ways to get gear ratios that were previously impossible. The options include AB 5:27 (=0.185), A 1:3 (=0.333), ABC 10:27 (0.370), ABD 25:54 (=0.463), B 5:9 (=0.556), AC 2:3 (=0.667), AD 5:6 (=0.833), ABCD 50:54 (=0.926), 1:1 (=1.00), BC 10:9 (=1.11), BD 25:18 (=1.39), ACD 5:3 (=1.67), C 2:1 (=2.00), D 5:2 (=2.50), BCD 25:9 (=2.78), CD 5:1 (=5.00). This approach gives us 35% more maximum torque, 25% more maximum speed, and most transitions between the gear settings are barely noticeable. Only the worst transitions (to the highest and lowest gear settings, respectively) remain 'jolty', but still only 90% as large as every transition used to be with the previous approach.

For this approach, we need the up/down counter to be clamped from 0 to 15. Transition times can also be much shorter e.g. 1/8th of a second, so if necessary we still do a full cycle of all gear combinations within two seconds as before.

A needs to be on for: 0, 1, 2, 3, 5, 6, 7, 11. B needs to be on for 0, 2, 3, 4, 7, 9, 10, 14. C needs to be on for 2, 5, 7, 9, 11, 12, 14, 15. D needs to be on for 3, 6, 7, 10, 11, 13, 14, 15.

In testing, this approach works extremely well. The movement is smooth even while moving up and down slopes and the speed is higher than it was at previous throttle settings, requiring about 30% less throttle to avoid going too fast.

---

Source: [Wiki/Guides/Gearbox](https://stormworks.fandom.com/wiki/Wiki/Guides/Gearbox) · Revision 4492 · CC BY-NC-SA
