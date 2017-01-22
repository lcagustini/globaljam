local bar = {}
local interference = 0

function bar:init()
    barimage = love.graphics.newImage("assets/barrinha.png")
    quad = love.graphics.newQuad(0, 0, interference, 49, barimage:getWidth(), barimage:getHeight())
    noise = love.audio.newSource("assets/noise.wav")
    noise:setLooping(true)
    noise:setVolume(0)
    noise:play()
end

function bar:update(dt)
    if interference > 0 then
        interference = interference - 0.1
    end
    noise:setVolume(interference/1320.0)
    quad = love.graphics.newQuad(0, 0, interference, 30, barimage:getWidth(), barimage:getHeight())
    if interference >= 560 then
        return true;
    end
    return false;
end

function bar:render()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line", 120, 550, 560, 30)
    love.graphics.draw(barimage, quad, 120, 550)
end

function bar:increase()
    if interference < 560 then
        interference = interference + 0.3
    end
end

return bar
