local gamestate = require "src.lib.gamestate"
local game = require 'src.gamestate.game'
local info = require 'src.gamestate.info'

local menu = {}

function menu:enter()
    menuimage = love.graphics.newImage("assets/menu-final.png")
end

function menu:draw()
    love.graphics.draw(menuimage, 0 , 0)
end

function menu:mousepressed( x, y, button)
    if button == 1 and x >= 226 and x <= 316 and y >= 395 and y <= 466   then
        gamestate.switch(game)
    elseif button == 1 and (x - 527)*(x - 527) <= 1600 and (y - 423)*(y - 423) <= 1600 then
        gamestate.switch(info)
   end
end

return menu
--527 423
