# 定时后执行

有的时候需要延迟执行一些函数，这时候就将需要执行的任务放在一个表中，每tick检查是否到了执行时间，如果到了就执行并移出表

```lua
{% raw %}
DELAY_EVENTS = {}

function addDelay(time, do_func, param)
    table.insert(DELAY_EVENTS, {
        ["TIME"] = time,
        ["DO"] = do_func,
        ["PARAM"] = param,
    })
end

function onTick(game_ticks)
	for k, v in pairs(DELAY_EVENTS) do
        if v.TIME > 0 then
            DELAY_EVENTS[k].TIME = DELAY_EVENTS[k].TIME - 1
        else
            v.DO(table.unpack(v.PARAM))
            DELAY_EVENTS[k] = nil
        end
    end
end
{% endraw %}
```
