---
title: "Wiki/Guides/Lua/Learning Lua as a beginner"
source_url: "https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Learning_Lua_as_a_beginner"
page_id: 1180
revision_id: 3290
revision_timestamp: "2022-12-18T03:20:33Z"
retrieved_at: "2026-08-31T10:12:17+00:00"
license: "CC BY-NC-SA"
license_url: "https://www.fandom.com/licensing"
record_type: "article"
categories: ["Stubs", "Wiki_Page"]
---
# Wiki/Guides/Lua/Learning Lua as a beginner

| [![Stub](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest/scale-to-width-down/64?cb=20250514003444)](https://static.wikia.nocookie.net/stormworks_gamepedia_en/images/f/f1/Stub_v1.png/revision/latest?cb=20250514003444) | *This article is a [stub](https://stormworks.fandom.com/wiki/Category:Stubs). *You can help Us by [expanding it](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Learning_Lua_as_a_beginner?action=edit). |
| --- | --- |

## Learning Lua as a beginner

After reading this you should proceed with [Learning Lua as a programer](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Learning_Lua_as_a_programer)

# Theory

Here we tell you the basics of Lua.

## Variables

The type of a variable is set automatically depending on the value. Possible types are:

- nil
- boolean
- number
- string
- function
- table

myVariable = nil myVariable = true myVariable = 3.141 myVariable = {"a","b","c"}

Numbers are always saved as floats (double precision). So "3" is actually saved as something very similar to "3.00000001". Comparison will of course work:

(3 == 3.000000001) --true

## Comments

comments are not executed:

-- this is a single line comment a = 1 + 2 -- this is also a comment, but the code before "--" will be executed

--[[ this is a multiline comment for long comments it makes sense to use it, instead of prefixing every line with -- still part of the comment ]]-- a = 1 + 2 -- this is also a comment, but the code before "--" will be executed

## Math calculations / Arithmetic

myVariable = 1 + 2 myVariable = 2 - 1 myVariable = 2 * 4 -- multiplication: 2*4 = 8 myVariable = 9 / 4 -- division: 9/4 = 2.25 myVariable = 9 % 4 -- rest after a division: 9/4 => 2*4 + 1, so finally 9%4 = 1 myVariable = 2 ^ 3 -- 2 to the power of 3 (two cubed): 2^3 = 2*2*2 = 8

## Strings

myTextA = "Hello:" myTextB = "World" myText = myTextA .. myTextB -- ".." concatenates (joins) two strings, so myText = "Hello:World"

myText = "Number: " .. 1 -- myText = "Number: 1"

## Tables

A table is a list of several entries (although it can be just one entry, or even none: {}). Each entry of a table has a key (how you should refer to it) and a value (the information stored). The key can be a number or a string. If you do not specify a key for a value, lua will automatically use numbers as keys. If you specify a key, this key will be not be visible in a "for" loop (see Loops) and it will not count in #table (length of table).

myTableA = {"a","b"} -- myTableA[1] = "a", myTableA[2] = "b" myTableB = {x="a"} -- myTableB["x"] = "a", myTableB.x = "a" myTableC = {"a",x="b"} -- myTableC[1] = "a", myTableC.x = "b"

Lua calculates the length of a table by starting at table[1] and then counting up until the last table[i] that is not nil. So table={"a","b",nil,"c"} -- #table = 4 but table={"a","b",nil} -- #table = 2

#myTableA -- length of myTableA = 2 #myTableB -- length of myTableB = 0 #myTableC -- length of myTableC = 1

## If, Else and Elseif

### The "If" Statement

#### Conditions

An "if" statement is used to decide whether or not to execute code. For code to be run, a condition must be met. A condition can be a variable or expression, and can include any data type. Examples of conditions include:

- true => true -- true itself is always true
- 1 > 2 => false -- greater than
- 1 < 2 => true -- less than
- 2 == 2 => true -- equal to
- 3 >= 2 => true -- greater than or equal to
- 3 <= 2 => false -- less than or equal to
- nil => false

nil is the only datatype (excluding booleans) that can be false when on its own, anything else always equals true:

- {} => true -- even empty tables are true
- -1 => true
- "" => true
- **0 => true** -- Unlike many other programming languages, it should be noted that **lua evaluates 0 to be true**.

you can combine expressions with the keywords "not", "and", "or":

- false or true => true
- false and true => false
- not true = false

Using brackets clarifies how more complex expressions should be interpreted:

- (false or true) and true => false
- (false and true) or (true and true) => true

#### Usage

An if statement needs three keywords (structure-words that tell lua what to do) and one condition to properly work:

- the "if"
- the condition
- the "then"
- the "do"

Example:

x = 5 if x >= 5 then print("x is greater than or equal to five.") end

result => x is greater than or equal to five

The condition could also be done before the statement if it is more complex to calculate:

x = 7391 x = x * 65 + 9 - 13 + 62 * 7 y = (9^(5/6)+5-5/6*(x+2)-1) x = (x / 73) * y z = math.sqrt(6) x = x * z

if x < 5 then print(x) end

result => -6465058150.6342 -- x < 5 => true, so the program prints out x, as instructed.

or

x = 5 condition = x > 7 if condition then print("true") end

result => -- nothing is outputted as condition (x>7) is false

### The Else Statement

The "else" statement is used directly after an if statement and tells the program what to do if the condition is *not* true. Else comes after the code to run for "if", but before "end":

x = 5 if x > 5 then print("x is greater than 5") else print("x is not greater than 5") end

result => x is not greater than 5

### The Elseif Statement

The elseif statement is a faster way of writing an else and an if together. It is used to check if a different condition is true, given that the first was not:

x = 5 if x > 5 then print("x is greater than 5") elseif x < 5 then print("x is less than 5") else print("x must be 5!") end

result => x must be 5!

the elseif could be rewritten as:

else if x < 5 then print("x is less than 5") end end

but this is much messier and harder to read.

## Functions

Functions (sometimes "subprograms" or "procedures") perform specific calculations, usually relating to a single task. and can return a value, but **they do not have to return anything**. They can accept input values, called arguments (although these are not required either). Below is a simple example of a function, which will take any value and add one to it:

function myFunction(argument1) return argument1 + 1 end

To 'call' a function is to run it by mentioning it somewhere else in your program. If we run myFunction, we get:

my_variable = myFunction(7)

'my_variable' will now hold the value outputted: 8

Note that saying:

my_variable = myFunction

will store the entire function in 'my_variable'.

## Loops

### The Conditional Loop

The conditional loop ("while loop") is used to repeat a block of code and unspecified amount of times. When it is run, a conditional loop will:

1. check that the condition is met initially. If not then skip the entire block.
2. run the code inside the loop until "end" is seen (in the same "level" as the loop, not just anywhere)
3. check the condition is met for the second time.
4. keep repeating 1-3 until the condition is **not** met
5. exit the loop without running the code again

This is useful when we need to perform calculations on every value in a table, but we do not know how large the table is:

myTable = {true, true, true, false}

n = 1 table_len = #myTable - 1 -- get the length of myTable, and subtract one while n < table_len do -- "check that i is less than the table's length. If that is false, exit the loop." -- this line will be called twice print(myTable.n) -- print the nth item of the table n = n + 1 -- increment n by one end

results in:

true true true

### The Unconditional Loop

Similar to the conditional loop, the ***un*conditional loop** ("for" loop) is used when we *do* know how many times to run a piece of code. It can also be used when we can *express* how many times to do something by performing a calculation beforehand. It can be used in the same way as a conditional loop:

for i=1,2 do -- this line is called twice end

You can manually set a 'step' for the loop, which determines how much i should be incremented by after each iteration:

for i=1,2,0.5 do -- this line is called 4 times end

You can choose a different max, even a negative (note that for most cases, a negative step should be used with a negative max, otherwise i never exceeds the max, and thus an infinite loop is created):

for i=1,-5,-1 do -- this line is called 7 times end

You can also loop over the entries of a table using the 'ipairs' function to grab the key and the value in one:

myTable = {"a","b","c"} for k,v in ipairs(myTable) do -- the code inside the loop will be called 3 times: -- 1. k=1, v="a" -- 2. k=2, v="b" -- 3. k=3, v="c" end

As mentioned, calculations can be done in any part of the statement:

for i=17/17, 10/5, 2/2 do print(i) end

results in:

1 2

## Further Reading

After understanding this, you should proceed with "[Learning Lua as a Programmer](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Learning_Lua_as_a_programer)". Alternatively, see [the first edition of *Programming in Lua*](https://www.lua.org/pil/contents.html) for extra information.

---

Source: [Wiki/Guides/Lua/Learning Lua as a beginner](https://stormworks.fandom.com/wiki/Wiki/Guides/Lua/Learning_Lua_as_a_beginner) · Revision 3290 · CC BY-NC-SA
