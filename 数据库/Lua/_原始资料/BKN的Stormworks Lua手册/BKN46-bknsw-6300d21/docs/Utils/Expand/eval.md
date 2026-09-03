# eval **(SW无法使用)**

输入: 字符串, 函数参数

```lua
function eval(a,b)if type(a)=="string"then local eval=loadstring("return "..a)if type(eval)=="function"then setfenv(eval,b or{})return eval()end end end
```
