local gamestate = require "src.lib.gamestate"
local game = require "src.gamestate.game"

local loading = {}
local waveImg = {}
local count = 0

function loading:enter(menu)
    background = love.graphics.newImage("assets/back.png")

end

function loading:update(dt)
    if count == 1 then
        --Yellow
        local files = love.filesystem.getDirectoryItems("assets/amarelo")
        waveImg["amarelo"] = {}
        for i, j in ipairs(files) do
            waveImg["amarelo"][i] = love.graphics.newImage("assets/amarelo/"..j)
        end
        --Green
        local files = love.filesystem.getDirectoryItems("assets/verde")
        waveImg["verde"] = {}
        for i, j in ipairs(files) do
            waveImg["verde"][i] = love.graphics.newImage("assets/verde/"..files[i])
        end
        --Blue
        local files = love.filesystem.getDirectoryItems("assets/azul")
        waveImg["azul"] = {}
        for i, j in ipairs(files) do
            waveImg["azul"][i] = love.graphics.newImage("assets/azul/"..files[i])
        end
        --Red
        local files = love.filesystem.getDirectoryItems("assets/vermelho")
        waveImg["vermelho"] = {}
        for i, j in ipairs(files) do
            waveImg["vermelho"][i] = love.graphics.newImage("assets/vermelho/"..files[i])
        end
        --Orange
        local files = love.filesystem.getDirectoryItems("assets/laranja")
        waveImg["laranja"] = {}
        for i, j in ipairs(files) do
            waveImg["laranja"][i] = love.graphics.newImage("assets/laranja/"..files[i])
        end

        gamestate.switch(game, menu, waveImg)
    end
    count = count +1
end

function loading:draw()
    love.graphics.draw(background, 0 ,0)
    love.graphics.print("carregando", 400, 300)
end

return loading
