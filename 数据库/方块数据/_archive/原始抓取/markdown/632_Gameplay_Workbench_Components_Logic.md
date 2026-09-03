---
title: "Gameplay/Workbench/Components/Logic"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Logic"
page_id: 632
revision_id: 4163
revision_timestamp: "2025-05-14T02:40:54Z"
retrieved_at: "2026-08-30T15:12:58+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
---
# Gameplay/Workbench/Components/Logic

## Logic

# Introduction to Logic

There are two key types of logic blocks with an extra section. The first is numeric, numeric logic blocks allow the user to manipulate numerical data, for example plus to input values together. The second is boolean, boolean logic allows for a true or false style of logic, for example opening/closing doors or on/off for lights.

Stormworks has two ways of impliment logic, either directly by placing them on a creation in the workshop, or by using them in a microcontroller.

# Numeric

Add

[![Add](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/76/Add.jpg/revision/latest/scale-to-width-down/100?cb=20190317005907)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/76/Add.jpg/revision/latest?cb=20190317005907)

- Input 1 (Number)
- Input 2 (Number)
- Output 1 (Number)
- adds two numbers

Subtract

[![Subtract](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/9f/Subtract.jpg/revision/latest/scale-to-width-down/100?cb=20190317010249)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/9f/Subtract.jpg/revision/latest?cb=20190317010249)

- Input 1 (Number)
- Input 2 (Number)
- Output 1 (Number)
- subtracts two numbers

Multiply

