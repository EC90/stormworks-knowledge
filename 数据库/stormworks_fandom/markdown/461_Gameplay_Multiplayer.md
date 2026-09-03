---
title: "Gameplay/Multiplayer"
source_url: "https://stormworks.fandom.com/wiki/Gameplay/Multiplayer"
page_id: 461
revision_id: 4134
revision_timestamp: "2025-05-14T02:35:10Z"
retrieved_at: "2026-08-31T10:02:33+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: []
---
# Gameplay/Multiplayer

Multiplayer in *[Stormworks](https://stormworks.fandom.com/wiki/Stormworks:_Build_and_Rescue)* allows for the same game modes as in singleplayer, though allowing these to be played with friends or strangers. Stormworks uses the Steam friend list to display games that your friends are playing, has a public server list in-game, and also allows direct connections to private servers (default port is 25565).

Although servers with few players and vehicles tend to perform adequately, it remains easy for a server with many players and large complex vehicles to grind to a crawl.

This page was last updated for Stormworks [V1.4.15](https://stormworks.fandom.com/wiki/V1.4.15) (4/11/2022).

This page is outdated since the server has been moved to the main game.

## Multiplayer Communities

Unofficial [Multiplayer Communities](https://stormworks.fandom.com/Wiki/Other_Stormworks_Communities%7C) are available to join any time, and are hosted around the clock by members of the player base. Please keep in mind that:

- In most cases, if you are hosting a game you will need to enter your routers settings and change your port forward options to enable communication between you and your friend's devices. There is also security software that may be a problem and may deny access.

- A guide on how to port forward on most common routers can be found [here:](https://www.noip.com/support/knowledgebase/general-port-forwarding-guide/)

- In case you cannot access the settings of the router or forward ports, you can use programs like [Hamachi](https://www.vpn.net/).

### Dedicated server

As of February 2020, Stormworks now supports hosting dedicated servers.

### Server hosts

As well as hosting your own Stormworks server, you can also rent a server without the worry of performance. Here's a few reputable hosts to choose from:

- [LOW.MS Hosting](https://low.ms/)
- [Zap Hosting](https://zap-hosting.com/)
- [FastCat Gaming Servers](https://fastcat.co/)

### Why can't my friend use the workbench?

Since 0.10.3-9, the host must authorize other players to be able to spawn vehicles. This is a security measure to prevent griefing on public servers. In game, hold the ~ key (or the backtick [`] on some computers) to open the player list. Then, check the number to the left of your friend's name; this is their id. Use the following commands in the chat window (opened by pressing [Enter]) to (de)authorize them:

- ?add_admin <id>
- ?remove_admin <id>
- ?add_auth <id>
- ?remove_auth <id>

## Patch notes

### [V1.4.15](https://stormworks.fandom.com/wiki/V1.4.15)

- Feature - [#5247](https://geometa.co.uk/support/stormworks/5247) [#6364](https://geometa.co.uk/support/stormworks/6364) [#6221](https://geometa.co.uk/support/stormworks/6221) Multiplayer time dilation algorithm overhaul
- Feature - Multiplayer bandwidth optimization

### [V1.4.7](https://stormworks.fandom.com/wiki/V1.4.7)

- Feature - Parsing Optimization
  - With an update to our parsing system, you can expect save and vehicle files to be significantly smaller in size; we managed to reduce the default mission vehicles by ~50%. We are not only hoping this will save users storage space but also reduce load times when sending vehicle data in multiplayer. You may need to re-save your vehicles.
- Fix - [#5064](https://geometa.co.uk/support/stormworks/5064) Fix health sync requests causing ragdoll on respawn

### [V1.4.4](https://stormworks.fandom.com/wiki/V1.4.4)

- Fix - Crash in multiplayer when entering/exiting seats

### [V1.3.13](https://stormworks.fandom.com/wiki/V1.3.13)

- Fix - Fix multiplayer hosts dropping client players not creating ragdoll animation

### [V1.3.0](https://stormworks.fandom.com/wiki/V1.3.0)

- Feature - Multiplayer Optimization Pass and Networking Layer Fixes
- Fix - Infinite spawning issue in multiplayer

### [V1.2.3-4](https://stormworks.fandom.com/wiki/V1.2.3-4)

- Fix - Fixed multiplayer issues caused by vehicle loading

### [V1.1.14-17](https://stormworks.fandom.com/wiki/V1.1.14-17)

- Fix - Stopped ai_debug command from causing issue in multiplayer

### [V1.1.13](https://stormworks.fandom.com/wiki/V1.1.13)

- Fix - Reordered multiplayer data so most important vehicle information is sent first

### [V1.0.26-27](https://stormworks.fandom.com/wiki/V1.0.26-27)

- Fix - Multiplayer CTD caused by returning a vehicle to workbench that is connected via rope to another object

### [V1.0.16-17](https://stormworks.fandom.com/wiki/V1.0.16-17)

- Fix - Invisible ropes for multiplayer clients

### [V1.0.1-14](https://stormworks.fandom.com/wiki/V1.0.1-14)

- Fix - Door jitter in multiplayer
- Fix - Multiplayer equipment crashes
- Fix - Rope state multiplayer sync

### [V1.0.0](https://stormworks.fandom.com/wiki/V1.0.0)

- Major Feature - Multiplayer Improvements and Optimisation

### [V0.10.32-33](https://stormworks.fandom.com/wiki/V0.10.32-33)

- Fix - CTD caused by microprocessors in multiplayer

### [V0.10.27-28](https://stormworks.fandom.com/wiki/V0.10.27-28)

- Fix - Multiplayer physics frame acceleration leading to stuttering

### [V0.10.23-25](https://stormworks.fandom.com/wiki/V0.10.23-25)

- Fix - Greatly reduced effects of multiplayer lag on particle trails

### [V0.10.10-11](https://stormworks.fandom.com/wiki/V0.10.10-11)

- Fix - Local multiplayer games overwriting server config

### [V0.10.3-9](https://stormworks.fandom.com/wiki/V0.10.3-9)

- Fix - Multiplayer shaking and sliding on vehicles
- Fix - Magall issues in multiplayer
- Fix - Research timers desyncing in multiplayer

### [V0.10.2](https://stormworks.fandom.com/wiki/V0.10.2)

- Feature - New Multiplayer Sync

### [V0.9.11](https://stormworks.fandom.com/wiki/V0.9.11)

- Rework - Multiplayer optimisations; moved several calculations to the server side

### [V0.9.7-8](https://stormworks.fandom.com/wiki/V0.9.7-8)

- Feature - Streamlined multiplayer dynamic object sync Vehicles and other entities are now visible at long range. The server will experience less slowdowns caused by clients loading vehicles.
- Fix - Multiplayer clients now wait for tile physics to load fully

### [V0.8.29-31](https://stormworks.fandom.com/wiki/V0.8.29-31)

- Fix - Soft-locking the game when fast travelling in multiplayer

### [V0.8.24-28](https://stormworks.fandom.com/wiki/V0.8.24-28)

- Rework - Further improvements to multiplayer sync including several fixes
- Feature - Multiplayer Island

### [V0.8.22-23](https://stormworks.fandom.com/wiki/V0.8.22-23)

- Feature - Kinematic Multiplayer

### [V0.8.11-14](https://stormworks.fandom.com/wiki/V0.8.11-14)

- Fix - Multiplayer server no longer gradually increases delay of some clients
- Fix - Multiplayer minor processing improvements

### [V0.8.7-10](https://stormworks.fandom.com/wiki/V0.8.7-10)

- Fix - Multiplayer timing algorithm updated for multithreading

### [V0.7.18](https://stormworks.fandom.com/wiki/V0.7.18)

- Fix - Fixed players being able to join a singleplayer game immediately after host has quit a multiplayer session
- Fix - Fixed being able to send empty chat messages in multiplayer

### [V0.7.2-3](https://stormworks.fandom.com/wiki/V0.7.2-3)

- Fix - Fixed completed research not being synced for clients when joining a multiplayer game

### [V0.6.21](https://stormworks.fandom.com/wiki/V0.6.21)

- Fix - Fixed research time not updating for host in multiplayer

### [V0.6.16-17](https://stormworks.fandom.com/wiki/V0.6.16-17)

- Fix - Fixed vehicle desync in multiplayer
- Fix - Fixed fuel tanks not having fuel in multiplayer

### [V0.6.15](https://stormworks.fandom.com/wiki/V0.6.15)

- Fix - Unloaded vehicles are still visible on the map in multiplayer
- Fix - Other players show on the map for multiplayer host

### [V0.6.1](https://stormworks.fandom.com/wiki/V0.6.1)

- Fix - Fixed object sync priority not being calculated correctly in multiplayer

### [V0.5.15](https://stormworks.fandom.com/wiki/V0.5.15)

- Fix - Fixed sending chat messages in multiplayer causing creative menu to be opened

### [V0.5.12-14](https://stormworks.fandom.com/wiki/V0.5.12-14)

- Feature - Added options to general settings to hide the minimap and hide player names in multiplayer
- Fix - Players who leave a multiplayer game while dead and then rejoin will be correctly respawned
- Fix - Fixed crash when hosting a multiplayer game

### [V0.5.6](https://stormworks.fandom.com/wiki/V0.5.6)

- Fix - multiplayer list now shows the correct peer count
- Fix - fixed microcontrollers not working correctly in multiplayer

### [V0.4.40-41](https://stormworks.fandom.com/wiki/V0.4.40-41)

- Fix - Fixed clone character sometimes being visible when reconnecting to a multiplayer game
- Fix - Fixed multiple network related bugs causing multiplayer to crash

### [V0.4.37-39](https://stormworks.fandom.com/wiki/V0.4.37-39)

- Fix - Fixed network crash when exiting multiplayer game

### [V0.4.29-30](https://stormworks.fandom.com/wiki/V0.4.29-30)

- Fix - Resolved some desync issues with advanced vehicles in multiplayer

### [V0.4.27](https://stormworks.fandom.com/wiki/V0.4.27)

- Fix - Multiplayer stability improvements
- Fix - Reworked Steam P2P multiplayer

### [V0.4.21-22](https://stormworks.fandom.com/wiki/V0.4.21-22)

- Fix - Fixed rotor physics desyncing in multiplayer
- Fix - Fixed being kicked out of seat in multiplayer when another player returns a vehicle to the workbench
- Fix - Fixed missions with fire crashing multiplayer games

### [V0.4.2-13](https://stormworks.fandom.com/wiki/V0.4.2-13)

- Fix - Some improvements to desync of new components in multiplayer
- Fix - Fixed wrong logic node tooltip showing when hovering pipe connection if multiple logic nodes were behind the connection

### [V0.3.9-12](https://stormworks.fandom.com/wiki/V0.3.9-12)

- Feature - Added more information to multiplayer "failed to connect" screen with potential solutions
- Fix - Fixed physics desync when clients get out of seats in multiplayer
- Fix - Fixed some multiplayer issues caused by data from previous game not being cleaned

### [V0.3.4](https://stormworks.fandom.com/wiki/V0.3.4)

- Fix - Improved fire desync in multiplayer
- Fix - Pressing [e] to drop carried object in multiplayer no longer toggles throwing behaviour

### [V0.3.3](https://stormworks.fandom.com/wiki/V0.3.3)

- Fix - Fixed peers in multiplayer having incorrect object load/unload range

### [V0.2.42](https://stormworks.fandom.com/wiki/V0.2.42)

- Fix - Players spawn in correct place on server in multiplayer while still in wardrobe

### [V0.2.41](https://stormworks.fandom.com/wiki/V0.2.41)

- Fix - Improved desync of pivots and hinges in multplayer
- Fix - Improved frequent multiplayer slowdown
- Fix - Improved bandwidth usage in multiplayer
- Fix - Added network debugging to F1 profiler

### [V0.2.39-40](https://stormworks.fandom.com/wiki/V0.2.39-40)

- Fix - Fixed held buttons desyncing in multiplayer when moving out of range

### [V0.2.32-35](https://stormworks.fandom.com/wiki/V0.2.32-35)

- Fix - Improved desync for vehicle logic in multiplayer
- Fix - Improved speed of multiplayer (multiplayer shouldn't get stuck in low framerates as often)
- Fix - Loot boxes no longer crash game in multiplayer
- Fix - Multiplayer client tick rate system reworked to manage problem where clients slow down game significantly

### [V0.2.29-31](https://stormworks.fandom.com/wiki/V0.2.29-31)

- Fix - Ocean rocks are synced in multiplayer
- Fix - Reduced client load/unload range in multiplayer
- Fix - Physics objects sync as islands in multiplayer to reduce desync
- Fix - Resolved several rare multiplayer crashes

### [V0.2.27-28](https://stormworks.fandom.com/wiki/V0.2.27-28)

- Fix - Fixed fire parented to a vehicle not being attached to vehicle in multiplayer
- Fix - Multiple stability fixes for multiplayer

### [V0.2.22-26](https://stormworks.fandom.com/wiki/V0.2.22-26)

- Fix - Getting out of a seat in multiplayer no longer kicks the host player out of their vehicle
- Fix - Fixed purchasing islands in multiplayer career
- Fix - Fixed currency and inventory not syncing properly in multiplayer
- Fix - Removed option for pausing/unpausing photo mode in multiplayer
- Fix - General stability improvements for multiplayer

### [V0.2.13-21](https://stormworks.fandom.com/wiki/V0.2.13-21)

- Fix - resolved incorrect game mode in multiplayer
- Fix - resolved tutorial sometimes starting in multiplayer
- Fix - player flashlight now works in multiplayer
- Fix - islands now purchase correctly for clients in multiplayer
- Fix - reduced message max size when spawning vehicles helping larger vehicles and multiplayer vehicles to spawn correctly
- Fix - resolved issue rejoining game in multiplayer
- Fix - resolved issue breaking creative mode in multiplayer
- Fix - players no longer move while in workbench in multiplayer

### [V0.2.11-12](https://stormworks.fandom.com/wiki/V0.2.11-12)

- Feature - Multiplayer system overhauled to use Steam P2P (you no longer need to port forward and can connect easily connect with anyone on your Steam friends list)
- Feature - Maximum player count in multiplayer increased to 6
- Feature - Multiplayer now has career mode as well as creative (co-op, inventory and money is shared between all players)
- Feature - Multiplayer games can now be loaded/saved
- Feature - Added sleeping in multiplayer
- Fix - Various changes and reworks of systems in multiplayer

### [V0.2.8-9](https://stormworks.fandom.com/wiki/V0.2.8-9)

- Fix - Fixed several crashes when spawning vehicles in multiplayer

### [V0.2.6-7](https://stormworks.fandom.com/wiki/V0.2.6-7)

- Feature - Mission spawn menu is now available in multiplayer
- Feature - Improved stability for large vehicles in multiplayer
- Fix - Missions spawn correctly in multiplayer
- Fix - Connectors now work properly in multiplayer
- Fix - Improved handle desync in multiplayer
- Fix - Fixed graphical artifacts in multiplayer when far from spawn

### [V0.1.26-27](https://stormworks.fandom.com/wiki/V0.1.26-27)

- Fix - Fixed vehicles crashing server when initially spawning in multiplayer

### [V0.1.23-25](https://stormworks.fandom.com/wiki/V0.1.23-25)

- Fix - controllers now work correctly in multiplayer

### [V0.1.20](https://stormworks.fandom.com/wiki/V0.1.20)

- Fix - Fixed some ladder-related multiplayer crashes
- Fix - Reduced some camera jitter when attached to ladders in multiplayer

### [V0.1.17-18](https://stormworks.fandom.com/wiki/V0.1.17-18)

- Fix - first person camera no longer jitters in multiplayer while in moving vehicle
- Feature - multiplayer now has "waiting for server" screen when server is working
- Fix - vehicles now consistently return to workbench using R even when their multi-bodies are unfolded larger than edit grid
- Fix - multiplayer player positions are corrected with vehicle position corrections
- Fix - multiplayer no longer crashes when a player disconnects
- Fix - multiplayer player names now disappear when players fast travel

### [V0.1.16](https://stormworks.fandom.com/wiki/V0.1.16)

- Feature - creative mode menu now in multiplayer for setting weather
- Feature - photo mode now in multiplayer

### [V0.1.14-15](https://stormworks.fandom.com/wiki/V0.1.14-15)

- Fix - resolved crash when using ladders in multiplayer

### [V0.1.12-13](https://stormworks.fandom.com/wiki/V0.1.12-13)

- Fix - resolved issue spawning boats in multiplayer
- Feature - multiplayer fast travel icons are now in multiplayer
- Fix - characters work properly in multiplayer immediately after disconnecting from ladder
- Fix - buoyancy data for vehicles now works correctly in multiplayer
- Fix - minor physics fix for characters in multiplayer

### [V0.1.10-11](https://stormworks.fandom.com/wiki/V0.1.10-11)

- Fix - multiplayer symbols no longer show up all over map
- Fix - multiplayer characters now render with correct clothes
- Fix - multiplayer character animation state improvements
- Fix - multiplayer crash when spawning character

### [V0.1.7-9](https://stormworks.fandom.com/wiki/V0.1.7-9)

- Feature - multiplayer refactor so clients move smoothly and no longer rubber band
- Fix - pilot seat controls no longer show for other players in multiplayer
- Fix - improved multiplayer performance and fixed issues where players didnt move correctly
- Fix - resolved multiplayer crash when player disconnect

### [V0.1.5](https://stormworks.fandom.com/wiki/V0.1.5)

- Fix - can now type punctuation in multiplayer chat

---

Source: [Gameplay/Multiplayer](https://stormworks.fandom.com/wiki/Gameplay/Multiplayer) · Revision 4134 · CC BY-NC-SA
