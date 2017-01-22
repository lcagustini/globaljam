local gamestate = require "src.lib.gamestate"
require "src.objects.wave"
require "src.lib.table_file"

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
    
    --Preloades wave images
    loadWaveImages()

    --Testing waves
    waves = { }
    waveTable = loadF("src/levels/1")
end


function game:update(dt)
    --Waves
    gameTime = gameTime+dt
    updateWaves(waves, waveTable, gameTime, dt)

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

amareloWaveImg = {}
azulWaveImg = {}
vermelhoWaveImg = {}
laranjaWaveImg = {}
function loadWaveImages()
    --Yellow
    files = love.filesystem.getDirectoryItems("assets/amarelo")
    for i=1,#files do
        amareloWaveImg[i] = love.graphics.newImage("assets/amarelo/"..files[i])
    end
    --Blue
    files = love.filesystem.getDirectoryItems("assets/azul")
    for i=1,#files do
        azulWaveImg[i] = love.graphics.newImage("assets/azul/"..files[i])
    end
    --Red
    files = love.filesystem.getDirectoryItems("assets/vermelho")
    for i=1,#files do
        vermelhoWaveImg[i] = love.graphics.newImage("assets/vermelho/"..files[i])
    end
    --Orange
    files = love.filesystem.getDirectoryItems("assets/laranja")
    for i=1,#files do
        laranjaWaveImg[i] = love.graphics.newImage("assets/laranja/"..files[i])
    end
end

return game
