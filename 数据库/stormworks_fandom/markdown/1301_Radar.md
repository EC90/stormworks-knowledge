---
title: "Radar"
source_url: "https://stormworks.fandom.com/wiki/Radar"
page_id: 1301
revision_id: 4711
revision_timestamp: "2026-04-06T21:32:17Z"
retrieved_at: "2026-08-31T10:04:38+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Electronic_components", "Sensor_components"]
---
# Radar

Radar detects other vehicles and provides a direction and distance to them. It can be used to locate vessels in need of assistance, avoid collisions, detect enemy vehicles, and track vehicles with turrets or cameras.

This page was last updated for [V1.15.2](https://stormworks.fandom.com/wiki/V1.15.2) (19 August 2025).

## Settings

### Sweep mode

Can be clockwise, counterclockwise, sweep, static, or manual.

In clockwise or counterclockwise mode, the radar will continuously turn in full circles and its output channels will indicate any radar contacts that happen to be visible. In sweep mode, the radar will go back and forth, passing along the center point. In either of these modes, it is recommended to set a large FOV Y and small FOV X (see below). All of these modes can be useful in search and rescue.

In static mode, the radar will only look straight ahead (in the direction of the arrow visible when it is placed). This mode is useful for automated turrets and missiles which need to continuously aim at a target. It can also be useful for externally-turned radars, like a simple radar with high FOV Y on a velocity pivot with a spotlight and buzzer set to turn on when it detects something, a trivially-easy way to indicate the direction towards nearby vehicles.

In all of the above modes, a pitch angle can be set in the radar's settings screen to make it look up or down by up to 45 degrees (0.125 turns). This can be useful, for example, for setting a look-down radar in a search-and-rescue helicopter to avoid getting confused with AI aircraft. Similarly, an air-defense turret might be configured to look up to avoid targeting surface craft.

In manual mode, the radar takes two values at its composite input, 1) Yaw 2) Pitch. The Azimuth and Elevation outputs have the slew accounted for. Both values are measured in turns. Both values are limited only by what the radar is capable of, so it is possible to yaw a full 360 degrees around but it can only look up or down by 45 degrees. Additional mechanisms can be used (e.g. a robotic pivot) if further tilt is required.

### FOV X & Y

FOV on radar is measured in pi radians (which are equal to 180.0 degrees), and determines the maximum angle that the radar can see from the center point (along the arrow visible in the workbench editor). With the max FOV X of 0.25, the radar can see 45 degrees left and right of the arrow, while maximum FOV Y would see 45 degrees above and below the arrow. Note that radar range is reduced as FOV X and FOV Y are increased.

When the radar is in any mode other than static mode, it will move the center point left and/or right. This means that a maximum FOV Y will swept through the entire airspace around the vehicle, while a maximum FOV X would just detect targets for longer when doing such a sweep, but only scan a tiny horizontal slice. Thus, to maximize detection range, a high FOV Y and low FOV X can be used.

## Radar components

Sorted by size (along with range, cost, and power consumption), the available radars from smallest to largest are as follows:

| Radar type | Mass (kg) | Cost ($) | Power consumption (swatts/second) | Max range (km)† | Fan range (km)‡ | Min range (km)1 |
| --- | --- | --- | --- | --- | --- | --- |
| Radar (Missile) | 50 | 800 | 0.137 | 80 | 3.2 | 0.13 |
| Radar (Basic) | 100 | 1,000 | 0.360 | 240 | 9.6 | 0.37 |
| Radar (Phalanx) | 550 | 2,000 | 0.602 | 400 | 16 | 0.60 |
| Radar (Dish) | 5,500 | 5,000 | 1.20 | 800 | 32 | 0.92 |
| Radar (AWACS) | 11,000 | 10,000 | 3.00 | 2,000 | 80 | 2.75 |

- †: Minimum FOV Y & FOV X.
- ‡: Maximum FOV Y and minimum FOV X.
- 1: Maximum FOV Y & FOV X.

### Detection range

The max detection range depends on target mass and max radar range. So a vehicle with very low mass will be more stealthy than a vehicle with a higher mass.

Max detection range = Vehicle mass/250*max radar range

## Detectability

