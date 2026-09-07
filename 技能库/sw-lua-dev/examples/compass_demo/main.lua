-- demo: compass HUD, wide-screen aware, smoothed heading
local M = math
local lib = require('lib')

function onTick()
    local hdg = input.getNumber(1)
    sm = lib.lerp(sm or hdg, hdg, 0.2)
    output.setNumber(1, sm)
end

function onDraw()
    if sm == nil then return end
    local w, h = screen.getWidth(), screen.getHeight()
    local padX = 0
    if w > h then
        padX = (w - h) / 2
        w = h
    end
    screen.setColor(0, 0, 0)
    screen.drawClear()
    screen.setColor(255, 255, 255)
    screen.drawCircle(padX + w / 2 - 0.5, h / 2 - 0.5, w / 2 - 2)
    for i = 0, 11 do
        local a = i * M.pi / 6 - sm * M.pi / 180
        local r1 = w / 2 - 2
        local r0 = r1 - 3
        if i % 3 == 0 then r0 = r1 - 5 end
        screen.drawLine(padX + w / 2 - 0.5 + M.cos(a) * r0, h / 2 - 0.5 + M.sin(a) * r0,
                        padX + w / 2 - 0.5 + M.cos(a) * r1, h / 2 - 0.5 + M.sin(a) * r1)
    end
    screen.setColor(255, 120, 0)
    screen.drawText(padX + w / 2 - 6, h / 2 - 3, string.format('%d', M.floor(sm + 0.5)))
end
