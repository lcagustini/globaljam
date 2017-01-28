local map = {}
local towers = require "src.objects.tower"
local wave = require "src.objects.wave"

local waves = {}

local function getPaths()
    local cr = require "src.lib.cornerRounder"

    local paths = {}
    paths.colors = {}

    --Corner rounded paths with unique colors
    paths[1] = cr.tranform_line_points({0,430, 300,430, 300,275, 800,275}, 30)
    paths.colors[3] = {248,243,0}
    paths[2] = cr.tranform_line_points({400,0, 400,400, 800,400}, 20)
    paths.colors[2] = {30,220,0}
    paths[3] = cr.tranform_line_points({700,0, 700,600}, 20)
    paths.colors[1] = {255,79,0}
    paths[4] = cr.tranform_line_points({200,0, 200,500, 800,500}, 20)
    paths.colors[5] = {0,144,199}
    paths[5] = cr.tranform_line_points({0,150, 800,150}, 20)
    paths.colors[4] = {237,8,37}

    return paths
end

function map:init(level, waveImg)
    self.towers = towers:getTowers()
    self.paths = getPaths()
    wave:init(level, waveImg)
end

function map:collision(bar)
    for i=1,#self.towers do
        for j=1,#waves do
            if self.towers[i].state then
                if (waves[j].x-self.towers[i].x)^2 + (waves[j].y-self.towers[i].y)^2 < 7225 then
                    bar:increase()
                end
            end
        end
    end
end

function map:update(dt, gameTime)
    wave:update(waves, gameTime, dt)
end

function map:win()
    return #waves == 0 and wave:emptyWaveTable()
end

function map:render(dt, gametime)
    love.graphics.setLineWidth(5)
    --Renders the paths
    for i,j in ipairs(self.paths) do
        love.graphics.setColor(self.paths.colors[i])
        love.graphics.line(j)
    end
    love.graphics.setColor(255,255,255)

    wave:render(waves, gametime)

    love.graphics.setLineWidth(2)
    --Renders the interference
    towers:renderInterference(self.towers, dt)

    --Renders the towers
    towers:renderTowers(self.towers)
end

return map
