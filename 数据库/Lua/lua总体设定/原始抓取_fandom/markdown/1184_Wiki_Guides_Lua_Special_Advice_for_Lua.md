---
title: "Wiki/Guides/Lua/Special Advice for Lua"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Special_Advice_for_Lua"
page_id: 1184
revision_id: 3291
revision_timestamp: "2022-12-18T03:32:16Z"
retrieved_at: "2026-08-30T17:10:04+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Wiki/Guides/Lua/Special Advice for Lua

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Special_Advice_for_Lua?action=edit). |
| --- | --- |

## Special Advice for Lua

## General

- As lua scripts run on the server and on the client, they can get into a state where they are not syncronized (e.g. math.random() causing issues in multiplayer). While the composite input and output are syncronized, the output on the screen can be different!
- When vehicles are out of sight (too far away), they despawn. Once you get closer, they spawn again. The values of Memory components is restored, however the lua scripts are reset (as if respawned from workbench). If you have important data, use Memory components or use a keep-active block (NOT RECOMMENDED due to performance impacts!).

## Interacting with composite data / onTick

- this function is called every time the physics engine calculates a new tick. The frequency is ~60 times per second, but can be much less when you spawn in large vehicles or are in multiplayer
- Note that you are not permitted to use screen functions at this time, this needs to be done in onDraw(). Calling a screen function from the onTick() function returns an error.
- if the execution of onTick() takes longer than 16ms, you effectively slow down the physics engine speed of the game.
- if the execution of onTick() takes longer than 100ms, the game will exit the function and discard the calculations done.

## Interacting with the Screen / onDraw

- The onDraw() function is called everytime the game draws a new frame to a monitor. The frequency depends on your game's FPS and is either ~60 times per second (no vsync) or ~30 FPS (with vsync)
- you are not allowed to access composite input and output at this time, this needs to be done in onTick() and stored as a variable for use in onDraw().
- for every connected monitor, this function will be called once. If you have 5 monitors connected, the function will be called 5 times per frame.
- Each time the function is called, a new monitor width and height can be used freely (e.g. screen.getWidth()/2 will result in different values for different sized monitors).
- if the execution of onDraw() takes longer than 16ms, you effectively slow down the FPS of the game
- if the execution of onDraw() takes longer than 100ms, the game will exit the function and discard the drawn stuff

## Special Cases

### BUS / synchronized and fast changing data (every tick different data)

The problem is: every logic component needs 1 tick to process data. When you programatically send data over composite, you will send different values every tick, to maximize bandwidth. While you are sending from one script to another script, this is no problem, but when the receiver is not a script you get into trouble. Imagine following example: You have a Bus system which sends data to receivers, one after another. The number channel 1 will contain the ID of the receiver, the other channels contain the data. Now the receiver only reads the data if the id on number channel 1 equals his own id. This procedure needs 2 ticks to process: 1 tick for composite read and 1 tick for the equal check. The output of the equal check will now control a composite switchbox that either forwards the composite data to whatever reads the data, or it discards it (in case the ID is not equal to my ID). But the time for the composite to travel to the composite switchbox is only 1 tick, while the time for the boolean to travel to the switchbox is (like we calculated before) 2 ticks. **This means:** we forward the wrong data! We forward the data which was sent 1 tick before our ID matched number channel 1!

**Solution:** artifically increase the tick time for the composite. We simply add another composite switchbox, inbetween the original composite and the boolean controlled switchbox. This has no effect on the composite (because we connect it to the OFF position) but only delays the composite by 1 tick. In the end the composite data needs the same time the equal check needs.

### onDraw while game is paused

Even if the game is paused, onDraw() is being called. onTick() is not being called. This can lead to unexpected behaviour.

### FPS and TPS (Ticks per second)

If the TPS, the physical ticks, slow down, the FPS of the screens and also the frequency of onDraw() calls will slow down!

## Nonstandard LUA API

### math.atan2

In Stormworks, math.atan2 does not exist. Note that math.atan2 normally requires two arguments in Lua, while math.atan only requires one. , In Stormworks, math.atan can take either one or two arguments, so it can also be used as if it were math.atan2.

### table.maxn

Stormworks implements many of Lua's table functions, but maxn is not implemented.

---

Source: [Wiki/Guides/Lua/Special Advice for Lua](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Special_Advice_for_Lua) · Revision 3291 · CC BY-NC-SA
