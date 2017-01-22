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
    paths.colors[1] = {249,174,0}
    paths[2] = cr.tranform_line_points({450,600, 450,400, 100,400, 100,250, 150,250, 150,0}, 20)
    paths.colors[2] = {255,0,0}
    paths[3] = cr.tranform_line_points({800,400, 600,400, 600,500, 700,500, 700,0}, 20)
    paths.colors[3] = {0,0,255}

    return paths
end

function map:init()
    self.towers = getTowers()
    self.paths = getPaths()
end

function map:render()
    --Renders the towers
    for i,j in ipairs(self.towers) do
        love.graphics.circle("fill", j.x, j.y, 10)
    end
    --Renders the paths
    for i,j in ipairs(self.paths) do
        love.graphics.setColor(self.paths.colors[i])
        love.graphics.line(j)
    end
    love.graphics.setColor(255,255,255)
end

return map
