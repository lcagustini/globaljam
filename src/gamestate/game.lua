local gamestate = require "src.lib.gamestate"
require "src.objects.wave"
require "src.lib.table_file"
local gameover = require "src.gamestate.gameover"
local win = require "src.gamestate.win"
local pause = require "src.gamestate.pause"

local game = {}

local gameCanvas = love.graphics.newCanvas()
local gameTime
local offTowers = 0
local menu

function game:enter(cur)
    menu = cur
    background = love.graphics.newImage("assets/back.png")
    pauseButton = love.graphics.newImage("assets/pauseb.png")

    --Initialize map with towers and paths
    map = require "src.objects.map"
    map:init()

    --Initialize bar object
    bar = require 'src.objects.bar'
    bar:init()

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

    map:collision(waves, bar)

    if #waves == 0 and #waveTable == 0 then
        gamestate.switch(win)
    end
    if bar:update(dt) then
        gamestate.switch(gameover)
    end

    --Drawing
    love.graphics.setCanvas(gameCanvas)
    if love.mouse.isDown(1) then
        local x = love.mouse.getX()
        local y = love.mouse.getY()
        if x > 20 and x < 20+pauseButton:getWidth() and y > 550 and y < 550+pauseButton:getHeight() then
            gamestate.push(pause, gameCanvas, menu, info)
        end
    end
    love.graphics.clear()

    love.graphics.draw(background, 0 ,0)
    map:render(dt)
    drawWaves(waves, gameTime)
    bar:render()
    love.graphics.draw(pauseButton, 20, 550)

    love.graphics.setCanvas()
end

function game:mousepressed(x, y, button, istouch)
    for i=1,#map.towers do
        if (x-map.towers[i].x)^2 + (y-map.towers[i].y)^2 < 100 then
            if offTowers < 3 or not map.towers[i].state then
                if map.towers[i].state then
                    offTowers = offTowers +1
                elseif offTowers > 0 then
                    offTowers = offTowers -1
                end
                map.towers[i].state = not map.towers[i].state
            end
        end
    end
end

function game:draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
    love.graphics.draw(gameCanvas)
end

amareloWaveImg = {}
azulWaveImg = {}
vermelhoWaveImg = {}
laranjaWaveImg = {}
verdeWaveImg = {}
function loadWaveImages()
    --Yellow
    files = love.filesystem.getDirectoryItems("assets/amarelo")
    for i=1,#files do
        amareloWaveImg[i] = love.graphics.newImage("assets/amarelo/"..files[i])
    end
    --Green
    files = love.filesystem.getDirectoryItems("assets/verde")
    for i=1,#files do
        verdeWaveImg[i] = love.graphics.newImage("assets/verde/"..files[i])
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
