---
title: "Gameplay/Mechanics/Fluids"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Mechanics/Fluids"
page_id: 881
revision_id: 4694
revision_timestamp: "2025-11-06T00:52:06Z"
retrieved_at: "2026-08-31T10:02:21+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Gameplay/Mechanics/Fluids

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Gameplay/Mechanics/Fluids?action=edit). |
| --- | --- |

## Fluids

(Note: This page was last updated on 7/10/25 for Stormworks v1.15.1.)

## General

- Gasses and liquids have very similar behaviors. Liquids and gases under any pressure above the external atmosphere can empty out of a container via a fluid output, such as a fluid port or fluid exhaust. Additionally, if they are released into an airtight space, the pressure of the space will increase. Liquids that enter an airtight space will compress the gasses already present there, while gasses added to an airtight space will change the atmospheric composition depending on the gas being outputted.
- Air can be pumped from the atmosphere into a tank, and later used in an engine.
- As of the Space DLC release, the fluid system has been overhauled to add pressure, gases such as Oxygen and Nitrogen, and many other revamps.
- Note that elevation no longer affects fluid pressure. There will be no flow between two tanks filled to 50% with a 5 meter height gap between them. Similarly, pumping water out directly, or pumping it out from the top of a 5-meter-tall pipe makes no difference in pumping rate.

## Piping

- Pipes in Stormworks do not store any fluid. They simply serve as connections for components to exchange fluids.
- All components have a small buffer, which often gives the illusion of fluid being stored in a pipe. This buffer can be seen with detailed tooltips: Every fluid component has one "Stored Fluid" label for each connection, which lists the current flow rate through that connection in L/s, as well as the current amount of fluid stored in the buffer, measured in L. This buffer also exists for tanks, allowing them to store slightly more fluid.

## Tanks

- Fluids can be mixed in any tank. This is not recommended, as separating them afterwards can be difficult.
- Oil can be refined into Diesel and Jet fuel at high temperatures. At low temperatures, this can happen in reverse: Diesel and Jet fuel combine into oil when stored in the same tank.
- Custom fluid tanks: it is a container made out of blocks/components. Not every block is sealed (e.g. jet turbines) so try to use the more basic blocks to create your tanks (cubes, wedges). By using wedges instead of blocks you can add more fluid capacity. Reason: the wedge is only half a cube so it can give you 8 liters of fluid while a cube gives you 0. Just place the wedge so the flat part is the outside of the tank and the sharp corner is the inside of the tank. Similarly, using micro controllers, windows, or any other seal-able blocks that take up less than an entire block's worth of volume will increase the capacity of a tank without increasing its size. Micro controllers and windows will increase the capacity the greatest amount.
- Finding a leak in your tank: When you are missing a block and the hull of your fluid tank has a hole it is not a tank. Just put a liquid/gas meter into the tank and connect its capacity output to a digital display. If the display says 0 you have a leak. Now you can add walls to divide your tank into two parts. Give every part its own liquid/gas meter + digital display to see which part has the leak. If one side is still displaying 0 divide that tank again with a wall and so on...
- [Small Fluid Tanks](https://stormworks.fandom.com/wiki/Fluid_tank_small) take up a 1x1x2 space and have a set capacity (currently) of 31.25 (15.625 per 'block'). [Medium Fluid Tanks](https://stormworks.fandom.com/wiki/Fluid_tank_medium) take up 2x2x3 space and have a set capacity of 187.50 (15.625 per 'block'.) However, [Large Fluid Tanks](https://stormworks.fandom.com/wiki/Fluid_tank_large) take 3x3x5 space and have a capacity of 703.125 (~15.667 per 'block'.) [Large Fluid Tanks have a slightly better space to capacity ratio out of all preset fluid storage solutions.]
- It is important to note that fluid tank pressure decreases as fluid is pumped out. The preset tanks come with pressurized gas to help push the fluid out. However, custom fluid tanks do not start with pressurized gas. For tanks meant to be drained until empty, like fuel tanks, it is recommended to use a gas relief valve with one port on the inside of the tank and one port on the outside, such as the side of a ship. Liquid will not flow through the gas relief valve. Without something like this to prevent vacuum formation, pumping fluid out of the tank will become increasingly difficult.

## Pressure and Gases

- In Stormworks, atmospheric pressure decreases with altitude, while water pressure increases with depth underwater. For example, at around 500m up (1640 feet) the pressure of the atmosphere outside is 0.94 atmospheres, while on the ground it is much closer to 1 atmosphere.
- There are 4 spawnable gases. Air (~20% Oxygen, ~79% Nitrogen, ~1% Carbon Dioxide), Oxygen, Nitrogen, Hydrogen as well as 2 unspawnable gases, being Carbon Dioxide and Steam.

## Gas & Pressure Effects on Player

- The player emits around 0.21 liters of carbon dioxide every 5 seconds (averaging to 0.042 l/s). They also consume oxygen the same rate they produce carbon dioxide.
- If oxygen in a space makes up less then 15% of the total gases (or carbon dioxide makes up more than 10%), the player will start to suffocate unless they have a scuba, diving or space suit equipped. It does not count other gases, so even if a space is 85% hydrogen no effects will be given to the player.
- Different suits give different limits for the pressure range that the player is able to survive in; refer below.
  - No suit: 0.12 to 4 atmospheres
  - Scuba Suit: 0.05 to 5 atmospheres
  - Diving Suit: 0.06 to ~24 atmospheres
  - Space Suits: [No Lower Limit] to 10 atmospheres

## Pumping

- Use a separate port for each tank. Without separate ports, flow rates can be only marginally improved or sometimes even worsened. For example, note that if you connect a T-piece pipe to a large fluid tank and then connect two small pumps to it, the combined flow rate will actually be lower than having a single small pump on the fluid tank.

---

Source: [Gameplay/Mechanics/Fluids](https://stormworks.fandom.com/wiki/Gameplay/Mechanics/Fluids) · Revision 4694 · CC BY-NC-SA
