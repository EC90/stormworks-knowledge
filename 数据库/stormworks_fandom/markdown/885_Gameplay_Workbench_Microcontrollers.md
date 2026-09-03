---
title: "Gameplay/Workbench/Microcontrollers"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Workbench/Microcontrollers"
page_id: 885
revision_id: 4203
revision_timestamp: "2025-05-14T02:40:56Z"
retrieved_at: "2026-08-31T10:03:07+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Gameplay/Workbench/Microcontrollers

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Microcontrollers?action=edit). |
| --- | --- |

## Microcontrollers

Microcontrollers are user-built devices that can perform complex logic through the use of logic gates.

### Overview

Generally speaking, microcontrollers are the go-to way to solve more complex problems and automate your vehicle, whether it be calculating the percentage of fuel remaining or automatically piloting your vehicle from waypoint to waypoint. Although it is possible to do almost everything that you can do in a microcontroller using the discrete gates in the inventory screen, it is vastly more space and mass efficient to use a microcontroller. Furthermore, microcontrollers have access to LUA gates for programming more complex behavior or drawing an interface for a display or HUD block.

## Basics

### Creating

To create a microcontroller, first click on the "Microcontroller Editor" button on the right side of the top button panel. This will open up the microcontroller editor. The first thing you will see is one of the screens below. Starting with the top panel, the buttons from the left close the editor, update the current microcontroller, create a new microcontroller, load a saved microcontroller, save the current microcontroller, and upload the current microcontroller to the steam workshop. The next two buttons switch between the two main screens of the microcontroller editor, the design screen which you currently see, and the logic screen which is where you will set up the logic of your microcontroller. The rest of the buttons to the right are tools that can be used when editing in the logic screen. On the left hand side, you can see the microcontroller schematic. This shows how the microcontroller block that you place will look.

[![Initial Microcontroller Screen when making a new microcontroller.](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f2/20191018044956_1.jpg/revision/latest/scale-to-width-down/600?cb=20191018095135)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f2/20191018044956_1.jpg/revision/latest?cb=20191018095135)

Initial Microcontroller Screen when making a new microcontroller.

On the right hand side of the screen you can see three tabs. The properties tab lets you name your microcontroller, give it a description, and change the width and length of the microcontroller. The width and length determine the physical width and length of the microcontroller once you place it on your vehicle, as well as how many nodes you can have on your microcontroller. The image to the right shows how properties tab may look for a microcontroller that adds two numbers together.

[![Logic panel of Microcontroller editor.](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/8f/20191018054644_1.jpg/revision/latest/scale-to-width-down/600?cb=20191018104719)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/8f/20191018054644_1.jpg/revision/latest?cb=20191018104719)

Logic panel of Microcontroller editor.

The logic tab, not to be confused with the logic screen, allows you to add nodes to your microcontroller. Nodes are used when you want to input or output an On/Off, number, composite, video, or audio signal into or out of the microcontroller. These nodes appear on the microcontroller schematic and can be moved by clicking and dragging them. Although they can overlap and be moved off of the white rectangle, any nodes that are overlapping or off the white rectangle will simply not appear on the microcontroller when it is placed, and thus can't be used. The image to the right shows how the logic tab may look for a microcontroller that adds two numbers together.

[![Symbol panel of Microcontroller editor.](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d0/20191018055259_1.jpg/revision/latest?cb=20191018105313)

Symbol panel of Microcontroller editor.

The symbol tab contains a 16x16 grid of pixels which can by toggled on and off by clicking on them. This picture is what will be shown when the microcontroller is in your block list in the vehicle editor. Although this is not required, it is generally good practice to draw an image so that the microcontroller stands out in the inventory screen. The image to the right shows how the symbol tab may look for a microcontroller that adds two numbers together.

[![Logic screen of Microcontroller editor.](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/3/33/20191018044843_1.jpg/revision/latest?cb=20191018095134)

Logic screen of Microcontroller editor.

Moving over the the logic screen, you can see a large grid that contains any nodes you have added to your microcontroller. Here is where you connect your inputs and ouputs to various logic gates in order to achieve some desired effect. Logic gates can selected and placed by pressing tab, clicking on a logic gate, and left clicking anywhere on the grid. Just like with vehicle logic, the logic gates and input and output nodes can be connected together by connecting the colored dots. The image to the right shows how you might do the logic for a microcontroller that adds two numbers together.

Once you are done making a microcontroller, save it and then exit back to the vehicle editor. Now that you have saved the microcontroller you can find it in your inventory and place on your vehicle.

### Updating

Microcontrollers can be updated by clicking on the select tool in the vehicle editor and clicking on the microcontoller you want to edit, and hitting the edit button on the top right of the panel that appears. This is also where you can change any properties that you added into your microcontroller logic. After clicking the edit button, the microcontroller Editor will open with the selected microcontroller where you can then make changes to the microcontroller as per usual. Once done editing the microcontroller, hit the update button on the left side of the top panel to apply the changes to the microcontroller you were editing.

## Advanced

### Execution Order and Latency

The logic stored in a microcontroller is evaluated every ingame tick (1/60th of a second), and every gate within the microcontroller is simultaneously evaluated based on their current input values. In effect, this means that a signal cannot propagate faster than one gate per tick in a microcontroller. This can be seen experimentally by connecting a button to the On/Off input of a microcontroller and a light to the On/Off output of the microcontroller, and then putting 60 OR gates between the input and the output within the microcontroller. If timed, it will take exactly one second for the light to turn on after hitting the switch, and exactly one second for it to turn off after releasing the button. For multiple microcontrollers connected in serial, the total latency of a signal will always be the total number of gates it passes through: going from one microcontroller to another does not add any additional latency*. Although most microcontrollers are more complex than just a straight line of OR gates, the way you find the latency of a signal is the same: count the number of serial logic gates the signal must pass through to reach its destination. It is imperative that latency is minimized for time critical applications such as using PIDs to control your vehicle, particularly with aircraft. To this end, it is worth noting that the LUA gate, like all gates, only takes a single tick to calculate, and so it is ideal for quickly performing complex and time-critical calculations.

*The one exception to this rule is in the case where the input connects directly to the output in the microcontroller logic. In this case it will still take 1 tick to update even though the signal does not pass through a logic gate.

## Note on damage

Slightly damaged microcontrollers may flicker on and off. Heavily damaged microcontrollers will turn off entirely. When microcontrollers are turned off by damage, inputs, outputs, and internal logic are all disabled (so, as an example, a timer running on the microcontroller will stop counting while it is disabled). Video outputs become a black screen, boolean outputs default to false, and numeric outputs default to 0.

Once repaired, the microcontroller will be returned to the state it was in before it was damaged. Unfortunately, this also means that any Lua blocks which have entered an error state (yielding a blue screen error message on any connected monitor) cannot be rebooted even by damaging and repairing the microcontroller. To fix errors of this sort, the vehicle would need to be returned to the workbench editor.

---

Source: [Gameplay/Workbench/Microcontrollers](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Microcontrollers) · Revision 4203 · CC BY-NC-SA
