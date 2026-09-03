# 矩阵乘法

```lua
function matMul( m1, m2 )
	local res = {}
	for i = 1, #m1 do
		res[i] = {}
		for j = 1, #m2[1] do
			res[i][j] = 0
			for k = 1, #m2 do
				res[i][j] = res[i][j] + m1[i][k] * m2[k][j]
			end
		end
	end
	return res
end
```

简化版:

```lua
function matMul(b,c)local d={}for e=1,#b do d[e]={}for f=1,#c[1]do d[e][f]=0;for g=1,#c do d[e][f]=d[e][f]+b[e][g]*c[g][f]end end end;return d end
```