[![Multiply](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/c/cb/Multiply.jpg/revision/latest?cb=20190317010141)

- Input 1 (Number)
- Input 2 (Number)
- Output 1 (Number)
- multiplies two numbers

Divide

[![Divide](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/a5/Divide.jpg/revision/latest?cb=20190317010023)

- Input 1 (Number)
- Input 2 (Number)
- Output 1 (Number)
- divides two numbers

Abs

[![Abs](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/6d/Abs.jpg/revision/latest?cb=20190317005900)

- Input 1 (Number)
- Output 1 (Number)
- the absolute value of a number

Clamp

[![Clamp](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/db/Clamp.jpg/revision/latest?cb=20190317005934)

- Input 1 (Number)
- Output 1 (Number)
- cuts off the input number at the given limits

Constant Number

[![Constant Number](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/6/60/Constant_Number.jpg/revision/latest?cb=20190317005944)

- Output 1 (Number): the defined value

Exponent

[![Exponent](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e6/Exponent.jpg/revision/latest?cb=20190317010032)

- Input 1 (Number)
- Input 2 (Number)
- Output 1 (Number): the exponent of both inputs

Greater than

[![Greater Than](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e5/Greater_Than.jpg/revision/latest?cb=20190317010051)

- Input 1 (Number)
- Input 2 (Number)
- Output 1 (On/Off)
- Outputs either true or false depending if Input 1 is greater than Input 2 or not.

Less than

[![Less Than](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/ae/Less_Than.jpg/revision/latest?cb=20190317010115)

- Input 1 (Number)
- Input 2 (Number)
- Output 1 (On/Off)
- Outputs either true or false depending if Input 1 is less than Input 2 or not.

Threshold Gate

[![Threshold Gate](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/0/06/Threshold_Gate.jpg/revision/latest?cb=20190317010256)

- The output is "On" if the tested value is in the defined interval

Modulo

[![Modulo](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/7e/Modulo.jpg/revision/latest?cb=20190317010134)

- Input 1 (Number)
- Input 2 (Number)
- Output 1 (Number)
- calculate the modulo of two numbers

Numerical Inverter

[![Numerical Inverter](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/c/c7/Numerical_Inverter.jpg/revision/latest?cb=20190317010156)

- Input 1 (Number)
- Output 1 (Number)
- inverts the input number: `f(-x)`

Trigonometry

[![Trigonometry](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/8c/Trigonometry.jpg/revision/latest?cb=20190317010303)

- can output different functions such as sin, cos, tan

# Boolean (True/False)

And

[![And](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d3/And.jpg/revision/latest?cb=20190317005912)

- Input 1 (On/Off)
- Input 2 (On/Off)
- Output 1 (On/Off)
- if both inputs are on

Not

[![Not](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/21/Not.jpg/revision/latest?cb=20190317010148)

- Input 1 (On/Off)
- Output 1 (On/Off)
- inverts the input ("On"->"Off", "Off"->"On")

Constant On

[![Constant On](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e2/Constant_On.jpg/revision/latest?cb=20190317005952)

- Output 1 (On/Off): always outputs "On"

JK Flip Flop

[![JK Flip Flop](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/2c/JK_Flip_Flop.jpg/revision/latest?cb=20190317010106)

- Input 1 (On/Off): Set Flip Flop to "On"
- Input 2 (Number): Set Flip Flop to "Off"
- Output 1 (On/Off): state of the Flip Flop
- Output 2 (On/Off): opposite of the state of the Flip Flop

Or

[![Or](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d6/Or.jpg/revision/latest?cb=20190317010218)

- Input 1 (On/Off)
- Input 2 (On/Off)
- Output 1 (On/Off): outputs "On" if input 1 or input 2 or both are "On"

Push to toggle

[![Push To Toggle](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/dd/Push_To_Toggle.jpg/revision/latest?cb=20190317010234)

- Input 1 (On/Off): change the state ("On"->"Off", "Off"->"On")
- Output 1 (On/Off): state of the toggle

SR Latch

[![SR Latch](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/c/c5/SR_Latch.jpg/revision/latest?cb=20190317010241)

Xor

[![XOR](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e0/XOR.jpg/revision/latest?cb=20190317010319)

- Input 1 (On/Off)
- Input 2 (On/Off)
- outputs "On" if only one of the two inputs is "On"

# Composite

# Functions

Function (1 Input)

[![Function 1 Input](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/5f/Function_1_Input.jpg/revision/latest?cb=20190317010039)

- Input 1 (Number)
- Output 1 (Number)
- applies a defined function onto a value

Function (3 Input)

[![Function 3 Input](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/57/Function_3_Input.jpg/revision/latest?cb=20190317010045)

- Input 1 (Number)
- Input 2 (Number)
- Input 3 (Number)
- Output 1 (Number)
- Same as Function with 1 input but you can use more different inputs in your function

Clamp: Sets both minimum and maximum values for a number. Although it states "clamp x within y and z" without specifying any order, it does require inputs in the order of (input, min, max).

# Other

Blinker

[![Blinker](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d8/Blinker.jpg/revision/latest?cb=20190317005918)

- Input 1 (On/Off): activate blinker
- Output 1 (On/Off)
- outputs "on" in a player defined rate

Capacitor

[![Capacitor](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/5a/Capacitor.jpg/revision/latest?cb=20190317005925)

- Input 1 (On/Off)
- Output 1 (On/Off)
- can delay and/or extend the input signal

Delay

[![Delay](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/1/16/Delay.jpg/revision/latest?cb=20190317010016)

- Input 1 (On/Off)
- Output 1 (On/Off)
- delays the change of the input signal (it will extend and delay the "On" state)

Counter

[![Counter](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/4/4c/Counter.jpg/revision/latest?cb=20190317010006)

- Input 1 (On/Off): is active
- Output 1 (Number): the current counter value
- after a defined time increases the counter value by 1

Counter (Ping Pong)

[![Counter Ping Pong](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/a/a4/Counter_Ping_Pong.jpg/revision/latest?cb=20190317010000)

- Input 1 (On/Off): is active
- Output 1 (Number): the current counter value
- after a defined time increases the counter value by 1 until it reaches its upper limit. Then it will count -1 until it reaches its lower limit ... and again and again

Memory

[![Memory](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/55/Memory.jpg/revision/latest?cb=20190317010121)

- Input 1 (Number): the value to write to the memory
- Input 2 (On/Off): write value to memory now
- Input 3 (On/Off): reset memory to defined value (default: 0)
- Output 1 (Number): value in the memory
- can be used to store a value over time

Numerical Junction

[![Numerical Junction](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/70/Numerical_Junction.jpg/revision/latest?cb=20190317010203)

- Input 1 (Number)
- Input 2 (On/Off): use output 2
- Output 1 (Number): outputs value of input 1 (if input 2 = "Off")
- Output 2 (Number): outputs value of input 1 (if input 2 = "On")

Numerical Switchbox

[![Numerical Switchbox](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/1/11/Numerical_Switchbox.jpg/revision/latest?cb=20190317010212)

- Input 1 (Number)
- Input 2 (Number)
- Input 3 (On/Off): use input 2
- Output 1 (Number): outputs value of input 1 (if input 3 = "Off") and value of input 2 (if input 3 = "On")

Up/Down

[![Up Down](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/2/2b/Up_Down.jpg/revision/latest?cb=20190317010310)

- outputs 1 if "On" and -1 if "Off"

# Microcontroller

[Microcontroller](https://stormworks.fandom.com/wiki/Wiki/Building/Microcontrollers "Wiki/Building/Microcontrollers")

[![Microcontroller](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d5/Microcontroller.jpg/revision/latest?cb=20190317010127)

- This holds logic components and is used to organize groups of logic components and save space. It is the only way to read or write composite data.

Gyro

[![Gyro](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/b/bf/Gyro.jpg/revision/latest?cb=20190317010059)

- Can be used to control a helicopter like vehicle

PID Controller

[![PID Controller](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/7/71/PID_Controller.jpg/revision/latest?cb=20190317010226)

- Input 1 (Number): the target value
- Input 2 (Number): the current measured value
- Input 3 (On/Off): is active
- Output 1 (Number): the value used to control the measured value
- can be used to e.g. control the speed and throttle of a vehicle or engine

---

Source: [Gameplay/Workbench/Components/Logic](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Logic) · Revision 4163 · CC BY-NC-SA
