---
title: "Gameplay/Workbench/Lua Programming"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Workbench/Lua_Programming"
page_id: 995
revision_id: 4201
revision_timestamp: "2025-05-14T02:40:56Z"
retrieved_at: "2026-08-31T10:03:06+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Gameplay/Workbench/Lua Programming

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Lua_Programming?action=edit). |
| --- | --- |

## Lua Programming

## Lua in Stormworks

Lua programming in Stormworks is done inside microcontrollers. "Lua Script" is a logic component like every other, it has 2 inputs (composite and video) and 2 outputs (composite and video). The lua script can draw stuff onto the video feed and it can read and write composite values. These two functionalities are also split in the code, all the video related stuff is done inside the "onDraw()" function while all composite related stuff is done inside the "onTick()" function.

**Programming Lua in Stormworks comes in with some special rules:**

- each lua script component can contain a maximum of 4096 characters of Lua code
- only basic Lua libraries are supported: pairs, ipairs, next, tostring, tonumber, math, table, string

**Additonally there are functions you can call to draw onto the video or interact with the composite input and output:**

- screen.drawXxx() functions to draw something on the monitor
- map.xxx() functions to manipulate a drawn map
- input.xxx() functions to read input composite
- output.xxx() functions to write output composite
- property.xxx() functions to read microcontroller's properties

Stormworks offers some code examples and documentation for all functions in the lua code editor (visible when you edit a Lua script component), but you should already have a basic knowledge of programming (any language).

## Guide

[Wiki/Guides/Lua](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua)

## Learn Lua

If you have no experience in programming learn Lua here: [https://www.lua.org/pil/contents.html](https://www.lua.org/pil/contents.html)

**MrNJersey offers some tutorial videos:**

## Special Lua Editors

### lua.flaffipony.rocks

CrazyFluffyPony offers a website where you can develop Lua code for Stormworks. It behaves 99% like in Stormworks and makes developing code easier. [https://lua.flaffipony.rocks](https://lua.flaffipony.rocks)

### Stormworks VSCode Extension

For Windows users wanting a full development environment with additional features: - A full debugger - Intellisense and error handling - Code libraries and ability to work across multiple files - Accurate, Multi-Monitor, Stormworks Simulator - Powerful build chain and Minimizer

Please look at the Stormworks VSCode Extension: [https://marketplace.visualstudio.com/items?itemName=NameousChangey.lifeboatapi](https://marketplace.visualstudio.com/items?itemName=NameousChangey.lifeboatapi)

(Or download VSCode and search "stormworks" in the extensions tab)

### ZeroBrane

Alternatively you can download ZeroBrane, a Lua IDE for Windows, Mac and Linux. Just be aware that its made for general Lua programming and not specialised for Stormworks. [https://studio.zerobrane.com/](https://studio.zerobrane.com/)

---

Source: [Gameplay/Workbench/Lua Programming](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Lua_Programming) · Revision 4201 · CC BY-NC-SA
