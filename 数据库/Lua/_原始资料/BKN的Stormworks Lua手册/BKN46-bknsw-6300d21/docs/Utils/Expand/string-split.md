# 字符串分割为table

实现string.split()函数

```lua
function split(a,b)if b==nil then b="%s"end;local c={}for d in string.gmatch(a,"([^"..b.."]+)")do table.insert(c,d)end;return c end
```

使用例：把字符串按照逗号分割成table

```lua
str = "1,2,3,4,5,6,7,8"
arr = split(str, ",") -- 结果为{"1","2","3","4","5","6","7","8"}
```
