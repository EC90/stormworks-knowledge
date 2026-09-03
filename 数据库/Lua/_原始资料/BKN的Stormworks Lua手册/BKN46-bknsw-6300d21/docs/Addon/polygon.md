# 判断点是否在多边形内

凹包算法

```lua
{% raw %}
function bPointInPolygen(posList, posTarget)
    local polygenSides = #posList
    local flag = 0
    for i = 1, polygenSides do
        local Xa, Ya = posList[i][1], posList[i][2]
        local Xb, Yb = posList[i][1], posList[i][2]
        local Xp, Yp = posTarget[1], posTarget[2]
        if posList[i + 1] then
            Xb, Yb = posList[i + 1][1], posList[i + 1][2]
        else
            Xb, Yb = posList[1][1], posList[1][2]
        end
        if (Xp == Xa and Yp == Ya) or (Xp == Xb and Yp == Yb) then
            return true
        end
        if (Yp <= Yb and Yp >= Ya) or (Yp >= Yb and Yp <= Ya) then
            local tempX = Xa + (Yp - Ya) * (Xb - Xa) / (Yb - Ya)
            if Xp == tempX then
                return true
            end
            if Xp > tempX then
                flag = flag + 1
            end
        end
    end
    if flag % 2 == 0 then
        return false
    else
        return true
    end
end
{% endraw %}
```
