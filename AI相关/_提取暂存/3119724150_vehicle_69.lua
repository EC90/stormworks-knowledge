-- source: steam id 3119724150 / vehicle.xml block#69
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3119724150
local t = {}  -- Kalman filtresi iin durum deikenleri

-- Kalman filtresi parametreleri
local initial_state = 0  -- Balang durumu
local process_noise = 0.01  -- Srekli zaman modelinin grlt seviyesi
local measurement_noise = 100.99  -- lm grlt seviyesi

function createKalmanFilter()
    return {
        state = initial_state,  -- Balang durumu
        error_estimate = 1.0,  -- Balang tahmin hatas
    }
end

function updateKalmanFilter(filter, measurement)
    -- Srekli zaman modelini kullanarak tahmin yapma
    local predicted_state = filter.state
    local predicted_error = filter.error_estimate + process_noise

    -- lm modelini kullanarak tahmin gncellemesi
    local kalman_gain = predicted_error / (predicted_error + measurement_noise)
    local updated_state = predicted_state + kalman_gain * (measurement - predicted_state)
    local updated_error = (1 - kalman_gain) * predicted_error

    -- Gncel sonucu dndrme
    filter.state = updated_state
    filter.error_estimate = updated_error

    return updated_state
end

function onTick()
    M = input.getBool(9)
    for i = 1, 8 do
        if not t[i] then
            t[i] = {
                Dis = createKalmanFilter(),
                Azi = createKalmanFilter(),
                Ele = createKalmanFilter(),
            }
        end

        local D = input.getNumber(i * 4 - 3)
        local X = input.getNumber(i * 4 - 2)
        local Y = input.getNumber(i * 4 - 1)
        local T = input.getNumber(i * 4)

        if (not M and D > 0 and T == 0)or(M and D > 0) then
            -- D, X ve Y deerlerini ayr ayr filtrele
            local filtered_D = updateKalmanFilter(t[i].Dis, D)
            local filtered_X = updateKalmanFilter(t[i].Azi, X)
            local filtered_Y = updateKalmanFilter(t[i].Ele, Y)

            -- Filtrelenmi sonular k olarak ayarla
            output.setNumber(i * 4 - 3, filtered_D)
            output.setNumber(i * 4 - 2, filtered_X)
            output.setNumber(i * 4 - 1, filtered_Y)
        end
    end
end
