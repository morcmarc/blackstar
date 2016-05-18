local Controls = require "src.controls.MenuControls"

local MainMenu = {}

function MainMenu:init()
    self.controls = Controls()
end

function MainMenu:draw()
    love.graphics.setBackgroundColor(0, 100, 200)
    love.graphics.clear()
    love.graphics.setColor(200, 200, 200)
    love.graphics.print("Press Enter", 350, 300)
end

function MainMenu:update(dt)
    self.controls:update(dt)
end

return MainMenu