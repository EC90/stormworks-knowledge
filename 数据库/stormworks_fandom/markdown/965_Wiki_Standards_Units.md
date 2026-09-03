---
title: "Wiki/Standards/Units"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Standards/Units"
page_id: 965
revision_id: 1928
revision_timestamp: "2019-05-15T12:29:09Z"
retrieved_at: "2026-08-31T10:12:46+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Wiki/Standards/Units

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Wiki/Standards/Units?action=edit). |
| --- | --- |

## Units

The game itself uses the metric system and the radians system (not degree). You should provide sensor data to the player in the metric system too. In case you are from the US or some other country not using the metric system you should use a toggle button + numeric switchbox to switch between metric(default) and imperial units.

### Distances

Meters (Altitude Sensor, Distance Sensor, Track positions, Winch lengths ...)

### Time

Seconds (Speed: meter per second, ) Tick (used in timers for microcontrollers)

**Special Case: Clock** The clock value ranges from 0 (midnight) over 0.5 (12 o'clock) to 1 (midnight again).

### Rotation

Rotation values (e.g. pivots) use values from -1 (maximum negative rotation = -180°) over 0 (no rotation) to 1 (maximum positive rotation = 180°). Hinges: -1 means -90°, 0 means no rotation, 1 means 90°.

---

Source: [Wiki/Standards/Units](https://stormworks.fandom.com/wiki/Wiki/Standards/Units) · Revision 1928 · CC BY-NC-SA
