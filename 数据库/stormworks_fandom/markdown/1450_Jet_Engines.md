---
title: "Jet Engines"
source_url: "https://stormworks.fandom.com/wiki/Jet_Engines"
page_id: 1450
revision_id: 4710
revision_timestamp: "2026-03-12T22:57:12Z"
retrieved_at: "2026-08-31T10:03:43+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Engin", "Power"]
---
# Jet Engines

The Jet Engine is a category of engine in Stormworks that uses jet fuel to generate thrust, electricity, and RPS.

Jet Engines are highly versatile and simpler than modular engines, as they require only fuel and throttle and can revolve much higher before breaking. They can be applied to all in-atmospheric vehicles.

[![An Example Of A Jet Engine](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/20/Jet.PNG/revision/latest/scale-to-width-down/180?cb=20240129123515)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/20/Jet.PNG/revision/latest?cb=20240129123515)

[https://stormworks.fandom.com/wiki/File:Jet.PNG](https://stormworks.fandom.com/wiki/File:Jet.PNG)

An Example Of A Jet Engine

## Pros vs. Cons

Pros:

1. Better Torque-to-size Ratio compared to a similarly sized modular engine.
2. Simple to construct, requiring only a fuel input and throttle input.
3. Quicker to start (Ignites at 0.5 RPS)
4. Can sustain lower speeds (down to 0.6 RPS)
5. Higher RPS limit (up to 200 RPS before broken, compared to 60 RPS for the modular engine), torque, and power.
6. Never overheat

Cons:

1. Loud(High pitch and amplitude noise)
2. Will be destroyed if the intake is submerged in the ocean (Repairable, but difficult or impossible if the engine isn't fully exposed
3. Lack of variety and hard to make smaller(Unlike Modular Engines, Jet Engines only come in 3x3 size, rendering them less flexible overall)
4. inconsistent throttle(fuel flow input) response (Slow responding in the low RPS range, but very quick and snappy in the mid-high RPS range)
5. Exhaust particles can cause physics lag (Can be hidden in the newest update)

## Part List

### Small Jet Intake (1x3x3)

This part acts like an air scoop, which can increase air intake when in high speed by placing it in front of the jet engine

### Large Jet Intake (2x7x7)

Similar to the Small Jet Intake, but the Large is of a turbo-fan design and generates thrust at high RPS.

### Jet Compressor (5x3x3)

The Compressor, as its name suggests, converts RPS to compress air for the combustion chamber. The compressor also has a built-in starter motor, which provides a small RPS. By placing it in front of the combustion chamber, it converts rps into pressure, maintaining the pressure at a lower RPS while fuel consumption remains constant, allowing it to achieve higher pressure and thrust with the same RPS.

### Jet Combustion Chamber (3x3x3)

The beating heart of a jet Engine, taking air and mixing it with jet fuel to create heat and combustion, thus a substantial increase in pressure and temperature proportional to the consumption of fuel, performs better with higher pressure.

### Jet Turbine Medium (3x3x3)

Another key component of the jet engine, which divides the pressure input by a factor of 3, converts pressure to RPS(of the jet engine and RPS out/input), and converts RPS into Electricity. It also has an RPS Port, which can be used to drive instruments such as generators, propellers, and wheels, or to turn the jet engine by motor.

The RPS is proportional to the square of the pressure of the jet engine.

### Jet Turbine Small (2x3x3)

Similar to Jet Turbine Medium, however, with a smaller size and without RPS connection

### Jet Exhaust (3x3x3)

Jet exhaust divides pressure input by 2 and converts pressure into thrust, where the thrust force is proportional to the pressure of the jet exhaust when the pressure is greater than 1000 units (Thrust isn't stable and can be ignored when the pressure is lower than 1000 units).

The relation between pressure and thrust force follows the formula:

F t = 320 ( P E − 1000 ) {\displaystyle F_{t}=320(P_{E}-1000)} ![{\displaystyle F_{t}=320(P_{E}-1000)}](https://services.fandom.com/mathoid-facade/v1/media/math/render/svg/cac5bebeedeccf27d81b23e2475f5403f6b9b707)

While F t {\displaystyle F_t} ![{\displaystyle F_{t}}](https://services.fandom.com/mathoid-facade/v1/media/math/render/svg/cadacea25c3873ea5c635cea4060961c6377bbb4) means thrust force in Stormworks Newton, and P e {\displaystyle P_e} ![{\displaystyle P_{e}}](https://services.fandom.com/mathoid-facade/v1/media/math/render/svg/686a30bbd687ac4b0de37dbd25a774724c7a80f5) means pressure unit of the exhaust(although this formula is kinda useless because of the insane air and water drag in the game ╮( ̄∇ ̄)╭ ).

### Jet Exhaust Afterburner (5x3x3)

Similar to Jet exhaust, but with an afterburner that can mix jet fuel by the fuel input port with unburnt gas for an extra thrust. When the afterburner boolean is activated, it will produce flame particles even without fuel flow to the afterburner.

### Jet Exhaust Rotating (4x3x3)

Similar to Jet exhaust, but can also be turned with a Number Input to redirect thrust. Unlike the Regular and Afterburner exhausts, the Jet Exhaust Rotating shoots out the side rather than straight backward, which may be used with jet ducts.

### Jet Ducts

There are a total of 5 Duct parts that can be placed to connect the components of a jet engine

The following parts are:

1. Jet Duct Straight (1x3x3)
2. Jet Duct Angle (3x3x3)
3. Jet Duct T (3x3x3)
4. Jet Duct Cross (3x3x3)
5. Jet Duct Diagonal (3x4x3)

## Odd Engine Designs

Jet Engines don't have to be a simple Intake>Compressor>Combustion>Exhaust, as stated above, the Exhaust can be ignored if you just want Torque

### Turbine Engines

[![An Example Of A Turbine Engine (This Engine Is Considered An Extreme Example)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e3/TurbinBoi.PNG/revision/latest/scale-to-width-down/180?cb=20240129123010)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e3/TurbinBoi.PNG/revision/latest?cb=20240129123010)

[https://stormworks.fandom.com/wiki/File:TurbinBoi.PNG](https://stormworks.fandom.com/wiki/File:TurbinBoi.PNG)

An Example Of A Turbine Engine (This Engine Is Considered An Extreme Example)

Due to a flaw in how pressure is divided, you can stick multiple Jet Turbine Mediums on the same engine with little to no loss of power on a single turbine, While possible to put turbines in series, this isn't ideal as the a turbine will consume pressure meaning the next turbine will produce less torque, The way to harness as much torque as possible is to put turbines in parallel with the use of T and Cross Ducts, These engines are **very** powerful but they have their drawbacks such as:

1. A lot harder to start (The Built in starter motor of the compressor usually isn't suitable to start the engine as it can either take a very long time to to get the engine to 0.5 RPS or it never will, the use of an external starter is recommended)
2. Throttle Response (Turbine Engines make con 4 more prevalent meaning they can be incredibly hard to tame)
3. Lag (Too many turbines can lead to the game lagging a lot with just the engine spawned)
4. Size (duh)

### Closed Loop Engines

[![An Example Of A Closed Loop Engine](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/75/ClosedEngine.PNG/revision/latest?cb=20240129123414)

[https://stormworks.fandom.com/wiki/File:ClosedEngine.PNG](https://stormworks.fandom.com/wiki/File:ClosedEngine.PNG)

An Example Of A Closed Loop Engine

[![An Example Of A Closed Loop Engine With An Exhaust](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/3/37/ClosedWExhaust.PNG/revision/latest/scale-to-width-down/180?cb=20240129123439)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/3/37/ClosedWExhaust.PNG/revision/latest?cb=20240129123439)

[https://stormworks.fandom.com/wiki/File:ClosedWExhaust.PNG](https://stormworks.fandom.com/wiki/File:ClosedWExhaust.PNG)

An Example Of A Closed Loop Engine With An Exhaust

[![An Example Of A Closed Loop Turbine](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/b/b0/ClosedLoopTurbine.PNG/revision/latest?cb=20240130133344)

[https://stormworks.fandom.com/wiki/File:ClosedLoopTurbine.PNG](https://stormworks.fandom.com/wiki/File:ClosedLoopTurbine.PNG)

An Example Of A Closed Loop Turbine

A fairly odd concept, a Closed Loop Engine involves using ducts to connect the turbine's exhaust to the compressor's intake, bypassing the need for an intake entirely resulting in a fully waterproof Engine meaning it can be submerged with no risk of damaging the engine, you can also combine a Closed Loop Engine with a Turbine Engine.

a Closed Loop Engine however is less powerful than an equal sized open engine and does not produce thrust in space.

### Exhaust stacking

It's as the name suggests, using ducts to power a lot of exhausts.

## Compressorless Engines

For some reason, intakes and compressors are optional, you can have a working engine with just combustion chamber and turbine (medium one, since you have to use extenral starter). Oddly enough, jet engines without compressor can output much more power and in general better than with one, as the only con is lack of integrated starter.

[![Jet engine with just combustion chamber and turbine](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/6a/Minimal_Viable_Product.png/revision/latest?cb=20250906150046)

[https://stormworks.fandom.com/wiki/File:Minimal_Viable_Product.png](https://stormworks.fandom.com/wiki/File:Minimal_Viable_Product.png)

Jet engine with just combustion chamber and turbine

pros:

- A lot smaller
- Can output more power
- Much more responsive

cons:

- Has to have an external starter

it's impossible to play this game and not find like a couple dozen exploits by accident lol

---

Source: [Jet Engines](https://stormworks.fandom.com/wiki/Jet_Engines) · Revision 4710 · CC BY-NC-SA
