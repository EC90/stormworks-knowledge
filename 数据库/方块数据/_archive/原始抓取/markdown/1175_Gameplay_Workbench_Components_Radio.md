---
title: "Gameplay/Workbench/Components/Radio"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Radio"
page_id: 1175
revision_id: 4715
revision_timestamp: "2026-07-02T16:22:15Z"
retrieved_at: "2026-08-30T15:13:07+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
---
# Gameplay/Workbench/Components/Radio

Radios allow vehicles and people to share numeric, boolean, audio, and video data. Signal strength is worsened by distance and depleted power sources, and improved with larger antennas (which also increase maximum range). Poor signal strength adds static to audio communication and a grain/static effect to video feeds, but numeric and boolean data are reliable until the maximum range is reached (maximum range is affected by both the transmitter and receiver).

Radios are also required to operate train switches, see below for details.

This article was last updated for Stormworks version [V1.15.2](https://stormworks.fandom.com/wiki/V1.15.2 "V1.15.2") (16 Aug 2025).

## Setup

### Frequencies

Usable frequencies can be any number, within certain limits:

- Only integers can be used.
- Numbers with a decimal point will get rounded to the nearest integer. For example, 0.5 and everything above it (up to 0.999...) rounds to 1, everything below it (down to 0.000...1) rounds to 0.
- Numbers larger than 16,777,216 may overlap with nearby numbers.
- Number precision within Stormworks is limited to +/- 224. Larger and smaller numbers may be used, but they may be converted to some other nearby value, so the limit where sequential radio channels definitely do not overlap is within the bounds of +/-16,777,216.
- Negative numbers can be used and are distinct from positive numbers (so -1 will not communicate with 1 or vice versa).

Within those bounds, all radio frequencies besides those listed below can be safely used by player creations without other in-game interaction. Note that for all of the in-game systems that respond to radio signals, buttons can be used instead for manual operation; the radio is there for convenience.

- **0-8:** Used by handheld radios and remote controls.
- **440:** Used to operate junction switches for trains. Whenever there are two possible paths a train could take, junction switches default to sending the train to the right. Sending an 'on' signal on channel 440 while within range of a junction switch will temporarily cause it to send trains to the left.

**Gantry cranes:**
Gantry cranes are used to buy/sell fish, oil, and fuel. They are all controlled similarly. Sending an 'On' signal on boolean channel 1 causes the crane to toggle its pump/vacuum on or off, buying or selling fuel/oil/fish as appropriate for the crane. Numeric channel 1 can be used to move the crane left / right with values from -1 to 1 (-1 moves left if standing behind the pump, or right if you're in the water in front of it). Numeric channel 2 can be used to move the crane up/down (1 moves up). Only values greater than 0.8 or less than -0.8 will have an effect.

- **1202:** Used by the diesel pump cranes for both buying and selling, such as at the [BVG Logistics Depot](https://stormworks.fandom.com/wiki/BVG_Logistics_Depot "BVG Logistics Depot") (player can sell) in the arctic, at the refinery island (buy), Olsen Bay in the northwest of Sawyer Island (sell), the Sawyer South Freight Terminal (sell), the Uran Power Plant (sell), and the Isle of Donkk (sell).
- **1267:** Used by crude oil pump cranes where oil can be bought or sold, such as at the Krail Oilworks (buy), the Daylight Oil Refinery in the arctic (buy), the refinery island (sell), or offshore oil rigs (buy).
- **1863:** Used by jet fuel pump cranes where jet fuel can be bought or sold, such as at the small unnamed airstrip (sell), or the refinery island (buy).
- **3077** Used by fish market cranes where players can sell [fish](https://stormworks.fandom.com/wiki/Fish "Fish"). Can be found at Terminal Camodo (part of the Donkk island chain), Sawyer Island's [North Harbor](https://stormworks.fandom.com/wiki/North_Harbor "North Harbor"), Sawyer Island's Fishing Village / Sawyer South Freight Terminal, the Uran Power Plant (northwestern part of the [Arid Island](https://stormworks.fandom.com/wiki/Arid_Island "Arid Island")), JSI Dock (southeastern part of the Arid Island), and near Tajin Airstrip (in the arctic).

Note: the Sawyer Island bridges *cannot* be operated by radio; they require someone to press the button on either side to lift them.

## Power consumption

Every antenna requires a small amount of [electricity](https://stormworks.fandom.com/wiki/Gameplay/Mechanics/Electricity "Gameplay/Mechanics/Electricity") to operate, as shown below.

Power consumption (transmit mode off/on):

- Radio RX Small: 0 / 0.0057 swatts
- Radio RX Medium: 0 / 0.0057 swatts
- Radio RX Large: 0 / 0.014 swatts
- Radio RX Huge: 0.011 / 0.054 swatts
- Radio Video Xmit: 0.0057 swatts (always on)
- Radio Video Recv: 0.0057 swatts (always on)
- RX Directional: 3.66 / 18.3 swatts
- RX Directional (Large): 5.49 / 23.8 swatts

## Logic and usage

### Radio RX antennas

These are the antennas vehicles use to transmit numeric, boolean, and audio data. Each antenna can either send or receive, depending on the setting of its transmit mode.

Logic nodes:

- Transmit mode (Boolean input):
- **Off (or not connected)**: The radio will be in 'listen' mode, and can receive transmissions.

- - **On**: The radio will be in 'transmit' mode, and can send but not receive transmissions.

- Frequency (Numeric input): Can be any value, see the frequencies section above.

- Signal strength (Numeric output): A value from 0 to 1. Will show 0 when no signal is being received. The small radios do not have a signal strength logic node. This can be also be used by radio scanners to automatically detect channels with any active data transfers, and to triangulate transmission locations. Specific types of data transfer can be identified by analyzing the various data channels within the frequency, or checking to see if a microphone connected to the antenna indicates an active audio transmission.

- Data Send (Composite input): The antenna will transmit all data sent to this node while in transmit mode.

- Data Recv (Composite output): Provides any data sent from the strongest nearby source broadcasting on the antenna's frequency setting.

- Audio Send (Audio input): Transmits audio from a microphone, or can relay audio from an antenna on another frequency to bridge communications between distant regions.

- Audio Recv (Audio output): Provides any audio sent from the strongest nearby source broadcasting on the antenna's frequency setting.

### Video antennas

Video transmissions do not interfere with radio communications and vice versa. Video is managed with a separate transmitter and receiver. This can allow a camera on a remotely-operated vehicle to be linked into a monitor display for a control terminal.

### Handheld radios

Handheld radios can be used to communicate with players and interact with autonomous vehicles. The signal strength produced by the handheld radio on a specific frequency can be used to detect a received signal, even though only audio data is being transmitted, and even if there's too much static to understand the audio. Vehicles can also distinguish audio data from other types by connecting the audio to a speaker - the speaker has a logic node to indicate if it is being used to receive a transmission. As such, handheld radios can be used to selectively trigger remotely-activated systems and to communicate via Morse code at longer distances while traveling on foot or in minimalist/lightweight vehicles.

Unfortunately, handheld radios cannot receive data back from autonomous vehicles. While it is theoretically possible to place a buzzer near a microphone in the hopes of creating audible Morse code chirps, in practice microphones will only transmit player voice data, and will only transmit when a player is nearby. However, it is certainly possible to receive audio from vehicles piloted by players.

### Directional antennas

Directional antennas send and receive audio, video, boolean, and numeric data. They must be pointed towards the target device to communicate with and they can communicate with other directional antennas, video antennas, or handheld radios. They take pitch and yaw inputs which can rotate them. The pitch input can rotate the dish up to 36 degrees with respect to the small arrow seen in the build editor, with a 1 pointing the dish in the opposite direction of the arrow. The yaw input causes the dish assembly to spin around on its base up to 1 full 360 degree turn in either direction (so -1 to 1 causes 720 degrees of rotation). Imprecise aiming causes degraded signal quality. Transmission range is increased by altitude (further analysis remains to be done).

## Calculating maximum transmission ranges

In Stormworks transmission ranges are calculated somewhat different than from what you would expect.
If you want to send a signal from antenna A to antenna B, the maximum range for a successfull transmission depends on:

- range of antenna A
- range of antenna B
- battery level of antenna A
- battery level of antenna B

+ any repeaters you have setup in the area

### Calculate maximum distance as sender

maximumDistance = ( rangeAntennaA + rangeAntennaB ) \* batteryLevelA \* batteryLevelB

### Calculate maximum distance as receiver (you must know distance to sender)

Hint: Small antenna has no output for signalStrength, so this does not work!

maximumDistance = distanceToSender / ( 1 - signalStrength )

distanceToSender must be calculated by gps difference:

distanceToSender = math.sqrt( (myGpsX - senderGpsX )^2 + (myGpsY - senderGpsY )^2 )

Hint: You could transmit the gps coordinates via radio.

### Calculate distance to sender (you must know the range of sender antenna and receiver antenna and both battery levels

Hint: Small antenna has no output for signalStrength, so this does not work!

distanceToSender = ( ( rangeAntennaSender + rangeAntennaReceiver ) \* batteryLevelSender \* batteryLevelReceiver ) \* ( 1 - signalStrength )

If you know the sender always has a full battery (e.g. diesel generator) and know the antenna type they are using, you can calculate your distance to the sender without any data over composite:

distanceToSender = ( ( rangeAntennaSender + rangeAntennaReceiver ) \* 1 \* batteryLevelReceiver ) \* ( 1 - signalStrength )

#### Example

Sender antenna: Huge
Receiver antenna: Small
Sender antenna range = 20000m
Receiver antenna range = 100m

Maximum distance between sender and receiver (in case of 100% batteries):

maximumDistance = ( rangeAntennaA + rangeAntennaB ) \*batteryLevelA \* batteryLevelB

```
maximumDistance = ( 20000m + 100m ) * 1 * 1
maximumDistance = 20100m * 1 * 1
maximumDistance = 20100m
```

Maximum distance between sender and receiver (in case of 100% battery for the sender and 50% battery for the receiver):
{{code-block | content = maximumDistance = rangeAntennaA \* batteryLevelA + rangeAntennaB \* batteryLevelB

```
maximumDistance = ( 20000m + 100m ) * 1 * 0.5
maximumDistance = 20100m * 0.5
maximumDistance = 10050m
```

## Controlling train switches

Broadcast Boolean on/off signal on 1st composite channel on frequency(radio channel) 440
.
Example:
Train with antenna (frequency 440) in transmit mode.
Connect a push button to composite input (boolean channel 1) of the antenna.

Now if you hit the push button, every train switch in range will toggle!

## Vehicle radio antennas

Radio RX Huge

[![Radio RX Huge](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/52/Radio_RX_Huge.png/revision/latest/scale-to-width-down/100?cb=20200130202247)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/5/52/Radio_RX_Huge.png/revision/latest?cb=20200130202247)

Range: 20km

Radio RX Large

[![Radio RX Large](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/ea/Radio_RX_Large.png/revision/latest/scale-to-width-down/100?cb=20200130202252)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/ea/Radio_RX_Large.png/revision/latest?cb=20200130202252)

Range: 4km

Radio RX Medium

[![Radio RX Medium](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/95/Radio_RX_Medium.png/revision/latest/scale-to-width-down/100?cb=20200130202257)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/9/95/Radio_RX_Medium.png/revision/latest?cb=20200130202257)

Range: 1km

Radio RX Small

[![Radio RX Small](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/d0/Radio_RX_Small.png/revision/latest?cb=20200130202302)

Range: 100m

## Video transmitters and receivers

Video receiver

[![Video receiver](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/d/de/Video_receiver.png/revision/latest?cb=20200130202310)

Range: 10km

Video emitter

[![Video emitter](data:image/gif;base64,R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAQAICTAEAOw%3D%3D)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/e/e3/Video_emitter.png/revision/latest?cb=20200130202315)

Range: 10km

## Patch history

### [V1.9.21](https://stormworks.fandom.com/wiki/V1.9.21 "V1.9.21")

- Fix - fixed typos in the radio antenna transmit logic nodes

### [V1.4.17](https://stormworks.fandom.com/wiki/V1.4.17 "V1.4.17")

- Fix - #6377 Radio RX composite descriptions are switched

### [V1.3.19](https://stormworks.fandom.com/wiki/V1.3.19 "V1.3.19")

- Balance - Reduced radio voice chat static noise

### [V1.3.13](https://stormworks.fandom.com/wiki/V1.3.13 "V1.3.13")

- Fix - Rx range description for handheld radios/remote control

### [V1.1.23-24](https://stormworks.fandom.com/wiki/V1.1.23-24 "V1.1.23-24")

- Fix - Handheld radio and remote control range being larger than described

### [V1.0.15](https://stormworks.fandom.com/wiki/V1.0.15 "V1.0.15")

- Fix - PTT being disabled when scrolling over hotbar radio equipment

### [V0.10.19-22](https://stormworks.fandom.com/wiki/V0.10.19-22 "V0.10.19-22")

- Balance - Radio parts now consume electricity proportionate to range. x4 when transmitting.

### [V0.9.20](https://stormworks.fandom.com/wiki/V0.9.20 "V0.9.20")

- Fix - Corrected Large Radio cost from 200 -> 2500

### [V0.8.32-33](https://stormworks.fandom.com/wiki/V0.8.32-33 "V0.8.32-33")

- Feature - Microphone Component
- Feature - 3 Speaker Components
- Feature - Audio Switchbox Microprocessor Component
- Rework - Radio Components V2 \*
- Fix - Voicechat and Quickchat can now be bound to inputs other than keyboard

- Old Radio components are now deprecated, but will still continue to work.

### [V0.7.1](https://stormworks.fandom.com/wiki/V0.7.1 "V0.7.1")

- Feature - Added 4 radio antenna sizes
- Larger antennas have higher range (up to 40km)
- Antennas can send and recieve composite data on a set channel
- Antennas have jiggle physics
- Radio signal is reduced when travelling through water

- Feature - Added 2 video radio components (transmitter and reciever)
- Similar to radio antennas, but they transmit a video signal
- Quality of video signal will degrade over long distances

---

Source: [Gameplay/Workbench/Components/Radio](https://stormworks.fandom.com/wiki/Gameplay/Workbench/Components/Radio) · Revision 4715 · CC BY-NC-SA
