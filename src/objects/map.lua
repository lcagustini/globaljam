local map = {}

function map:init()
    map.towers = getTowers()
    map.paths = getPaths()
end

function getTowers()
    local towers = {}
    for i=1,15,1 do
        towers[i] = {x = love.math.random(800), y = love.math.random(600)}
    end
    return towers
end

function getPaths()
    local cr = require "src.lib.cornerRounder"

    local paths = {}
    paths.colors = {}

    paths[1] = cr.tranform_line_points({200,600, 200,500, 400,500, 400,200, 800,200}, 20)
    paths.colors[1] = {0,255,0}
    paths[2] = cr.tranform_line_points({450,600, 450,400, 100,400, 100,250, 150,250, 150,0}, 20)
    paths.colors[2] = {255,0,0}

    return paths
end

return map
