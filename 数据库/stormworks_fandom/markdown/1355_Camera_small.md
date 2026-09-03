---
title: "Camera small"
source_url: "https://stormworks.fandom.com/wiki/Camera_small"
page_id: 1355
revision_id: 3054
revision_timestamp: "2022-02-12T05:25:33Z"
retrieved_at: "2026-08-31T10:01:08+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Cameras", "Components", "Electric_components", "Stubs"]
---
# Camera small

## Specifications

| Field | Value |
| --- | --- |
| Name | Camera Small |
| Image | 200px |
| Mass | 5 |
| Dimensions | 1×1×1 |
| Cost | $1,000 |
| Logic inputs | None |
| Logic outputs | Video (Camera feed) |
| Connections | Electric |
| Since version | V0.7.1 |

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Camera_small?action=edit). |
| --- | --- |

"A camera with video output feed".

## Notes

A relatively cheap, lightweight [camera](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Video/Cameras) with a variety of uses including remote-control video-guided missiles, reversing cameras for land vehicles and ships, crane alignment view cameras, hazmat robot cameras, hull damage inspection cameras, etc.

### FOV / Zoom

Unlike all of the other cameras, the small camera has a fixed field of view of 70 degrees, the same as a player using default settings, so effectively a fixed zoom value of 1:1 with player vision. Note that when connected to monitor with a rectangular (but not square) screen, only the narrow dimension has the exactly 70-degree FOV - the wider dimension gets a larger FOV in proportion to the difference so that the image is not stretched.

## Patch history

### [V0.10.19-22](https://stormworks.fandom.com/wiki/V0.10.19-22)

- Fix - Recategorized cameras and speakers

### [V0.9.28-32](https://stormworks.fandom.com/wiki/V0.9.28-32)

- Fix - Camera feed visually not disappearing completely on signal loss
- Fix - Camera feed and lua overlay transparencies fighting

### [V0.9.1-2](https://stormworks.fandom.com/wiki/V0.9.1-2)

- Fix - Vehicle cameras not using graphics quality settings

### [V0.8.16-18](https://stormworks.fandom.com/wiki/V0.8.16-18)

- Fix - Rain and snow not displaying correctly when video camera is active
- Fix - Flickering player flashlight when video camera is active in 1st person view

### [V0.7.6-7](https://stormworks.fandom.com/wiki/V0.7.6-7)

- Fix - camera meshes appear correctly when flipped
- Fix - cameras now render water correctly when inside vehicle compartment

### [V0.7.1](https://stormworks.fandom.com/wiki/V0.7.1)

- Feature - Added 3 camera components (small, medium and gimbal)
- Feature - New video logic type used for transferring camera and video feeds between components
- Feature - Added 4 monitor components to view camera and video feeds
  - Video logic can be chained through several scripts to layer many draw commands together, making it possible to build self-contained UI microcontrollers
- Feature - Added 2 video radio components (transmitter and receiver)
- Similar to radio antennas, but they transmit a video signal
- Quality of video signal will degrade over long distances

---

Source: [Camera small](https://stormworks.fandom.com/wiki/Camera_small) · Revision 3054 · CC BY-NC-SA
