local gamestate = require "src.lib.gamestate"

local info = {}

function info:enter()
    infoimage = love.graphics.newImage("assets/creditos-deuonda.png")
end

function info:draw()
    love.graphics.draw(infoimage, 0 , 0)
end

return info
