local gamestate = require 'src.lib.gamestate'
local game = require 'src.gamestate.game'
local bar = require 'src.objects.bar'

function love.load()
    barimage = love.graphics.newImage("assets/color-bar.jpg")
    quad = love.graphics.newQuad(0, 0, interference, 49, barimage:getWidth(), barimage:getHeight())

    love.math.setRandomSeed(os.clock())
    love.graphics.setDefaultFilter("nearest", "nearest")
    gamestate.registerEvents()
    gamestate.switch(game)
end
