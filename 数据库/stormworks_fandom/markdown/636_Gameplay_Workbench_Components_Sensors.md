---
title: "Gameplay/Workbench/Components/Sensors"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Sensors"
page_id: 636
revision_id: 4637
revision_timestamp: "2025-08-24T02:28:59Z"
retrieved_at: "2026-08-31T10:02:55+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Gameplay/Workbench/Components/Sensors

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Sensors?action=edit). |
| --- | --- |

## Sensors

## Environment

Player Sensor

[![Player Sensor](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/99/Player_Sensor.jpg/revision/latest/scale-to-width-down/100?cb=20190419122800)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/99/Player_Sensor.jpg/revision/latest?cb=20190419122800)

- Output 1 (Number): Number of players detected
- Output 2 (On/Off): if at least one player is detected

Types:

- Sphere (Trigger is a ball around the sensor)
- Hemisphere (is half of a ball = just in the front)

Mode:

- Detect All
- Detect Players
- Detect NPCs

Radius:

- Minimum 0.25m (1 block)
- Maximum 10m (40 blocks)

Wind Sensor

[![Wind Sensor](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/4/41/Wind_Sensor.jpg/revision/latest/scale-to-width-down/100?cb=20190317011242)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/4/41/Wind_Sensor.jpg/revision/latest?cb=20190317011242)

- Output 1 (Number): Relative direction of the wind
- Output 2 (Number): Relative speed of the wind (in m/s)

Rain Sensor

