---
title: "Nuclear power"
source_url: "https://stormworks.fandom.com/wiki/Nuclear_power"
page_id: 1841
revision_id: 4558
revision_timestamp: "2025-07-28T03:13:03Z"
retrieved_at: "2026-08-31T10:04:25+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: []
---
# Nuclear power

Nuclear power provides a way to generate large amounts of power at effectively zero cost. Due to reactors and associated steam power plants usually being quite large and heavy, it is typically used to power ships, although compact nuclear power plants can also power large ground vehicles like trains and even aircraft.

## Reactor

Reactors provide a heat source for [boilers](https://stormworks.fandom.com/wiki/Steam_boiler) to convert freshwater into steam. Reactors are built with nuclear fuel assemblies, control rods, and nuclear fuel rods. A chain reaction takes effect when multiple nuclear fuel assemblies loaded with nuclear fuel rods are adjacent to each other, and this rapidly produces heat. The heat can easily be excessive, so control rods adjacent to the fuel assemblies are required to dampen the reaction and prevent meltdown.

To begin reacting, nuclear fuel rods must be inserted into nuclear fuel assemblies. The rounded tip on the fuel rod is the end which must be inserted into the assembly. A mechanism to physically move the fuel rod into the assembly must be built, or you can use gravity, though this risks having the rods get stuck from time to time.

Even just a sliding connector track in the reactor and a sliding connector gripper on the fuel rods is enough to prevent the fuel rods from getting stuck, though many other approaches are equally effective. Note that if you want to get the fuel rods out of the assembly (e.g. in the event of a coolant leak causing overheating fuel rods), you cannot stop the reaction merely by releasing the rods from the fuel assemblies (using the fuel assembly logic node). That's the first step, but it will simply unlock the fuel rods. They then have to be physically moved out of position (ejected from the core) using some other mechanism, e.g. a sliding track or a piston.

Note that adjacent assemblies have a synergistic effect, so reactors with many adjacent fuel assemblies can become excessively hot. The desired operating temperature is generally on the low end of the range between 120-300 °C since 120 °C is hot enough to get a boiler producing at least a small amount of steam while 300 °C is hot enough to get a boiler producing steam so quickly that it is no longer feasible to pump water into it fast enough to keep it working properly. Note that any excess heat just means the fuel rods will be expended more quickly, so the best approach is to minimize the reactor temperature to whatever is required to keep the boiler's steam pressure up.

In contrast to the fuel assemblies, control rods are used to dampen the reaction. Control rods are placed adjacent to fuel assemblies and must be placed three blocks higher than the level at which the assembly was placed or else they will do nothing. Control rods have an adjustable 'insertion' value from 0 to 1 controlled by a numeric input, and can be inserted more to decrease reaction rate and thus reduce the temperature of adjacent fuel assemblies.

### Coolant

Reactors should have freshwater as coolant. Without water as a radiation moderator, fuel rods can easily overheat, spew out excessive radiation, and potentially melt down. It is often a good idea to set a fluid meter inside of a reactor and an alarm in case the fluid level drops below normal (e.g. due to damage). This may require ejecting the fuel rods until the reactor can be repaired and refilled.

A reactor filled with coolant will tend to have all fuel assemblies at the same temperature. As coolant level drops, the fuel assemblies closer to the center of the reactor will heat up more than the ones at the edges. This can result in some of the fuel assemblies reaching meltdown temperatures even while other assemblies appear to be working normally.

### Radiation

If a radiation detector picks up more than about 1.5, it's enough to cause radiation damage to nearby players within a few seconds. This is worth sounding an alarm (and possibly switching to a different reactor design). This is also generally a sign that a reactor is overheating and/or has lost its coolant water, so an emergency core ejection is usually required to prevent a meltdown.

Radiation has a cumulative effect on players, so the longer the player is near an intense source of radiation, the longer it will take to get rid of the radiation effect. Hazmat suits can be used to reduce radiation exposure. Radiation causes damage over time, so players exposed to large doses of it may need a medical bed and many med kits to survive.

### Meltdown

At over 1500 degrees, reactors will suffer a meltdown. This creates a large, invisible area of extremely hazardous radiation which will remain even after the vehicle which created it is gone. The radiation gradually decreases over time.

## Reactor configuration

Reactors have to balance size and weight with startup speed and longevity. Lightweight (e.g. aviation-grade) reactors tend to use a minimum number of fuel assemblies and control rods which leads to a slow startup and reduced maximum operating time. Many different reactor configurations are possible.

In the sections below, fuel assemblies are denoted with an 'F' and control rods are denoted with a 'C'.

### 4 assemblies

This is the smallest functional reactor configuration:

```
CC
FF
FF
CC
```

### 9 assemblies

```
 C C
CFFFC
CFFFC
CFFFC
 C C
```

At 0.45 control rod insertion, this reactor will hold a temperature of about 339 degrees.

## Troubleshooting

### Reactor overheating

Likely causes:

- No coolant / inadequate coolant. It is best practice to keep reactors filled with fresh water.

- Control rods not built exactly three blocks above the level that the fuel assemblies were placed on.

- Not enough control rods / too many fuel assemblies.

- Control rods insufficiently inserted. Try setting their insertion to 1 and see if the reactor cools down.

### Reactor not heating up

Likely causes:

- Fuel rods not actually inserted (temperature reading from fuel assembly will be 0). Put the fuel rods on a sliding connector track with track grippers to make sure they slide into place correctly.

---

Source: [Nuclear power](https://stormworks.fandom.com/wiki/Nuclear_power) · Revision 4558 · CC BY-NC-SA
