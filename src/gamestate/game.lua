local gamestate = require "src.lib.gamestate"
require "src.wave"

local game = {}

local gameCanvas = love.graphics.newCanvas()
local gameTime;

function game:enter()
    --Initialize map with towers and paths
    map = require "src.objects.map"
    map:init()

    --Initialize bar object
    bar = require 'src.objects.bar'
    bar:init()

    --Path width
    love.graphics.setLineWidth(5)

    gameTime = 0;

    --Testing waves
    waves = { }
    testWaveTable = {{releaseTime=0.5, track=1, speed=100}, {releaseTime=1.5, track=1, speed=200}, {releaseTime=2.0,track=1, speed=300}}
end


function game:update(dt)
    --Waves
    gameTime = gameTime+dt
    updateWaves(waves, testWaveTable, gameTime, dt)

    bar:update(dt)

    --Drawing
    love.graphics.setCanvas(gameCanvas)
    love.graphics.clear()

    map:render()
    drawWaves(waves)
    bar:render()

    love.graphics.setCanvas()
end

function game:draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
    love.graphics.draw(gameCanvas)
end

return game
