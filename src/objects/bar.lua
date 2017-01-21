interference = 0
function love.update(dt)
    if interference > 0 then
        interference = interference - 0.2
    end
    if love.keyboard.isDown('space') then
        if interference < 599 then
            interference = interference + 2
        end
    end
    quad = love.graphics.newQuad(0, 0, interference, 49, barimage:getWidth(), barimage:getHeight())
end
function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line", 100, 500, 600, 50)
    love.graphics.draw(barimage, quad, 100, 500)
end
