# 〰 贝塞尔曲线

```lua
function factorial(n)
	local res=1
	for i=2,n do
		res=res*i
	end
	return res
end
	
function comb(n,k)
	return math.floor(factorial(n)/(factorial(k)*factorial(n-k)))
end

function bezier(points, t, poi)
	local res,n=0,#points-1
	for i=0,n do
		res=res+comb(n, i)*t^(i)*(1-t)^(n-i)*points[i+1][poi]
	end
	return res
end
	
function bezierCurve(points, total)
	local res={}
	for t=0,1,1/total do
		local tres={}
		for poi=1,#points[1] do
			table.insert(tres,bezier(points, t, poi))
		end
		table.insert(res,tres)
	end
	return res
end
```

简化版：

```lua
function factorial(a)local b=1;for c=2,a do b=b*c end;return b end
function comb(a,d)return math.floor(factorial(a)/(factorial(d)*factorial(a-d)))end;function bezier(e,f,g)local b,a=0,#e-1;for c=0,a do b=b+comb(a,c)*f^c*(1-f)^(a-c)*e[c+1][g]end;return b end
function bezierCurve(e,h)local b={}for f=0,1,1/h do local i={}for g=1,#e[1]do table.insert(i,bezier(e,f,g))end;table.insert(b,i)end;return b end
```

使用例：

```lua
{% raw %}
points={{2,h/2},{w/2-10,h/4},{w/2+10,h-20},{w-5,30}}

Color(50,0,0)
for i,p in pairs(points) do
	Circle(p[1],p[2],2)
end

Color(0,50,50)
points = bezierCurve(points, 300)
for i,p in pairs(points) do
	Circle(p[1],p[2],0.1)
end
{% endraw %}
```
