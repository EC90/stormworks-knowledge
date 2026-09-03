---
title: "Impact sensor"
source_url: "https://stormworks.fandom.com/wiki/Impact_sensor"
page_id: 1348
revision_id: 3033
revision_timestamp: "2022-01-31T01:16:18Z"
retrieved_at: "2026-08-31T10:03:31+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Components"]
---
# Impact sensor

## Specifications

| Field | Value |
| --- | --- |
| Name | Impact Sensor |
| Image | 200px |
| Mass | 1 |
| Dimensions | 1x1x1 |
| Cost | $20 |
| Logic inputs | None |
| Logic outputs | Bool (acceleration threshold exceeded) |
| Connections | None |
| Adjustable parameters | Impact threshold (1-50 m/s) |
| Since version | V1.1.18 |

Impact sensors detect when they are accelerated beyond their set limit. They were initially added for the [Weapon DLC](https://stormworks.fandom.com/wiki/Weapon_DLC) to serve as triggers for warheads. Note that they are no longer strictly required for that purpose since, as of [V1.3.14](https://stormworks.fandom.com/wiki/V1.3.14), warheads have been modified to have built-in impact sensing capability.

## Uses

- Autonomous vehicle damage detection: Unmanned tanker ships making trips to the arctic may run into moving icebergs. Such ships should normally have very low acceleration, but an iceberg collision could easily set off an impact sensor, allowing it to trigger a distress signal and get a player to fix it.

- Complex warhead triggers: Some missile designs are intended to have multiple sensors to trigger them (e.g. impact or proximity), and sometimes several conditions to prevent activation (e.g. proximity to friendly vehicles) especially with long-range effects like [EMP warheads](https://stormworks.fandom.com/wiki/Weapon_DLC#EMP_Warheads)). For these, a microcontroller may combine data from radar, an impact sensor, and [radio](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Radio) to trigger a 0-threshold warhead only when it is appropriate to do so.

## Patch history

### [V1.3.14](https://stormworks.fandom.com/wiki/V1.3.14)

- Feature - Warhead built-in impact sensor

### [V1.1.18](https://stormworks.fandom.com/wiki/V1.1.18)

- Feature - Impact sensor - triggers ON signal when acceleration exceeds the value set in properties

---

Source: [Impact sensor](https://stormworks.fandom.com/wiki/Impact_sensor) · Revision 3033 · CC BY-NC-SA