[![Rain Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/a2/Rain_Sensor.jpg/revision/latest?cb=20190317011222)

- Output 1 (Number): How intense its raining (0 - Sunny, 1 - Thunderstorm)

Humidity Sensor

[![Humidity Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/dc/Humidity_Sensor.jpg/revision/latest?cb=20190317011207)

- Output 1 (Number): Humidity (0 - No fog, 1 - Max fog)

Temperature Sensor

[![Temperature Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/87/Temperature_Sensor.png/revision/latest?cb=20200130202517)

- Output 1 (Number): Ambient room temperature in °C

## Position of Vehicle relative to the world

Tilt Sensor

[![Tilt Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/8b/Tilt_Sensor.jpg/revision/latest?cb=20190317011229)

- Output 1 (Number): The "angle" of tilt. 0.25 is +90 degree, -0.25 is -90 degree. Zero is defined by the direction of the block (blue arrow when placing).

Physics Sensor

[![Linear Speed Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/2b/Linear_Speed_Sensor.jpg/revision/latest?cb=20190317011212)

- The physics sensor component combines functionality of several other sensors into a single block. The sensor outputs position, rotation, linear and angular speeds over 14 composite channels detailed on the component, where the red arrow is the X-axis, the green arrow is the Y-axis, and the blue arrow is the Z-axis.

The composite output is:

- Output 1 to 3 (Number): X, Y and Z position of the block
- Output 4 to 6 (Number): Euler rotation X, Y and Z of the block
- Output 7 to 9 (Number): Linear velocity X, Y and Z of the block
- Output 10 to 12 (Number): Angular velocity X, Y and Z of the block
- Output 13 (Number): Absolute linear velocity of the block
- Output 14 (Number): Absolute angular velocity of the block
- Output 15 (Number): Local Z tilt (pitch)
- Output 16 (Number): Local X tilt (roll)
- Output 17 (Number): Compass heading (-0.5 to 0.5)

Note that modifying physics sensor in xml to make it invisible also disturbs output 17.

Linear Speed Sensor

[![Linear Speed Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/2b/Linear_Speed_Sensor.jpg/revision/latest?cb=20190317011212)

- Output 1 (Number): Speed in m/s.

There are different modes:

- Absolute: The speed without caring about direction.
- Horizontal: The horizontal speed.
- Vertical: The vertical speed.
- Directional: The speed in the axis of the sensor. This is the only mode in which the orientation of the sensor matters.

Distance Sensor

[![Distance Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/73/Distance_Sensor.jpg/revision/latest?cb=20190317011132)

- Output 1 (Number): Distance to the next block (in the direction of blue arrow when placing). Max range: 500m
- when nothing is detected, it will output 500m.

Laser Distance Sensor

[![Laser Distance Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/84/Laser_Distance_Sensor.png/revision/latest?cb=20200130200837)

- Similar to distance sensor, but has a higher max range (4000m).
- when nothing is detected, it will output 4000m.
- also shows a cool laser beam when active
- Optional IR mode hides visible laser (unless using Night Vision)

Laser Point Sensor

[![Laser Point Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/b/b7/Laser_Point_Sensor.png/revision/latest?cb=20200130200841)

- can detect laser beacons and tell you in which direction the laser beacon is.

Laser Beacon

[![Laser Beacon](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/5e/Laser_Beacon.png/revision/latest?cb=20200130200845)

Needed for the Laser Point Sensor.

[Compass Sensor](https://stormworks.fandom.com/wiki/Compass_Sensor)

[![Compass Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f8/Compass_Sensor.jpg/revision/latest?cb=20190317011124)

- Output 1 (Number): your direction relative to the north

Altimeter

[![Altimeter](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/0/08/Altimeter.jpg/revision/latest?cb=20190317011110)

- Output 1 (Number): the height relative to the sea level in meters.

GPS

[![GPS](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f3/GPS.jpg/revision/latest?cb=20190317011201)

- Output 1 (Number): the x coordinate.
- Output 2 (Number): the y coordinate.

## Mechanical

Torque Meter

[![Torque Meter](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/22/Torque_Meter.jpg/revision/latest?cb=20190317011236)

- Output 1 (Number): the RPS (rotations per second).
- Output 2 (Number): the force.

## Radar

Basic Radar

[![Stormworks-radar-basic](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/0/07/Stormworks-radar-basic.jpg/revision/latest?cb=20240829151115)

- Can detect vehicles and persons in a radius around it.
- For more informations on the radar Please visit
- [https://stormworks.fandom.com/wiki/Radar](https://stormworks.fandom.com/wiki/Radar)

Phalanx Radar

[![Strormworks-Radar-Phalanx](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/9f/Strormworks-Radar-Phalanx.jpg/revision/latest?cb=20240829151115)

- Can detect vehicles and persons in a radius around it.

Radar Dish / Large radar

[![Stormworks-radar-dish](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/1/11/Stormworks-radar-dish.jpg/revision/latest?cb=20240829151115)

- Can detect vehicles and persons in a radius around it.

Radar AWACS / Huge Radar

[![Stormworks-radar-awacs](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/a1/Stormworks-radar-awacs.jpg/revision/latest?cb=20240829151114)

- Can detect vehicles and persons in a radius around it.
- Largest Radar in game

Missle Radar

[![Stormworks-radar-missle](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/4/42/Stormworks-radar-missle.jpg/revision/latest?cb=20240829151115)

- Can detect vehicles and persons in a radius around it.
- Desinged to be used on missles
- Has a specialized composite port to be able to connect to rocket fins

## Sonar

A sonar that returns information about detected objects within range. This sensor outputs the relative angle to underwater sound waves. The sensor can passively detect certain noisy components such as propellers or engines, but it can also send out a loud ping to detect quiet underwater bodies. While the ping input is held, passive signals will be suppressed. After activating, another ping will overwrite the previous one, and no further data will be returned from the old signal.

Smal Sonar

[![Stormworks-smal-sonar](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/ed/Stormworks-smal-sonar.jpg/revision/latest?cb=20240829150026)

- Can detect Bodies in a radius of 60km around it.
- Has a specialized composite port to be able to connect to rocket fins

Smal Sonar

[![Stormworks-Medium-Sonar](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/b/ba/Stormworks-Medium-Sonar.jpg/revision/latest?cb=20240829152459)

- Can detect Bodies in a radius of 100km around it.

Smal Sonar

[![Stormworks-Large-Sonar](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/0/00/Stormworks-Large-Sonar.jpg/revision/latest?cb=20240829152500)

- Can detect Bodies in a radius of 200km around it.

## Fluid

Fluid Pressure Sensor

[![Fluid Pressure Sensor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/1/1d/Fluid_Pressure_Sensor.jpg/revision/latest?cb=20190317011155)

- Output 1 (Number): the pressure.

Fluid Meter

[![Fluid Meter](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/0/08/Fluid_Meter.jpg/revision/latest?cb=20190317011147)

- Output 1 (Number): the capacity of the surrounding room.
- Output 2 (Number): the amount of fluid in the surrounding room in liters.

## Other

Clock

[![Clock](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/20/Clock.jpg/revision/latest?cb=20190317011116)

- Output 1 (Number): the current time (0 = 12am, 0.5 = 12pm)

---

Source: [Gameplay/Workbench/Components/Sensors](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Sensors) · Revision 4637 · CC BY-NC-SA
