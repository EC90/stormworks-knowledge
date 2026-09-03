---
title: "Camera gimbal"
source_url: "https://stormworks.fandom.com/wiki/Camera_gimbal"
page_id: 1359
revision_id: 3156
revision_timestamp: "2022-03-29T21:11:37Z"
retrieved_at: "2026-08-31T10:01:04+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Cameras", "Components", "Electric_components"]
---
# Camera gimbal

## Specifications

| Field | Value |
| --- | --- |
| Name | Camera Gimbal |
| Image | 200px |
| Mass | 50 |
| Dimensions | 3×3×3 |
| Cost | $5,000 |
| Logic inputs | Bool (Infrared mode), Numeric (Field of view), Numeric (Pitch rotation), Numeric (Pivot rotation) |
| Logic outputs | Video (Camera feed) |
| Connections | Electric |
| Since version | V0.7.1 |

"A gimbal camera with video output feed. Has an infrared mode as well as pivot controls, a variable field of view."

## Notes

A [camera](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Video/Cameras) with telescopic and wide-field zoom capabilities, as well as [infrared mode](https://stormworks.fandom.com/wiki/Infrared_mode). It has a wide range of uses, including all of those for the [medium camera](https://stormworks.fandom.com/wiki/Camera_medium), though its size and cost make it a poor choice for video-guided remote control missiles.

If the camera is placed facing up or down, the pivot rotation allows the camera to turn in 360 degrees, looking in any bearing from the vehicle. The pitch rotation allows the camera to adjust its angle, allowing a search and rescue helicopter to switch between looking straight down (e.g. when lowering rescue harnesses towards people to be rescued) and looking forward, or at a downward angle (e.g. when looking for a lost swimmer), or even looking straight backward.

### Vehicle placement

Note that the arrow on the camera in the vehicle editor seems to be upside down compared to other cameras and monitors. The actual orientation isn't terribly important though as the camera can just be pitched 180 degrees to flip the orientation, then rotated 180 degrees to look in the same direction again.

The camera is generally best placed pointing up (common on ground vehicles and ships), or pointing downward (common on jets and helicopters).

### FOV / Zoom

The camera's FOV input will take values from 0-1 (anything higher or lower has no additional effect) and has a zoom range of 0.29x up to 28x zoom.

0 is the low-zoom wide field of view, with the camera seeing a 135-degree FOV (0.29x zoom). 1 is the high-zoom narrow field of view, with the camera seeing an approximately 1.43 degree FOV (0.025 radian FOV - 28x zoom). The camera's FOV setting is structured so that the number of degrees in its FOV increases evenly as the input value increases, so adding 0.5 to a low input value will add (135-1.43)*0.5 degrees to the FOV.

The following function can be used in a function block or Lua block in a [microcontroller](https://stormworks.fandom.com/wiki/Microcontroller) to convert from desired zoom (x) to the required input value for the camera:

1-(2*(180/pi)*(atan (tan ((pi/180)*(70/2.0))/x)))/(135-1.43)

The same logic can be used for adjusting camera zoom when tracking targets at a distance. Once you've picked a desirable zoom setting for 100m, you can simply divide the target's distance by 100, multiply by the desired zoom for 100m, and then input that desired zoom (x) into the function above.

### Pitch / pivot controls

Input values greater than -0.1 but less than 0.1 will make the camera stop turning. The camera's maximum turn rate is difficult to determine. At input values of 1 or -1, the camera turns at about 0.1 rps, though this appears to be slowed if power supply is less than 100%. At values of up to 100, the camera can turn extremely quickly, presumably at about 10 rps, though certainly fast enough to be difficult to measure.

## Patch history

### [V1.3.14](https://stormworks.fandom.com/wiki/V1.3.14)

- Rework - Cameras are now correctly nameable

### [V1.0.20](https://stormworks.fandom.com/wiki/V1.0.20)

- Fix - Gimbal Cameras not saving orientation correctly

### [V1.0.15](https://stormworks.fandom.com/wiki/V1.0.15)

- Fix - Gimbal camera mirrored editor arrows
- Fix - Gimbal camera laser rendering flipping in y-axis

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

Source: [Camera gimbal](https://stormworks.fandom.com/wiki/Camera_gimbal) · Revision 3156 · CC BY-NC-SA
