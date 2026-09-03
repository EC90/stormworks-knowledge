# 贝塞尔插值

```lua
function bezierInterpolation(p1,p2,p3,f,total)
	local d12,d32,d13=subD2(p1,p2),subD2(p3,p2),subD2(p1,p3)
	local p1e,p2s,p2e,p3s=addD2(p1,d32,f),addD2(p2,d13,-f),addD2(p2,d13,f),addD2(p3,d12,f)
	local res=bezierCurve({p1,p1e,p2s,p2}, total)
	arrAdd(res,bezierCurve({p2,p2e,p3s,p3}, total))
	return res
end

function subD2(p1,p2) return {p2[1]-p1[1],p2[2]-p1[2]} end
function addD2(p1,p2,c) return {p2[1]*c+p1[1],p2[2]*c+p1[2]} end
function arrAdd(a1,a2) for i,e in pairs(a2) do table.insert(a1,e) end end

function bezierInterpolation(a,b,c,d,e)local f,g,h=subD2(a,b),subD2(c,b),subD2(a,c)local i,j,k,l=addD2(a,g,d),addD2(b,h,-d),addD2(b,h,d),addD2(c,f,d)local m=bezierCurve({a,i,j,b},e)arrAdd(m,bezierCurve({b,k,l,c},e))return m end
```
