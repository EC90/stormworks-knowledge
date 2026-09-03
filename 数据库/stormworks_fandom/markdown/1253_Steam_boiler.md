---
title: "Steam boiler"
source_url: "https://stormworks.fandom.com/wiki/Steam_boiler"
page_id: 1253
revision_id: 4719
revision_timestamp: "2026-08-17T15:17:57Z"
retrieved_at: "2026-08-31T10:05:07+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Components", "Stubs"]
---
# Steam boiler

## Specifications

| Field | Value |
| --- | --- |
| name | Steam Boiler |
| cost | $250 |
| fluidcapacity | 175 |
| mass | {{property\|mass}} 500 |
| logicoutput1 | {{property\|number}} Fluid Volume |
| logicoutput2 | {{property\|number}} Temperature |
| connection1 | {{property\|fluid}} Coolant A |
| connection2 | {{property\|fluid}} Coolant B |
| connection3 | {{property\|fluid}} Water In |
| connection4 | {{property\|fluid}} Steam Out |

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Steam_boiler?action=edit). |
| --- | --- |

## Steam Boiler

### Cost

$250

### Capacity

175

## Properties

| mass 500 |

## Logic Outputs

| number Fluid Volume | number Temperature |
| --- | --- |

## Connections

| fluid Coolant A | fluid Coolant B |
| --- | --- |

| fluid Water In | fluid Steam Out |
| --- | --- |

Steam boilers use heat and fresh water to produce high-pressure steam. The steam can be used to produce power through steam turbines or [steam pistons](https://stormworks.fandom.com/wiki/Steam_piston) in custom-built steam engines. It can also produce thrust with RCS thrusters or loud whistling with steam whistles. It can also be used for physics effects, e.g. applying pressure to help push water out of a ballast tank.

## Heat source

Steam boilers are heated with coal (standard and large coal fireboxes), electricity (electric furnaces), diesel (diesel fireboxes), and nuclear-power (custom reactors with fuel rods and fuel rod assemblies). One of these heat sources is used to provide hot 'coolant' to the boiler so that fresh water can be converted into steam. Anything hot enough will work, no matter liquid or gas, including exhaust from firebox. If using a nuclear reactor, a separate pump must be included to take hot 'coolant' water from the reactor to the boiler and back.

## Fresh water source

A steam boiler spawns with a small amount of fresh water in it by default, enough for trivial tests. For vehicles intended for short-range trips, tanks of fresh water can be added to extend range, similar to how fuel tanks are used in other vehicles. Note that large pumps should be used to pump water into boilers as the regular small pumps reach a maximum pressure of 11 atm although boilers generally operate at a pressure of 60 atm.

For boats which need unlimited range, desalinators can convert seawater to freshwater at a rate of 0.18L/s. This works fine for a low-power setup with up to 24 small steam pistons working against heavy gear ratios. However, this can require an excessively large number of desalinators and pumps for high-performance applications (e.g. 30+ desalinators might supply just 25-50% of the required water for a boiler supplying an engine with eight medium steam pistons). It also will not work on submarines since the steam outlets face high backpressure while submerged. As such, although desalinators are impractical for supplying all of the required water in high-performance designs or submarines, they are often good to include in a design as a way to top off the vehicle with fresh water if water losses occur due to damage.

For everything else, including submarines, high-performance boats, and long-range ground vehicles and aircraft, condensers must be used to take the steam from the output of a turbine/piston and turn it back into fresh water. It is important to remember that Stormworks does take into account ambient temperature which is greatly affected by fireboxes and reactors so putting condensers and their radiators as far as possible from heat sources will greatly improve efficiency.

## Pressure

Boilers can begin to build up pressure when their temperature is at least 100. Boilers produce steam faster and build pressure faster when they are at higher temperatures. Boiler explosions from overpressure were previously a danger in Stormworks, but they have since been removed. Boilers now reach a peak pressure of 60 atmospheres; once full of steam and at maximum pressure, excess water will not be converted into steam.

## Mechanics

Boilers convert 1L of fresh water into 60L of steam. Although it was previously possible to pump seawater into a boiler, albeit with resulting damage over time, this no longer works. Seawater is physically blocked from entering the boiler.

The boiler's maximum conversion rate depends on temperature. Boilers can produce about 35L of steam per second for each degree over 100, so a boiler at a temperature of 150 can produce 1,750L of steam from 29L of water per second. Note that above a temperature of 350, even having four large pumps pumping into the boiler against minimum backpressure (i.e. steam is simply vented into the atmosphere) are unable to supply enough fresh water to keep it filled.

## Troubleshooting

### Boiler won't fill

Boilers have a maximum total fluid volume (water + steam) of 175 liters. If power output is too low, and the water level is low, but there's plenty of steam, the boiler is not the problem. In this case, the problem lies with RPS being too low or not enough turbines / pistons to fully use the generated steam.

If the steam level is low (i.e. pressure below 59 atm) and water level is low, the problem is likely inadequate delivery of fresh water. Consider using 1-4 large pumps supplying the boiler, or using additional boilers.

## See also

- [Pumps](https://stormworks.fandom.com/wiki/Pumps)
- [Steam piston](https://stormworks.fandom.com/wiki/Steam_piston)

---

Source: [Steam boiler](https://stormworks.fandom.com/wiki/Steam_boiler) · Revision 4719 · CC BY-NC-SA
