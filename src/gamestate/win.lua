local gamestate = require "src.lib.gamestate"

local win = {}

function win:enter()
    background = love.graphics.newImage("assets/back.png")
end

function win:update(dt)

end

function win:draw()
    love.graphics.draw(background, 0 ,0)
    love.graphics.print("ganho", 400, 300)
end

return win