Radars can detect [players](https://stormworks.fandom.com/wiki/Player), vehicles, and animals.

Radars will not detect:

- Their own vehicle, nor any of its subgrids,
- Rockets or shells in flight,
- Moveable objects.

## Composite output

Radars provide a composite output with up to 32 numeric channels and 8 boolean channels. The boolean channels simply indicate whether or not a target was detected. Radars are limited to detecting a maximum of 8 targets. The targets with the highest signal strength are given the highest positions in the list, so if nothing is detected on boolean channel 1, nothing will be present on any of the other channels.

When radar is modified in xml then only distance output is working. Other output signals are distorted. They are a good option for simple proximity fuzes. By placing several radars, you can create a system that calculates differences in distance and calculates the direction of the target.

The signal strength value is not exposed on an output of the new radar but is still used for the calculations, however (deprecated) radars do have signal strength exposed as an output meaning you can subtract the distance from (deprecated) radars to get the mass of your target.

Signal strength = (Vehicle mass/distance)

The numeric channels can give positional information on up to eight different radar contacts, with groups of 4 sequential channels being used for each detected radar contact. The channels for each contact follow a pattern of "distance", "x bearing", "y elevation", and "time since detected", so channels 1-4 cover the first contact, channels 5-8 cover the second, and so on.

### Distance

The distance (channel 1 out of 4) provides the straight-line distance to the target in meters, the same unit used by lasers and GPS systems, so no unit conversion is required. Note that there is some 'jitter' in the output, so accurately estimating a vehicle's position and speed requires averaging at least a few ticks' worth of data.

### Azimuth

The azimuth angle (channel 2 out of 4) is the horizontal angle to the target in turns (multiply by 2π to get radians), with left being negative and right being positive. Like distance, this suffers from jitter, and if all sensor tick delays are not synced exactly (radar, tilt, compass sensor), then vehicle movements can throw this off. Note that every logic component (including components in a microcontroller) adds a delay of one tick to the output.

Note: If using a radar in 'static' sweep mode, multiply this value by 8 to provide a laser distance sensor pointed in the same direction with the correct azimuth adjustment to aim at the detected target. The same principle applies to elevation. This can be useful for observing the jitter effect, seeing how movement and acceleration can reduce accuracy, and evaluating any smoothing methods you may be using to improve accuracy.

### Elevation angle

The elevation angle (channel 3 out of 4) is the vertical angle to the target in turns, with up being positive and down being negative. Like azimuth, it also suffers from jitter and requires sensor synchronization.

### Time since detected

This channel indicates the number of ticks since the contact was detected - sort of. It is not particularly useful, but details for the curious are provided below.

When no contact has been detected yet, this channel will have a value of 0.

On the first tick in which a contact has been detected, this value will still be zero but the detected boolean will be true.

After that first tick, this value will start to increment by 1 each tick until it reaches some constant number n, at which point it will reset back to 0. Note that the radar will continue to provide distance, azimuth and elevation data about whatever target was detected at least until the nth tick is reached, even when the target is no longer be in the radar's FOV. After reaching n, the subsequent tick will reset. Time since detected will return to zero, even if the same target is still within its FOV). The target detected boolean will return to false if nothing is in the FOV, or true if the same target or some other target is within the FOV.

The value of n is a constant for any particular radar based upon the settings it spawned with, though it increases with the scan range of the radar and decreases with increasing FOV. The n value appears to be consistently equal to scan range/2000, rounded to the nearest integer, minus 1. For example:

- An AWACS radar with FOV X = 0.01 and FOV Y = 0.15 has a scan range of 133,333 m, and an n value of 66.
- An AWACS radar with FOV X = 0.02 and FOV Y = 0.25 has a scan range of 40,000 m and an n value of 19.
- A dish radar with FOV X = 0.02 and FOV Y = 0.25 has a scan range of 16,000 m and an n value of 7.
- A dish radar with FOV = 0.01 and FOV Y = 0.15 has a scan range of 53,333 m and an n value of 26.
- A dish radar with FOV = 0.01 and FOV Y = 0.21 has a scan range of 38,095 m and an n value of 18.
- A dish radar with FOV = 0.01 and FOV Y = 0.25 has a scan range of 32,000 m and an n value of 15.

Thus, for a quickly rotating scanner with a narrow FOV X, if time since detected = 0, and a target is reported as detected, this is a newly detected target, and each increment after that until the reset will be the same target. For a slowly rotating scanner (and/or those with wide FOV X), time since detected is meaningless since it could be any number from 0 to n yet still be the same target.

In general, the "time since detected" channel is useless. By converting the target's position into world coordinates (see below), a target can be continuously tracked in a manner that will also carry over beyond each scanner pass. As such, radar systems can safely ignore this channel. To implement this easily, note that inside a microcontroller, channels connected on a composite write element will overwrite any channels which come from a composite input to that channel, but any channels not connected will not be overwritten. As such, you can simply connect the radar composite input directly into the composite input of a 32-channel numerical composite write block, and then feed any other numeric data that you need into channels 4, 8, 16, ... , leaving all other channels unconnected so they will not be overwritten.

### Converting to coordinates

For reference, the world map uses X and Y (as obtained from a GPS) to represent coordinates. X goes left and right (east/west), with increasing values towards the right. Y goes up and down (north/south), with increasing values towards the top. However, note that [compass sensors](https://stormworks.fandom.com/wiki/Compass_Sensor) read 0 when pointing north, though this can be corrected to match with normal trigonometric standards (radians from east) using the code snippet on the compass page. Also note that [camera stabilized](https://stormworks.fandom.com/wiki/Camera_stabilized) can give confusing coordinates, as it uses Y to represent altitude (equivalent to altimeter) and Z to represent north/south position (equivalent to GPS Y).

If we assume the radar is pointing directly east (0° - we'll correct for this later) without pitch and roll, and if we suppose X is used for east/west, Y for north/south, and Z for altitude, then the radar values can be converted into local radar coordinates as follows:

- X = sqrt(distance2 - Y2 - Z2)
- Y = sin(-azimuth angle in radians) * distance
- Z = sin(elevation angle in radians) * distance

Of course, in practice, the radar won't be pointing directly east and there will usually be at least some pitch and roll to contend with as well. Thus, we'll want to apply a [matrix rotation](https://en.wikipedia.org/wiki/Rotation_matrix) to convert to actual local coordinates. Assume our inputs are bearing (radians from east, calculated as noted above), pitch (radians from pointing horizontal - directly from a forward-facing tilt sensor), and roll (radians from zero roll - directly from a right-facing tilt sensor).

- φ = rotation about the x-axis (roll)
- θ = rotation about the y-axis (pitch)
- ψ = rotation about the z-axis (yaw/bearing)

| 1 | 0 | 0 |
| --- | --- | --- |
| 0 | cos(φ) | -sin (φ) |
| 0 | sin(φ) | cos(φ) |

| cos (θ) | 0 | sin (θ) |
| --- | --- | --- |
| 0 | 1 | 0 |
| -sin (θ) | 0 | cos(θ) |

| cos (ψ) | -sin (ψ) | 0 |
| --- | --- | --- |
| sin (ψ) | cos (ψ) | 0 |
| 0 | 0 | 1 |

If we multiply each of these matrices together, and then multiply that by a column vector with the original (unrotated) local coordinates, we rotate the original coordinates into actual local coordinates.

Add the vehicle's X, Y, and Z position to the target's local coordinates to get the target's world coordinates.

### Gimbal lock warning

A pitch or roll angle of greater than π/2 (90°) will cause erroneous results.

## See also

- [Radar Detector](https://stormworks.fandom.com/wiki/Radar_Detector)

## Patch notes

### [V1.15.2](https://stormworks.fandom.com/wiki/V1.15.2)

- Feature - composite input for gimbal radar

### [V1.7 .0](https://stormworks.fandom.com/wiki/V1.7_.0)

- Rework - Radar now ignores moveable class objects

### [V1.5.14](https://stormworks.fandom.com/wiki/V1.5.14)

- Fix - [#12347](https://geometa.co.uk/support/stormworks/12347) Radars now ignore rotor child physics

### [V1.5.2](https://stormworks.fandom.com/wiki/V1.5.2)

- Fix - [#8838](https://geometa.co.uk/support/stormworks/8838) [#8728](https://geometa.co.uk/support/stormworks/8728) Radar does not detect tilted vehicle

### [V1.4.18](https://stormworks.fandom.com/wiki/V1.4.18)

- Fix - [#2003](https://geometa.co.uk/support/stormworks/2003) Inverting radars causes them to detect behind the radar/inverted detection

### [V1.4.7](https://stormworks.fandom.com/wiki/V1.4.7)

- Fix - [#2943](https://geometa.co.uk/support/stormworks/2943) Increased relevance threshold for radar hits by 10x

### [V1.3.14](https://stormworks.fandom.com/wiki/V1.3.14)

- Feature - Radar "missile instructions" output composite
- Feature - [Chaff flares](https://stormworks.fandom.com/wiki/Flare_Launcher#Flare_types)
- Feature - Flare launcher trigger passthrough node
- Feature - New example missile launcher
- Rework - Radar tracking algorithm improved
- Fix - Updated radar descriptions to explain sensitivity
- Fix - Remove extra physics voxel from missile radar
- Added new AI warship variant that is armed with a radar missile array carrying eight radar-guided missiles.

### [V1.3.7](https://stormworks.fandom.com/wiki/V1.3.7)

- Rework - radar threshold for detection is now higher for weaker radars
- Fix - rescaled radar range

### [V1.3.6](https://stormworks.fandom.com/wiki/V1.3.6)

- Fix - Re-Added radar effective range preview after fixing associated crashes
- Fix - Radar descriptions still mentioning radians
- Fix - Phalanx radar editor arrow height
- Fix - Missile radar detection angle output

### [V1.3.1-4](https://stormworks.fandom.com/wiki/V1.3.1-4)

- Rework - radars no longer consume electric when off, rescaled electric consumption based on size
- Rework - updated radar descriptions to use turns unit
- Fix - fixed crash related to radar properties menu
- Fix - fixed radars rendering with pitch angle
- Fix - fixed missile radar detection orientation
- Fix - added correct surfaces to bottom of radar parts

### [V1.3.0](https://stormworks.fandom.com/wiki/V1.3.0)

- Rework - Radars now output and input using turns instead of radians/degrees
- Balance - Radar max ranges increased 10x

- Fix - Radars missing from research group
- Fix - Radar rendering issues
- Fix - Greatly reduce radar random noise
- Fix - Missing buoyancy surfaces on radars
- Fix - Missing Pitch Angle slider on radars

### [V1.2.29](https://stormworks.fandom.com/wiki/V1.2.29)

- Feature - Added 5 new advanced radars

### [V1.1.23-24](https://stormworks.fandom.com/wiki/V1.1.23-24)

- Fix - Multi-target radar can now detect 8 targets instead of 7

### [V1.1.19](https://stormworks.fandom.com/wiki/V1.1.19)

- Fix - Radar/Sonar small tracking issue

### [V1.0.33](https://stormworks.fandom.com/wiki/V1.0.33)

- Fix - Radar detection for rotated bodies

### [V1.0.1-14](https://stormworks.fandom.com/wiki/V1.0.1-14)

- Fix - CTD when radar raycasts physics with no user data

### [V1.0.0](https://stormworks.fandom.com/wiki/V1.0.0)

- Fix - Radar and Sonar now only detect targets above and below sea-level respectively

### [V0.10.32-33](https://stormworks.fandom.com/wiki/V0.10.32-33)

- Feature - [Radar Detector](https://stormworks.fandom.com/wiki/Radar_Detector)

### [V0.9.1-2](https://stormworks.fandom.com/wiki/V0.9.1-2)

- Rework - Increased raycast origin height of Phalanx Radar

### [V0.8.32-33](https://stormworks.fandom.com/wiki/V0.8.32-33)

- Fix - Greatly reduced effect of FOV on radar range

### [V0.8.22-23](https://stormworks.fandom.com/wiki/V0.8.22-23)

- Fix - Crash with multiple obscured bodies with Huge Radar

### [V0.8.20-21](https://stormworks.fandom.com/wiki/V0.8.20-21)

- Fix - Updated radar descriptions
- Feature - 3 New Radar Types
- Fix - Radar descriptions updated to be more intuitive
- Fix - Radars output angles are no longer 0.25 turns offset
- Fix - Radar freezing game when two objects are at the same distance
- Fix - Radars now have blue arrows in editor for ease of use

### [V0.8.19](https://stormworks.fandom.com/wiki/V0.8.19)

- Feature - Radar component

## External links

- [YouTube: Multiplying a matrix by a matrix | Matrices | Precalculus | Khan Academy](https://www.youtube.com/watch?v=OMA2Mwo0aZg)
- [YouTube: Rotations in 3D](https://www.youtube.com/watch?v=wg9bI8-Qx2Q)

---

Source: [Radar](https://stormworks.fandom.com/wiki/Radar) · Revision 4711 · CC BY-NC-SA
