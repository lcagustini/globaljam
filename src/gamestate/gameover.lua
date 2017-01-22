local gamestate = require "src.lib.gamestate"

local gameover = {}

function gameover:enter()
    background = love.graphics.newImage("assets/back.png")
end

function gameover:update(dt)

end

function gameover:draw()
    love.graphics.draw(background, 0 ,0)
    love.graphics.print("cabo", 400, 300)
end

return gameover
