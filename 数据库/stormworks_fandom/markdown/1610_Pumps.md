---
title: "Pumps"
source_url: "https://stormworks.fandom.com/wiki/Pumps"
page_id: 1610
revision_id: 4645
revision_timestamp: "2025-09-10T01:37:43Z"
retrieved_at: "2026-08-31T10:04:37+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: []
---
# Pumps

Pumps are used to move [fluids](https://stormworks.fandom.com/wiki/Gameplay/Mechanics/Fluids) against gravity or against pressure gradients.

This page was last updated for Stormworks [V1.15.2](https://stormworks.fandom.com/wiki/V1.15.2) on 20 August 2025.

## Uses

Pumps serve multiple roles, including (but not limited to):

- Bilging water out of a damaged [ship](https://stormworks.fandom.com/wiki/Boat) or [submarine](https://stormworks.fandom.com/wiki/Submersible) .
- Pumping air into a ship or submarine to accelerate bilging of water.
- Re-pressurizing air tanks.
- Pumping liquids to be sold into an appropriate receiver.
- Pumping coolant into a heat exchanger, or hot 'coolant' into a boiler to produce steam.
- Pumping fresh water into a [boiler](https://stormworks.fandom.com/wiki/Steam_boiler) to make steam (note the large fluid pump is the best option for this, small pumps provide inadequate pressure).
- "Supercharging" [diesel engines](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Propulsion/DieselEngines), with either the **Fluid Pump** or **Large Fluid Pump** serving best in this role.

## Pump types

There are currently 5 pumps in-game, as follows.

### Fluid Pump (Manual)

"A small fluid pump with a manual handle. Hold q/e to to create pressure in the pump. Connect to an inlet and outlet to create a pumping system to move fluid around a vehicle."

With a starting pressure of 1 atm, it reaches a maximum pressure of 4.1274 atmospheres. Acts as a one-way valve. Does not require electricity. A player can operate two manual pumps at the same time.

### Fluid pump

"A small fluid pump. Connect to an inlet and outlet to create a pumping system to move fluid around a vehicle."

Maximum pressure of 11 atmospheres given a starting pressure of 1 atm. Acts as a one-way valve. Requires an almost negligible amount of electricity.

### Large fluid pump

"A large fluid pump. Connect to an inlet and outlet to create a pumping system to move fluid around a vehicle."

Maximum pressure is 60 atm. Acts as a one-way valve. Requires an almost negligible amount of electricity.

### Impeller pump (small)

"An Impeller Pump that can push fluid through a system. An impeller that will force fluid through the system when torque is applied."

Requires power with an RPS input. Maximum pressure is 60 atm. Doesn't block flow when unpowered, and can allow reverse flow if a one-way valve is not included. Works faster with higher RPS.

### Impeller pump

"An Impeller Pump that can push fluid through a system. An impeller that will force fluid through the system when torque is applied."

Requires power with an RPS input. Maximum pressure is 60 atm. Doesn't block flow when unpowered, and can allow reverse flow if a one-way valve is not included. Works faster with higher RPS.

## Applied techniques

### Pump stacking

Pumps can be stacked in a series to increase their maximum pressure, e.g. for repressurizing gas tanks. Note that this can leave pumps towards the end of the series with intermittent flow as it takes a while for adequate back pressure to build up; additional pumps at the earlier steps of the series can be used to build backpressure faster.

## Challenges

### Combined gas and liquid

Ports cannot be positioned such that they draw only gas or only liquid. Even if a port is placed well below the water level in a ballast tank or room, simply pumping from that port will pump out both gas and liquid, not just liquid. Similarly, a port well above the water level will pump out gas and liquid, not just gas.

To pump only gas or only liquid, liquid relief valves and gas relief valves must be used. A single gas or liquid relief valve can be placed between the inlet port and the pump to ensure that only gas or only liquid enters the pump, respectively. Alternatively, the pump can configured with a T-piece pipe on its outlet leading to both gas and liquid relief valves so that air and fluids can go to separate places (e.g. for bilging, fluid goes out but air should be returned to the tank).

### Low flow

Pumps tend to provide low flow without pressurized assistance. If trying to clear water rapidly, e.g. from a ballast tank, consider using a boiler to fill the tank with steam.

If using gas or liquid relief valves to separate gasses and liquids, note that it is about three times more efficient to place these in pairs at the pump outlet instead of one or the other at the inlet as discussed in the combined gas and liquid section above.

## Hazards

### Vacuum

Be aware that bilge pumps can suck the air out of a room if they do not have gas/liquid relief valves in place to ensure that only water is pumped out. Also, a damaged room which flooded with water may have little-to-no air remaining in it to begin with, so unless air is added to that room after it is repaired, a vacuum could also be produced simply by pumping out just the water. When pressure falls below 0.12 atmospheres, players without a space suit will start to take damage.

### Oxygen shortage

Note that rooms with low pressure have less oxygen to use up, so insufficient oxygen can become a problem faster. Alternately, rooms pressurized with steam may also have adequate pressure without sufficient oxygen. Note that oxygen supply / CO2 excess is not a problem until about 30-40% of the oxygen in a room has been used up (and converted into CO2). After this point, the player will begin holding their breath as if underwater and then start taking damage when the breath timer runs out. Oxygen is converted by players into an equal volume of CO2, and oxygen consumption is about 0.04L/s. Consumption does not significantly change whether at rest or jumping and sprinting.

### Overpressure

While pressurizing rooms can help to keep out seawater and to expel it when bilging, excess pressure is harmful. By default, maximum pressure is 4 atm before a player starts to take damage. With scuba gear, the maximum pressure is 5 atmospheres. With diving equipment, the maximum pressure is 24 atm. Note that at 24 atm, the pressure damage without diving equipment is extremely rapid but does allow a few seconds of survival, so it is possible to swap diving equipment in a high-pressure environment if low on oxygen.

## Benchmarks

### Pressurizing a huge gas tank

Test results when pressurizing a huge gas tank with air to reach 59.5 atm, sorted by worst-to-best filling time:

1. One large pump with one inlet port and a gas relief valve: 618.33s

2. One large pump with two inlet ports and one gas relief valve: 526.03s

3. One large pump with one inlet port and, at the outlet, a T-pipe with a gas relief valve to the tank and a liquid relief valve + port on the other end: 570.08s

4. One large pump with two inlet ports and, at the outlet, a T-pipe with a gas relief valve to the tank and a liquid relief valve + port on the other end: 485.35s

5. One large pump with two inlet ports, each with its own gas relief valve: 385.32s

6. One large pump with one inlet port: 354.28s

7. One large pump with two inlet ports: 263.13s

8. One large pump with four inlet ports: **260.28s (slower than with three inlet ports!)**

9. One large pump with three inlet ports: 256.15s

10. Two large pumps in parallel, each with one inlet port: 180.1s

11. Four large pumps in parallel, each with one inlet port: 142.93s

12. Two large pumps in parallel, each with two inlet ports: **135.42s (faster than using four pumps with one inlet port each!)**

13. Four large pumps in parallel, each with two small pumps in parallel (each with one inlet port) feeding into it: **63.55s (almost as fast as the fastest options with a fairly reasonable setup)**

14. Four large pumps in parallel, each with four small pumps in parallel (each with an inlet port) feeding into it: 54.95s

15. As the line above, but feeding into a large pump which feeds into the gas tank: 54.9s

16. As the line above, but feeding into an impeller pump running at 440 rps instead of the large pump: 54.9s

Note that the piping configuration for parallelization doesn't appear to matter. Whether in a line, or a loop, the arrangement of the pipes didn't even slightly affect the time to fill the tank. Tests with variations of piping configuration were not included in these results.

There's a few notable takeaways from these results:

- 2-3 inlet ports will speed up a pump compared to 1 inlet, but a fourth will actually slow it down

- 2 pumps with two inlet ports each is actually faster than four pumps with one inlet port each

- Gas / liquid relief valves significantly slow down pumps, worse at the inlet but still noticeably even if they are at the outlet. Where possible, it is recommended to use other methods to keep out water, like only allowing the air inlet pumps to turn on when the inlet ports are safely above the water level.

---

Source: [Pumps](https://stormworks.fandom.com/wiki/Pumps) · Revision 4645 · CC BY-NC-SA
