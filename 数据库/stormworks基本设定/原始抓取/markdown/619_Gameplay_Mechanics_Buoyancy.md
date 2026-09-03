---
title: "Gameplay/Mechanics/Buoyancy"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Mechanics/Buoyancy"
page_id: 619
revision_id: 4231
revision_timestamp: "2025-05-14T06:15:44Z"
retrieved_at: "2026-08-30T14:37:35+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
---
# Gameplay/Mechanics/Buoyancy

## Buoyancy

This page was last updated for Stormworks [V1.4.14](https://stormworks.fandom.com/wiki/V1.4.14 "V1.4.14") (29 Mar 2022).

Objects float if they are less dense (in total) than the water they displace. Water has a density of 1 kg/L, or 1,000 kg/m3.

"Blocks" (the typical cube blocks often used for making hulls) have a mass of "1", which is equal to 10 kg. Their sides are 0.25 m long, so they have a volume of 0.015625 m3, giving them a density of 640 kg/m3. As is obvious by the math (and confirmed through testing), regular blocks float in water.

Heavy blocks have a mass of "10", which is equal to 100 kg, giving them a density of 6,400 kg/m3. As such, these blocks sink.

Various other components may be more or less dense. Of note, engines, motors, generators, batteries, and weapons all tend to be quite dense. Thus, to keep a ship with many such components afloat, there must be a lot of volume ("displacement") with little mass to counter the heavy stuff. Air is generally used for this purpose.

Air has no mass in Stormworks. However, Stormworks will assume that any non-enclosed volumes can be instantly filled with water if they are below the waterline. Thus, conventional open topped hull designs (like a common rowboat) will instantly flood and will sink if their hull is more dense than water. The air below the waterline simply disappears and is replaced with water.

To prevent this, air must be kept in enclosed spaces. These spaces can have doors or hatches for access, though flooding will occur if the door/hatch is open and at/beneath the waterline. The flooding in this case is slower than the instantaneous flooding which occurs with non-enclosed spaces, and pumps can be used to gradually remove any water which does happen to get through an open door or hatch. This approach also allows airlocks to be used for underwater access.

## Gaps

Any gaps in the construction of an enclosed space will allow it to immediately fill with water. Some blocks and components will obviously allow water around them (like regular pipes), thus would create a hole in the hull unless an alternative were used (like the "enclosed" full-block versions of pipes). There are other slightly less obvious gaps such as:

- Unmerged sections: Even if they look perfectly sealed, unmerged sections cannot form a watertight seal except in the case of a custom door (and in this case the edges of both sections must all be properly oriented door parts).

- Fluid tanks: The corners of fluid tanks will allow water in.

- Batteries: All surfaces of a battery except the bottom will fail to form a seal and allow water in.

Gaps can be found using a fluid meter and partitioning a space. The fluid meter will report the volume of the space if it is an enclosed volume, so a space can be split into parts, two fluid meters can be used to narrow down which part(s) have gaps, and this process can be repeated until any remaining gaps are located and sealed off.

---

Source: [Gameplay/Mechanics/Buoyancy](https://stormworks.fandom.com/wiki/Gameplay/Mechanics/Buoyancy) · Revision 4231 · CC BY-NC-SA
