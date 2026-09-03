---
title: "Shipping container"
source_url: "https://stormworks.fandom.com/wiki/Shipping_container"
page_id: 1316
revision_id: 4559
revision_timestamp: "2025-07-29T01:32:20Z"
retrieved_at: "2026-08-31T10:04:56+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: []
---
# Shipping container

[![Note weight of 2,200 units (22,000 kg) shown on left side.](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/86/Shipping_container_2.png/revision/latest/scale-to-width-down/253?cb=20250718010226)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/8/86/Shipping_container_2.png/revision/latest?cb=20250718010226)

[https://stormworks.fandom.com/wiki/File:Shipping_container_2.png](https://stormworks.fandom.com/wiki/File:Shipping_container_2.png)

Standard shipping container

Shipping containers (Also known as ISO-L containers) can be found at freight terminals in Stormworks, and can be transported to other terminals for various amounts of money. Short trips may earn as little as $1,000. Longer trips, like from the Sawyer Island's [North Harbor](https://stormworks.fandom.com/wiki/North_Harbor) up to the [BVG Logistics Depot](https://stormworks.fandom.com/wiki/BVG_Logistics_Depot) in the arctic can earn $18,000 - $46,000+.

A blank built-in shipping container is available in the presets.

## Design

All built-in shipping containers follow the same standard configuration as described below.

### Size

11 blocks tall x 11 blocks wide x 29 blocks long (2.75 x 2.75 x 7.25 meters).

### Connectors

They have electric connectors facing upward at each of the top corners, as well as electric connectors facing downward at each of the bottom corners, allowing the containers to be stacked. On the square faces at both ends, there are buttons to turn the connectors on/off, with one at the top (controlling the top connectors) and one at the bottom (controlling the bottom connectors). Indicator lights show whether or not the connectors are active: red is off, green is on.

### Rope anchors

At the top corners, there are four rope anchors, just inside (lengthwise) from the electric connectors.

### Sliding connector tracks

There are sliding connector tracks facing downward along the bottom on both long edges, ending at the electric connectors.

### Hardpoints

As of [V1.6.13](https://stormworks.fandom.com/wiki/V1.6.13) shipping containers have hardpoint connector attachments at the midpoint along the bottom edge on both long sides, at the exact middle of both square ends of the container, and one on the top in the middle.

### Labels

Cargo containers are generally labelled on all sides with their mass in Stormworks mass units (1 SMU = 10 kg). The fuel-tanker container variants only have their weight labelled on their long edges.

As of [V1.6.13](https://stormworks.fandom.com/wiki/V1.6.13), it appears that all regular cargo containers are 1,400 mass units and all fuel-tanker containers are 1,200 mass units.

### Logic

Shipping containers support a composite connection through any of the top electric connectors. A pulse on Channel 1 or Channel 31 will toggle the top electric connectors in the same way as the top button. A pulse on Channel 2 will toggle the bottom electric connectors in the same way as the bottom button.

Additionally, the shipping containers will send data on the composite connection through all of the top electric connectors. Channel 1 will be on if the top connectors are enabled. Channel 2 will be on if the bottom connectors are enabled. Channel 1 1 will be on if the top connectors are disabled. Channel 12 will be on if the bottom connectors are disabled. Channel 31 will always be on.

## See also

- [Trailer](https://stormworks.fandom.com/wiki/Trailer)

## Patch notes

### [V1.6.13](https://stormworks.fandom.com/wiki/V1.6.13)

- Rework - Updated and improved the default cargo containers (#9615 #10724)

### [V1.0.21](https://stormworks.fandom.com/wiki/V1.0.21)

- Rework - Cargo container design rework (Toggle buttons for connectors)

### [V0.6.2](https://stormworks.fandom.com/wiki/V0.6.2)

- Fix - Fixed some terrain issues at container depot, shipbreaking yard and arctic outpost

### [V0.6.1](https://stormworks.fandom.com/wiki/V0.6.1)

- Feature - Added arctic biome with new islands to explore including a second "mega island" (located roughly 100km north of the main spawn area)
  - [Shipping container depot](https://stormworks.fandom.com/wiki/BVG_Logistics_Depot)

---

Source: [Shipping container](https://stormworks.fandom.com/wiki/Shipping_container) · Revision 4559 · CC BY-NC-SA
