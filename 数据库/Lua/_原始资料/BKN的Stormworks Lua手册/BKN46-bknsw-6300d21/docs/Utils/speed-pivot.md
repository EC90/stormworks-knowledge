# 速度轴指向固定方向

x,y分别对应速度轴当前朝向、目标朝向  

如果直接使用微控的function，可以直接填`(x-y)-floor((x-y)+0.5)`  
如果lua调用，则类似:

```lua
function sgn(x) if x>=0 then return 1 else return -1 end end

target=GN(1)%1
turret=GN(2)%1
turn=(target-turret)-math.floor(target-turret+0.5)
```
