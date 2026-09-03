---
title: "Wiki/Guides/Lua/Exploring the Stormworks Lua API"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Exploring_the_Stormworks_Lua_API"
page_id: 1185
revision_id: 3254
revision_timestamp: "2022-12-09T22:04:55Z"
retrieved_at: "2026-08-30T17:10:01+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Wiki/Guides/Lua/Exploring the Stormworks Lua API

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Exploring_the_Stormworks_Lua_API?action=edit). |
| --- | --- |

## Exploring the Stormworks Lua API

After reading this you should proceed with [Special advise and little known facts](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Special_advise_and_little_known_facts)

# Theory

- Lua scripts run on the server and on the client, which means they can get into a state in which they aren't syncronized (e.g. `math.random()`)! While the composite input and output are in sync, the output on the screen can be different!
- When vehicles are too far away, they are unloaded. Once you come closer, the values of Memory components are restored, but the Lua scripts are reset (similar to loading the vehicle from the workbench.) If you need persistent data, use Memory components or use a No-Despawn-Block (NOT RECOMMENDED because of performance problems!)

## Interacting with composite data / onTick

- The function is called every time the physics engine runs a new tick. The frequency is ~60 times per second, but can decrease when large vehicles are spawned, especially in multiplayer.
- You are not allowed to access screen functions through onTick. This needs to be done in onDraw().
- If the execution of onTick() takes longer then 16ms, you effectively slow down the physics engine speed of the game.
- If the execution of onTick() takes longer than 100ms, the game will exit the function and discard any calculations done.

## Interacting with the Screen / onDraw

- onDraw() is called every time the game draws a new frame. The frequency depends on your game's FPS and is either ~60 times per second (no vsync) or ~30 FPS (with vsync).
- You are not allowed to access composite input and output at this time, this needs to be done in onTick().
- For every connected monitor, this function will be called once. If you have 5 monitors connected, the function will be called 5 times per frame.
- The position of objects to draw on the monitor is based on its size (e.g. `screen.getWidth()/2`) the objects will look different on monitors with different sizes when connected to the same script. It's recommended to resize your output based on screen size unless your script is written for specific screens.
- If the execution of onDraw() takes longer than 16ms, you effectively slow down the FPS of the game.
- If the execution of onDraw() takes longer than 100ms, the game will return from the function and discard anything drawn to your screen.

## Interacting with HTTP

You can send HTTP requests from within Lua.

Lua is executed on the server itself (a normal game or dedicated server) and on the every connected client. If a Lua script calls *async.httpGet()* every server/client will make a http request from it's own machine (localhost). This means you cannot transmit any information between players directly, and you cannot access any website on the internet. If a server/client has no webserver running on the specifiec port, the package will simply be dropped and the *response_body* will be exactly *"connect(): Connection refused"*.

You can run your own webserver for picking up requests and responding to them. Your webserver may also talk with other services (e.g. Youtube or Discord) and behave like a gateway for your lua script.

Important Information: This information is quite important if you want to develop a lua script with http.

Example code:

async.httpGet(port, url)

function httpReply(port, request_body, response_body) end

