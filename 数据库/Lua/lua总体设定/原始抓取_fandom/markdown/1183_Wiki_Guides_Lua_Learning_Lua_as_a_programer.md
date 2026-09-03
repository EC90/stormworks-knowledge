---
title: "Wiki/Guides/Lua/Learning Lua as a programer"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Learning_Lua_as_a_programer"
page_id: 1183
revision_id: 2497
revision_timestamp: "2020-02-02T20:53:16Z"
retrieved_at: "2026-08-30T17:10:03+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Wiki/Guides/Lua/Learning Lua as a programer

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Learning_Lua_as_a_programer?action=edit). |
| --- | --- |

## Learning Lua as a programer

After reading this you should proceed with [Exploring the Stormworks Lua API](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Exploring_the_Stormworks_Lua_API)

# Theory

In case you did not read [Learning Lua as a beginner](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Learning_Lua_as_a_beginner)

- Lua variables have dynamic types:

myVariable = true myVariable = 0.1

- Lua variables do not need to be declared, but can (it influences scope):

myVariableA = 1 local myVariableB = 2

- all index do start at 1, not at 0 (same is valid for strings: the first character is at position 1)!

myTable = {"a", "b"} -- myTable[1] = "a" #myTable -- length of myTable = 2

## Scope

- by default, everything is in the global scope
- you can declare variables to be local

function test() local myVariable = "hello" - can access myVariable here end -- cannot access myVariable here (myVaribale = nil)

# Practical Examples

In the

[Lua IDE](https://lua.flaffipony.rocks/)

you can use the function

print()

. It's not supported in Stormworks, but it helps to create and debugs scripts in the Lua IDE.

## Basic Math

myVariable = 1 + 2 print(myVariable) -- will output "3" to console

Copy this code into the Lua IDE and run it. If you scroll down a little bit, you can see the console output, now showing "3".

## String formatting / Cutting away digits of numbers

Let's say you want to show a battery % label, from 1.0-100.0%. But the actual battery level is 0.12345 which would result in 12.345%.

battery = 0.12345 batteryPercent = battery * 100 -- 12.345 oneDecimalPlace = string.format("%0.1f", batteryPercent) -- "12.3" print(oneDecimalPlace .. "%") -- "12.3%" -- if you want two decimal place, use string.format("%0.2f", batteryPercent)

## Write to and read from tables

myTable = {} -- create empty table

-- fill table for i=1,5 do myTable[i] = i*5 end

-- print table for k,v in ipairs(myTable) do print("k=" .. k, "v=" .. v) end

-- this will print: -- k=1 v=5 -- k=2 v=10 -- k=3 v=15 -- k=4 v=20 -- k=5 v=25

## Create your own functions

This function simply adds 1 to the argument numb and returns the result.

function increment(numb) return numb + 1 end

print( increment(1) ) -- 2 print( increment(3.5) ) -- 4.5

## Advanced table functions

table.insert() helps us to insert a new entry to an existing table:

myTable = {"a"}

table.insert(myTable, "b") -- will add entry at the end of the table (called push)

-- print table for k,v in ipairs(myTable) do print("k=" .. k, "v=" .. v) end -- k=1 v="a" -- k=2 v="b"

table.insert(myTable, 2, "c") -- will add entry at position 2 of the table

-- print table for k,v in ipairs(myTable) do print("k=" .. k, "v=" .. v) end -- k=1 v="a" -- k=2 v="c" -- k=3 v="b"

The opposite of table.insert() is table.remove(), it removes an existing entry of an existing table.

myTable = {"a","b","c","d"}

value = table.remove(myTable) -- will remove the last entry of the table and return it to us (called pop)

print(value) -- "d" -- print table for k,v in ipairs(myTable) do print("k=" .. k, "v=" .. v) end -- k=1 v="a" -- k=2 v="b" -- k=3 v="c"

value = table.remove(myTable, 2) -- will remove the 2nd entry of the table and return it to us, it will also shift all the entries behind that (3,4,5,6,...) once index to the left to close the gap

print(value) -- "b" -- print table for k,v in ipairs(myTable) do print("k=" .. k, "v=" .. v) end -- k=1 v="a" -- k=2 v="c"

After reading this you should proceed with [Exploring the Stormworks Lua API](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Exploring_the_Stormworks_Lua_API)

---

Source: [Wiki/Guides/Lua/Learning Lua as a programer](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Learning_Lua_as_a_programer) · Revision 2497 · CC BY-NC-SA
