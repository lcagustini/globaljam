local map = {}
local towers = require "src.objects.tower"

local function getPaths()
    local cr = require "src.lib.cornerRounder"

    local paths = {}
    paths.colors = {}

    --Corner rounded paths with unique colors
    paths[1] = cr.tranform_line_points({0,430, 300,430, 300,275, 800,275}, 30)
    paths.colors[1] = {248,243,0}
    paths[2] = cr.tranform_line_points({400,0, 400,400, 800,400}, 20)
    paths.colors[2] = {30,220,0}
    paths[3] = cr.tranform_line_points({700,0, 700,600}, 20)
    paths.colors[3] = {255,79,0}
    paths[4] = cr.tranform_line_points({200,0, 200,500, 800,500}, 20)
    paths.colors[4] = {0,144,199}
    paths[5] = cr.tranform_line_points({0,150, 600,150, 600,0}, 20)
    paths.colors[5] = {237,8,37}

    return paths
end

function map:init()
    self.towers = towers:getTowers()
    self.paths = getPaths()
end

function map:collision(waves)
    for i=1,#self.towers do
        for j=1,#waves do
            
        end
    end
end

function map:render(dt)
    love.graphics.setLineWidth(2)
    --Renders the interference
    towers:renderInterference(self.towers, dt)

    --Renders the towers
    for i,j in ipairs(self.towers) do
        love.graphics.circle("fill", j.x, j.y, 10)
    end

    love.graphics.setLineWidth(5)
    --Renders the paths
    for i,j in ipairs(self.paths) do
        love.graphics.setColor(self.paths.colors[i])
        love.graphics.line(j)
    end
    love.graphics.setColor(255,255,255)
end

return map
