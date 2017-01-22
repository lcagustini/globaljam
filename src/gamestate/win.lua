local gamestate = require "src.lib.gamestate"

local win = {}

function win:enter()

end

function win:update(dt)

end

function win:draw()
    love.graphics.print("ganho", 400, 300)
end

return win
