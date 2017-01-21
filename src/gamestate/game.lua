local gamestate = require "src.lib.gamestate"
require "src.objects.wave"

local game = {}

local physicsWorld = {}

local gameCanvas = love.graphics.newCanvas()
local gameTime;

<<<<<<< Updated upstream
function game:enter() 
    circle = {
               x = 100,
               y = 100,
               r = 20
             }
=======
function game:enter()
    map = require "src.objects.map"
    map:init()

    love.graphics.setLineWidth(5)
  
>>>>>>> Stashed changes
    gameTime = 0;
    
    --Testing waves
    waves = { }
    testWaveTable = {{releaseTime=0.5, track=2, speed=100}, {releaseTime=1.0, track=1, speed=200}, {releaseTime=1.2, track=2, speed=300}}
end


function game:update(dt)
    --Waves
    gameTime = gameTime+dt
    updateWaves(waves, testWaveTable, gameTime, dt)
    
	--Teste
    love.graphics.setCanvas(gameCanvas)
    love.graphics.clear()
    love.graphics.circle("fill", circle.x, circle.y, circle.r)
    drawWaves(waves)
    love.graphics.setCanvas()
   
    
end

function game:draw()
    love.graphics.print(gameTime, 0, 0)
    love.graphics.draw(gameCanvas)
end

return game
