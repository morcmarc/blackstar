local fps = {}

function fps.draw()
    local dFps = love.timer.getFPS()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("FPS: " .. dFps, 10, 30)
end

return fps