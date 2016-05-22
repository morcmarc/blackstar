local Class = require "vendor.hump.class"

local Cursor = Class {
    init = function(self)
        self.x = love.graphics.getWidth() / 2
        self.y = love.graphics.getHeight() / 2
        -- Set up mouse
        love.mouse.setVisible(false)
        love.mouse.setGrabbed(true)
        self.cursorImg = love.graphics.newImage("assets/sprites/cursor.png")
    end,
}

function Cursor:draw()
    -- love.graphics.draw(self.cursorImg, self.x, self.y)
end

return Cursor