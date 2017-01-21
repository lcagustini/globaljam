local gamestate = require 'src.lib.gamestate'
local game = require 'src.gamestate.game'

function love.load()
    love.math.setRandomSeed(os.clock())
    love.graphics.setDefaultFilter("nearest", "nearest")
    gamestate.registerEvents()
    gamestate.switch(game)
end
