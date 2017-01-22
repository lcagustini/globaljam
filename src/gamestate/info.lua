local gamestate = require "src.lib.gamestate"

local info = {}

function info:enter(cur, menu0)
    if menu0 then
        menu = menu0
    else
        menu = cur
    end
    infoimage = love.graphics.newImage("assets/creditos-deuonda1.png")
end

function info:draw()
    love.graphics.draw(infoimage, 0 , 0)
end

function info:mousepressed(x,y,button)
    if button == 1 and x >= 350 and x <= 430 and y >= 470 and y <= 550   then
        gamestate.switch(menu)
    end
end

return info
