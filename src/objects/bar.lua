local bar = {}
local interference = 0

function bar:init()
    barimage = love.graphics.newImage("assets/color-bar.jpg")
    quad = love.graphics.newQuad(0, 0, interference, 49, barimage:getWidth(), barimage:getHeight())
end

function bar:update(dt)
    if interference > 0 then
        interference = interference - 0.2
    end
    if love.keyboard.isDown('space') then
        if interference < 599 then
            interference = interference + 2
        end
    end
    quad = love.graphics.newQuad(0, 0, interference, 30, barimage:getWidth(), barimage:getHeight())
end

function bar:render()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line", 100, 550, 600, 30)
    love.graphics.draw(barimage, quad, 100, 550)
end

return bar
