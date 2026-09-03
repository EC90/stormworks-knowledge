---
title: "Camera medium"
source_url: "https://stormworks.fandom.com/wiki/Camera_medium"
page_id: 1357
revision_id: 4695
revision_timestamp: "2025-11-22T20:00:04Z"
retrieved_at: "2026-08-31T10:01:06+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Cameras", "Components", "Electric_components"]
---
# Camera medium

## Specifications

| Field | Value |
| --- | --- |
| Name | Camera Medium |
| Image | 200px |
| Mass | 10 |
| Dimensions | 1×2×1 |
| Cost | $3,000 |
| Logic inputs | Bool (Infrared mode), Numeric (Field of view) |
| Logic outputs | Video (Camera feed) |
| Connections | Electric |
| Since version | V0.7.1 |

"A camera with video output feed. Has infrared mode as well as a variable field of view."

## Notes

A [camera](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Video/Cameras) with telescopic and wide-field zoom capabilities, as well as [infrared mode](https://stormworks.fandom.com/wiki/Infrared_mode). It has a wide range of uses, including all of those for the [small camera](https://stormworks.fandom.com/wiki/Camera_small) as well as more advanced applications like being placed on a weapon turret to zoom in and track distant [radar](https://stormworks.fandom.com/wiki/Radar) contacts, allowing the player to positively identify them.

### FOV / Zoom

The camera's numeric FOV input will take values from 0-1 (anything higher or lower has no additional effect) and has a zoom range of 0.29x up to 28x zoom.

0 is the low-zoom wide field of view, with the camera seeing a 127-degree vertical FOV (0.29x zoom). 1 is the high-zoom narrow field of view, with the camera seeing an approximately 1.43 degree FOV (0.025 radian FOV - 28x zoom). The camera's FOV setting is structured so that the number of degrees in its FOV increases evenly as the input value increases, so adding 0.5 to a low input value will add (127-1.43)*0.5 degrees to the FOV.

The following function can be used in a function block or Lua block in a [microcontroller](https://stormworks.fandom.com/wiki/Microcontroller) to convert from desired zoom (x) to the required input value for the camera:

1-(2*(180/pi)*(atan (tan ((pi/180)*(70/2.0))/x)))/(127-1.43)

The formula to go back from a camera zoom to FOV is

0.700208/tan(0.0053+1.16562*x)

The formula to go from a camera input to FOV is

(1-x)*2.1893+0.025

The same logic can be used for adjusting camera zoom when tracking targets at a distance. Once you've picked a desirable zoom setting for 100m, you can simply divide the target's distance by 100, multiply by the desired zoom for 100m, and then input that desired zoom (x) into the function above.

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
- Fix- increased medium and gimbal camera max zoom, made zoom characteristics the same for both cameras

### [V0.7.1](https://stormworks.fandom.com/wiki/V0.7.1)

- Feature - Added 3 camera components (small, medium and gimbal)
- Feature - New video logic type used for transferring camera and video feeds between components
- Feature - Added 4 monitor components to view camera and video feeds
  - Video logic can be chained through several scripts to layer many draw commands together, making it possible to build self-contained UI microcontrollers
- Feature - Added 2 video radio components (transmitter and receiver)
- Similar to radio antennas, but they transmit a video signal
- Quality of video signal will degrade over long distances

---

Source: [Camera medium](https://stormworks.fandom.com/wiki/Camera_medium) · Revision 4695 · CC BY-NC-SA
