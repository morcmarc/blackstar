local Class     = require "vendor.hump.class"

local MainMenu = Class {
    init = function(self)
        self.menuItems = {
            "New Game",
            "Quit",
        }
        self.len     = 2
        self.current = 1
    end,
}

function MainMenu:update(dt)
end

function MainMenu:draw()
    local margin = 5

    love.graphics.clear()
    
    for k, v in pairs(self.menuItems) do
        if self.current == k then
            love.graphics.setColor(255, 182, 13)
            love.graphics.print(
                v, 
                love.graphics.getWidth() / 2 - 30, 
                love.graphics.getHeight() / 2 - 30 + (10 + 2 * margin) * k)
        else
            love.graphics.setColor(200, 200, 200)
            love.graphics.print(
                v, 
                love.graphics.getWidth() / 2 - 30, 
                love.graphics.getHeight() / 2 - 30 + (10 + 2 * margin) * k)
        end
    end
end

return MainMenu