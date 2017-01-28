local gamestate = require "src.lib.gamestate"
local gameover = require "src.gamestate.gameover"
local win = require "src.gamestate.win"
local pause = require "src.gamestate.pause"

local game = {}

local gameCanvas = love.graphics.newCanvas()
local gameTime
local offTowers = 0
local menu

function game:enter(_, cur, waveImg)
    menu = cur
    background = love.graphics.newImage("assets/back.png")
    pauseButton = love.graphics.newImage("assets/pauseb.png")
    music = love.audio.newSource("assets/sound/all.mp3", "stream")
    music:setLooping(true)

    --Initialize map with towers and paths
    map = require "src.objects.map"
    map:init(1, waveImg)

    --Initialize bar object
    bar = require 'src.objects.bar'
    bar:init()

    gameTime = 0;

    music:play()
end

function game:update(dt)
    --Waves
    gameTime = gameTime+dt

    map:update(dt, gameTime)
    map:collision(bar)

    if map:win() then
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
    map:render(dt, gameTime)
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

function game:leave()
    love.audio.stop()
end

return game
