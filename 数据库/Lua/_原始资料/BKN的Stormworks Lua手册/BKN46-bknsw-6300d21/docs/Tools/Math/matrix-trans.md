# 矩阵转置

```lua
function transpose(m)
	local res = {}
	for i = 1, #m[1] do
		res[i] = {}
		for j = 1, #m do
			res[i][j] = m[j][i]
		end
	end
	return res
end
```

简化版:

```lua
function transpose(b)local c={}for d=1,#b[1]do c[d]={}for e=1,#b do c[d][e]=b[e][d]end end;return c end
```
