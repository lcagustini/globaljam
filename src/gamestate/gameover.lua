local gamestate = require "src.lib.gamestate"

local gameover = {}

function gameover:enter()

end

function gameover:update(dt)

end

function gameover:draw()
    love.graphics.print("cabo", 400, 300)
end

return gameover
