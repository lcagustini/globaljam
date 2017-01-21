local map = {}

local function getTowers()
    local towers = {}
    --Creates towers in random places
    for i=1,15,1 do
        towers[i] = {x = love.math.random(800), y = love.math.random(600)}
    end
    return towers
end

local function getPaths()
    local cr = require "src.lib.cornerRounder"

    local paths = {}
    paths.colors = {}

    --Corner rounded paths with unique colors
    paths[1] = cr.tranform_line_points({200,600, 200,500, 400,500, 400,200, 800,200}, 20)
    paths.colors[1] = {0,255,0}
    paths[2] = cr.tranform_line_points({450,600, 450,400, 100,400, 100,250, 150,250, 150,0}, 20)
    paths.colors[2] = {255,0,0}

    return paths
end

function map:init()
    map.towers = getTowers()
    map.paths = getPaths()
end

function map:render()
    --Renders the towers
    for i,j in ipairs(map.towers) do
        love.graphics.circle("fill", j.x, j.y, 10)
    end
    --Renders the paths
    for i,j in ipairs(map.paths) do
        love.graphics.setColor(map.paths.colors[i])
        love.graphics.line(j)
    end
    love.graphics.setColor(255,255,255)
end

return map
