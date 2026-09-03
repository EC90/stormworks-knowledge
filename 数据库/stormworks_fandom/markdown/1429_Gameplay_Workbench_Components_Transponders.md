---
title: "Gameplay/Workbench/Components/Transponders"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Transponders"
page_id: 1429
revision_id: 4185
revision_timestamp: "2025-05-14T02:40:55Z"
retrieved_at: "2026-08-31T10:02:58+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: []
---
# Gameplay/Workbench/Components/Transponders

Transponders are used as emergency rescue beacons to locate players and vehicles in need of help.

## Mechanics

When a transponder is activated, active transponder locators will occasionally generate transponder pulses. The frequency of the transponder pulses is proportional to the distance from the transponder, so you get more frequent transponder pulses as you get closer.

### Frequency

The distance and frequency relationship is closely approximated by the following formula:

```
0.02*d+5 = t
```

Where d is the distance (in meters) and t is the time (in ticks which are 1/60th of a second).

Conversely:

```
d = t*50 - 250
```

### Range

The maximum range for transponders (if there is one) is over 110 km, i.e. far enough for signals to span from the desert landmass in the south to the arctic airbase in the north.

The minimum range for vehicle transponders is about 250 meters. Below this distance, no matter how close the transponder and transponder locator become, there will still be an interval of 10 ticks between each transponder pulse. Handheld locators can help to home in on signals within this distance if the source isn't obvious.

## Personal equipment

Handheld transponders are available to players. These can be set to a man-overboard mode which will automatically turn on if the player becomes submerged.

Handheld radio signal locators can also be used to narrow down the precise location of a signal. They work similar to vehicle-mounted transponder locators by providing audible beeps which get more frequent as you get closer. They have a shorter detection range but also work better at short distances. They reach their maximum beep rate at about 50 meters from a transponder, allowing for somewhat better precision than vehicle-mounted locators.

---

Source: [Gameplay/Workbench/Components/Transponders](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Transponders) · Revision 4185 · CC BY-NC-SA
