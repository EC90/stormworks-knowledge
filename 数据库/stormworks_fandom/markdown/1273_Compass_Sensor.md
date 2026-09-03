---
title: "Compass Sensor"
source_url: "https://stormworks.fandom.com/wiki/Compass_Sensor"
page_id: 1273
revision_id: 4718
revision_timestamp: "2026-08-16T19:43:51Z"
retrieved_at: "2026-08-31T10:01:21+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Electric_components", "Sensor_components"]
---
# Compass Sensor

## Specifications

| Field | Value |
| --- | --- |
| name | Compass Sensor |
| image | 200px |
| cost | $20 |
| dimensions | 1×1×1 |
| mass | {{Property\|mass}} 1 |
| logicinput1 | {{Property\|onoff}} Backlight |
| logicoutput1 | {{Property\|number}} Compass Reading |
| connection1 | {{Property\|electric}} Electric |

## Compass Sensor

[![Compass Sensor](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f8/Compass_Sensor.jpg/revision/latest/scale-to-width-down/267?cb=20190317011124)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f8/Compass_Sensor.jpg/revision/latest?cb=20190317011124)

### Cost

$20

### Dimensions

1×1×1

## Properties

| mass 1 |

## Logics Inputs

| onoff Backlight |

## Logic Outputs

| number Compass Reading |

## Connections

| electric Electric |

Compass sensors output the direction of their forward arrow (visible in the vehicle creator) relative to north. They yield values of between 0.49999 and -0.49999.

In-game, the red arrow on the compass sensor is the one which points north.

A compass sensor's input can be converted to radians from east (for use with other trig functions) with the following function, '%(((x+1.25)*pi2), pi2)' or with Lua using the following code inside of onTick():

compass_input = input.getNumber(whatever input channel) pi2 = math.pi*2 rads_from_east = math.fmod ((compass_input+1.25)*pi2, pi2)

---

Source: [Compass Sensor](https://stormworks.fandom.com/wiki/Compass_Sensor) · Revision 4718 · CC BY-NC-SA
