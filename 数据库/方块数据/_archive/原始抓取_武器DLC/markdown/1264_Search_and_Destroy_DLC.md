---
title: "Search and Destroy DLC"
source_url: "https://stormworks.fandom.com/wiki/Search_and_Destroy_DLC"
page_id: 1264
revision_id: 4717
revision_timestamp: "2026-08-13T20:51:28Z"
retrieved_at: "2026-08-30T15:54:17+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
---
# Search and Destroy DLC

The **Weapons DLC** (officially known as **Search and Destroy**) was released on October 5, 2021. The DLC allows players to use weapons such as cannons, autocannons, bombs, missiles, and torpedoes. It also allows players to make worlds where enemy vehicles spawn and capture islands and locations. [Click here to purchase the DLC on Steam.](https://store.steampowered.com/app/1542360/Stormworks_Search_and_Destroy/?curator_clanid=28842908)

This page was last updated for Stormworks V1.15.12 (19 March 2026), which armor piercing ammo is calculated based on the density times the thickness, rather than calculated by walls.

## Machine guns

[![Machine gun](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/5a/Machine_gun.png/revision/latest/scale-to-width-down/200?cb=20220129172950)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/5a/Machine_gun.png/revision/latest?cb=20220129172950)

Machine guns are fed by hand-loaded belts of 100 rounds each. They produce little damage, but are lightweight and inexpensive.

- Cost: $50 (machine gun), $20 (ammo box), $1/round (kinetic), $2/round (AP or incendiary)
- Mass: 10 units (100 kg) [machine gun], 5 units (50 kg) [ammo box]
- Burst fire rate: 900 rounds per minute (4 ticks per round)
- Maximum burst fire duration: 3.33 seconds (manual reload required after this)
- Muzzle velocity: 800 m/s
- Projectile lifetime (ticks): 120
- Maximum range: Approx. 500 m
- Drag Coefficient: 0.005

Ammo effects:

- Kinetic: Only damages the block it hits directly (very low power compared to kinetic rounds from every other vehicle weapon).
- Armor piercing: Can pierce through 3 mass unit/block \* block length
- Incendiary: ~5% chance per shot per shot of starting a fire at the impact point. No penetration.

Machine guns can be edited in xml allowing for many modifications (Infinite ammo is needed in some cases). Changing width changes the spread. Changing length changes the projectile speed and damage. Removing completely width creates an invisible weapon.

## Autocannons

Autocannons are fast-firing weapon systems with higher damage than machine guns, though they can overheat and shut down until they have cooled off. They can be automatically reloaded by connectors, junctions, and feeders, making it possible to design a single autocannon which draws from a massive ammo stockpile within a vehicle. Vehicles can similarly be reloaded automatically from other vehicles via connectors. Manual reloading is still possible, like with machine guns, though not required.

Autocannons come in three varieties which will be described below. In order of decreasing ammo capacity (larger rounds) and increasing damage they are: light, rotary, and heavy.

Autocannons can fire five types of rounds: kinetic, high explosive, fragmentation, armor piercing and incendiary. The effects of these ammo types are described in each of the autocannon sections, since the effectiveness of the ammo increases with the more powerful autocannon variants (though at the cost of reduced ammo capacity).

All rounds damage a larger radius as the size goes up (detailed for each weapon), probability of incendiary rounds starting a fire goes up with the larger rounds,

The same small, medium, and large ammo boxes are used for all three autocannons:

- Autocannon ammo drum (small): Mass: 10 units (100 kg). Cost: $100 each.
- Autocannon ammo drum (medium): Mass: 20 units (200 kg). Cost: $100 each (same as small).
- Autocannon ammo drum (large): Mass: 40 units (400 kg). Cost: $100 each (same as small).

### Light autocannons

Light autocannons are single-barrel weapons with a relatively low fire rate and damage.

[![Light autocannon](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/b/b6/Light_autocannon.png/revision/latest/scale-to-width-down/200?cb=20220129172334)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/b/b6/Light_autocannon.png/revision/latest?cb=20220129172334)

- Cost: $100 (light autocannon), $1/round (kinetic), $2/round (HE, frag, AP, and incendiary)
- Mass: 25 units (250 kg)
- Burst fire rate: 450 rounds/minute (8 ticks per round)
- Maximum burst fire duration: 14.6 seconds
- Cooldown time: 6.266 seconds
- Maximum sustained fire rate: 319 rounds/minute
- Ammo drum capacity: 500 rounds (large), 200 rounds (medium), 100 rounds (small)
- Muzzle velocity: 1,000 m/s
- Projectile lifetime (ticks): 150
- Maximum range: Approx. 750 m
- Drag Coefficient: 0.02

Ammo effects:

- Kinetic: Damages blocks up to half a meter (2 block lengths) away from the impact point. No penetration.
- High explosive: Damages blocks up to half a meter (2 block lengths) away from the impact point. No penetration.
- Fragmentation: Spews shrapnel from the point of impact in all directions. Can penetrate an airgapped wall to spew shrapnel on the other side. Otherwise, only damages the block it hits directly.
- Armor piercing: Can pierce through 8 mass unit/block \* block length
- Incendiary: ~10% chance per shot of starting a fire at the impact point. No penetration.

### Rotary autocannons

Rotary autocannons have a spinning barrel made up of 6 smaller barrels around a central point.

[![Rotary autocannon](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/0/0f/Rotary_autocannon.png/revision/latest/scale-to-width-down/200?cb=20220129170924)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/0/0f/Rotary_autocannon.png/revision/latest?cb=20220129170924)

- Cost: $100 (rotary autocannon), $1/round (kinetic), $2/round (HE, frag, AP, and incendiary)
- Mass: 400 units (4,000 kg)
- Burst fire rate: 1,800 rounds/minute (2 ticks per round)
- Maximum burst fire duration: 5.56 seconds
- Cooldown time: 6.733 seconds
- Maximum sustained fire rate: 814 rounds/minute
- Ammo drum capacity: 250 rounds (large), 100 rounds (medium), 50 rounds (small) [halved compared to light autocannon]
- Muzzle velocity: 1,000 m/s
- Projectile lifetime (ticks): 300
- Maximum range: Approx. 1.5 km
- Drag Coefficient: 0.01

Ammo effects:

- Kinetic: Damages blocks up to 0.75 meters (3 block lengths) away from the impact point. No penetration.
- High explosive: Damages blocks up to 0.75 meters (3 block lengths) away from the impact point. No penetration.
- Fragmentation: Spews shrapnel from the point of impact in all directions. Can penetrate an airgapped wall to spew shrapnel on the other side. Will also damage blocks within 1/4 meter (1 block length) from the point of impact.
- Armor piercing: Can pierce through 10 mass unit/block \* block length
- Incendiary: ~10% chance per shot of starting a fire at the impact point. No penetration.

Note: rotary autocannons require approximately 0.5 seconds to spin up before they will start firing. They spin up and spin down at the same rate and fire once they have spun up, so they can be 'primed' for more responsive firing by spinning up for just under 0.5 seconds and then alternately spinning up then down every other tick. This creates an audible clicking sound.

### Heavy autocannons

[![Heavy autocannon](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f6/Heavy_autocannon.png/revision/latest?cb=20220129172408)

Heavy autocannons are single-barreled and offer high damage with a low fire rate, reduced ammo capacity, and high recoil.

- Cost: $100 (heavy autocannon), $1/round (kinetic), $2/round (HE, frag, AP, and incendiary)
- Mass: 50 units (500 kg)
- Burst fire rate: 112.5 rounds/minute (32 ticks per round if infinite ammo is on, 38 ticks if it is off due to the 6 tick reloading time)
- Maximum burst fire duration: 30 seconds
- Cooldown time: 6.266 seconds
- Maximum sustained fire rate: 99 rounds/minute
- Ammo drum capacity: 100 rounds (large), 40 rounds (medium), 20 rounds (small) [1/5 the ammo capacity of drums storing light autocannon ammo]
- Muzzle velocity: 900 m/s
- Projectile lifetime (ticks): 600
- Maximum range: Approx. 2.5 km
- Drag Coefficient: 0.005

Ammo effects:

- Kinetic: Damages blocks up to 1.25 meters (5 block lengths) from the impact point. No penetration.
- High explosive: Damages blocks up to 1.5 meters (6 block lengths) from the impact point. No penetration.
- Fragmentation: Spews shrapnel from the point of impact in all directions. Can penetrate an airgapped wall to spew shrapnel on the other side. Will also damage blocks within 1/2 meter (2 block lengths) from the point of impact.
- Armor piercing: Can pierce through 14 mass unit/block \* block length
- Incendiary: ~25% chance per shot of starting a fire at the impact point. No penetration. Damages blocks within 0.75 m (3 blocks) of the impact point.

## Heavy cannons

Heavy cannons have a slower fire rate and cause heavy recoil. The lighter variants can be hand-loaded, and all heavy cannons can be automatically loaded with a loading system which automatically opens the breach, feeds in a shell, and then closes the breach in preparation to fire (though this does require player design to construct the feed mechanism).
Note that shell feeding time gets set to 1 when the infinite ammo option is active, making all heavy cannons fire effectively faster.

Heavy cannons can store a single round of ammo in each belt component.

### Battle cannons

Battle cannons can fire five types of rounds: kinetic, high explosive, fragmentation, armor piercing and incendiary. They are light enough to be hand-loaded.

[![Battle cannon](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/5f/Battle_cannon.png/revision/latest?cb=20220129172432)

- Cost: $100 (battle cannon), $100 (battle cannon belt components), $50/shell (kinetic), $100/shell (HE, frag, AP, and incendiary)
- Mass: 100 units (1,000 kg), 1 unit (battle cannon belt components)
- Breach opening time (ticks): 77
- Shell feeding time (ticks): 26
- Breach closing time (ticks): 77
- Maximum rate of fire: 20 shells/minute
- Muzzle velocity: 800 m/s
- Projectile lifetime (ticks): 1500
- Maximum range: Approx. 4.5 km
- Drag Coefficient: 0.002

Ammo effects:

- Kinetic (black tip): Damages blocks up to 1.5 meters (6 block lengths) from the impact point. No penetration.
- High explosive (yellow tip): Damages blocks up to 2.5 meters (10 block lengths) from the impact point. Can only damage armor (weight blocks) up to 1.5 meters (6 block lengths) from the impact point.
- Fragmentation (orange tip): Damages blocks up 1 meter (4 block lengths) from the impact point and spews shrapnel from the point of impact in all directions. Can penetrate an airgapped wall to spew shrapnel on the other side.
- Armor piercing (blue tip): Can pierce through 25 mass unit/block \* block length
- Incendiary (red tip): Damages blocks out to 1.25 meters (5 blocks) from the impact point. ~50% chance per shot of starting a fire at the impact point. No penetration.

### Artillery cannons

Artillery cannons can fire three types of rounds: high explosive, fragmentation, and armor piercing. They are light enough to be hand-loaded as well.

[![Artillery cannon](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/7d/Artillery_cannon.png/revision/latest?cb=20220129172449)

- Cost: $100 (artillery cannon), $100 (artillery cannon belt components), $200/shell
- Mass: 200 units (2,000 kg), 1 unit (artillery cannon belt components)
- Breach opening time (ticks): 130
- Shell feeding time (ticks): 60
- Breach closing time (ticks): 280
- Maximum rate of fire: 7.7 shells/minute
- Muzzle velocity: 700 m/s
- Projectile lifetime (ticks): 2400
- Maximum range: Approx. 6.5 km
- Drag Coefficient: 0.001

Ammo effects:

- High explosive (yellow tip): Damages blocks up to 4 meters (16 block lengths) from the impact point. No penetration.
- Fragmentation (orange tip): Damages blocks up 2 meters (8 block lengths) from the impact point and spews shrapnel from the point of impact in all directions. Can penetrate an airgapped wall to spew shrapnel on the other side.
- Armor piercing (blue tip): Can pierce through 32 mass unit/block \* block length

### Bertha cannons

Bertha cannons are massive cannons which can fire only two types of rounds: high explosive or fragmentation. Unlike artillery and battle cannons, Bertha cannons can only be fed with a machine-loading system. The rounds are too big to pick up or move by hand.

[![Bertha cannon](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/29/Bertha_cannon.png/revision/latest?cb=20220129172548)

- Cost: $100 (bertha cannon), $100 (bertha cannon belt components), $1,000/shell
- Mass: 500 units (5,000 kg), 1 unit (bertha cannon belt components)
- Breach opening time (ticks): 305
- Shell feeding time (ticks): 240
- Breach closing time (ticks): 600
- Maximum rate of fire: 3.1 shells/minute
- Muzzle velocity: 600 m/s
- Projectile lifetime (ticks): 2400
- Maximum range: Approx. 7.5 km
- Drag Coefficient: 0.0005

Ammo effects:

- High explosive (yellow tip): Damages blocks up to 3.75 meters (15 block lengths) from the impact point. No penetration.
- Fragmentation (orange tip): Damages blocks up 3.75 meters (15 block lengths) from the impact point and spews shrapnel from the point of impact in all directions. Can penetrate an airgapped wall to spew copious amounts of shrapnel on the other side. The shrapnel itself damages up to about 0.75 m (3 block lengths) from each impact point.

## Warheads

With the exception of EMP warheads, all warheads are high explosive. They come in small, medium, and large sizes, and can be activated by receiving damage, by impact (if armed and an impact threshold set), or detonated by logic (when armed and no impact threshold set). Warheads are used to make missiles, bombs, heavy rockets, sea mines, depth charges, torpedoes, and self-destruct devices. Vehicles which are overwhelmingly damaged by an explosion get removed without a trace.

Note that blast damage and range is not increased by underwater detonation.

### Small warheads

[![Warhead small](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/69/Warhead_small.png/revision/latest?cb=20220129230259)

These damage everything within 2.5 meters (10 blocks) of the warhead's position when it detonates, a slightly greater damage radius than rockets. Well-suited for use as small missile warheads or cluster munitions.

- Cost: $25
- Mass: 15 (150 kg)

### Medium warheads

[![Warhead medium](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/4/45/Warhead_medium.png/revision/latest?cb=20220129230324)

These damage everything within 3.25 meters (13 blocks) of the warhead's position when it detonates. Their damage radius and size makes them a good choice for torpedoes and long-range guided missiles with advanced guidance systems.

- Cost: $50
- Mass: 80 (800 kg)

### Large warheads

[![Warhead large](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/83/Warhead_large.png/revision/latest?cb=20220129230344)

These damage everything within 3.5 meters (14 blocks) of the warhead's position when it detonates, though there is also shrapnel which damages other nearby structures. Note that these can be dangerous to carry if not well-protected, as they are large targets and even as little as six shots directly from a rifle (or potentially fewer shots from an autocannon with piercing ammo) can set them off.

- Cost: $100
- Mass: 400 (4,000 kg)

### EMP Warheads

[![EMP warhead](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/a6/EMP_warhead.png/revision/latest?cb=20220129230737)

A nearby EMP warhead being set off will cause vehicles to lose power. EMP range is approximately 500 meters. The brief, faint blue flash and "phwew!" sound can be difficult to notice at the limits of its range, but the effect is unmistakable. Circuit breakers will be tripped, and resetting them will not fix the issue. All electronic actuators and control surfaces will stop working, while all gauges and displays will go blank as if they were unconnected. Power will start coming back on after up to 55 seconds (depending on distance) and ramps back up to full power over five seconds.

Given the radius of the effect on EMP warheads, it is advisable to use a microcontroller to serve as a complex warhead trigger. Data from [radar](https://stormworks.fandom.com/wiki/Radar "Radar"), an [impact sensor](https://stormworks.fandom.com/wiki/Impact_sensor "Impact sensor"), and friendly vehicle positions transmitted via [radio](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Radio "Wiki/Building/Components/Radio") can be combined to ensure it only detonates when it is within range of the target and *not* within range of friendlies.

- Cost: $200
- Mass: 500 (5,000 kg)

## Rocket launchers

[![Rocket launcher](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/84/Rocket_launcher.png/revision/latest?cb=20220129230409)

Rocket launchers are highly damaging vehicle-mounted weapons suitable for large and/or stationary targets, like large slow-moving ships. Their damage is very slightly lower yet comparable to a small warhead or an HE shell fired from a battle cannon.

- Cost: $100 (rocket launcher), $50/rocket
- Mass: 50 (500 kg)
- Maximum range: Approx. 2.5 km
- Maximum fire rate: 1 rocket per second (per launcher)
- Speed: ~1000 Blocks per second at launch

Rocket launchers damage everything within 2.25 meters (9 blocks) of the impact point. For reference, this is a 50% larger damage radius than with heavy autocannons firing HE rounds, and a 3.375x greater volume of damage. They also cause zero recoil and don't require any added loaders/ammo reserves making them a decent choice for minimalist and lightweight vehicles.

Note that the cost of the rockets is not included in the apparent $100 cost of the rocket launcher, but $200 will be charged upon spawning the rocket launcher to cover the cost of the four rockets it contains. Unused rockets on a vehicle are refunded when the vehicle is despawned.

Also note that rocket launchers are poorly suited for high speed or evasive targets. They work best on large, slow moving targets.

Also note that rocket launchers **can not** be reloaded.

Rocket launchers can be edited in XML allowing for many modifications. Changing width changes the spread. Changing length increases the projectile speed and damage. Removing width completely creates an invisible weapon.

## Ballistics Calculations

In Stormworks Search and Destroy, some things should be noted when calculating ballistic data

### Gravity

As of [V1.3.6](https://stormworks.fandom.com/wiki/V1.3.6 "V1.3.6") gravity for projectiles is 30 m/s2. This was intended to improve the ability to use artillery and indirect fire on Stormworks map/battle scales. [In contrast, vehicle gravity is exactly 10 m/s2.]

### Drag

Drag is calculated on a per-tick basis, slowing down projectiles proportional to their speed. To calculate drag per tick:

- Find the current velocity of the projectile (initial velocity can be found elsewhere in this wiki. Velocities after projectile initialization can be derived from previous drag calculations).
- Multiply this velocity by 1 minus the drag coefficient. This is now the projectile's new velocity.

Note that this does not apply for warheads; Calculating drag for warheads is based on how the game processes aerodynamics

## See also

- [Damage control](https://stormworks.fandom.com/wiki/Damage_control "Damage control")

## Patch notes

- [V1.11.8](https://stormworks.fandom.com/wiki/V1.11.8 "V1.11.8"):
- Balance - Reduced weapon projectile spread x4
- Balance - Increased machine gun ammo box capacity to 100
- [V1.9.18](https://stormworks.fandom.com/wiki/V1.9.18 "V1.9.18"):
- Fix - #22917 Weapons AI autocannon tanks not firing
- Fix - #22510 #23023 Updated weapons AI boats and fixed AI captain raycasts colliding with character physics
- Fix - #20947 Ordnance type default value
- [V1.8.6](https://stormworks.fandom.com/wiki/V1.8.6 "V1.8.6"):
- Fix - #17520 Rocket launcher weapon now respects relative velocity when fired from a vehicle
- [V1.6.11](https://stormworks.fandom.com/wiki/V1.6.11 "V1.6.11"):
- Fix - #15142 Updated missiles on default weapons AI destroyers
- [V1.5.15-16](https://stormworks.fandom.com/wiki/V1.5.15-16 "V1.5.15-16"):
- Feature - Missile Laser Sensor (#5754 #6954)
- [V1.4.19](https://stormworks.fandom.com/wiki/V1.4.19 "V1.4.19"):
- Fix - #6995 Prefab rocket launchers mirror incorrectly
- Fix - #7388 Npcs not taking vehicle fire damage
- Fix - #7673 Updated small warhead meshes to match with SRBs and radar
- Fix - #7705 Corrected cannon belt mass values
- [V1.4.18](https://stormworks.fandom.com/wiki/V1.4.18 "V1.4.18"):
- Fix - #6558 Removed ability to place C4 on characters
- Fix - #2126 Ammo Belts not refunding when editing a vehicle
- Fix - #7253 Weapons can now fire underwater

## References

- [Steam Workshop: Ballistic Calculator Sample](https://steamcommunity.com/sharedfiles/filedetails/?id=2628490430) - Ballistic data source.

---

Source: [Search and Destroy DLC](https://stormworks.fandom.com/wiki/Search_and_Destroy_DLC) · Revision 4717 · CC BY-NC-SA
