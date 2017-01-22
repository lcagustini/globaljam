local gamestate = require "src.lib.gamestate"
require "src.objects.wave"

local game = {}

local gameCanvas = love.graphics.newCanvas()
local gameTime;

function game:enter()
    --Initialize map with towers and paths
    map = require "src.objects.map"
    map:init()

    psystem = require "src.objects.psystem"
    psystem:init()

    --Initialize bar object
    bar = require 'src.objects.bar'
    bar:init()

    --Path width
    love.graphics.setLineWidth(5)

    gameTime = 0;

    --Testing waves
    waves = { }
    testWaveTable = {{releaseTime=0.5, track=1, speed=100, color="laranja"},
                     {releaseTime=1.5, track=2, speed=100, color="vermelho"},
                     {releaseTime=2.0, track=3, speed=100, color="azul"}}
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
    drawWaves(waves, gameTime)
    bar:render()

    love.graphics.setCanvas()
end

function game:draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
    love.graphics.draw(gameCanvas)
end

return game
