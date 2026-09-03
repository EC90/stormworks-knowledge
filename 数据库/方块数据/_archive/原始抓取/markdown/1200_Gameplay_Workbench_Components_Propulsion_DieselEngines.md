---
title: "Gameplay/Workbench/Components/Propulsion/DieselEngines"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Propulsion/DieselEngines"
page_id: 1200
revision_id: 4716
revision_timestamp: "2026-07-30T16:22:49Z"
retrieved_at: "2026-08-30T15:13:04+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
---
# Gameplay/Workbench/Components/Propulsion/DieselEngines

## Diesel Engines

Diesel Engines are the cheapest components in the game that produce power. There are 3 variants: Small, which produces 20kW and costs 400$; Medium costs 1000$ and produces 60kW and Large, also 3000$ and 200kW. Diesel Engines require fuel, air, cooling and an exhaust to operate.
Unlike electric motors, diesel engines can't produce power at 0 min-1 and therefore need to be started. The starter requires electricity to be connected to the engine and will start the engine when the "Starter" input on the Engine is on. It will consume a lot of power and start the engine.

Starters are very powerful. They can produce a lot of torque. The electric requirement scales with the output torque. Because of this behavior you only need one starter to start all of your engines if all of their power ports are linked together, which is helpful because starters are a lot louder than the engines themselves.

If an engine is slowed down to 2rps, either because the throttle is 0 or because the load is too high, it will stall. To prevent stalling vehicles require gearboxes and a clutch.

## Power output

Unlike electric motors, diesel engines don't have a constant power output. The elastic range (the rps range from peak torque to peak power) is 3-18rps for large engines, 3-28RPS for medium engines and 3-40RPS for small. Each engine has about 3 times the power than the one a size smaller.

[![Engine figures as tested ingame](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/92/DieselEngine_FiguresV3.png/revision/latest/scale-to-width-down/928?cb=20201218211043)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/92/DieselEngine_FiguresV3.png/revision/latest?cb=20201218211043)

Engine figures as tested ingame

## Ports

Diesel Engines have ports for air, exhaust, fuel, coolant in and coolant out. Engines will pump the liquids themselves so there is generally no need for external pumps. However, **medium** engines require **pumps** on the fuel, air and exhaust pipes **above ~75rps** and the same is true for **large** engines **above ~40rps**. Additionally, **long** pipes, **gravity** and **external pressure** also decrease engine performance without pumps.

[![All diesel engine connections, except for power and the rear air port on the medium engine](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/6b/DieselEngine_Connections.jpg/revision/latest/scale-to-width-down/180?cb=20201217165114)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/6b/DieselEngine_Connections.jpg/revision/latest?cb=20201217165114)

All diesel engine connections, except for power and the rear air port on the medium engine

The engine requires an air connection to the outside. If you place it inside an enclosed room it might run if the space has enough air, but it will quickly use up all the air and stall.

The infinite fuel setting in a custom mode world doesn't help with troubleshooting because it supplies all the engines ports.
(The engine then only needs power and the starter to start. But it can still overheat.)

For fixing problems, you can set the tooltip detail to: Detailed in the settings and look at the engine in-game (not in the editor). You will then get information for all connections like: power, fuel, temperature, etc.

## Cooling

Diesel Engines require cooling.

If they aren't sufficiently cooled they will heat up past 115°C and overheat. An overheating engine can rev a bit higher than the set RPS limit and produce a lot less torque. If the engines operates for more than a few seconds over 115°C, it will catch fire and eventually explode. The engine will stay somewhat operational until it reached higher temperatures (around 400 - 500°C).

The amount of heat produced only depends on the RPS. Engines can be cooled by either connecting the coolant ports to the sea or to a radiator. If one radiator is not enough multiple can be chained together to improve cooling.

Because custom fluid tanks don't store heat, connecting the coolant ports to one is the same as connecting them to the sea. This is usually regarded as cheating and might be changed in future releases.

At 20 RPS one radiator is enough to cool a small engine sufficiently. 2 for medium and 3 for large. 30rps is about the limit for engines that aren't cooled using seawater.

## Fuel Usage

As detailed in the engine figures, the fuel usage is exponential and only depends on rps. Large engines are most efficient in terms of kw of power per litre of fuel at 7-8RPS, medium at 6-7RPS and the small engine is most efficient at around 10RPS. The maximum efficiency is the same for all engines.

---

Source: [Gameplay/Workbench/Components/Propulsion/DieselEngines](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Propulsion/DieselEngines) · Revision 4716 · CC BY-NC-SA