- URL must begin with a slash: */test?param=hello*
- Rate limit: You are only allowed to send 1 http request per tick. If you send more they will be placed into a queue. Every tick, the oldest request from that queue will be processed. This means potential delay!
- Error handling: The error handling inside Lua is quite poor. If you want some more documentation create an issue through [[1\]](http://mcro.org/issues/1/mcro.org)

## Available functions

For a complete list, visit [https://lua.flaffipony.rocks](https://lua.flaffipony.rocks) and scroll down to the bottom part of the page. Here are some of the most important ones:

input.getNumber(i) -- Read from composite input of the script (i = channel) input.getBool(i) -- Read from composite input of the script (i = channel)

output.setNumber(i, v) -- Write to the composite output of the script (i = channel, v = number) output.setBool(i, v) -- Write to the composite output of the script (i = channel, v = boolean)

screen.XXX -- Lots of functions to draw stuff onto the monitor

screen.setColor(r,g,b,a) -- Set drawing color (r=red, g=green, b=blue, a=alpha) -- r,g,b can range from 0 to 255 (as the "help tab" in the Lua script component denotes) -- alpha is the transparency and also ranges from 0 to 255 (also denoted in the "help tab" mentioned above)

screen.getHeight() -- Returns the height of the connected monitor in pixels

screen.drawRectF(x,y,w,h) -- Draws a filled rectangle with the top left corner at x,y and a width of w pixels and a height of h pixels

## Monitor coordinates

- the top left corner is x=0, y=0
- x is the axis to the right
- y = is the axis to bottom

# Practical Examples

## Reading and writing to composite

Let's say we want to read to values from composite, add them together and output the result on the composite again.

function onTick() val1 = input.getNumber(1) -- read first value from composite number channel 1 val2 = input.getNumber(2) -- read second value from composite number channel 2

result = val1 + val2

output.setNumber(1, result) -- output result on composite number channel 1 end

## Reading Battery value and drawing onto a monitor

batteryLevel = 0 -- Initiate the variable

function onTick() batteryLevel = input.getNumber(1) -- Every tick we read the current batteryLevel from the composite input (number channel 1) end

function onDraw() -- Convert raw battery level to nice looking percent text: "99.9%" batteryPercent = batteryLevel * 100 oneDecimalPlace = string.format("%0.1f", batteryPercent) -- cut away more than 1 decimal digit

text = oneDecimalPlace .. "%"

-- draw text onto monitor screen.setColor(255,0,0) -- Set drawing color to red

screen.drawText(1,2, text) -- Draw the text, first char begins at x=1, y=2 end

## Visualize rotation

Let's say you have a velocity pivot and want to visualize its current rotation.

rotation = 0

function onTick() rotation = input.getNumber(1) end

function onDraw() radiusOfCircle = 8

screen.setColor(0,0,255)

centerXOfCircle = 10 centerYOfCircle = 10

screen.drawCircle(centerXOfCircle, centerYOfCircle, radiusOfCircle) -- Draw the border of a circle

angle = rotation * math.pi * 2 -- convert the rotation to a radians angle: 1 rotation == 360 deg == 2*math.pi

-- The point we rotate is on the upper/north end of the circle, which represents our angle=0 rPoint = rotatePoint(centerXOfCircle, centerYOfCircle, angle, centerXOfCircle, centerYOfCircle - radiusOfCircle)

screen.setColor(255,0,0)

-- Draw a line from the center of the cirle to the rotated point -- The resulting line visualizes the rotation screen.drawLine(centerXOfCircle,centerYOfCircle, rPoint.x,rPoint.y) end

-- This functions rotates a point (px,py) and rotates it around a center (cx,cy) by an angle function rotatePoint(cx, cy, angle, px, py) s = math.sin(angle) c = math.cos(angle)

-- Translate point back to origin px = px - cx py = py - cy

-- Totate point xnew = px * c - py * s ynew = px * s + py * c

-- Translate point back x = xnew + cx y = ynew + cy return {x=x, y=y} end

## Drawing a graph of battery level over time

data = {} -- Here we will store the latest battery levels

MAX_DATA_LENGTH = 32 -- Store a maxium of 32 battery levels which means the battery level of the last ~0.5 seconds (60 ticks per second)

function onTick() batteryLevel = input.getNumber(1)

-- Push current battery level to the data table table.insert(data, batteryLevel)

if #data > MAX_DATA_LENGTH then -- Remove the oldest entry in data table.remove(data, 1) end end

function onDraw() -- Set background to black screen.setColor(0,0,0) screen.drawClear()

-- Draw graph screen.setColor(0,255,0)

for k,v in ipairs(data) do x = k y = screen.getHeight() * (1 - v) -- calculate y depending on the battery level, and because we want 100% to be on top of the monitor and 0% at the bottom we need to do "(1 - v)" screen.drawRectF(x, y, 1, 1) end end

After reading this you may proceed with [Special advise and little known facts](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Special_advise_and_little_known_facts)

---

Source: [Wiki/Guides/Lua/Exploring the Stormworks Lua API](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Exploring_the_Stormworks_Lua_API) · Revision 3254 · CC BY-NC-SA
