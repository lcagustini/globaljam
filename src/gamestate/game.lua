local gamestate = require "src.lib.gamestate"

local game = {}

local gameCanvas = love.graphics.newCanvas()

function game:enter()
    map = require "src.objects.map"
    map:init()

    love.graphics.setLineWidth(5)
end

function game:update(dt)
    love.graphics.setCanvas(gameCanvas)
    for i,j in ipairs(map.towers) do
        love.graphics.circle("fill", j.x, j.y, 10)
    end
    for i,j in ipairs(map.paths) do
        love.graphics.setColor(map.paths.colors[i])
        love.graphics.line(j)
    end
    love.graphics.setColor(255,255,255)
    love.graphics.setCanvas()
end

function game:draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
    love.graphics.draw(gameCanvas)
end

return game
