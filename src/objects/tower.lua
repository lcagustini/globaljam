local tower = {}

local timer = 0
function tower:getTowers()
    local towers = {}
    --Creates towers

    towers[1] = {x = 170, y = 120, i = {}, state = true}
    towers[2] = {x = 250, y = 380, i = {}, state = true}
    towers[3] = {x = 360, y = 440, i = {}, state = true}
    towers[4] = {x = 370, y = 212, i = {}, state = true}
    towers[5] = {x = 550, y = 337, i = {}, state = true}
    towers[6] = {x = 650, y = 450, i = {}, state = true}
    towers[7] = {x = 650, y = 75, i = {}, state = true}
    towers[8] = {x = 750, y = 225, i = {}, state = true}

    return towers
end

function tower:renderInterference(towers, dt)
    if timer > 1.5 then
        timer = 0
        for i=1,#towers do
            table.insert(towers[i].i, {r = 0, o = 300})
        end
    end
    timer = timer + dt

    for i=1,#towers do
        for j=1,#towers[i].i do
            towers[i].i[j].r = towers[i].i[j].r +20*dt
            towers[i].i[j].o = towers[i].i[j].o -65*dt

            if towers[i].state then
                love.graphics.setColor(255, 255, 255, towers[i].i[j].o)
                love.graphics.circle("line", towers[i].x, towers[i].y, towers[i].i[j].r)
                love.graphics.setColor(255, 255, 255, 255)
            end
        end
    end
    for i=1,#towers do
        for j=1,#towers[i].i do
            if towers[i].i[j].o < 0 then
                table.remove(towers[i].i, j)
            end
        end
    end
end

return tower
