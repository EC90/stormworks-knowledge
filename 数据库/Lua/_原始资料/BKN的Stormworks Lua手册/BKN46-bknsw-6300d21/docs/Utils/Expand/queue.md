# 队列存储

适用于数据存储、数据平滑

## 压入队列

参数: 队列（用空table就好）, 队列最大长度, 压入元素

```lua
S={}

function stackPush(S,MAX,value)
	table.insert(S,value)
	if #S > MAX then
		table.remove(S,1)
	end
end
```

简化版:

```lua
function stackPush(b,c,d)table.insert(b,d)if#b>c then table.remove(b,1)end end
```

## 队列求平均

```lua
function tableAvg(S)
	tmp=0
	for i=1,#S do
		tmp=tmp+S[i]
	end
	return tmp/#S
end
```

简化版:

```lua
function tableAvg(b)c=0;for d=1,#b do c=c+b[d]end;return c/#b end
```
