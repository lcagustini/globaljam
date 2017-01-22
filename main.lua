local gamestate = require 'src.lib.gamestate'
local menu = require 'src.gamestate.menu'

function love.load()
    love.math.setRandomSeed(os.clock())
    --love.graphics.setDefaultFilter("nearest", "nearest")
    gamestate.registerEvents()
    gamestate.switch(menu)
end
