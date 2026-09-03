# table的reduce方法

实现table的reduce方法  
Reference: [Stackoverflow](https://stackoverflow.com/questions/8695378/how-to-sum-a-table-of-numbers-in-lua)  

输入: table(数组), 函数(两个输入), 初始值
输出: 单一结果

```lua
table.reduce = function (list, fn, init)
   local acc = init
   for k, v in ipairs(list) do
	  if 1 == k and not init then
		 acc = v
	  else
		 acc = fn(acc, v)
	  end
   end
   return acc
end
```

压缩版本

```lua
table.reduce = function (b,c,d)local e=d;for f,g in ipairs(b)do if 1==f and not d then e=g else e=c(e,g)end end;return e end
```

使用例: 求一个table所有元素之和

```lua
function add(a,b) return a+b end

arr = {1,2,3,4,5,6,7,8}

res = arr.reduce(arr, add, 0) -- 结果为36
```
