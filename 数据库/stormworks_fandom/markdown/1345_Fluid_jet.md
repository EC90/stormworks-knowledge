---
title: "Fluid jet"
source_url: "https://stormworks.fandom.com/wiki/Fluid_jet"
page_id: 1345
revision_id: 4270
revision_timestamp: "2025-05-21T16:03:34Z"
retrieved_at: "2026-08-31T10:01:51+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Components", "Electric_components"]
---
# Fluid jet

## Specifications

| Field | Value |
| --- | --- |
| Name | Fluid Jet |
| Image | 200px |
| Mass | 10 |
| Dimensions | 3x3x3 (black section) + 1x3x1 (nozzle) + 2x1x1 (connectors at the end) |
| Cost | $3,000 |
| Logic inputs | Number (Vertical Trim), Number (Deflector A), Number (Deflector B) |
| Logic outputs | None |
| Connections | Electric, Fluid (Intake), Power |
| Adjustable parameters | None |
| Since version | V0.5.16 |

Fluid jets are a form of [propulsion](https://stormworks.fandom.com/wiki/Wiki/Building/Components/Propulsion) with built-in [thrust pivoting](https://stormworks.fandom.com/wiki/Wiki/Vehicles/Water/Boat#Thrust_pivoting) ability. They are an especially good choice for making high-speed watercraft. Despite the generic term "fluid", fluid jets actually only work with seawater - other fluids will not be expelled.

## Fluid requirements

Fluid jets can work without a fluid pump at all, simply using their supplied power to move fluid as necessary as long as the fluid intake port is connected to a fluid source. Pumps can be used to increase the fluid supply to the jet to prevent sputtering / intermittent operation.

## Power requirements

- Small engines are not recommended for fluid jets - they struggle to provide anywhere close to the required power except with reduction gearing, high RPS, and/or low clutch settings.
- A [medium engine](https://stormworks.fandom.com/wiki/Medium_engine) at 1:1 gearing can just barely run a fluid jet while sustaining at ~2.7 RPS. They can work better with reduction gearing and/or a clutch.

## Inputs

The deflectors take values from 0-1 and convert forward thrust to lateral thrust when activated. The deflectors stay away from the fluid stream at 0, but move towards it as their input value increases.

Deflector A is on the right, deflects the stream to the right, and thus causes a vehicle to turn to the left as it is activated (if the fluid jet is located at the back of the vessel).

Deflector B is on the left, deflects the stream to the left, and thus causes a vehicle to turn to the right as it is activated (if the fluid jet is located at the back of the vessel).

Activating both deflectors in the same proportion will decrease the thrust provided by the water jet, with maximum deflector activation resulting in zero thrust.

Vertical trim takes values from -1 to 1. A vertical trim of 1 causes the water stream to be forced downwards, while -1 creates an upward stream. Assuming the fluid jet is located on the back of the vessel, +1 will create a lifting force on the back of the vessel while pitching it downward, while -1 will push the back of the vessel down but pitch the vessel upward.

Note that standard orientation is with the fluid intake port placed below the power connection, and with the deflector B logic input on the left side when viewed from the back of the ship in the vehicle editor (note that mirrored placement will cause mirroring of this orientation, so fluid jets are best to place manually). If you have fluid jets in nonstandard orientation, you will need to reverse some or all of this information.

## Patch history

### [V0.5.17-19](https://stormworks.fandom.com/wiki/V0.5.17-19)

- Fix - Improved water stream rendering for fluid jet
- Fix - Fixed fluid jet deflector bucket rotation direction

### [V0.5.16](https://stormworks.fandom.com/wiki/V0.5.16)

- Feature - Added Fluid Jet component (water jet that produces thrust and has thrust vectoring)

---

Source: [Fluid jet](https://stormworks.fandom.com/wiki/Fluid_jet) · Revision 4270 · CC BY-NC-SA
