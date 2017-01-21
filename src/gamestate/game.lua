local gamestate = require "src.lib.gamestate"
require "src.wave"

local game = {}

local gameCanvas = love.graphics.newCanvas()
local gameTime;

function game:enter()
    map = require "src.objects.map"
    map:init()

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
    
	--Teste
    love.graphics.setCanvas(gameCanvas)
  
    love.graphics.clear()
    drawWaves(waves)

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
    love.graphics.print(gameTime, 0, 0)
    love.graphics.draw(gameCanvas)
end

return game
