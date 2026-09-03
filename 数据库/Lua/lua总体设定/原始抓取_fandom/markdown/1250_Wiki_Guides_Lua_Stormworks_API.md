---
title: "Wiki/Guides/Lua/Stormworks API"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Stormworks_API"
page_id: 1250
revision_id: 2748
revision_timestamp: "2021-03-17T03:23:42Z"
retrieved_at: "2026-08-30T17:10:05+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Pages_using_deprecated_source_tags"]
---
# Wiki/Guides/Lua/Stormworks API

## Vehicle API

## Mission API

### Server Functions

### Callbacks

These are callback functions that can be added to a script and are called automatically when their specified conditions are met, the simplest callback function is `onTick()` which is called every game tick.

#### onTick(game_ticks)

Called every game tick. `game_ticks` refers to the number of ticks that have passed this frame (normally 1, while sleeping 400).

### Matrix Functions

#### matrix.multiply

Multiplies two matrices together.

```
out_matrix=matrix.multiply(matrix1,matrix2)
```

#### matrix.invert

Inverts a matrix.

#### matrix.transpose

#### matrix.indentity

## Lua API

---

Source: [Wiki/Guides/Lua/Stormworks API](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Stormworks_API) · Revision 2748 · CC BY-NC-SA
