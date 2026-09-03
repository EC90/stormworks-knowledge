---
title: "Flare Launcher"
source_url: "https://stormworks.fandom.com/wiki/Flare_Launcher"
page_id: 1303
revision_id: 3104
revision_timestamp: "2022-02-18T02:55:11Z"
retrieved_at: "2026-08-31T10:01:48+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Components"]
---
# Flare Launcher

## Specifications

| Field | Value |
| --- | --- |
| Name | Flare Launcher |
| Image | 200px |
| Mass | 1 |
| Dimensions | 1×1×1 |
| Cost | $10 |
| Logic inputs | Boolean (Launch) |
| Logic outputs | Boolean (Launch passthrough) |
| Connections | None (No power required) |

Flare Launchers are vehicle-mounted systems to deploy flares. They are one-time-use and cannot be reloaded, though [hardpoints](https://stormworks.fandom.com/wiki/Hardpoint) can be used to create disposable flare pods which can be replaced like any other ordnance.

Deployed flares last for three minutes. They can be picked up by hand without injury and do not risk igniting vehicles.

Flares can be used for illumination during nighttime search-and-rescue operations (e.g. when trying to find stranded swimmers). They can also be used for signalling, providing a way for vehicles to report their position.

[Infrared](https://stormworks.fandom.com/wiki/Infrared_mode) flares can be used to provide illumination for infrared [cameras](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Video/Cameras). These flares have about 1/4 the normal visible illumination, but still retain full visibility in infrared.

## Flare types

- Illumination: Provides bright illumination over a wide area but quickly falls to the ground. Can be used for signalling, including alerting rescuers to your location.

- Smoke: Provides some illumination and creates a billowing cloud of smoke. Can be used by aircraft to mark ground locations for rescuers to go to, as the smoke can be seen over terrain obstacles.

- Illumination parachute: Like an illumination flare, but falls slowly, providing good area lighting for a while. Excellent source of illumination for nighttime search-and-rescue operations (e.g. when trying to find stranded swimmers), especially as several can be spread over a wide area.

- Smoke parachute: Like the smoke flare but falls slowly. Largely decorative use, though can be used as a crude wind gauge.

- Chaff: Looks like a faintly sparkling cloud. Can be detected by [radar](https://stormworks.fandom.com/wiki/Radar), and if it is closer than the vehicle it was launched from, it will appear as the first target, potentially causing missiles to go off course and auto-turrets to aim into the air. Unlike the other options, chaff clouds only last about six seconds.

## Logic

Flares will launch when they receive an 'on' signal. They can be daisy-chained by connecting the launch passthrough output to the next flare launcher. When an empty flare launcher receives an 'on' signal, its launch passthrough will be set to on to launch the next flare. A blinker can be used to cause repeated flare launches, such as if sustained chaff is required.

---

Source: [Flare Launcher](https://stormworks.fandom.com/wiki/Flare_Launcher) · Revision 3104 · CC BY-NC-SA
