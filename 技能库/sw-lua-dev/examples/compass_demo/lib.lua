local lib = {}

--@storm export
function lib.norm360(a)
    a = a % 360
    if a > 0 then
        return a
    end
    return a + 360
end

--@storm export
function lib.lerp(a, b, t)
    return a + (b - a) * t
end

return lib
