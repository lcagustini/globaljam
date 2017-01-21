local gamestate = require "src.lib.gamestate"

local game = {}

local physicsWorld = {}

local gameCanvas = love.graphics.newCanvas()

function game:enter() 
    circle = {
               x = 100,
               y = 100,
               r = 20
             }
end

function game:update(dt)
    love.graphics.setCanvas(gameCanvas)
        love.graphics.circle("fill", circle.x, circle.y, circle.r)
    love.graphics.setCanvas()
end

function game:draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
    love.graphics.draw(gameCanvas)
end

return game
