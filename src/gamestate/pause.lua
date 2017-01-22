local gamestate = require "src.lib.gamestate"
local info = require "src.gamestate.info"

local pause = {}
local menu

function pause:enter(_, gameCanvas, menu0)
    canvas = gameCanvas
    menu = menu0
    pauseMenu = love.graphics.newImage("assets/pause.png")
end

function pause:mousepressed(x, y, button)
    if button == 1 then
        if x > 340 and x < 460 then
            if y > 190 and y < 270 then
                gamestate.pop()
            elseif y > 300 and y < 380 then
                gamestate.switch(info, menu)
            elseif y > 395 and y < 450 then
                gamestate.switch(menu)
            end
        end
    end
end

function pause:draw()
    if not canvas then
        gamestate.switch(menu)
    end

    love.graphics.draw(canvas)
    love.graphics.draw(pauseMenu, 400-pauseMenu:getWidth()/2, 300-pauseMenu:getHeight()/2)
end

return pause
